local on_attach = function(_, bufnr)
  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  -- bufmap('gr', require('telescope.builtin').lsp_references)
  -- bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  -- bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


-- 1
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
--   callback = function(args)
--     -- 2
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       -- 3
--       buffer = args.buf,
--       callback = function()
--         -- 4 + 5
--         vim.lsp.buf.format { async = false, id = args.data.client_id }
--       end,
--     })
--   end
-- })


-- Doesn't work, fix l8er
require('neodev').setup {
  override = function(root_dir, library)
    if root_dir:find("home/angryluck/.config/home-manager/nvim", 1, true) == 1 then
      library.enabled = true
      library.plugins = true
    end
  end,
}
require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      workspace = { checkThirdparty = false },
      telemetry = { enable = false },
    }
  }
}

-- require('lspconfig').lua_ls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- 	root_dir = function()
--         return vim.loop.cwd()
--     end,
-- 	cmd = { "lua-lsp" },
--     settings = {
--         Lua = {
--             workspace = { checkThirdParty = false },
--             telemetry = { enable = false },
--         },
--     }
-- }

require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

-- require('lspconfig').nil_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     ['nil'] = {
--       formatting = {
--         -- Re-add when https://github.com/neovim/neovim/pull/29601 is merged!
--         command = { "nixfmt" },
--         -- command = { "alejandra" },
--       },
--     },
--   },
-- }
--
-- require("lspconfig").fsautocomplete.setup {}

-- require('lspconfig').ccls.setup {}
require('lspconfig').clangd.setup {}

require("lspconfig").pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        yapf = {
          enabled = true,
        },
      },
    },
  },
}

require("lspconfig").hls.setup({
  -- filetypes = { 'haskell', 'lhaskell', 'cabal' },
  haskell = {
    formattingProvider = "fourmolu",
  },
})

-- require('lspconfig').pyright.setup {
--   settings = {
--     ['pyright'] = {
--       formatting = {
--         command = { "black ." }
--       }
--     }
--   }
-- }

require("lspconfig").futhark_lsp.setup {}
