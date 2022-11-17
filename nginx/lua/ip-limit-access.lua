ngx.log(ngx.INFO,"ip limit access")

local redis = require "resty.redis"

local red = redis:new()

-- 连接reids

red:connect("127.0.0.1",6379)

-- 需要写连接状态的判断


-- 判断是否限流

limit = red:get("limit")

if limit == '1'
	then
		return ngx.exit(503)
	end

inc = red:incr("flagLimit")

if inc <= 2
	then
		red:expire("flagLimit",1)
else
	red:set("limit",1)
	red:expire("limit",10)
end

