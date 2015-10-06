#!/bin/bash

set -o nounset -o errexit -o pipefail -o noglob

trap "rm -rf /tmp/msysgit-extrabin" EXIT

die() {
  echo "Error: $*" >&2
  exit 1
}

(cd /tmp && git clone --depth 1 --branch master https://github.com/mojocorp/msysgit-extrabin.git)

git_version=$(git --version | cut -d' ' -f 3)
arch=$(uname -m)
toolpath=/tmp/msysgit-extrabin/${git_version}/${arch}

[ -d "${toolpath}" ] || die "unsupported git version"

cp -r -n "${toolpath}"/. / || die "unable to copy the tools"

echo "Success"
