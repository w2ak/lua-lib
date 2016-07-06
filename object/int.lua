local int = {}

local mt = {
    __len = function ( i )
        return int.value(i)
    end,
    __tostring = function ( i )
        return tostring(int.value(i))
    end,
    __unm = function ( i )
        return int.new(-int.value(i))
    end,
    __add = function ( i , j )
        return int.new(int.value(i) + int.value(j))
    end,
    __sub = function ( i , j )
        return int.new(int.value(i) - int.value(j))
    end,
    __mul = function ( i , j )
        return int.new(int.value(i) * int.value(j))
    end,
    __div = function ( i , j )
        return int.new(int.value(i) / int.value(j))
    end,
    __mod = function ( i , j )
        return int.new(int.value(i) % int.value(j))
    end,
    __pow = function ( i , j )
        return int.new(int.value(i) ^ int.value(j))
    end,
    __concat = function ( i , j )
        return int.new(tonumber(tostring(int.value(i))..tostring(int.value(j))))
    end
}

int.new = function ( i )
    local int = {}
    int.value = i
    setmetatable(int,mt)
    return int
end

int.value = function ( i )
    if type(i) == "number" then
        return i
    else
        return i.value
    end
end

return int
