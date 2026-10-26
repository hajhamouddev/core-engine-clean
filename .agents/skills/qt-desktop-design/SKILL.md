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
