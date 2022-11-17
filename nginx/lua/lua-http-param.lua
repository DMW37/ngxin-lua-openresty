-- 获取get请求的参数

local redis = require "resty.redis"

local red = redis:new()

red:connect("127.0.0.1","6379")

local arg = ngx.req.get_uri_args();

for k,v in pairs(arg)
	do
		ngx.say("key:",k,",value:",v)
		red:set(k,v)

	end


