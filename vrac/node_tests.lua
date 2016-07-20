#!/usr/bin/lua
local node = require "node"
local tst = require "test_lib"

local test = tst.test
local testf= tst.test_fun

local N_NODES = 10

-- tests sur un nœud
local names = { 'a' , {} , 1 }
local values = { 'b' , {} , 2 }
local name = 'test'
local value = 'value'
local nde = node.new({ name = name , value = value })

test('initial name',name)(nde:get_name()==name)
test('initial value',value)(nde:get_value()==value)

for _,n in ipairs(names) do
    testf('change name',n)(nde.set_name,nde,n)
    test('new name',n)(nde:get_name()==n)
    for _,v in ipairs(values) do
        test('change value',v)(nde:set_value(v))
        test('new value',v)(nde:get_value()==v)
    end
end

-- tests sur plusieurs nœuds
local ndes = {}
for i=1,N_NODE do
    ndes[i]=node.new({name='node'..tostring(i),value=i})
end


