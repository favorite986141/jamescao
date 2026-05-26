filter { 

    json { 
        source => "message"
     } 
    # 👇 使用 grok 精準擷取 shost 的值
    grok {
    match => { "message" => "shost=(?<shost>[^\s ]+)" }
    on_error => "grok_failed"
  }
    # 👇 順便處理一下 shost 裡面殘留的反斜線與引號
  if [shost]!="" {
    mutate {
      gsub => [
        "shost", '\\"', "",
        "shost", '"', ""
      ]
    }
  } 
  # 👇 使用 grok 精準擷取 suser 的值
    grok {
    match => { "message" => "suser=(?<suser>[^\s ]+)" }
    on_error => "grok_failed"
  }
    # 👇 順便處理一下 suser 裡面殘留的反斜線與引號
  if [suser]!="" {
    mutate {
      gsub => [
        "suser", '\\"', "",
        "suser", '"', ""
      ]
    }
  }
  # 👇 使用 grok 精準擷取 malwareName 的值
    grok {
    match => { "message" => 'malwareName=\\"(?<malwareName>[^\\"]+)\\"' }
    on_error => "grok_failed"
  }
    # 👇 順便處理一下 malwareName 裡面殘留的反斜線與引號
  if [malwareName]!="" {
    mutate {
      gsub => [
        "malwareName", '\\"', "",
        "malwareName", '"', ""
      ]
    }
  }
  # 👇 使用 grok 精準擷取 infectedObject 的值
    grok {
    match => { "message" => 'infectedObject=\\"(?<infectedObject>[^\\"]+)\\"' }
    on_error => "grok_failed"
  }
    # 👇 順便處理一下 infectedObject 裡面殘留的反斜線與引號
  if [infectedObject]!="" {
    mutate {
      gsub => [
        "infectedObject", '\\"', "",
        "infectedObject", '"', ""
      ]
    }
  }
   # 👇 使用 grok 精準擷取 domainTreePath 的值
    grok {
    match => { "message" => 'domainTreePath=\\"(?<domainTreePath>[^\\"]+)\\"' }
    on_error => "grok_failed"
  }
    # 👇 順便處理一下 domainTreePath 裡面殘留的反斜線與引號
  if [domainTreePath]!="" {
    mutate {
      gsub => [
        "domainTreePath", '\\"', "",
        "domainTreePath", '"', ""
      ]
    }
  }
     # 👇 使用 grok 精準擷取 message 的值
    grok {
    match => { "message" => 'message=\\"(?<message>[^\\"]+)\\"' }
    on_error => "grok_failed"
  }
    # 👇 順便處理一下 message 裡面殘留的反斜線與引號
  if [message]!="" {
    mutate {
      gsub => [
        "message", '\\"', "",
        "message", '"', ""
      ]
    }
  }
   # 👇 1. 先建立一個空的 Action 欄位，防止後面 if 判斷式因為找不到欄位而崩潰
    mutate {
        add_field => { "Action" => "" }
}

    # 👇 2. 使用更穩固的 grok 規則，抓取 Action: 到 File hash: 之間的明文
    grok {
        match => { "message" => "Action: (?<Action>.*?) File hash:" }
        overwrite => [ "Action" ]
        on_error => "grok_failed"
}

    # 👇 3. 清理前後空白。因為前面先建立了欄位，這裡只判斷 != "" 絕對安全
    if [Action] != "" {
        mutate {
            strip => [ "Action" ]
  }
}
    # 👇 1. 先建立一個空的 file_hash 欄位，防止後面判斷式崩溃
    mutate {
        add_field => { "file_hash" => "" }
}

    # 👇 2. 使用 grok 抓取 File hash: 到 Acces 之間的所有字元
    grok {
        match => { "message" => "File hash: (?<file_hash>.*?) Acces" }
        overwrite => [ "file_hash" ]
        on_error => "grok_failed"
}

# 👇 3. 清理前後空白
if [file_hash] != "" {
  mutate {
    strip => [ "file_hash" ]
  }
}
    date { 
        match => [ "@timestamp" , "yyyy-MM-dd HH:mm:ss" , "UNIX" , "ISO8601" , "UNIX_MS" ] 
        on_error => "no_match"
     } 
    mutate { 
        replace => {
            "event.idm.read_only_udm.metadata.vendor_name" => "F-Secure" 
            "event.idm.read_only_udm.metadata.product_name" => "WithSecure" 
            "event.idm.read_only_udm.metadata.event_type" => "GENERIC_EVENT"
         } 
    }
    # 👇 這裡就能順利把抓到的 shost 塞進 target.hostname 了
    
    mutate {
      replace => {
        "event.idm.read_only_udm.target.hostname" => "%{shost}"
        "event.idm.read_only_udm.target.user.userid" => "%{suser}"
        "event.idm.read_only_udm.target.resource.name" => "%{malwareName}"
        "event.idm.read_only_udm.target.application" => "%{infectedObject}"
        "event.idm.read_only_udm.target.process.file.full_path" => "%{domainTreePath}"
        "event.idm.read_only_udm.metadata.description" => "%{message}"
        "event.idm.read_only_udm.target.file.security_result.action_details" => "%{Action}"
        "event.idm.read_only_udm.target.file.sha1" => "%{file_hash}"
      }
    }
  
  # 👇 判斷 hostname 欄位是否存在且不為空
if [hostname] != "" {
  mutate {
    replace => {
      # 範例 A：放進 principal.hostname (依你的 UDM 對應需求調整)
      "event.idm.read_only_udm.principal.hostname" => "%{hostname}"
      
      # 或者是放進中間報告設備的 observer.hostname
      # "event.idm.read_only_udm.observer.hostname" => "%{hostname}"
    }
  }
}
    # save  event to @output
   mutate {
     merge => {
       "@output" => "event"
     }
   }
}
