-- 引用resty的redis
local redis = require "resty.redis"

local red = redis:new()

-- 连接redis
local ok,err = red:connect("127.0.0.1",6379)

if not ok 
	then
		ngx.say("faild to connect",err)
		return
end

ok,err = red:set("dKey","dValue")

if not ok 
	then
		ngx.say("faild to set dKey",err)
		return
end

ok,err = red:get("dKey")

if not ok 
	then
		ngx.say("dKey is null")
else
	ngx.say("dKey value is : "..ok)
end

return
