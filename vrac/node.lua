local tbl = require "tbl"

local node = {}
local nodea = { "name" , "value" }
local nodet = { "children" , "parents" }
local nodem = {}

local set = function (k)
    return function ( o , v )
        o[k] = v;
        return true
    end
end
local get = function (k)
    return function ( o )
        return o[k]
    end
end

for i,k in ipairs(nodea) do
    nodem['set_'..k] = set(k)
    nodem['get_'..k] = get(k)
end

local add = function (k)
    return function ( o , v )
        if v == 'n' then error("Reserved value.") end
        if not o[k][v] then
            if v.type and v.type==o.type then
                o[k][v] = true
                o[k]['n'] = o[k]['n'] + 1
                return true
            else
                error("Objects must be of same type '"..tostring(o.type).."'.")
            end
        end
        return false
    end
end
local rem = function (k)
    return function ( o , v )
        if v == 'n' then error("Reserved value.") end
        if o[k][v] then
            o[k][v] = nil
            o[k]['n'] = o[k]['n'] - 1
            return true
        end
        return false
    end
end
local has = function (k)
    return function ( o , v )
        if v == 'n' then error("Reserved value.") end
        return o[k][v] or false
    end
end
local itr = function (k)
    return function ( o )
        local co = coroutine.create(
            function ()
                for k,v in pairs(o[k]) do
                    if k~='n' then coroutine.yield(v) end
                end
            end
        )
        return function ()
            local _,res = coroutine.resume(co)
            return res
        end
    end
end
local sze = function(k)
    return function ( o )
        return o[k]['n']
    end
end

for i,k in ipairs(nodet) do
    nodem[k .. '_add'] = add(k)
    nodem[k .. '_rem'] = rem(k)
    nodem[k .. '_sze'] = sze(k)
end

node.new = function ( t )
    local index = {}
    local _node = { type = "Node" }
    for i,k in ipairs(nodea) do
        index[k] = "hidden"
        if t then
            _node[k] = t[k]
        end
    end
    for i,k in ipairs(nodet) do
        index[k] = "table: hidden"
        _node[k] = {}
    end
    for k,v in pairs(nodem) do
        index[k] = function ( n , ... )
            return v( _node , ... )
        end
    end
    index.type = function ( n )
        return _node.type
    end
    return tbl.protect(index)
end

return tbl.protect(node)
