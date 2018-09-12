--[[
station_cfg={}
wifi.setmode(wifi.STATION)

station_cfg.ssid="SeuSSID"
station_cfg.pwd= "SuaSenha"
station_cfg.auto=true]]



set = wifi.sta.config(station_cfg)

wifi.sta.connect()

function conectmqtt ()

  -- init mqtt client with logins, keepalive timer 120sec
  m = mqtt.Client("SeuNome", 120, "user", "password")
  
  -- conect to server
  m:connect("192.168.25.96", 1883, 0, function(client) print("Success" end,
  function(client, reason) print("failed reason: " .. reason) end)
  
end

function sendData()
 --Envie os dados
end

end
