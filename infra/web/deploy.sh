#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/deploy.env" ]; then
  set -a
  # shellcheck disable=SC1091
  . "$SCRIPT_DIR/deploy.env"
  set +a
fi

: "${SSH_HOST:?Thiếu SSH_HOST (sửa deploy.env hoặc export)}"
: "${SSH_USER:?Thiếu SSH_USER}"
: "${SSH_PASSWORD:?Thiếu SSH_PASSWORD}"
SSH_PORT="${SSH_PORT:-22}"

IMAGE="${IMAGE:-phongit1995/ola-web}"
TAG="${TAG:-latest}"
CONTAINER="${CONTAINER:-ola-web}"
HOST_PORT="${HOST_PORT:-5081}"
NETWORK="${NETWORK:-dockflare-internal}"
DOMAIN="${DOMAIN:-web.ola-server.click}"
DOCKFLARE_SERVICE="${DOCKFLARE_SERVICE:-http://phong.local:${HOST_PORT}}"

command -v sshpass >/dev/null 2>&1 || {
  echo "Cần cài sshpass: brew install sshpass" >&2
  exit 1
}

echo "→ Deploy ${IMAGE}:${TAG} tới ${SSH_USER}@${SSH_HOST}:${SSH_PORT}"
echo "  container=${CONTAINER} port=${HOST_PORT} domain=${DOMAIN}"

sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=accept-new -p "$SSH_PORT" "${SSH_USER}@${SSH_HOST}" bash -s <<EOF
set -euo pipefail
echo "[remote] pull ${IMAGE}:${TAG}"
docker pull "${IMAGE}:${TAG}"
echo "[remote] recreate container ${CONTAINER}"
docker rm -f "${CONTAINER}" >/dev/null 2>&1 || true
docker run -d --name "${CONTAINER}" --network "${NETWORK}" -p ${HOST_PORT}:80 --restart unless-stopped --label dockflare.enable=true --label dockflare.hostname=${DOMAIN} --label dockflare.service=${DOCKFLARE_SERVICE} "${IMAGE}:${TAG}" >/dev/null
docker image prune -f >/dev/null 2>&1 || true
echo "[remote] status:"
docker ps --filter "name=^/${CONTAINER}\$" --format "  {{.Image}} | {{.Status}} | {{.Ports}}"
EOF

echo "→ Xong. Kiểm tra: https://${DOMAIN}/"
