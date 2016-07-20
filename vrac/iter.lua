local tbl = require "tbl"

local iter = {}

iter.interval = function ( a , b )
    local co = coroutine.create (
        function ()
            for i=a,b do
                coroutine.yield(i)
            end
        end
    )
    return function ()
        local s,res = coroutine.resume(co)
        return res
    end
end

return tbl.protect(iter)

