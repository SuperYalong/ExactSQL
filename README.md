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
2. 将 `exactSQL.lua` 放入你的 `lua_package_path` 中，或者用 LuaRocks 安装：  
   Place `exactSQL.lua` in your `lua_package_path`, or install it via LuaRocks:
   ```bash
   luarocks install exactSQL
