#!/bin/sh
# Copies the web build (App/dist) here for Vercel. Build it first: cd App && npx expo export --platform web
# Vercel leaves every folder named node_modules out of a deployment, so the build's assets/node_modules
# (the fonts and icons) is renamed to assets/pkg and the app's paths to it are updated to match.
set -e
cd "$(dirname "$0")"
rsync -a --delete --exclude '.*' --exclude vercel.json --exclude update.sh ../App/dist/ ./
mv assets/node_modules assets/pkg
find _expo -name '*.js' -exec sed -i '' 's#assets/node_modules/#assets/pkg/#g' {} +
sed -i '' 's#assets/node_modules/#assets/pkg/#g' index.html
echo "Web updated from App/dist. Commit and push to deploy."
