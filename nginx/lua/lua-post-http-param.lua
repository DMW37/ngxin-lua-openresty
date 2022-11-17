-- 获取post的key-value键值对
-- 读取body

ngx.req.read_body();

local bodyArgs = ngx.req.get_post_args();

for k,v in pairs(bodyArgs)
	do
		ngx.say("[post] key:",k,",value:",v,"<br/>")
	end

