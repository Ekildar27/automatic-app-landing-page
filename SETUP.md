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
jekyll serve --host 127.0.0.1 --port 4000
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

后续部署时，可将 `Gemfile` 改回 `gem 'github-pages'` 以匹配 GitHub Pages 环境，或直接使用 GitHub Actions 构建。
