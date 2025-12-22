import io
import json
import logging
import requests
import concurrent.futures
from fdk import response

# 初始化連線池
session = requests.Session()
adapter = requests.adapters.HTTPAdapter(pool_connections=20, pool_maxsize=20)
session.mount('https://', adapter)

def handler(ctx, data: io.BytesIO = None):
    cfg = ctx.Config()
    endpoint_url = cfg.get("ENDPOINT_URL")
    api_key = cfg.get("X-goog-api-key")
    secret = cfg.get("X-Webhook-Access-Key")

    if not all([endpoint_url, api_key, secret]):
        return response.Response(ctx, response_data="Missing Configuration", status_code=500)

    try:
        if data is None or data.getvalue() == b"":
            return response.Response(ctx, response_data="", status_code=200)

        # 1. 解析原始資料
        raw_payload = data.getvalue().decode('utf-8')
        input_data = json.loads(raw_payload)
        
        # 2. 準備目標 URL
        separator = "&" if "?" in endpoint_url else "?"
        target_url = f"{endpoint_url}{separator}key={api_key}&secret={secret}"
        headers = {"Content-Type": "application/json"}

        # 3. 準備原始事件列表
        events_to_process = input_data if isinstance(input_data, list) else [input_data]
        total_events = len(events_to_process)
        
        logging.getLogger().info(f"開始拋送 {total_events} 筆原始日誌...")

        # 定義拋送邏輯 (發送原始 event)
        def send_to_google(event):
            try:
                resp = session.post(target_url, json=event, headers=headers, timeout=10)
                return resp.status_code < 300
            except Exception:
                return False

        # 平行處理
        with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
			results = list(executor.map(send_to_google, events_to_process))
            success_count = sum(results)

        logging.getLogger().info(f"拋送完畢：成功 {success_count}/{total_events}")

        # 【關鍵修正】不要回傳任何 JSON 統計資訊，回傳空內容。
        # 這樣 Google SecOps 就不會收到那段 {"processed":...}
        return response.Response(
            ctx,
            response_data="", 
            headers={"Content-Type": "text/plain"}
        )

    except Exception as e:
        logging.getLogger().error(f"系統崩潰: {str(e)}")
        # 錯誤時也只回傳狀態碼，不回傳詳細資訊給 Google
        return response.Response(ctx, response_data="", status_code=500)
