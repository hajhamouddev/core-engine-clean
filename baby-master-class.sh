#!/usr/bin/env bash
# ==============================================================================
# baby-master-class.sh
# المنظومة الهندسية والتنفيذية الشاملة (35 مهارة تخصصية بمستوى بروفيسور + حوكمة النظم)
# الاستخدام:  cd your-project && bash baby-master-class.sh
# ==============================================================================
set -euo pipefail

ROOT="${1:-.}"

echo "🚀 جاري بناء منظومة Baby Master Class..."

# 1. إنشاء شجرة المجلدات لجميع المهارات الـ 35
SKILLS=(
  "verify-online" "project-memory" "careful-coder" "app-troubleshoot" "web-design-review"
  "project-lead" "qt-desktop-design" "mobile-app-architect" "linux-system-integration"
  "code-refactor-architect" "linux-deb-releaser" "engineering-management" "product-strategy-lead"
  "python-core-specialist" "flutter-mobile-engineer" "apple-ios-specialist" "android-native-specialist"
  "code-sentinel-auditor" "mobile-uiux-designer" "desktop-uiux-designer" "web-frontend-designer"
  "ecommerce-architect" "deep-research-analyst" "source-intelligence-validator" "strategic-innovation-ideator"
  "market-competitor-scout" "database-security-architect" "devops-infra-specialist" "docker-container-master"
  "ai-prompt-engineer" "github-workflow-expert" "terminal-bash-wizard" "vscode-environment-master"
  "strategic-planning-architect" "algorithms-data-structures-architect"
)

for s in "${SKILLS[@]}"; do
  mkdir -p "$ROOT/.agents/skills/$s"
done

# ---------------------------------------------------------------- AGENTS.md & GEMINI.md
cat > "$ROOT/AGENTS.md" <<'EOF_AGENTS'
# Working agreement (read fully at the start of every session)

## Who you work with
A software engineer who manages projects end to end: web pages, apps, redesigns,
strategy, builds, e-commerce stores. Extremely detail-oriented. Small details matter.
Treat the user as an expert: no basics, no filler, no motivational talk.

## Language
- Reply in Levantine (Shami) Arabic. Keep technical terms, code, commands, file
  names and code comments in English.

## Truth rules (most important)
1. Your training knowledge is OLD. Assume it is 1-3 years behind. Never answer from
   memory about anything that changes: product models and releases, software or
   library versions, APIs, flags, prices, laws, news, "latest" or "current" anything.
2. For those topics: use the `verify-online` and `source-intelligence-validator` skills.
3. Get today's date from the system (`date`) at session start. Never guess the year.
4. Never invent functions, flags, config keys, packages or file paths.
5. If sources disagree, show the disagreement. Do not pick silently.
6. Never say something worked unless you saw real output proving it.

## Working rules
- Read the actual file before editing it. Never edit from memory of the file.
- One change at a time. Edit only the part needed. Do not rewrite whole files.
- Before any risky change: make sure there is a git commit or a backup.
- Show every change as before/after, plus the exact command to test it.
- Diagnose before fixing: use `careful-coder` and `app-troubleshoot`.
- Ask at most ONE clarifying question, only if you cannot proceed.

## Memory and drift control
- At session start, read `PROJECT_STATE.md`. It is the source of truth.
- Update it immediately after every milestone, decision or failure.
- Every ~20 messages, re-read `PROJECT_STATE.md` and the last relevant files BEFORE answering.
EOF_AGENTS
cp "$ROOT/AGENTS.md" "$ROOT/GEMINI.md"

# ---------------------------------------------------------------- PROJECT_STATE.md
if [ ! -f "$ROOT/PROJECT_STATE.md" ]; then
cat > "$ROOT/PROJECT_STATE.md" <<'EOF_STATE'
# PROJECT_STATE

## Goal (one sentence)
-

## Environment (OS, language, frameworks, how it is run/deployed)
-

## Current status
-

## Done (newest first)
-

## Decisions (with the reason)
-

## Known problems / what failed (and what we already tried)
-

## Do NOT do (lessons learned)
-

## Next step (exactly one)
-

## Useful commands
-
EOF_STATE
fi

# ================================================================ 1. verify-online
cat > "$ROOT/.agents/skills/verify-online/SKILL.md" <<'EOF_SKILL'
---
name: verify-online
description: التحقق الرقمي المباشر عبر الإنترنت قبل الإجابة. التحقق من الإصدارات الحديثة، توافق المكتبات، الأسعار، التوثيق الرسمي، لتفادي البيانات المتقادمة.
---
# ميثاق التحقق الرقمي عبر الإنترنت
1. استخراج تاريخ اليوم بدقة عبر أمر `date` واستخدامه في صياغة الاستعلامات.
2. صياغة 2-3 استعلامات بحث مختلفة الزوايا والمصطلحات.
3. الاعتماد الحصري على المصادر الأولية: التوثيق الرسمي ومستودعات الأكواد.
4. قراءة محتوى الصفحات مباشرة دون الاكتفاء بمقتطفات البحث.
5. مطابقة النتائج مع مصدرين مستقلين على الأقل قبل تأكيد أي معلومة.
EOF_SKILL

