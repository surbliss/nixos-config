-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
--
-- AutoSnippet function "as":
local function as(trigger, nodes, opts)
  opts = opts or {}
  -- Add snippetType = "autosnippet" to the first parameter
  if type(trigger) == "table" then
    trigger.snippetType = "autosnippet"
  else
    trigger = { trig = trigger, snippetType = "autosnippet" }
  end
  return s(trigger, nodes, opts)
end

return {
  as("eq", fmta([[
  \[
    <>
  \]
]], { i(1) }), { condition = line_begin }),

  as("\\[", fmta(
      [[
        \[
          <>
        \]
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),


  s("\\", fmta([[
\[
  <>
\]
  ]], { i(1) }), { condition = line_begin }),


  as("begin", fmta([[
\begin{<>}
  <>
\end{<>}
]], { i(1), i(2), rep(1) }), { condition = line_begin }),

  as("bg", fmta([[
        \begin{<>}
          <>
        \end{<>}
      ]], { i(1), i(2), rep(1) }), { condition = line_begin }),

  as(
    "als",
    fmta(
      [[
    \begin{align*}
      <>
    \end{align*}
  ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  as(
    "ali",
    fmta(
      [[
    \begin{align}
      <>
    \end{align}
  ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),


  as(
    "enumm",
    fmta(
      [[
  \begin{enumerate}
    \item <>
  \end{enumerate}
  ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),


  as(
    "itemm",
    fmta(
      [[
  \begin{itemize}
    \item <>
  \end{itemize}
  ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  as(",i", { t("\\item") }, { condition = line_begin }),


  -- Primært til programmering (MLA)
  as(
    "lst",
    fmta(
      [[
  \begin{lstlisting}
  <>
  \end{lstlisting}
  ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),



  s("fig", fmta([[
\begin{figure}[hb]
  \centering
  \includegraphics[width=0.9\textwidth]{<>}
  \caption{<>}
\end{figure}
  ]], { i(1, "file_path"), i(2, "caption") }), { condition = line_begin }),



  -- Sections:
  as("secc", fmta("\\section{<>} %", { i(1) }), { condition = line_begin }),
  as("subb", fmta("\\subsection{<>} %", { i(1) }), { condition = line_begin }),
  as("ssubb", fmta("\\subsubsection{<>} %", { i(1) }), { condition = line_begin }),
  as("codd", fmta("\\code{<>}", { i(1) }))
}
