station_cfg={}    
station_cfg.ssid="certorio"
station_cfg.pwd= "jair"
station_cfg.auto=true
set = wifi.sta.config(station_cfg)

wifi.sta.connect()

-- enquanto não tiver a biblioteca de pwm
pwm={['setup']=function(x,y,z) return x end,['start']=function(x) return x end,['setduty']=function(x,y) return x end}

pwm.setup(p,500,0)
pwm.start(p)

simpleHTMLpage = [[
<head></head>
<body>
<p>my text is simple
</body>
]]

function onReceive(sck, data)
    sck:send(simpleHTMLpage)
    aux = string.gmatch(data,"(%w+)=(%w+)&*")
    for k,v in aux do
        v = tonumber(v)
        if v>=0 and v<=1000 then
            pwm.setduty(p,v)
        end
    end
    sck:on("sent",function() sck:close() end)
end

function handlerxx(x)
    x:on("receive",onReceive)
end

a = net.createServer(net.TCP,30)
a:listen(80,handlerxx)