# ================================================================ 2. project-memory
cat > "$ROOT/.agents/skills/project-memory/SKILL.md" <<'EOF_SKILL'
---
name: project-memory
description: حوكمة ذاكرة المشروع وإدارة ملف PROJECT_STATE.md لمنع النسيان وانحراف الأهداف في الجلسات الطويلة.
---
# ميثاق ذاكرة وحالة المشروع
- ملف `PROJECT_STATE.md` هو المصدر الوحيد للحقيقة (Single Source of Truth).
- التحديث الفوري بعد كل مرحلة: إضافة المنجزات إلى Done، والقرارات إلى Decisions، والأعطال إلى Known problems.
- مراجعة الملف دورياً لضمان عدم الانحراف عن الهدف الأساسي، والحفاظ على حجمه تحت 150 سطراً.
EOF_SKILL

# ================================================================ 3. careful-coder
cat > "$ROOT/.agents/skills/careful-coder/SKILL.md" <<'EOF_SKILL'
---
name: careful-coder
description: هندسة التصحيح البرمجي الجراحي والحذر. يحل الأعطال بتعديل أصغر جزء ممكن من الكود دون كسر الوظائف القائمة.
---
# ميثاق المبرمج الحذر
1. تشخيص السبب الجذري أولاً وتحديده في سطر واحد بالدليل والسطر والملف.
2. التحقق من حالة Git وعمل نسخة احتياطية قبل أي تعديل حساس.
3. تعديل الملف المستهدف بأقل عدد ممكن من الأسطر وتجنب إعادة كتابة الملفات بالكامل.
4. عرض التعديل بصيغة المقارنة (Before / After) مرفقاً بأمر الفحص الدقيق.
5. حظر ادعاء نجاح أي حل برمجي دون معاينة مخرجات التنفيذ الحقيقية.
EOF_SKILL

# ================================================================ 4. app-troubleshoot
cat > "$ROOT/.agents/skills/app-troubleshoot/SKILL.md" <<'EOF_SKILL'
---
name: app-troubleshoot
description: تشخيص وحصر أعطال التطبيقات القائمة وحل مشاكل التجمد والخروج الصامت وتشوه النوافذ وقراءة السجلات بعمق.
---
# ميثاق تشخيص أعطال التطبيقات
1. تحديد العَرَض بدقة: قراءة الـ Traceback من الأسفل للأعلى وحصر السطر الفعلي داخل كود المشروع.
2. تتبع الأعطال الصامتة والعمليات المعلقة عبر `pgrep -af` و `strace` وسجلات `journalctl --user`.
3. فحص تطابق النسخة المثبتة على النظام مع كود المشروع لتفادي تعديل ملفات معزولة.
4. تجنب ابتلاع الاستثناءات (`except: pass`) والتحقق من تحذيرات التنسيق والتوافق مع Wayland و X11.
EOF_SKILL

# ================================================================ 5. web-design-review
cat > "$ROOT/.agents/skills/web-design-review/SKILL.md" <<'EOF_SKILL'
---
name: web-design-review
description: تدقيق واجهات وتصاميم الويب بدقة متناهية (التجاوب، المسافات، الخطوط، التباين اللوني، إمكانية الوصول، وسرعة التحميل).
---
# ميثاق تدقيق واجهات الويب
- الالتزام بمقياس مسافات رياضي ثابت (4/8/16/24/32px) وضبط التباين اللوني وفق معيار WCAG AA (4.5:1).
- دعم الاتجاه العربي (RTL) الصارم عبر الخواص المنطقية ومحاذاة الأيقونات والأسهم.
- فحص الأداء ومؤشرات Core Web Vitals (LCP, CLS, INP) وإلغاء حظر التحميل للموارد.
EOF_SKILL

# ================================================================ 6. project-lead
cat > "$ROOT/.agents/skills/project-lead/SKILL.md" <<'EOF_SKILL'
---
name: project-lead
description: قيادة وتخطيط وتوجيه المشاريع البرمجية من الفكرة إلى التسليم (النطاق، المهام، المخاطر، والخطط).
---
# ميثاق القيادة التقنية للمشاريع
- صياغة أهداف المشروع ومعايير القبول القابلة للقياس بدقة وتحديد ما هو داخل وخارج النطاق بحزم.
- تفكيك المهام إلى حزم عمل يومية محددة المخرجات وتقديم المهام ذات المخاطر العالية أولاً.
- تقديم تقارير حالة تنفيذية مركزة تلخص المنجزات والخطوات التالية.
EOF_SKILL

