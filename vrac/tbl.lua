local tbl = {}

tbl.protect = function ( t )
    local px = {}
    local mt = {
        __index = t,
        __newindex = function ( ... ) error("Read-only table !") end,
        __metatable = "Read-only table.",
        __tostring = function ()
            local res = nil
            for k,v in pairs(t) do
                if res then
                    res = res .. ", "
                else
                    res = "{ "
                end
                res = res .. tostring(k) .. " = " .. tostring(v)
            end
            res = res .. " }"
            return res
        end,
    }
    setmetatable(px,mt)
    return px
end

tbl.copy = function ( t )
    local res = {}
    for k,v in pairs(t) do
        res[k] = v
    end
    return res
end

return tbl:protect()
