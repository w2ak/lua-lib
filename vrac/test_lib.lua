local tbl = require "tbl"
local color = require "ansicolors"

local test_lib = {}

test_lib.tostring = function (v)
    if type(v) == "boolean" then
        local c = v and 'green' or 'red'
        return color('%{'..c..' bright}'..tostring(v))
    else
        return tostring(v)
    end
end

test_lib.test = function ( ... )
    local args = {...}
    return function ( b )
        local toprint = tbl.copy(args)
        table.insert(toprint,test_lib.tostring(b))
        print(unpack(toprint))
        return b
    end
end

test_lib.test_fun = function ( ... )
    local args = {...}
    return function ( ... )
        local res = { pcall(...) }
        local toprint = tbl.copy(args)
        table.insert(toprint,test_lib.tostring(res[1]))
        if res[1] then
            table.remove(res,1)
            print(unpack(toprint))
            return unpack(res)
        else
            table.insert(toprint,tostring(res[2]))
            print(unpack(toprint))
        end
    end
end

test_lib.test_err = function ( ... )
    local args = {...}
    return function ( ... )
        local res = { pcall(...) }
        local toprint = tbl.copy(args)
        table.insert(toprint,test_lib.tostring(not res[1]))
        print(unpack(toprint))
        return not res[1]
    end
end

test_lib.test_res = function ( ... )
    local args = {...}
    return function ( ... )
        local valueargs = tbl.copy(args)
        table.insert(valueargs,'result')
        test_lib.test(unpack(args)

return tbl.protect(test_lib)
