---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by z1178.
--- DateTime: 06/09/2022 18:40
---

--- lua中的table表示所有的东西，但是table本身是没有方法的，
---metatable可以去扩展表的一些方法。元表和表是一一对应的，
---有setmetatable去设置元表，也可以通过getmetatable去获取元表

tA = { 1, 3 }
tB = { 5, 7 }

mt = {}

mt.__add = function(t1, t2)
    for _, item in ipairs(t2) do
        table.insert(t1, item)
    end
    return t1
end

setmetatable(tA, mt)

tSum = tA + tB
for k, v in pairs(tSum) do
    print(v)
end

mytable = setmetatable({ key1 = "value1" }, {
    __index = function(mytable, key)
        if key == "key2" then
            return "metatablevalue"
        else
            return nil
        end
    end
})

print(mytable.key1, mytable.key2, mytable.key3)  --- output：value1 metatablevalue nil

mytable = setmetatable({ key1 = "value1" }, {
    __newindex = function(mytable, key, value)
        rawset(mytable, key, "\"" .. value .. "\"")
    end
})

mytable.key1 = "new value"
mytable.key2 = 4

print(mytable.key1, mytable.key2)
--- output：new value "4"
---用以上两个特性，可以做出一张只读表。__index的时候，正常读表；__newindex的时候，跑出异常即可。
---lua这个表就是一个对象，拥有类和继承的概念。虽然没有提供私有性机制，但是却可以用其他的方法提供访问控制，
---主要思想是用两个表表示一个对象，一个用来保存对象的状态，
---一个用来保存对象的操作；还有一种对偶表示的方法，将self作为自己的key