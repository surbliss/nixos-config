require("telescope").setup({
  defaults = {
    mappings = {
      i = { ["<c-enter>"] = "to_fuzzy_refine" },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")
-- require("telescope").load_extension("emoji")

-- Mappings
-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
local nmap = function(key, cmd, desc)
  vim.keymap.set("n", key, cmd, { desc = desc })
end
nmap("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
nmap("<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles")
nmap("<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
nmap("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
nmap("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
nmap("<leader>sr", builtin.resume, "[S]earch [R]esume")
nmap("<leader>s.", builtin.oldfiles, "[S]earch [.] (Recent Files)")
nmap("<leader>sg", builtin.git_files, "[S]earch [G]it Files")
nmap("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")
nmap("<leader>se", ":Telescope emoji<CR>", "[S]earch [E]mojis")

local fuzzy_find = function()
  builtin.current_buffer_fuzzy_find(
    require("telescope.themes").get_dropdown({
      winblend = 10,
      previewer = false,
    })
  )
end
nmap("<leader>/", fuzzy_find, "[/] Fuzzily search current buffer")

local live_grep = function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end
nmap("<leader>s/", live_grep, "[S]earch [/] in Open Files")

local find_files = function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end
nmap("<leader>sn", find_files, "[S]earch [N]eovim files")
