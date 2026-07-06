# Minimal Neovim & Ghostty Konfigürasyonu

Kişisel, sadeleştirilmiş ve çekirdek API öncelikli **Neovim** konfigürasyonum ile **Ghostty** terminal ayarlarım. Neovim tarafı tek dosya (`init.lua`) tabanlıdır; plugin yönetimi dahil her şey mümkün olduğunca Neovim çekirdeğiyle yapılır.

## 🚀 Neovim Kurulumu

### Gereksinimler

- **Neovim 0.12+** (zorunlu — `vim.pack`, `'autocomplete'` ve `vim.lsp.completion` çekirdek özellikleri kullanılıyor)
- `git` ve bir **C derleyici** (treesitter parser derlemek için; macOS: `xcode-select --install`, Windows: VS Build Tools veya `zig`)
- `ripgrep` (Telescope metin arama)
- Bir **Nerd Font** ya da ikon destekli font (dosya ağacı ikonları için)
- Dil sunucuları (PATH'te olmalı, Mason yok): `lua-language-server`, `typescript-language-server`, `vue-language-server`, `pyright`, `gopls`, `astro-ls`, `svelteserver`
- Formatlayıcılar: `stylua`, `biome` veya `prettier`, `black` (`gofmt` Go ile gelir)
- Opsiyonel: `lazygit`, `lazydocker` (yüzen terminal kısayolları için)

### Kurulum

Mevcut Neovim konfigürasyonunuzu yedekledikten sonra:

```bash
# macOS / Linux
git clone https://github.com/aburakt/vim-config.git ~/.config/nvim
```

```powershell
# Windows (PowerShell)
git clone https://github.com/aburakt/vim-config.git $env:LOCALAPPDATA\nvim
```

İlk açılışta `vim.pack` tüm eklentileri `nvim-pack-lock.json`'daki revizyonlarla kendisi klonlar, treesitter parser'ları derlenir. Sorun olursa `:checkhealth` ile kontrol edin.

### Özellikler

- **Plugin yöneticisi:** Yerleşik `vim.pack` — güncelleme için `:Vimpack` (onay: `:w`, vazgeç: `:q`, sonra `:restart`)
- **LSP:** Native `vim.lsp.config` / `vim.lsp.enable` — sunucular doğrudan PATH'ten
- **Otomatik Tamamlama:** Yerleşik `'autocomplete'` + `vim.lsp.completion` (cmp yok, sıfır bağımlılık)
- **Dosya Gezgini:** `neo-tree.nvim`
- **Arama:** `telescope.nvim`
- **Git:** `gitsigns.nvim`
- **Format:** `conform.nvim` (kayıtta otomatik)
- **Terminal:** Yerleşik API ile yüzen `lazygit` / `lazydocker` (plugin yok)
- **Tema:** `github-nvim-theme` (Transparent mod aktif)

### Önemli Kısayollar (Leader: Space)

| Tuş Kombinasyonu | İşlev |
|------------------|-------|
| `<Space> f` | Dosya Ara (Telescope) |
| `<Space> g` | Metin Ara (Grep) |
| `<Space> b` | Açık Buffer'lar |
| `<Space> e` | Dosya Ağacını Aç/Kapa (NeoTree) |
| `<Space> lg` | Lazygit |
| `<Space> ld` | Lazydocker |
| `Tab` / `S-Tab` | Tamamlama menüsünde gezin (snippet içinde durak atla) |
| `Enter` | Seçili tamamlamayı kabul et |
| `Ctrl + Space` | LSP tamamlamayı elle tetikle |
| `K` | Dökümantasyonu Gör (Hover) |
| `gd` | Tanıma Git (Go to Definition) |
| `gr` | Referansları Bul |
| `<Space> d` | Hata detayını gör |
| `]d` / `[d` | Sonraki / Önceki hata |
| `<Space> ca` | Hata Düzeltme (Code Action) |
| `<Space> r` | Yeniden Adlandır (Rename) |
| `<Space> cf` | Manuel Format |
| `Shift + H/L` | Önceki / Sonraki buffer |
| `<Space> x` | Buffer kapat |
| `]c` / `[c` | Sonraki / Önceki git hunk |
| `<Space> hp/hr/hb` | Hunk önizle / geri al / blame |

---

## 🖥️ Ghostty Kurulumu

Minimal Ghostty yapılandırması: Monaspace Neon fontu, texture healing ve coding ligature'ları aktif.

> Ghostty şu an macOS ve Linux'ta mevcut; Windows'ta bu reponun yalnızca Neovim kısmı geçerlidir.

```bash
# macOS / Linux
mkdir -p ~/.config/ghostty
ln -sf $(pwd)/ghostty/config ~/.config/ghostty/config
```

---

## Lisans
Bu proje MIT lisansı ile lisanslanmıştır.