# ================================================================ 7. qt-desktop-design
cat > "$ROOT/.agents/skills/qt-desktop-design/SKILL.md" <<'EOF_SKILL'
---
name: qt-desktop-design
description: مهارة بروفيسور واجهات سطح المكتب لـ PySide6 و Qt6 (QSS، تحجيم Wayland، وتفادي تجمد الشاشة).
---
# ميثاق بروفيسور واجهات سطح المكتب (Qt6 / PySide6)
- حظر الأبعاد الثابتة (`fixedSize`) والاعتماد على تخطيطات مرنة داخل `QScrollArea(widgetResizable=True)`.
- اعتماد خطوط macOS: `SF Pro Display` للعناوين، و `SF Mono` الحصري لقراءات الـ RPM والواط والحرارة.
- تجنب الأقواس المزدوجة بالنصوص العادية لمنع تحذيرات `could not parse stylesheet`.
- استبدال الـ Shadows المنهكة بحدود رقيقة ناعمة `1px solid rgba(255, 255, 255, 0.08)`.
- تفريغ قراءة الحساسات والـ I/O إلى `QThread`؛ خيط الشاشة الأساسي مخصص للعرض التفاعلي فقط.
EOF_SKILL

# ================================================================ 8. mobile-app-architect
cat > "$ROOT/.agents/skills/mobile-app-architect/SKILL.md" <<'EOF_SKILL'
---
name: mobile-app-architect
description: مهارة بروفيسور هندسة وتطوير تطبيقات الجوال لأنظمة Flutter و React Native وإدارة الحالة ودورة الحياة.
---
# ميثاق بروفيسور تطبيقات الجوال
- عزل تام بين طبقة الواجهة (UI)، طبقة منطق التطبيق (State)، وطبقة البيانات (Repository).
- إيقاف المؤقتات ومستمعي البث عند انتقال التطبيق للخلفية لحفظ البطارية.
- الحفاظ على معدل إطارات سلس (60/120 FPS) وعزل بناء العناصر لتفادي إعادة رسم كامل الشجرة.
- التوافق مع وسائط التشغيل المختلفة (أجهزة حقيقية وبيئة Waydroid على أنظمة لينكس).
EOF_SKILL

# ================================================================ 9. linux-system-integration
cat > "$ROOT/.agents/skills/linux-system-integration/SKILL.md" <<'EOF_SKILL'
---
name: linux-system-integration
description: مهارة كبير مهندسي تكامل أنظمة لينكس والعتاد (sysfs, hp-wmi, RAPL, udev, systemd, PipeWire).
---
# ميثاق كبير مهندسي عتاد لينكس
- استكشاف مسارات الحساسات بمطابقة الاسم الداخلي `/sys/class/hwmon/hwmon*/name` دون افتراض أرقام ثابتة.
- حساب استهلاك طاقة المعالج (RAPL) بالواط بدقة رياضية عبر فروق الطاقة بالزمن.
- تطبيق منحنى التباطؤ (Hysteresis) للمراوح لتفادي التذبذب الصوتي والضجيج المفاجئ.
- ضبط قواعد udev لمنح المستخدم العادي صلاحيات العتاد، وتفعيل خدمات `systemd --user` للتشغيل التلقائي.
- ضبط معالجة صوت PipeWire بمحدد قمة صارم عند `-1.0 dBFS` وتطبيق بروفايل DTS الرسمي لويندوز.
EOF_SKILL

# ================================================================ 10. code-refactor-architect
cat > "$ROOT/.agents/skills/code-refactor-architect/SKILL.md" <<'EOF_SKILL'
---
name: code-refactor-architect
description: مهارة بروفيسور نظافة وهندسة البرمجيات وإعادة الهيكلة وتفكيك الملفات المتضخمة وتطبيق مبادئ SOLID.
---
# ميثاق بروفيسور إعادة الهيكلة البرمجية
- تفكيك الكتل المتضخمة التي تتجاوز 500 سطر وفصل منطق الأعمال والعتاد عن عناصر الواجهة الرسومية.
- كتابة تعليقات الأنواع الصارمة (Type Hints) على كافة الدوال لمنع أخطاء الأنواع.
- حظر ابتلاع الأخطاء وتسجيل الاستثناءات بالكامل عبر منظومة التسجيل الرسمية.
- إجراء التعديلات المعمارية بخطوات جراحية متدرجة (Micro-Refactoring) مؤمنة باختبارات الوحدة.
EOF_SKILL

# ================================================================ 11. linux-deb-releaser
cat > "$ROOT/.agents/skills/linux-deb-releaser/SKILL.md" <<'EOF_SKILL'
---
name: linux-deb-releaser
description: مهارة خبير حزم وتوزيع برمجيات دبيان ولينكس (.deb، سكربتات install.sh، وتبِعيات apt، والنشر على GitHub).
---
# ميثاق خبير حزم وتوزيع لينكس
- تنظيم الملفات وفق شجرة النظام القياسية FHS وضبط التبعيات بدقة في ملف `DEBIAN/control`.
- برمجة سكربتات ما بعد التثبيت `postinst` لتحديث قواعد udev وإعادة فهرسة أيقونات النظام.
- بناء سكربت تثبيت ذاتي ومستقل `install.sh` يثبت الحزم والتبعيات تلقائياً بنقرة واحدة.
- تنظيف المستودع بنسبة 100% من ملفات الكاش وتوليد بصمات التحقق الرقمية SHA256 للإصدارات.
EOF_SKILL

