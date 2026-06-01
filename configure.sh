#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: ./configure.sh https://your-domain.example/path/to/ios-ota-install"
  exit 1
fi

BASE_URL="${1%/}"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

python3 - "$ROOT_DIR" "$BASE_URL" <<'PY'
from pathlib import Path
import sys

root = Path(sys.argv[1])
base_url = sys.argv[2]
known_base_urls = {
    "https://example.com/ios-ota-install",
    "https://egeorgm.github.io/ios-ota-install",
}

for name in ("index.html", "manifest.plist", "config.example.json"):
    path = root / name
    text = path.read_text()
    for known_base_url in known_base_urls:
        text = text.replace(known_base_url, base_url)
    path.write_text(text)

print(f"Configured OTA base URL: {base_url}")
PY
