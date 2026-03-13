#!/usr/bin/env bash

# Install Actionlint
# See: https://github.com/rhysd/actionlint
ACTIONLINT_INSTALL_DIR="${HOME}/.local/bin"
ACTIONLINT_DOWNLOAD_URL="https://github.com/rhysd/actionlint/releases/download/v1.7.11/actionlint_1.7.11_linux_amd64.tar.gz"
ACTIONLINT_SHA256="900919a84f2229bac68ca9cd4103ea297abc35e9689ebb842c6e34a3d1b01b0a" # v1.7.11

DOWNLOAD_TEMP_FILE="$(mktemp -d)/actionlint.tar.gz"
wget "${ACTIONLINT_DOWNLOAD_URL}" -O "${DOWNLOAD_TEMP_FILE}"

# Verify the checksum of the downloaded file
sha256sum -c <(echo "${ACTIONLINT_SHA256}  ${DOWNLOAD_TEMP_FILE}") || { echo "Checksum verification failed for Actionlint"; exit 1; }

pushd "${DOWNLOAD_TEMP_FILE}"
tar -xzf "${DOWNLOAD_TEMP_FILE}"
mkdir -p "${ACTIONLINT_INSTALL_DIR}"
cp actionlint "${ACTIONLINT_INSTALL_DIR}/"
echo 'export PATH=\"${ACTIONLINT_INSTALL_DIR}:${PATH}\"' >> ~/.bashrc
popd