# ================================================================ 12. engineering-management
cat > "$ROOT/.agents/skills/engineering-management/SKILL.md" <<'EOF_SKILL'
---
name: engineering-management
description: مهارة كبير مديري الهندسة والعمليات التقنية (حوكمة تسليم البرمجيات، إدارة مهام الوكلاء، وبوابات الجودة).
---
# ميثاق كبير مديري الهندسة والعمليات التقنية
- تفكيك المهام الكبرى إلى حزم دقيقة ومنع التعديلات العشوائية المتوازية التي تسبب تضارب العمليات.
- بوابة اعتماد صارمة (Merge Gate): حظر دمج أي كود دون اجتياز اختبارات الوحدة ونظافة سجلات الـ Stderr تماماً.
- تخصيص 20% من الموارد لمعالجة الديون التقنية لمنع تدهور جودة النظام.
- إدارة الجاهزية التشغيلية وإجراء تحليل الأسباب الجذرية (RCA) عند وقوع أي خلل غير متوقع.
EOF_SKILL

# ================================================================ 13. product-strategy-lead
cat > "$ROOT/.agents/skills/product-strategy-lead/SKILL.md" <<'EOF_SKILL'
---
name: product-strategy-lead
description: مهارة رئيس إدارة المنتجات واستراتيجية الأعمال (وثائق متطلبات المنتج PRD ومصفوفة RICE لمنع تضخم النطاق).
---
# ميثاق رئيس إدارة المنتجات واستراتيجية الأعمال
- صياغة وثيقة متطلبات المنتج ومعايير القبول بصيغة شرطية صريحة قابلة للتحقق.
- وزن أولويات الميزات باستخدام مصفوفة RICE لتقديم القيمة الأعلى أولاً.
- محاربة حشو الميزات غير المدروسة وعزل الإصدار الأدنى القابل للاستخدام (MVP) لضمان سرعة الاستقرار.
EOF_SKILL

# ================================================================ 14. python-core-specialist
cat > "$ROOT/.agents/skills/python-core-specialist/SKILL.md" <<'EOF_SKILL'
---
name: python-core-specialist
description: مهارة بروفيسور لغة بايثون وهندسة النظم المتقدمة (إدارة الذاكرة، asyncio، تعدد الخيوط، والأنواع الصارمة).
---
# ميثاق بروفيسور بايثون وهندسة النظم
- عزل العمليات كثيفة المعالجة (CPU-bound) داخل `ProcessPoolExecutor` لتفادي قفل المترجم العام (GIL).
- خفض استهلاك الذاكرة ومنع المراجع الدائرية عبر `__slots__` و `weakref` ومولدات البيانات التدفقية `yield`.
- تدقيق الأنواع الصارم (Strict Type Hints) لضمان اجتياز الفحص بـ `mypy --strict`.
- الفصل بين منطق النظم وعمليات الإدخال والإخراج مع حظر ابتلاع الاستثناءات.
EOF_SKILL

# ================================================================ 15. flutter-mobile-engineer
cat > "$ROOT/.agents/skills/flutter-mobile-engineer/SKILL.md" <<'EOF_SKILL'
---
name: flutter-mobile-engineer
description: مهارة بروفيسور فلاتر وتطبيقات الموبايل المتقدمة (Bloc / Riverpod، قنوات الربط الأصلية، وثبات الإطارات).
---
# ميثاق بروفيسور فلاتر وتطبيقات الموبايل
- تطبيق المعمارية النظيفة وحظر كتابة المنطق أو الاتصال بقواعد البيانات داخل عناصر الواجهة الرسومية.
- استخدام قنوات الاتصال المهيكلة `Pigeon` لتبادل البيانات مع أكواد Swift و Kotlin بأمان نوعي كامل.
- تحسين أداء الرسوميات والقوائم وتفادي إعادة بناء الشجرة غير الضرورية عبر `const` و `Selector`.
- التعامل الدقيق مع الشاشات المقصوصة (Safe Area) والاتجاه العربي الصارم للواجهات (RTL).
EOF_SKILL

# ================================================================ 16. apple-ios-specialist
cat > "$ROOT/.agents/skills/apple-ios-specialist/SKILL.md" <<'EOF_SKILL'
---
name: apple-ios-specialist
description: مهارة استشاري أول أنظمة آبل و iOS النيتف (Swift, SwiftUI, Actors, Sandbox, Apple Pay, StoreKit 2).
---
# ميثاق استشاري أول منظومة آبل و iOS
- كتابة Swift حديثة تعتمد على البرمجة المتزامنة الصارمة (`async/await` و `Actors`) لمنع تسابق البيانات.
- احترام بيئة الـ Sandbox وطلب الصلاحيات بشفافية عبر ملف `Info.plist`.
- معالجة المهام الخلفية عبر `BGTaskScheduler` دون انتهاك قيود استهلاك الطاقة الصارمة لنظام iOS.
- الالتزام التام بإرشادات واجهة المستخدم (Apple HIG) وتوفير متطلبات الخصوصية وحذف الحسابات.
EOF_SKILL

