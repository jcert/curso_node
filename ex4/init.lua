--station_cfg={}
--station_cfg.ssid="certorio"
--station_cfg.pwd= "jair"
--station_cfg.auto=true
--set = wifi.sta.config(station_cfg)

wifi.sta.connect()

simpleHTMLpage = {[[
<head></head>
<body>
<form method="post">
<textarea rows="4" cols="50" name="input"></textarea>
<input type="submit">
</form>
<p>]],
[[lorem ipsum]],
[[
</body>
]]}

function onReceive(sck, data)
--    local _, _, method, path_vars = string.find(data, "([A-Z]+) (.+) HTTP");
	local _, _, input = string.find(data, "input=(.+)");
		
	if input then
		x = file.open('dados.txt','w')		
		x:write(input)
		x:close()
	end

	x = file.open('dados.txt','r')		
	if(x) then		
		simpleHTMLpage[2] = x:read()
		x:close()	
	else
		simpleHTMLpage[2] = [[ ]]	
	end

  local pkg=0
  local function sendPackages()
		pkg=pkg+1
    if pkg>=3 then
			pkg=0
			sck:on("sent",function() sck:close() end)
   		sck:send(simpleHTMLpage[3])		
		else
			print(pkg)
			sck:send(simpleHTMLpage[pkg])		
		end
  end
  sck:on("sent",function() sendPackages() end)
	sendPackages()
end

function handlerxx(x)
    x:on("receive",onReceive)
end

a = net.createServer(net.TCP,30)
a:listen(80,handlerxx)




