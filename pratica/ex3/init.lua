

--configure o wifi para modo STA com a senha e ssid da rede local

--conecte ao wifi

--cuidado para não usar o 4 pois tem um led nele

--inicie o pwm no pino desejado

pwm.setup(...)
pwm.start(...)

--use essa página de modelo
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
    --nesta função você recebe a requisição da conexão em 'data'
	--e pode enviar dados usando o socket 'sck'

    --envie a pagina modelo para todas as conexões de entrada e mude o duty, valor de saída,
	--do seu pwm de acordo com o valor do campo 'speed' da requisição
    pwm.setduty(...)

    --como você só mandará um pacote, ao fim da transmissão ele fechará a conexão
    sck:on("sent",function() sck:close() end)
end

function handlerx(x)
    x:on("receive",onReceive)
end

--é esperada uma conexão TCP com timeout de 30 segundos
a = net.createServer(net.TCP,30)
--ao receber coneções na porta 80 ele chama a função 'handlerx'
a:listen(80,handlerx)




