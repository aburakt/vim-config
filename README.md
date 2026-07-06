# Minimal Neovim & WezTerm Konfigürasyonu

Bu repo, kişisel, sadeleştirilmiş ve performans odaklı **Neovim** ve **WezTerm** konfigürasyonlarımı içerir. Tek dosya (`init.lua`) tabanlı, çekirdek API öncelikli bir Neovim yapısı ve minimal bir terminal deneyimi sunar.

> Not: Repo adı eski LazyVim döneminden kalmadır. Artık ne LazyVim ne de lazy.nvim kullanılıyor — plugin yönetimi dahil her şey mümkün olduğunca Neovim çekirdeğiyle yapılıyor.

## 🚀 Neovim Kurulumu

### Gereksinimler

- **Neovim 0.12+** (zorunlu — `vim.pack`, `'autocomplete'` ve `vim.lsp.completion` çekirdek özellikleri kullanılıyor)
- `git` ve bir **C derleyici** (treesitter parser derlemek için; macOS: `xcode-select --install`, Windows: VS Build Tools veya `zig`)
- `ripgrep` (Telescope metin arama)
- Bir **Nerd Font** (ikonlar için; WezTerm config'i CaskaydiaCove bekliyor)
- Dil sunucuları (PATH'te olmalı, Mason yok): `lua-language-server`, `typescript-language-server`, `vue-language-server`, `pyright`, `gopls`, `astro-ls`, `svelteserver`
- Formatlayıcılar: `stylua`, `biome` veya `prettier`, `black` (`gofmt` Go ile gelir)
- Opsiyonel: `lazygit`, `lazydocker` (yüzen terminal kısayolları için)

### Kurulum

Mevcut Neovim konfigürasyonunuzu yedekledikten sonra:

```bash
# macOS / Linux
git clone https://github.com/aburakt/lazyvim-config.git ~/.config/nvim
```

```powershell
# Windows (PowerShell)
git clone https://github.com/aburakt/lazyvim-config.git $env:LOCALAPPDATA\nvim
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

## 🖥️ WezTerm Kurulumu

Göz yormayan, şeffaf ve bulanıklık (blur) efektli, sekmesiz (tabless) minimal terminal yapılandırması.

### Özellikler
- **Görünüm:** Özel koyu mavi tema, %80 opaklık ve blur efekti.
- **Font:** CaskaydiaCove Nerd Font.
- **Minimalizm:** Tab bar kapatıldı, sadece içerik odaklı.

### Kurulum

`wezterm/wezterm.lua` dosyasını home dizininize `.wezterm.lua` olarak kopyalayın veya symlink oluşturun.

```bash
# macOS / Linux
ln -s $(pwd)/wezterm/wezterm.lua ~/.wezterm.lua
```

### Kısayollar

| Tuş Kombinasyonu | İşlev |
|------------------|-------|
| `Cmd + d` | Ekranı Yatay Böl (Split Horizontal) |
| `Cmd + Shift + d` | Ekranı Dikey Böl (Split Vertical) |
| `Cmd + Opt + Oklar` | Pencereler Arası Geçiş |
| `Cmd + Ctrl + Oklar` | Pencere Boyutlandırma |

---

## Lisans
Bu proje MIT lisansı ile lisanslanmıştır.
