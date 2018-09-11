station_cfg={}
wifi.setmode(wifi.STATION)

station_cfg.ssid="SeuSSID"
station_cfg.pwd= "SuaSenha"
station_cfg.auto=true

set = wifi.sta.config(station_cfg)

wifi.sta.connect()

function conectmqtt ()

  -- init mqtt client with logins, keepalive timer 120sec
  m = mqtt.Client("SeuNome", 120, "user", "password")

  -- setup Last Will and Testament (optional)
  -- Broker will publish a message with qos = 0, retain = 0, data = "offline"
  -- to topic "/lwt" if client don't send keepalive packet
  m:lwt("/lwt", "offline", 0, 0)

  m:on("connect", function(client) print ("connected") end)
  m:on("offline", function(client) print ("offline") end)

  -- on publish message receive event
  m:on("message", function(client, topic, data)
    print(topic .. ":" )
    if data ~= nil then
      print(data)
    end
  end)

  -- for TLS: m:connect("192.168.11.118", secure-port, 1)
  m:connect("192.168.25.96", 1883, 0, function(client)
    print("connected")
    -- Calling subscribe/publish only makes sense once the connection
    -- was successfully established. You can do that either here in the
    -- 'connect' callback or you need to otherwise make sure the
    -- connection was established (e.g. tracking connection status or in
    -- m:on("connect", function)).

    -- subscribe topic with qos = 0
    client:subscribe("/inData", 0, function(client) print("subscribe success") end)
    -- publish a message with data = hello, QoS = 0, retain = 0
    client:publish("/topic", "hello", 0, 0, function(client) print("sent") end)
    flagsend = 1
  end,
  function(client, reason)
    flagsend = 0
    print("failed reason: " .. reason)
  end)


  --m:close();
  -- you can call m:connect again
end

function sendData()
  if (flagsend == 1) then
    val = adc.read(0)
    msg = tostring(val)
    m:publish("/topic", msg, 0, 0, function(client) print("sent") end)
  end

end



tmr.alarm(1,15000, tmr.ALARM_SINGLE, function() conectmqtt() end )
tmr.alarm(2,5000, 1, function() sendData() end )
