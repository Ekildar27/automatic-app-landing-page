# Multi-App Portfolio

This fork adds a portfolio homepage and per-app detail pages.

## Add an app

Create `_apps/my-app.md`:

```yaml
---
title: My App
layout: app
app_name: My App
ios_app_id: 1234567890
app_description: One-line description
device_color: black
features:
  - title: Feature
    description: Description
    fontawesome_icon_name: star
---
```

Optional: `ios_app_country: cn` for region-specific App Store lookup.
Optional: `app_description_zh` for homepage Chinese copy (EN/中文 toggle).

## Per-app Privacy Policy & Terms of Use

Create `_legal/my-app/privacy.md` and `_legal/my-app/terms.md`:

```yaml
---
layout: legal
title: Privacy Policy
title_zh: 隐私政策
app_slug: my-app
app_name: My App
doc_type: privacy
---
```

Pages are published at `/apps/my-app/privacy/` and `/apps/my-app/terms/` with an EN / 中文 toggle.
Replace the placeholder copy in `_includes/legal-privacy-placeholder.html` and `_includes/legal-terms-placeholder.html`.

## Local preview

```bash
bundle install
jekyll serve --config _config.yml,_config_dev.yml
```

## GitHub Pages

For `https://username.github.io/repo-name/`, set in `_config.yml`:

```yaml
url: "https://username.github.io"
baseurl: "/repo-name"
```

Deploy with the included GitHub Actions workflow (`.github/workflows/jekyll.yml`).