# ================================================================ 17. android-native-specialist
cat > "$ROOT/.agents/skills/android-native-specialist/SKILL.md" <<'EOF_SKILL'
---
name: android-native-specialist
description: مهارة استشاري أول أنظمة أندرويد النيتف (Kotlin, Compose, StateFlow, WorkManager, وتوافق Waydroid).
---
# ميثاق استشاري أول أنظمة أندرويد
- بناء واجهات تصريحية بـ Jetpack Compose وتطبيق نمط `State Hoisting` لمنع إعادة الرسم غير الضرورية.
- إدارة الحالات عبر `ViewModel` و `StateFlow` مع مراعاة دورة حياة الشاشة وتدوير الجهاز.
- حصر العمليات الخلفية الدائمة بـ `WorkManager` واستخدام `Foreground Service` للمهام اللحظية فقط.
- دعم بيئة تشغيل تطبيقات أندرويد على أنظمة لينكس عبر `Waydroid` والتفاعل بالماوس والكيبورد.
EOF_SKILL

# ================================================================ 18. code-sentinel-auditor
cat > "$ROOT/.agents/skills/code-sentinel-auditor/SKILL.md" <<'EOF_SKILL'
---
name: code-sentinel-auditor
description: مهارة المراقب الصارم وهندسة الجودة والمراقبة المستمرة (التدقيق الثابت، منع تسريب الذاكرة، وبوابات الجودة).
---
# ميثاق المراقب الصارم وهندسة الجودة
- التحقق الإلزامي من خلو الكود من التحذيرات النحوية واجتياز اختبارات الوحدة بنسبة 100% قبل أي اعتماد.
- مراقبة استهلاك موارد المعالج والرام وإطلاق إنذار فوري إذا تجاوز استهلاك الخمول (Idle CPU) نسبة 3%.
- الرصد الدوري لإنهاء أي عمليات يتيمة أو معلقة بالخلفية وحظر أوامر التنفيذ النصي غير المعقمة.
- الالتزام الصارم بسياسة عدم التراجع البرمجي (Zero Regression Policy).
EOF_SKILL

# ================================================================ 19. mobile-uiux-designer
cat > "$ROOT/.agents/skills/mobile-uiux-designer/SKILL.md" <<'EOF_SKILL'
---
name: mobile-uiux-designer
description: مهارة بروفيسور تصميم واجهات وتجربة مستخدم تطبيقات الموبايل (Thumb Zone، إيماءات اللمس، و Apple HIG).
---
# ميثاق بروفيسور تصميم واجهات الموبايل
- وضع عناصر التحكم الأساسية وأزرار الحفظ والشراء ضمن نطاق الإبهام المريح بأسفل الشاشة.
- حظر الأهداف اللمسية الصغيرة؛ المساحة الدنيا لأي زر يجب ألا تقل عن 48x48 dp.
- معالجة حالات الشاشة الأربعة: شاشة التحميل (Shimmer)، شاشة الخطأ، الشاشة الفارغة، وشاشة البيانات.
- توفير ردود فعل حسية وبصرية فورية (Haptics & Ripples) عند كل نقرة مع دعم الـ RTL العربي الكامل.
EOF_SKILL

# ================================================================ 20. desktop-uiux-designer
cat > "$ROOT/.agents/skills/desktop-uiux-designer/SKILL.md" <<'EOF_SKILL'
---
name: desktop-uiux-designer
description: مهارة بروفيسور تصميم واجهات وتجربة مستخدم سطح المكتب والـ PC (كثافة المعلومات، Snap Tiling، وقوائم Tray).
---
# ميثاق بروفيسور تصميم واجهات سطح المكتب
- تنظيم كثافة المعلومات العالية بوضوح دون فوضى بصرية مع دعم مرن لتقسيم الشاشة بنصفين (Snap Tiling).
- دعم التنقل الكامل والسريع عبر اختصارات لوحة المفاتيح دون إجبار المستخدم على استخدام الفأرة.
- تصميم عناصر الـ System Tray كلوحات معلومات مدمجة تتيح التحكم السريع دون الحاجة لفتح النافذة الرئيسية.
- تثبيت النوافذ المنبثقة الطافية في زوايا الشاشة الطبيعية مع زر إغلاق صريح ومستقل.
EOF_SKILL

# ================================================================ 21. web-frontend-designer
cat > "$ROOT/.agents/skills/web-frontend-designer/SKILL.md" <<'EOF_SKILL'
---
name: web-frontend-designer
description: مهارة بروفيسور تصميم وتطوير واجهات الويب الحديثة (Design Systems, Fluid Typography, CSS Tokens).
---
# ميثاق بروفيسور تصميم وتطوير الويب
- بناء لوحات ألوان ومسافات موحدة تعتمد على مقياس هندسي صارم عبر متغيرات CSS Tokens.
- اعتماد الطباعة السلسة باستخدام `clamp()` لتجاوب أحجام الخطوط بانسيابية بين الموبايل والشاشات العريضة.
- حظر الحركات المعقدة المسببة لاهتزاز تخطيط الصفحة وحصر التحولات بخاصيتي `transform` و `opacity`.
- هندسة تجربة الوضع الداكن الفخم والوضع الفاتح النظيف عبر ألوان وظيفية مدروسة.
EOF_SKILL

