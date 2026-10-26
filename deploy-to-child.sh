#!/usr/bin/env bash
# محرك توزيع مهارات الأم إلى المشاريع الفرعية (الأولاد)
# الاستخدام: ./deploy-to-child.sh /path/to/child-project
set -euo pipefail

TARGET="${1:-}"

if [ -z "$TARGET" ]; then
  echo "❌ خطأ: يرجى تحديد مسار المشروع الفرعي!"
  echo "مثال: ./deploy-to-child.sh ~/Documents/projects/diagnostics/inbox/mybaby-omen"
  exit 1
fi

mkdir -p "$TARGET/.agents"

# ربط المهارات كـ Symlink لضمان التحديث التلقائي
rm -rf "$TARGET/.agents/skills"
ln -s "$(pwd)/.agents/skills" "$TARGET/.agents/skills"

# نسخ ملفات الحوكمة
[ ! -f "$TARGET/AGENTS.md" ] && cp AGENTS.md "$TARGET/AGENTS.md" && cp GEMINI.md "$TARGET/GEMINI.md"
[ ! -f "$TARGET/PROJECT_STATE.md" ] && cp PROJECT_STATE.md "$TARGET/PROJECT_STATE.md"

echo "✓ تم ربط المشروع الفرعي بمحرك الأم بنجاح: $TARGET"
