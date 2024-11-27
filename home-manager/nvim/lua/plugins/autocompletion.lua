local cmp = require("cmp")
local luasnip = require("luasnip")

vim.keymap.set(
  "n",
  "<Leader>L",
  -- "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/luasnippets/'})<CR>"
  -- To quickly reload snippets, without having to run home-manager switch.
  -- But do remember to run home-manager switch at end of session!
  "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/home-manager/nvim/luasnippets/'})<CR>"
)
luasnip.config.setup({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
  update_events = "TextChanged,TextChangedI",
})

-- HACK: Do this in terms of 'luasnip' variable instead?
require('luasnip.loaders.from_lua').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- old one: completeopt = "menuone,noselect",
  completion = { completeopt = "menu,menuone,noinsert" },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-b>"] = cmp.mapping.scroll_docs(-8),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(8),
    -- Accept ([y]es) the completion
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({ select = true })
        end
      else
        fallback()
      end
    end),
    -- Manually trigger a completion from nvim-cmp (normally not needed)
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "n", "i", "s" }),
    ["<C-k>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "n", "i", "s" }),
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

    ["jk"] = cmp.mapping(function()
      if luasnip.locally_jumpable() then
        luasnip.jump(1)
      end
    end, { "i", "s" }),
    -- Better completions, especially for latex
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "neorg" },
    { name = "orgmode" },
  },
})
