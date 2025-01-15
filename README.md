# ExactSQL

**ExactSQL** 是一个基于 OpenResty 的轻量级 SQL 构建器，主要功能是通过模板生成灵活、安全的 SQL 查询语句。它依赖 `resty.template` 提供模板渲染能力，并使用 `ngx.quote_sql_str` 实现 SQL 参数转义。

**ExactSQL** is a lightweight SQL builder based on OpenResty. It helps generate flexible and secure SQL queries through templating. It leverages `resty.template` for template rendering and uses `ngx.quote_sql_str` for SQL parameter escaping.

## 特性 / Features

- **轻量级 / Lightweight**: 无复杂依赖，使用 `resty.template` 直接渲染。  
  No heavy dependencies—uses `resty.template` for straightforward rendering.
- **安全性 / Security**: 通过 `ngx.quote_sql_str` 转义参数，防止 SQL 注入。  
  Escapes parameters with `ngx.quote_sql_str` to prevent SQL injection.
- **灵活性 / Flexibility**: 支持条件判断和动态参数填充，适应多种查询场景。  
  Supports conditional logic and dynamic parameter substitution, adapting to various query scenarios.
- **简单易用 / Easy to use**: 熟悉 Lua 和 OpenResty 的开发者可以快速上手。  
  Lua and OpenResty developers can get started quickly.

## 安装 / Installation

1. 确保你的环境中已安装 OpenResty 和 LuaRocks。  
   Make sure OpenResty and LuaRocks are installed in your environment.
2. 将 `exact.lua` 放入你的 `lua_package_path` 中，或者用 LuaRocks 安装：  
   Place `exact.lua` in your `lua_package_path`, or install it via LuaRocks:
   ```bash
   luarocks install exactSQL

## 使用方法 / Usage

```lua
local exactSql = require "exactSQL"

-- 定义 SQL 模板 / Define the SQL template
local view = [[
SELECT * FROM users WHERE 1=1
{% if name then %}
    AND name = {{ exactSql.format_param(name) }}
{% end %}
{% if ages then %}
    AND age IN ( {{ exactSql.format_param(ages) }} )
{% end %}
]]

-- 定义参数 / Define parameters
local params = {
    name = "name",
    ages = {25, 30, 35},
    exactSql = exactSql
}

-- 生成最终的 SQL / Generate the final SQL
local rendered_sql, err = exactSql.build(view, params)
if not rendered_sql then
    ngx.log(ngx.ERR, "SQL generation error: ", err)
else
    ngx.say(rendered_sql)
end

```

## 输出 / Output

``` sql
SELECT * FROM users WHERE 1=1
    AND name = 'name'
    AND age IN ( 25, 30, 35 )
```
## 模板语法 / Template Syntax

exactSQL 使用了 `resty.template` 的语法，支持：  
exactSQL uses `resty.template` syntax, supporting:
- 条件语句（`if`，`elseif`，`else`）  
  Conditional statements (`if`, `elseif`, `else`)
- 循环语句（`for`，`while`）  
  Loops (`for`, `while`)
- 局部变量（`local`）  
  Local variables (`local`)
- 格式化函数  
  Formatting functions

请参考 [resty.template 文档](https://github.com/bungle/lua-resty-template) 了解详细的模板语法。  
Refer to [resty.template documentation](https://github.com/bungle/lua-resty-template) for detailed syntax.

## API

### `exactSql.build(view, params)`

**参数 / Parameters**:  
- `view` (string): 包含 SQL 模板的字符串。  
  The SQL template as a string.
- `params` (table): 包含传递给模板的参数表。  
  A table of parameters to pass into the template.

**返回值 / Returns**:  
- `rendered_sql` (string): 渲染后的 SQL 语句。  
  The rendered SQL string.
- `err` (string): 发生错误时返回错误信息。  
  An error message if the rendering fails.

---

### `exactSql.format_param(value)`

**参数 / Parameters**:  
- `value` (string|number|table): 需要插入 SQL 的参数值。  
  The parameter value to be inserted into the SQL query.

**返回值 / Returns**:  
- 如果是字符串或数字，返回适当转义后的值。  
  If the value is a string or number, returns the escaped version.
- 如果是表，返回格式化的值列表（例如：`(1, 2, 3)`）。  
  If the value is a table, returns a formatted list of values (e.g., `(1, 2, 3)`).

**用途 / Usage**:  
在模板中调用 `exactSql.format_param` 格式化参数以确保安全性。  
Use `exactSql.format_param` within templates to safely format parameters.

---

## 贡献 / Contributing

我们欢迎任何形式的贡献！如果你发现问题、希望添加新功能或者改进文档，可以直接提 [Issues](https://github.com/your-repo/exactSQL/issues) 或提交 PR。  
We welcome all forms of contributions! If you find issues, want to suggest features, or improve documentation, please submit an [Issue](https://github.com/your-repo/exactSQL/issues) or open a PR.

## 许可协议 / License

exactSQL 遵循 MIT 开源协议。详细信息请查看 [LICENSE](LICENSE) 文件。  
exactSQL is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
