
-- ============================================
-- MİNİMAL NEOVİM KURULUMU (GELİŞMİŞ LSP)
-- ============================================

-- KULLANILMAYAN PROVIDER'LARI DEVRE DIŞI BIRAK (checkhealth uyarılarını giderir)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- TEMEL AYARLAR
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.cursorline = true

-- TAMAMLAMA (yerleşik autocompletion, Neovim 0.12+)
vim.o.autocomplete = true
vim.opt.complete = { "o", ".^5", "w^5", "b^5" } -- önce LSP (omnifunc), sonra buffer kaynakları (5'er aday)
vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }

-- Telescope prompt'unda otomatik tamamlama menüsü açılmasın
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function() vim.opt_local.autocomplete = false end,
})

-- TEMEL KISA TUŞLAR
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Kaydet" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Çık" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Önceki Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Sonraki Buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Buffer Kapat" })

-- TAMAMLAMA TUŞLARI (popup menü + snippet durakları)
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-n>" end
  if vim.snippet.active({ direction = 1 }) then return "<Cmd>lua vim.snippet.jump(1)<CR>" end
  return "<Tab>"
end, { expr = true, silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-p>" end
  if vim.snippet.active({ direction = -1 }) then return "<Cmd>lua vim.snippet.jump(-1)<CR>" end
  return "<S-Tab>"
end, { expr = true, silent = true })
vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end, { desc = "LSP Tamamlama Tetikle" })

-- ============================================
-- LSP KONFİGÜRASYONU VE KISAYOLLAR
-- ============================================

-- Hata mesajlarının görünümü (Simgeler)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- LSP Bağlandığında Çalışacak Tuşlar
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    -- Yerleşik LSP tamamlama (snippet açma, auto-import gibi yan etkiler için)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)

    -- EN ÖNEMLİ TUŞLAR:
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)           -- Dökümantasyonu Görüntüle (Hover)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)     -- Tanıma Git (Go Definition)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Hata Detayını Gör
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- Otomatik Düzeltme (Code Action)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)   -- Sonraki Hataya Git
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts) -- Önceki Hataya Git
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)  -- Yeniden Adlandır (Rename)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)    -- Referansları Bul (References)
  end,
})

-- LSP SUNUCULARI (Native API — plugin gerektirmez)

-- Lua Language Server
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
}

-- TypeScript Language Server
vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}

-- Vue Language Server (Volar)
vim.lsp.config.volar = {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = { "package.json", ".git" },
}

-- Python Language Server (Pyright)
vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
}

-- Go Language Server (gopls)
vim.lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", "go.work", ".git" },
}

-- Astro Language Server
vim.lsp.config.astro = {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json", "astro.config.mjs", "astro.config.ts", ".git" },
}

-- Svelte Language Server
vim.lsp.config.svelte = {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = { "package.json", "svelte.config.js", "svelte.config.ts", ".git" },
}

vim.lsp.enable({ "lua_ls", "ts_ls", "volar", "pyright", "gopls", "astro", "svelte" })

-- ============================================
-- YÜZEN TERMİNAL (lazygit & lazydocker — yerleşik API, plugin gerektirmez)
-- ============================================
local float_terms = {}
local function toggle_float_term(cmd)
  local t = float_terms[cmd] or {}
  float_terms[cmd] = t
  if t.win and vim.api.nvim_win_is_valid(t.win) then
    vim.api.nvim_win_close(t.win, true)
    t.win = nil
    return
  end
  if not (t.buf and vim.api.nvim_buf_is_valid(t.buf)) then
    t.buf = vim.api.nvim_create_buf(false, true)
  end
  local width = math.min(130, vim.o.columns - 4)
  local height = math.min(30, vim.o.lines - 4)
  t.win = vim.api.nvim_open_win(t.buf, true, {
    relative = "editor",
    border = "rounded",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
  })
  if vim.bo[t.buf].buftype ~= "terminal" then
    vim.fn.jobstart(cmd, {
      term = true,
      on_exit = function()
        vim.schedule(function()
          local cur = float_terms[cmd]
          float_terms[cmd] = nil
          if cur and cur.win and vim.api.nvim_win_is_valid(cur.win) then
            vim.api.nvim_win_close(cur.win, true)
          end
        end)
      end,
    })
  end
  vim.cmd.startinsert()