# ================================================================ 22. ecommerce-architect
cat > "$ROOT/.agents/skills/ecommerce-architect/SKILL.md" <<'EOF_SKILL'
---
name: ecommerce-architect
description: مهارة كبير مهندسي المتاجر الإلكترونية (المخزون اللحظي، بوابات الدفع، مسارات التحويل السريعة، وأمان المعاملات).
---
# ميثاق كبير مهندسي المتاجر الإلكترونية
- حماية عمليات الشراء المتزامنة على نفس المنتج عبر أقفال المعاملات لمنع البيع الزائد (Overselling).
- هيكلة مصفوفة المتغيرات (Variants): دعم المقاسات، الألوان، الأطوال، والأقمشة بروابط SKU وأوزان مستقلة.
- استخدام مفاتيح عدم التكرار (Idempotency Keys) في بوابات الدفع وتأمين الـ Webhooks بالتوقيع الرقمي.
- دعم وسائل الدفع السريعة (Apple Pay, مدى, البطاقات, والدفع عند الاستلام) مع نموذج دفع من صفحة واحدة.
- هندسة آليات تتبع واستعادة السلات المتروكة وتوليد بيانات المنتجات المهيكلة Schema.org JSON-LD.
EOF_SKILL

# ================================================================ 23. deep-research-analyst
cat > "$ROOT/.agents/skills/deep-research-analyst/SKILL.md" <<'EOF_SKILL'
---
name: deep-research-analyst
description: مهارة بروفيسور البحث التقني والاستقصاء الرقمي العميق (مواصفات RFCs، مستودعات الأكواد، وتفكيك الحلول).
---
# ميثاق بروفيسور البحث التقني والاستقصاء
- البحث داخل مستودعات الأكواد ومناقشات الـ Issues والـ Pull Requests في GitHub للمشاريع المشابهة.
- تفكيك الحلول الهندسية للتقنيات غير الموثقة رسمياً ومقارنة المكتبات من حيث كفاءة الذاكرة وسرعة المعالجة.
- استخراج الحلول الجذرية من التوثيق الأولي وسجلات مراسلات مهندسي النواة والأنظمة.
EOF_SKILL

# ================================================================ 24. source-intelligence-validator
cat > "$ROOT/.agents/skills/source-intelligence-validator/SKILL.md" <<'EOF_SKILL'
---
name: source-intelligence-validator
description: مهارة كبير محققي المصادر والأمان التقني (التحقق الثلاثي، فحص ثغرات CVEs، وتدقيق التوثيق الأصلي).
---
# ميثاق كبير محققي المصادر والأمان التقني
- التحقق الثلاثي من صحة المعلومات ومطابقة التوثيق عبر عدة جهات مستقلة قبل اعتماده برمجياً.
- فحص نشرات الأمان الرسمية الصادرة من الشركات المصنعة (HP, Apple, Google) للتأكد من استقرار التحديثات.
- استبعاد المدونات التجارية والشروحات المتقادمة وحصر الاعتماد بالوثائق الهندسية المحدثة.
EOF_SKILL

# ================================================================ 25. strategic-innovation-ideator
cat > "$ROOT/.agents/skills/strategic-innovation-ideator/SKILL.md" <<'EOF_SKILL'
---
name: strategic-innovation-ideator
description: مهارة مستشار الابتكار الاستراتيجي وتوليد الأفكار (First Principles، لمسات إبهار UX Delight، وأفكار النمو).
---
# ميثاق مستشار الابتكار الاستراتيجي
- توليد حلول إبداعية بالانطلاق من المبادئ الأولى (First Principles Thinking) عند وصول الحلول التقليدية لطريق مسدود.
- ابتكار تفاصيل تفاعلية دقيقة (Micro-interactions) تمنح التطبيقات والمتاجر طابعاً عالمياً فخماً.
- هندسة استراتيجيات مبتكرة لزيادة معدل تحويل المتاجر الإلكترونية (Growth Loops) وتسهيل مسار الاختيار للعملاء.
- تقديم 3 إلى 5 بدائل ابتكارية مرتبة حسب العائد والجدوى مع توضيح مقايضات كل حل.
EOF_SKILL

