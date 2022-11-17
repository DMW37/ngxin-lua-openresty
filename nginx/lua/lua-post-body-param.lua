-- 获取body体参数
-- 所有获取body的操作，这个很重要

ngx.req.read_body();

local body  = ngx.req.get_body_data();

ngx.say(body)

