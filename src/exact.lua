--[[
    Module: exactSQL
    Description: main file of exactSQL
    Author: SuperYalong
    Version: 0.0.1
    Date: 2025-01-15
    Dependencies: resty.template
    ChangeLog:
        - 0.0.1(2025-01-15) first version
]]
local _M = {}
local template = require "resty.template"

function _M.format_param(value)
    if not value then
        return "null"
    end

    if type(value) == "string" then
        return ngx.quote_sql_str(value)
    elseif type(value) == "table" then
        local formatted = {}
        for _, v in ipairs(value) do
            table.insert(formatted, _M.format_param(v))
        end
        return table.concat(formatted, ", ")
    else
        return tostring(value)
    end
end

function _M.build(sql_template, params)
    local compiled, err = template.comile(sql_template)
    if err then
        return nil, err
    end
    return compiled(params)
end

return _M