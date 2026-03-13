#!/usr/bin/env bash

# Install Actionlint
# See: https://github.com/rhysd/actionlint
ACTIONLINT_INSTALL_DIR="${HOME}/.local/bin"
ACTIONLINT_DOWNLOAD_URL="https://github.com/rhysd/actionlint/releases/download/v1.7.11/actionlint_1.7.11_linux_amd64.tar.gz"
ACTIONLINT_SHA256="900919a84f2229bac68ca9cd4103ea297abc35e9689ebb842c6e34a3d1b01b0a" # v1.7.11

TMPDIR=$(mktemp -d)
DOWNLOAD_TEMP_FILE="${TMPDIR}/actionlint.tar.gz"
wget "${ACTIONLINT_DOWNLOAD_URL}" -O "${DOWNLOAD_TEMP_FILE}"

# Verify the checksum of the downloaded file
sha256sum -c <(echo "${ACTIONLINT_SHA256}  ${DOWNLOAD_TEMP_FILE}") || { echo "Checksum verification failed for Actionlint"; exit 1; }

pushd "${TMPDIR}"
tar -xzf "${DOWNLOAD_TEMP_FILE}"
mkdir -p "${ACTIONLINT_INSTALL_DIR}"
cp actionlint "${ACTIONLINT_INSTALL_DIR}/"
popd

BASHRC="${HOME}/.bashrc"
touch "$BASHRC"
EXPORT_LINE="export PATH=\"${ACTIONLINT_INSTALL_DIR}:\${PATH}\""
if ! grep -Fxq "$EXPORT_LINE" "$BASHRC" 2>/dev/null; then
    printf '\n# Add actionlint to PATH\n%s\n' "$EXPORT_LINE" >> "$BASHRC"
fi
