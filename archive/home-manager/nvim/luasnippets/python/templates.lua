-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

-- from nvim/lua/
-- local helpers = require("luasnip-helpers")
-- Autosnippet, only for math environments
-- local asm = helpers.asm
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s("aoc-template", fmt([[
from aocd import get_data

data = get_data(year=2024, day={})
test = """{}
"""

def part1(text:str) -> {}:
  return

print(part1(test))
print(part1(data))
]], { i(1), i(2), i(3) }), { condition = line_begin }
  ),
}
