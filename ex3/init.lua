--station_cfg={}
--station_cfg.ssid="certorio"
--station_cfg.pwd= "jair"
--station_cfg.auto=true
--set = wifi.sta.config(station_cfg)

wifi.sta.connect()

p=4 --não usar o 4 pois tem um led nele

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
--    local _, _, method, path_vars = string.find(data, "([A-Z]+) (.+) HTTP");
--    local _, _, speed = string.find(path_vars, "speed=(.+)");

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




