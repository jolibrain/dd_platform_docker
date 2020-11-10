#!/bin/bash

set -e

here=$(readlink -f $(dirname $0))
kind=${1:-minor}

dd_server_version=$(curl https://api.github.com/repos/jolibrain/deepdetect/releases/latest | jq -r .tag_name)
dd_platform_ui_version=$(curl https://api.github.com/repos/jolibrain/platform_ui/releases/latest | jq -r .tag_name)

# TODO(sileht): build stable version of them, jupyter need to be prefixed with the upstream version 
# dd_filebrowser_version=latest
# dd_jupyter_version=latest

cd $here/..

sed -i -e "s,^DD_SERVER_TAG=.*,DD_SERVER_TAG=${dd_server_version},g" code/cpu/.env code/gpu/.env
git add code/cpu/.env code/gpu/.env
git commit --no-edit -m "feat(deepdetect): upgrade to ${dd_server_version}" code/cpu/.env code/gpu/.env

sed -i -e "s,^DD_PLATFORM_UI_TAG=.*,DD_PLATFORM_UI_TAG=${dd_platform_ui_version},g" code/cpu/.env code/gpu/.env
git add code/cpu/.env code/gpu/.env
git commit --no-edit -m "feat(platform_ui): upgrade to ${dd_platform_ui_version}" code/cpu/.env code/gpu/.env

git rm CHANGELOG.md || true
yarn run standard-version -r $kind
tag=$(cat package.json | jq -r .version)

sed -ne "/^## $tag/,/^##.*202/p" CHANGELOG.md | sed -e '$d' -e '1d' > note.md.tmp

cat > note.md <<EOF
### Versions:

* DeepDetect Server C++ and REST API: [$dd_server_version](https://github.com/jolibrain/deepdetect/releases/tag/v0.11.0)
* DeepDetect Platform UI: [$dd_platform_ui_version](https://github.com/jolibrain/platform_ui/releases/tag/v0.10.0)
* All docker images available on https://hub.docker.com/u/jolibrain
EOF
cat note.md.tmp >> note.md

trap "rm -f note.md note.md.tmp" EXIT
gh release create --title "DeepDetect Platform v$tag" -F note.md -d v$tag
