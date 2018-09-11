
--configure o wifi para modo STA com a senha e ssid da rede local

--conecte ao wifi


--neste exemplo a página será servida em 3 pacotes, sendo que o pacote 2 será os dados a serem
	--atualmente guardados na memória e o campo 'input' contem os novos dados 
	--a se guardar na memória 
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
	--recebe o valor do campo 'input'
    local _, _, input = string.find(data, "input=(.+)");

	--confira se o valor é vazio e escreva ele em um arquivo	
	
	--abra o arquivo, confira se ele pode ser aberto e leia o valor nele
		--se não houver valor mande algum valor em
		--simpleHTMLpage[2] = [[ ]]
		--se esse campo for vazio dá um erro 	

	--escreva uma função mande os três pacotes, no qual o pacote 2 é os dados do arquivo
	local function sendPackages()
		
	end
	sck:on("sent",function() sendPackages() end)
	sendPackages()
end

function handlerxx(x)
    x:on("receive",onReceive)
end

a = net.createServer(net.TCP,30)
a:listen(80,handlerxx)