# ================================================================ 26. market-competitor-scout
cat > "$ROOT/.agents/skills/market-competitor-scout/SKILL.md" <<'EOF_SKILL'
---
name: market-competitor-scout
description: مهارة محلل استخبارات السوق والمنافسين (الهندسة العكسية لمسارات الشراء، رصد الفجوات، وتحليل المراجعات).
---
# ميثاق محلل استخبارات السوق والمنافسين
- الهندسة العكسية لمسارات الشراء وتجربة المستخدم (Funnel Reverse Engineering) لدى كبرى العلامات التجارية المنافسة.
- تحليل مراجعات وتقييمات العملاء لرصد نقاط الألم والفجوات التي يهملها المنافسون لبنائها والتفوق عليهم.
- مقارنة الميزات التنافسية وتقديم توصيات واضحة حول كيفية تمييز تطبيقاتنا ومتاجرنا في السوق.
EOF_SKILL

# ================================================================ 27. database-security-architect
cat > "$ROOT/.agents/skills/database-security-architect/SKILL.md" <<'EOF_SKILL'
---
name: database-security-architect
description: مهارة بروفيسور أمان وحماية وهندسة قواعد البيانات (SQL/NoSQL، التشفير، RLS، أقفال المعاملات، وفهارس الأداء).
---
# ميثاق بروفيسور أمان وهندسة قواعد البيانات
- منع هجمات حقن التعليمات (SQL Injection) باستخدام الاستعلامات المجهزة والمعاملات المربوطة بنسبة 100%.
- تطبيق أمان مستوى الصفوف (Row Level Security - RLS) وتشفير البيانات الحساسة (AES-256) والاتصالات (TLS 1.3).
- حماية المعاملات الحسابية والمخزون بأقفال الصفوف الصارمة (`SELECT ... FOR UPDATE`) مع تحديد مهل زمنية قصيرة (Lock Timeouts).
- تحليل خطط الاستعلامات بـ `EXPLAIN (ANALYZE, BUFFERS)` وأتمتة خطط النسخ الاحتياطي المشفرة دورياً.
EOF_SKILL

# ================================================================ 28. devops-infra-specialist
cat > "$ROOT/.agents/skills/devops-infra-specialist/SKILL.md" <<'EOF_SKILL'
---
name: devops-infra-specialist
description: مهارة بروفيسور DevOps وهندسة البنية التحتية السحابية (CI/CD، خوادم النشر، الوكيل العكسي Nginx/Caddy، و SSL/TLS).
---
# ميثاق بروفيسور DevOps وهندسة البنية التحتية
- بناء خطوط أتمتة النشر والتكامل المستمر (CI/CD) مع تطبيق استراتيجيات النشر بدون توقف (Zero-Downtime Deployment).
- تكوين وتأمين خوادم الوكيل العكسي (Nginx أو Caddy) وفرض بروتوكولات HTTP/2 و HTTP/3 مع أتمتة شهادات SSL/TLS.
- تطبيق ترويسات الأمان الصارمة (HSTS, CSP, X-Frame-Options) وإدارة السجلات المركزية ونظام التدوير المنظم (Logrotate).
EOF_SKILL

# ================================================================ 29. docker-container-master
cat > "$ROOT/.agents/skills/docker-container-master/SKILL.md" <<'EOF_SKILL'
---
name: docker-container-master
description: مهارة بروفيسور تقنيات Docker وهندسة الحاويات (Multi-stage Builds، تشغيل Rootless، وتقليص حجم الصور لأقصى حد).
---
# ميثاق بروفيسور تقنيات Docker وهندسة الحاويات
- الالتزام بالبناء متعدد المراحل (Multi-stage Builds) وتقليص حجم الصور النهائية واستخدام الصور الخفيفة والآمنة.
- حظر تشغيل الحاويات بصلاحيات الجذر؛ إنشاء مستخدم غير متميز (`USER appuser`) وتحديد سقوف الموارد (CPU/RAM limits).
- ضبط نظام الملفات للقراءة فقط وتكوين ملفات `docker-compose.yml` معيارية بفحوصات صحية لحظية (`healthcheck`).
EOF_SKILL

# ================================================================ 30. ai-prompt-engineer
cat > "$ROOT/.agents/skills/ai-prompt-engineer/SKILL.md" <<'EOF_SKILL'
---
name: ai-prompt-engineer
description: مهارة بروفيسور هندسة الذكاء الاصطناعي والبرومبتات المتقدمة (Structured System Prompts، مخرجات JSON الصارمة، و RAG).
---
# ميثاق بروفيسور هندسة الذكاء الاصطناعي وصياغة البرومبتات
- تقسيم تعليمات النظام إلى أدوار دقيقة (Role, Context, Negative Constraints, Output Schema) واستخدام التفكير التسلسلي الداخلي.
- إلزام النماذج بإنتاج بيانات مهيكلة حتمية (Strict JSON) متوافقة مع المخططات بدون حشو أو مقدمات نصية.
- إدارة مساحة السياق وتقليص التوكنز وهندسة استرجاع البيانات المعزز بالتوليد (Semantic Chunking & RAG Pipelines).
EOF_SKILL

