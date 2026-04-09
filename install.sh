#!/usr/bin/env sh
set -e

BASE_URL="https://physmind.ai"
BIN="physmind"
INSTALL_DIR="/usr/local/bin"

OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  Darwin)
    case "$ARCH" in
      arm64)  ASSET="physmind-macos-arm64" ;;
      x86_64) ASSET="physmind-macos-x86_64" ;;
      *)      echo "Unsupported architecture: $ARCH" && exit 1 ;;
    esac
    ;;
  Linux)
    case "$ARCH" in
      x86_64)  ASSET="physmind-linux-x86_64" ;;
      aarch64) ASSET="physmind-linux-arm64" ;;
      *)       echo "Unsupported architecture: $ARCH" && exit 1 ;;
    esac
    ;;
  *)
    echo "Unsupported OS: $OS"
    echo "Windows: download https://physmind.ai/physmind-windows-x86_64.exe"
    exit 1
    ;;
esac

URL="$BASE_URL/$ASSET"

echo "Downloading PhysMind CLI..."
curl -fsSL "$URL" -o "/tmp/$BIN"
chmod +x "/tmp/$BIN"

if [ -w "$INSTALL_DIR" ]; then
  mv "/tmp/$BIN" "$INSTALL_DIR/$BIN"
else
  sudo mv "/tmp/$BIN" "$INSTALL_DIR/$BIN"
fi

echo ""
echo "PhysMind CLI installed! Run: physmind"