end
vim.keymap.set("n", "<leader>lg", function() toggle_float_term("lazygit") end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>ld", function() toggle_float_term("lazydocker") end, { desc = "Lazydocker" })

-- ============================================
-- PLUGINLER (yerleşik vim.pack — Neovim 0.12+)
-- ============================================

-- Treesitter güncellenince parser'ları da güncelle (lazy'deki build = ":TSUpdate" karşılığı)
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      vim.schedule(function() require("nvim-treesitter").update() end)
    end
  end,
})

vim.pack.add({
  "https://github.com/projekt0n/github-nvim-theme",
  "https://github.com/nvim-lua/plenary.nvim",       -- bağımlılık: telescope, neo-tree
  "https://github.com/nvim-telescope/telescope.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-tree/nvim-web-devicons", -- bağımlılık: neo-tree
  "https://github.com/MunifTanjim/nui.nvim",        -- bağımlılık: neo-tree
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/ThePrimeagen/vim-be-good",
}, { confirm = false })

-- :Vimpack = plugin güncellemelerini denetle (onaylamak için :w, vazgeçmek için :q, sonra :restart)
vim.api.nvim_create_user_command("Vimpack", function()
  vim.pack.update()
end, { desc = "Pluginleri Güncelle" })

-- TEMA
require("github-theme").setup({
  options = {
    transparent = true,
    styles = { sidebars = "transparent", floats = "transparent" },
  },
})
vim.cmd([[colorscheme github_dark_default]])

-- TELESCOPE
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "%.git/", "node_modules/" },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = { "--hidden" },
    },
  },
})
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Dosya Bul" })
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep additional_args={'--hidden'}<cr>", { desc = "Metin Ara" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Açık Dosyalar" })

-- TREESITTER (main branch - Neovim 0.11+ uyumlu API)
local langs = { "lua", "javascript", "typescript", "tsx", "python", "html", "css", "vue", "go", "astro", "svelte" }
require("nvim-treesitter").install(langs)

-- Highlight'ı dosya tipi açıldığında başlat
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ok = pcall(vim.treesitter.start, args.buf)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- NEO-TREE
require("neo-tree").setup({
  filesystem = {
    follow_current_file = { enabled = true },
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
})
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Dosya Ağacı" })

-- GITSIGNS
require("gitsigns").setup({
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "]c", function() gs.nav_hunk("next") end, opts)
    vim.keymap.set("n", "[c", function() gs.nav_hunk("prev") end, opts)
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Hunk Önizle" })
    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Hunk Geri Al" })
    vim.keymap.set("n", "<leader>hb", gs.blame_line, { buffer = bufnr, desc = "Satır Blame" })
  end,
})

-- CONFORM (Formatter)
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "biome", "prettier", stop_after_first = true },
    javascriptreact = { "biome", "prettier", stop_after_first = true },
    typescript = { "biome", "prettier", stop_after_first = true },
    typescriptreact = { "biome", "prettier", stop_after_first = true },
    json = { "biome", "prettier", stop_after_first = true },
    css = { "biome", "prettier", stop_after_first = true },
    vue = { "prettier" },
    astro = { "prettier" },
    svelte = { "prettier" },
    html = { "prettier" },
    python = { "black" },
    go = { "gofmt" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
})
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })

-- AUTOPAIRS
require("nvim-autopairs").setup({})

-- VIM-BE-GOOD: setup gerektirmiyor, :VimBeGood komutu kendiliğinden gelir

-- ============================================
-- KISAYOL ÖZETİ
-- ============================================
-- K           = İmleçteki kodun dökümanını oku (Hover)
-- Tab / S-Tab = Tamamlama menüsünde gezin (snippet içinde: durak atla)
-- Enter       = Seçili tamamlamayı kabul et
-- Ctrl+Space  = LSP tamamlamayı elle tetikle
-- Space + d   = Hata detayını pencerede gör
-- ]d          = Sonraki hataya git
-- [d          = Önceki hataya git
-- gd          = Tanıma git (Go Definition)
-- gr          = Referansları bul (References)
-- Space + ca  = Hata düzeltme önerileri (Code Action)
-- Space + r   = Değişken adını her yerde değiştir (Rename)
-- Space + cf  = Manuel format
-- Shift + H/L = Önceki/Sonraki buffer
-- Space + x   = Buffer kapat
-- ]c / [c     = Sonraki/Önceki git hunk
-- Space + hp  = Git hunk önizle
-- Space + hr  = Git hunk geri al
-- Space + hb  = Satır blame
-- ============================================