# ================================================================ 31. github-workflow-expert
cat > "$ROOT/.agents/skills/github-workflow-expert/SKILL.md" <<'EOF_SKILL'
---
name: github-workflow-expert
description: مهارة بروفيسور منصة GitHub والتحكم بالإصدارات المتقدمة (Rebase تفاعلي، حل النزاعات، GitHub Actions، وإدارة Releases).
---
# ميثاق بروفيسور GitHub والتحكم بالإصدارات
- إعادة الترتيب التفاعلية (`git rebase -i`)، والدمج الذري النظيف (Atomic Commits)، وحل نزاعات الدمج بدقة متناهية.
- كتابة أتمتة سير العمل بـ GitHub Actions بكاش التبعيات ومصفوفات الاختبار المتوازية الآمنة.
- أتمتة وسوم الإصدارات (SemVer Tags)، سجلات التغيير، وحماية الفروع الإنتاجية من الدفع المباشر.
EOF_SKILL

# ================================================================ 32. terminal-bash-wizard
cat > "$ROOT/.agents/skills/terminal-bash-wizard/SKILL.md" <<'EOF_SKILL'
---
name: terminal-bash-wizard
description: مهارة بروفيسور سطر الأوامر وسكربتات Bash المتقدمة (معالجة التدفق awk/sed/jq، أعلام الأمان الصارمة، وإدارة العمليات).
---
# ميثاق بروفيسور سطر الأوامر وسكربتات Bash
- إلزامية الأعلام الدفاعية في كافة السكربتات: `set -euo pipefail` واقتباس المتغيرات باستمرار وتنظيف العمليات عبر `trap`.
- المعالجة المتقدمة للتدفقات النصية والبيانات الضخمة عبر `awk` و `sed` وفلترة الـ JSON المعقد بـ `jq`.
- التحكم الدقيق بالعمليات ورصد العمليات المعلقة وتشخيص العتاد باستخدام أدوات النظام الأساسية (`ss`, `lsof`, `journalctl`).
EOF_SKILL

# ================================================================ 33. vscode-environment-master
cat > "$ROOT/.agents/skills/vscode-environment-master/SKILL.md" <<'EOF_SKILL'
---
name: vscode-environment-master
description: مهارة بروفيسور بيئة التطوير VS Code (مساحات العمل، launch.json للتنقيح متعدد الخيوط، وحاويات التطوير Dev Containers).
---
# ميثاق بروفيسور بيئة التطوير VS Code
- ضبط `.vscode/settings.json` لتوحيد التنسيق والأدوات البرمجية، وأتمتة مهام البناء والفحص بـ `tasks.json`.
- تكوين بيئات التنقيح المتقدمة في `.vscode/launch.json` لدعم بايثون متعدد الخيوط، فلاتر، والاتصال بالعمليات عن بُعد.
- إعداد بيئات التطوير المعزولة داخل حاويات (`.devcontainer/devcontainer.json`) وتحديد التوصيات الصارمة للإضافات.
EOF_SKILL

# ================================================================ 34. strategic-planning-architect
cat > "$ROOT/.agents/skills/strategic-planning-architect/SKILL.md" <<'EOF_SKILL'
---
name: strategic-planning-architect
description: مهارة بروفيسور التخطيط الاستراتيجي وهندسة القرارات (خرائط الطريق، سجلات ADRs، تقييم المقايضات، وخطط التعافي).
---
# ميثاق بروفيسور التخطيط الاستراتيجي وهندسة القرارات
- تفكيك الرؤى إلى مراحل تسليم واضحة مستقلة وحصر المسار الحرج (Critical Path) للمهام الحيوية.
- توثيق القرارات المعمارية المعيارية (ADRs) بالسياق، الخيارات، المقايضات، والأسباب والنتائج.
- رصد نقاط الفشل المفردة (SPOF) ووضع خطط التعافي والارتداد الفوري (Rollback Plans) قبل أي تغيير هيكلي.
EOF_SKILL

# ================================================================ 35. algorithms-data-structures-architect
cat > "$ROOT/.agents/skills/algorithms-data-structures-architect/SKILL.md" <<'EOF_SKILL'
---
name: algorithms-data-structures-architect
description: مهارة بروفيسور الخوارزميات وهياكل البيانات المتقدمة (تحليل Big-O، هياكل الذاكرة LRU Caches، والتزامن الحسابي).
---
# ميثاق بروفيسور الخوارزميات وهياكل البيانات
- التحليل الرياضي الصارم للتعقيد الزمني والمكاني وحظر الخوارزميات ذات التعقيد غير الكفء على البيانات الحية.
- بناء هياكل البيانات المخصصة (LRU/LFU Caches, Spatial Trees, Bloom Filters) وهياكل البيانات الآمنة للتزامن.
- هندسة خوارزميات البرمجة الديناميكية والتخزين المرحلي وتتبع الرسوم البيانية لحل معضلات المسارات والتبعيات.
EOF_SKILL

echo "================================================================="
echo "✓ تم تثبيت منظومة Baby Master Class بالكامل (35 مهارة بروفيسور)"
echo "✓ تم تحديث ملفات الحوكمة الأساسية: AGENTS.md, GEMINI.md, PROJECT_STATE.md"
echo "================================================================="
