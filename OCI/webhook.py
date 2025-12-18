import io
import json
import logging
import requests
from fdk import response

def handler(ctx, data: io.BytesIO = None):
    cfg = ctx.Config()
    # 從 OCI 配置讀取 URL 與金鑰
    endpoint_url = cfg.get("ENDPOINT_URL")
    api_key = cfg.get("API_KEY")
    secret = cfg.get("SECRET")

    if not all([endpoint_url, api_key, secret]):
        return response.Response(ctx, response_data="Missing Configuration", status_code=500)

    try:
        if data is None or data.getvalue() == b"":
            return response.Response(ctx, response_data="Empty Data", status_code=200)

        # 1. 解析來自 Connector Hub 的資料 (通常是 List)
        input_data = json.loads(data.getvalue().decode('utf-8'))
        
        # 2. 準備 Google SecOps 要求的 URL 格式 (依據您的圖片)
        separator = "&" if "?" in endpoint_url else "?"
        target_url = f"{endpoint_url}{separator}key={api_key}&secret={secret}"
        headers = {"Content-Type": "application/json"}

        # 3. 核心處理邏輯：拆解批次
        # 如果是列表，就一筆一筆發送；如果不是，就直接發送
        events_to_process = input_data if isinstance(input_data, list) else [input_data]
        
        success_count = 0
        for event in events_to_process:
            try:
                # 這裡的 event 就是單一筆 JSON 事件
                resp = requests.post(target_url, json=event, headers=headers, timeout=10)
                if resp.status_code < 300:
                    success_count += 1
                else:
                    logging.getLogger().error(f"單筆發送失敗: {resp.status_code}, {resp.text}")
            except Exception as inner_e:
                logging.getLogger().error(f"發送過程發生錯誤: {str(inner_e)}")

        logging.getLogger().info(f"批次處理完成：成功發送 {success_count}/{len(events_to_process)} 筆事件")
        
        return response.Response(
            ctx, 
            response_data=json.dumps({"processed": len(events_to_process), "success": success_count}),
            headers={"Content-Type": "application/json"}
        )

    except Exception as e:
        logging.getLogger().error(f"Function 崩潰: {str(e)}")
        return response.Response(ctx, response_data=str(e), status_code=500)
