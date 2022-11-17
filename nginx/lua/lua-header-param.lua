-- 获取header参数

local headers = ngx.req.get_headers();

for k,v in pairs(headers)
	do
		ngx.say("[header] key :",k,",value:",v,"<br/>")
	end

