-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep

-- from nvim/lua/
-- local helpers = require("luasnip-helpers")
-- Autosnippet, only for math environments
-- local asm = helpers.asm
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s("mla-template", fmta(
    [[
%%% Macros:
\usepackage{amsthm}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{hyperref}
\usepackage{xifthen}
\usepackage{xparse}
\usepackage{dsfont}
\usepackage{xcolor}

% Left-right bracket
\newcommand{\lr}[1]{\left (#1\right)}

% Left-right square bracket
\newcommand{\lrs}[1]{\left [#1 \right]}

% Left-right curly bracket
\newcommand{\lrc}[1]{\left \{#1\right\}}

% Left-right absolute value
\newcommand{\lra}[1]{\left |#1\right|}

% Left-right upper value
\newcommand{\lru}[1]{\left \lceil#1\right\rceil}

% Scalar product
\newcommand{\vp}[2]{\left \langle #1 , #2 \right \rangle}

% The real numbers
\newcommand{\R}{\mathbb R}

% The natural numbers
\newcommand{\N}{\mathbb N}

% Expectation symbol with an optional argument
\NewDocumentCommand{\E}{o}{\mathbb E\IfValueT{#1}{\lrs{#1}}}

% Indicator function with an optional argument
\NewDocumentCommand{\1}{o}{\mathds 1{\IfValueT{#1}{\lr{#1}}}}

% Probability function
\let\P\undefined
% \NewDocumentCommand{\P}{o}{\mathbb P{\IfValueT{#1}{\lr{#1}}}}
\NewDocumentCommand{\P}{o}{P{\IfValueT{#1}{\lr{#1}}}}

% A hypothesis space
\newcommand{\HH}{\mathcal H}
\let\H\relax
\newcommand{\H}{\mathcal H}

% A sample space
\newcommand{\XX}{\mathcal{X}}

% A label space
\newcommand{\YY}{\mathcal{Y}}

% A nicer emptyset symbol
\let\emptyset\varnothing

% Sign operator
\DeclareMathOperator{\sign}{sign}
\newcommand{\sgn}[1]{\sign\lr{#1}}

% KL operator
\DeclareMathOperator{\KL}{KL}

% kl operator
\DeclareMathOperator{\kl}{kl}

% The entropy
% \let\H\relax
% \DeclareMathOperator{\H}{H}

% Majority vote
\DeclareMathOperator{\MV}{MV}

% Variance
\DeclareMathOperator{\V}{Var}
\NewDocumentCommand{\Var}{o}{\V\IfValueT{#1}{\lr{#1}}}
\DeclareMathOperator{\C}{Cov}
\NewDocumentCommand{\Cov}{o}{\C\IfValueT{#1}{\lr{#1}}}

% VC
\DeclareMathOperator{\VC}{VC}

% VC-dimension
\newcommand{\dVC}{d_{\VC}}

% FAT ...
\DeclareMathOperator{\FAT}{FAT}
\newcommand{\dfat}{d_{\FAT}}
\newcommand{\lfat}{\ell_{\FAT}}
\newcommand{\Lfat}{L_{\FAT}}
\newcommand{\hatLfat}{\hat L_{\FAT}}

% Distance
\DeclareMathOperator{\dist}{dist}
]], {}
  ), { condition = line_begin }),
}
