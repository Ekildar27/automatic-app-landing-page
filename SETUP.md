# 多 App 展示落地页

基于 [automatic-app-landing-page](https://github.com/emilbaehr/automatic-app-landing-page) 改造，支持在首页展示多个 App，每个 App 有独立详情页。

## 本地运行

需要 Ruby 3.x（推荐 Homebrew 安装的 Ruby）。

```bash
# 安装 Jekyll（若尚未安装）
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"
gem install jekyll:4.3.4 webrick --no-document

# 进入项目目录
cd app-landing-page

# 构建
jekyll build

# 本地预览（浏览器打开 http://127.0.0.1:4000）
jekyll serve --config _config.yml,_config_dev.yml --host 127.0.0.1 --port 4000
```

## 添加新 App

1. 在 `_apps/` 下新建 Markdown 文件，例如 `_apps/my-app.md`：

```yaml
---
layout: app
ios_app_id: 1234567890
app_description: 一句话简介
device_color: black   # black | blue | yellow | coral | white
features:
  - title: 功能标题
    description: 功能描述
    fontawesome_icon_name: star
---
```

2. （可选）上传截图到 `assets/screenshots/my-app/`（文件名任意，支持 png/jpg）
3. （可选）上传视频到 `assets/videos/my-app/`（mp4/webm/ogg）

### What's New（更新说明）

每个 App 支持在详情页和顶部导航 **What's New** 页面展示更新内容：

1. **优先本地配置** — 在 `_apps/my-app.md` 的 front matter 中：

```yaml
whats_new:
  - version: "1.2"
    items:
      - 新功能描述
      - 修复了某个问题
```

或在 front matter 下方写 Markdown 正文（作为更新说明）。

2. **未配置时自动拉取** — 从 App Store（iTunes API）读取 `releaseNotes` 和版本号。

图标、名称、价格、App Store 链接会通过 iTunes API 根据 `ios_app_id` 自动填充。

**App Store 截图**也会自动加载（仅 iPhone 截图，`auto_load_app_store_screenshots: true`），有几张拉几张。详情页 iPhone 预览框下方可用左右箭头、圆点或键盘方向键切换。若本地有截图或视频，则优先使用本地文件。

## 当前 App 列表

| 文件 | App Store ID | 页面路径 |
|------|-------------|----------|
| `nexus-note.md` | 6797005454 | `/apps/nexus-note/` |
| `moments-with-mom.md` | 6801768385 | `/apps/moments-with-mom/` |
| `animal-zoom.md` | 6449437829 | `/apps/animal-zoom/` |
| `animal-zoom-pro.md` | 6746965982 | `/apps/animal-zoom-pro/` |

## 全站配置

编辑 `_config.yml` 修改站点标题、主题颜色、页脚社交链接等。

## 部署到 GitHub Pages

站点通过 GitHub Actions 自动部署。生产环境使用自定义域名：

```yaml
url: "https://ekildar.kdns.fr"
baseurl: ""
```

本地预览（保留 github.io 子路径）：

```bash
jekyll serve --config _config.yml,_config_dev.yml --host 127.0.0.1 --port 4000
```

### 自定义域名 DNS（kdns.fr）

在 kdns 面板为 `ekildar.kdns.fr` 添加 **CNAME**（推荐）：

| 类型 | 名称 | 值 |
|------|------|-----|
| CNAME | `ekildar` | `ekildar27.github.io` |

若经 Cloudflare 代理，GitHub 校验 DNS 可能失败：请先将该记录改为 **灰云（DNS only）**，验证通过后再开橙云。

GitHub Pages → Custom domain 填 **`ekildar.kdns.fr`**（不要带 `www`）。仓库根目录 `CNAME` 文件内容相同。

`www.ekildar.kdns.fr` 无需配置；若 GitHub 报 `www` 相关错误，说明填错域名或浏览器缓存了旧设置，改回 apex 即可。

DNS 生效后勾选 **Enforce HTTPS**。
