#!/usr/bin/env bash
# Contribute to upstream: sanitize on a side branch, push PR branch, keep master as production.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

BRANCH="feature/multi-app-showcase"
UPSTREAM="https://github.com/emilbaehr/automatic-app-landing-page.git"

if [[ "$(git branch --show-current)" != "master" ]]; then
  echo "Switch to master first."
  exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Uncommitted changes. Commit or stash first."
  exit 1
fi

git remote add upstream "$UPSTREAM" 2>/dev/null || git remote set-url upstream "$UPSTREAM"

git branch -D "$BRANCH" 2>/dev/null || true
git checkout -b "$BRANCH"

if [[ -f CNAME ]]; then
  git rm -f CNAME
fi

cat > _config.yml <<'YAML'
# Site Info (portfolio homepage)
page_title                                : My Apps
site_description                          : A collection of mobile apps. Add yours in _apps/.
ios_app_country                           : us

enable_smart_app_banner                   : false
auto_load_app_store_screenshots           : true

your_name                                 :
your_link                                 :
your_city                                 :
email_address                             :
linkedin_username                         :
linkedin_company                          :
facebook_username                         :
instagram_username                        :
twitter_username                          :
github_username                           :
youtube_username                          :
mastodon_link                             :

presskit_download_link                    :

topbar_color                              : "#000000"
topbar_transparency                       : 0.1
topbar_title_color                        : "#ffffff"

cover_image                               : assets/headerimage.png
cover_overlay_color                       : "#363b3d"
cover_overlay_transparency                : 0.8

device_color                              : black
body_background_color                     : "#ffffff"
link_color                                : "#1d63ea"

app_title_color                           : "#ffffff"
app_price_color                           : "#ffffff"
app_description_color                     : "#ffffff"

feature_title_color                       : "#000000"
feature_text_color                        : "#666666"
feature_icons_foreground_color            : "#1d63ea"
feature_icons_background_color            : "#e6e6e6"
social_icons_foreground_color             : "#666666"
social_icons_background_color             : "#e6e6e6"
footer_text_color                         : "#666666"

sass:
  style: :compressed

exclude:
  - LICENSE
  - README.md
  - CNAME

collections:
  pages:
    output: true
    permalink: /:path/
  apps:
    output: true
    permalink: /apps/:name/

markdown: kramdown
YAML

rm -f _apps/*.md
cat > _apps/example-app.md <<'MD'
---
layout: app
ios_app_id: 1234793120
app_description: Example app. Replace with your App Store ID in _apps/your-app.md.
device_color: black
features:
  - title: Automatic Metadata
    description: Icon, name, price and App Store link from iTunes API.
    fontawesome_icon_name: sync
  - title: Multi-App Portfolio
    description: Add more apps by creating files in _apps/.
    fontawesome_icon_name: mobile
---
MD

git add -A
git commit -m "Add multi-app portfolio landing page support" \
  -m "Portfolio homepage, per-app pages, iTunes screenshots and release notes." \
  || true

git push -u origin "$BRANCH" --force

git checkout master

PR_URL="https://github.com/emilbaehr/automatic-app-landing-page/compare/master...Ekildar27:automatic-app-landing-page:${BRANCH}?expand=1"
echo ""
echo "Done. Open this URL to create Pull Request to upstream:"
echo "$PR_URL"
echo ""
echo "Local master unchanged (ekildar.kfds.fr production config)."
