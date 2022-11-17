ngx.log(ngx.INFO)

local ip_black_list = ngx.shared.ip_black_list

-- 获取最近更新的时间
local last_update_time = ip_black_list:get("last_udpate_time")

if last_update_time == nil or last_update_time < (ngx.now() - 2)
	then
		-- 表示没名单最近更新的时间过期了，我们需要重新获取
		local redis = require "resty.redis"
		local red = redis:new()
		
		local ok,err = red:connect("127.0.0.1",6379)

		if not ok then
				ngx.log(ngx.INFO,"connect error")

		else
			local local_black_list,err = red:smembers("ip-black-list")
			-- 清空conf中共享空间
			ip_black_list:flush_all()
			
			for k,v in pairs(local_black_list)
				do
					-- 如果客户端请求到的IP地址的结果为true,则该IP为黑名单IP
					ip_black_list:set(v,true)
			end

			-- 设置当前设置IP黑名单的时间
			ip_black_list:set("last_update_time",ngx.now())
		end
end


-- 判断当前的Ip是不是在黑名单中
-- 获取当前请求的IP

local ip = ngx.var.remote_addr

ngx.log(ngx.INFO,"request ip is "..ip)

if ip_black_list:get(ip) 
	then
		return ngx.exit(503)
end

