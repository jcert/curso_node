wifi.setmode(wifi.STATION)

station_cfg={}
station_cfg.ssid="HackerSpace Maringa"
--station_cfg.pwd= "jair"
station_cfg.auto=true
set = wifi.sta.config(station_cfg)

wifi.sta.connect()

p=7 --não usar o 4 pois tem um led nele

pwm.setup(p,500,0)
pwm.start(p)

simpleHTMLpage = [[
<head></head>
<body>
<form>
<input type="number" name="speed">
<input type="submit">
</form>


<p>my text is simple
</body>
]]

function onReceive(sck, data)
    sck:send(simpleHTMLpage)
    aux = string.gmatch(data,"(%w+)=(%w+)&*")
    for k,v in aux do
        v = tonumber(v)
        if v>=0 and v<=1000 and k=="speed" then
            pwm.setduty(p,v)
            print(v)
        end
    end
    sck:on("sent",function() sck:close() end)
end

function handlerxx(x)
    x:on("receive",onReceive)
end

a = net.createServer(net.TCP,30)
a:listen(80,handlerxx)




