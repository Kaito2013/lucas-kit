#!/usr/bin/env bash
# scripts/sync.sh: Tự động đồng bộ các quy chuẩn, component và tính năng mới từ upstream
# Đảm bảo giữ nguyên 100% thương hiệu Lucas và lịch sử commit cá nhân sạch đẹp.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

SYNC_FILE=".upstream-commit"

echo "🔍 Đang kiểm tra cập nhật mới từ upstream..."

# 1. Đảm bảo upstream remote tồn tại
if ! git remote get-url upstream >/dev/null 2>&1; then
  git remote add upstream https://github.com/evondev/evondevKit.git
fi

# 2. Lấy dữ liệu mới nhất từ nhánh master của upstream
git fetch upstream master --quiet

CURRENT_UPSTREAM=$(git rev-parse upstream/master)
LAST_SYNCED=$(cat "$SYNC_FILE" 2>/dev/null || echo "")

if [ "$CURRENT_UPSTREAM" = "$LAST_SYNCED" ]; then
  echo "✅ Bạn đang ở phiên bản mới nhất! Upstream chưa có cập nhật mới."
  exit 0
fi

echo "📦 Phát hiện commit mới trên upstream (${CURRENT_UPSTREAM:0:7}). Đang tiến hành đồng bộ..."

# 3. Kéo các cập nhật về references, components, layouts và tài liệu kỹ thuật
git checkout upstream/master -- skills/ui-ux/references/
git checkout upstream/master -- BACKLOG.md DARKMODE.md NEXT.md REVIEW.md TESTS.md 2>/dev/null || true

# 4. Nếu probe.mjs có bản cập nhật mới, tự động nạp và chuyển sang tiền tố lucas
TEMP_PROBE=$(mktemp)
git show upstream/master:skills/ui-ux/scripts/probe.mjs > "$TEMP_PROBE"
if [ -s "$TEMP_PROBE" ]; then
  sed -i '' 's/data-evon/data-lucas/g' "$TEMP_PROBE"
  sed -i '' 's/evonTransition/lucasTransition/g' "$TEMP_PROBE"
  sed -i '' 's/evonProbeId/lucasProbeId/g' "$TEMP_PROBE"
  sed -i '' 's/evonHoverId/lucasHoverId/g' "$TEMP_PROBE"
  sed -i '' 's/evonLayoutOnly/lucasLayoutOnly/g' "$TEMP_PROBE"
  sed -i '' 's/evonSeenLayer/lucasSeenLayer/g' "$TEMP_PROBE"
  sed -i '' 's/evonBefore/lucasBefore/g' "$TEMP_PROBE"
  sed -i '' 's/evonPopupId/lucasPopupId/g' "$TEMP_PROBE"
  sed -i '' 's/evonProbeOpened/lucasProbeOpened/g' "$TEMP_PROBE"
  sed -i '' 's/evonStateId/lucasStateId/g' "$TEMP_PROBE"
  sed -i '' 's/evonCheckedId/lucasCheckedId/g' "$TEMP_PROBE"
  sed -i '' 's/evonTrack/lucasTrack/g' "$TEMP_PROBE"
  sed -i '' 's/evonOpenerId/lucasOpenerId/g' "$TEMP_PROBE"
  sed -i '' 's/evon-probe/lucas-probe/g' "$TEMP_PROBE"
  sed -i '' 's/evon/lucas/g' "$TEMP_PROBE"
  cp "$TEMP_PROBE" skills/ui-ux/scripts/probe.mjs
  rm -f "$TEMP_PROBE"
fi

# 5. Lưu lại commit hash đã sync
echo "$CURRENT_UPSTREAM" > "$SYNC_FILE"

# 6. Chạy lint kiểm tra chất lượng quy tắc
echo "🧪 Đang kiểm tra lint quy tắc thiết kế..."
node skills/ui-ux/scripts/lint-skill.mjs --all

echo ""
echo "🎉 Đồng bộ hoàn tất! Toàn bộ tính năng mới đã được cập nhật."
echo "👉 Để lưu và đẩy lên GitHub cá nhân, bạn chỉ cần gõ:"
echo "   git add -A && git commit -m 'chore: sync updates from upstream' && git push origin master"
