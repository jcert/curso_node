function fibrec(n)
    if(n==0 or n==1) then
        return 1
    else
        return fibrec(n-1)+fibrec(n-2)
    end
end

function fib(n)
    aux1=0
    aux2=1
    while n>0 do
        tmp=aux1
        aux1=aux2
        aux2=aux2+tmp
        n=n-1
    end
    return aux2
end

