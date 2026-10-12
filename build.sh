#!/bin/sh
# Packages the plugin as project-spec.plugin for Claude Cowork.
set -e
cd "$(dirname "$0")"
rm -f project-spec.plugin
zip -rq project-spec.plugin .claude-plugin/plugin.json skills README.md -x "*.DS_Store"
echo "built project-spec.plugin"
