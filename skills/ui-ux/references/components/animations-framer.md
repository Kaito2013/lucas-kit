# Framer Motion Micro-Interactions

> Bộ preset chuyển động vi mô (Micro-interactions) bằng thư viện **Framer Motion**.
> Mục tiêu: Làm giao diện chuyển động mượt mà, phản hồi tinh tế theo hành động của người dùng, không làm giật hay trễ thao tác.

---

## 1. Nguyên tắc vàng về Chuyển động

1. **Nhanh và dứt khoát**: Thời lượng chuyển động (duration) lý tưởng từ `150ms` đến `250ms`. Chuyển động trên `300ms` làm người dùng cảm thấy ứng dụng bị chậm.
2. **Không nảy quá đà (Subtle Spring)**: Dùng `stiffness: 400`, `damping: 30` cho độ nảy nhẹ nhàng, tự nhiên.
3. **Tôn trọng người dùng**: Hỗ trợ `useReducedMotion()` để tắt hoạt ảnh đối với người dùng nhạy cảm với chuyển động thị giác.

---

## 2. Preset A: Modal / Dialog Pop-in

Chuyển động mở hộp thoại: Nền mờ dần (Fade-in) + Hộp thoại phóng nhẹ từ `95%` lên `100%`.

```tsx
import { motion, AnimatePresence } from "framer-motion";

export function ModalAnimation({ isOpen, children }: { isOpen: boolean; children: React.ReactNode }) {
  return (
    <AnimatePresence>
      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          {/* Lớp nền mờ (Backdrop) */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.15 }}
            className="fixed inset-0 bg-black/50 backdrop-blur-xs"
          />

          {/* Khung nội dung Modal */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95, y: 8 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 8 }}
            transition={{ type: "spring", duration: 0.2, bounce: 0 }}
            className="relative z-10 w-full max-w-lg rounded-2xl border border-border bg-surface p-6 shadow-xl"
          >
            {children}
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
}
```

---

## 3. Preset B: Dropdown Menu / Popover

Mở menu thả xuống từ nút kích hoạt: mờ dần và trượt nhẹ theo phương thẳng đứng.

```tsx
import { motion, AnimatePresence } from "framer-motion";

export function DropdownAnimation({ isOpen, children }: { isOpen: boolean; children: React.ReactNode }) {
  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          initial={{ opacity: 0, y: -6, scale: 0.98 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          exit={{ opacity: 0, y: -6, scale: 0.98 }}
          transition={{ duration: 0.15, ease: "easeOut" }}
          className="absolute right-0 top-full mt-2 w-56 rounded-xl border border-border bg-surface p-1.5 shadow-lg outline-hidden"
        >
          {children}
        </motion.div>
      )}
    </AnimatePresence>
  );
}
```

---

## 4. Preset C: Accordion co giãn mượt mà

Tự động đo chiều cao thực tế khi đóng/mở nội dung mà không gây giật layout:

```tsx
import { motion, AnimatePresence } from "framer-motion";

export function AccordionContent({ isOpen, children }: { isOpen: boolean; children: React.ReactNode }) {
  return (
    <AnimatePresence initial={false}>
      {isOpen && (
        <motion.div
          initial={{ height: 0, opacity: 0 }}
          animate={{ height: "auto", opacity: 1 }}
          exit={{ height: 0, opacity: 0 }}
          transition={{ duration: 0.22, ease: [0.04, 0.62, 0.23, 0.98] }}
          className="overflow-hidden"
        >
          <div className="pb-4 pt-1 text-sm text-muted">{children}</div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
```

---

## 5. Preset D: Tabs Indicator trượt viền (`layoutId`)

Hiệu ứng viên thuốc (Pill) hoặc đường gạch chân trượt theo tab đang được chọn:

```tsx
import React, { useState } from "react";
import { motion } from "framer-motion";

export function AnimatedTabs({ tabs }: { tabs: string[] }) {
  const [activeTab, setActiveTab] = useState(tabs[0]);

  return (
    <div className="flex items-center gap-1 rounded-xl border border-border bg-surface p-1">
      {tabs.map((tab) => {
        const isActive = activeTab === tab;
        return (
          <button
            key={tab}
            type="button"
            onClick={() => setActiveTab(tab)}
            className={`relative rounded-lg px-3.5 py-1.5 text-sm font-medium transition-colors outline-hidden ${
              isActive ? "text-foreground" : "text-muted hover:text-foreground"
            }`}
          >
            {isActive && (
              <motion.div
                layoutId="activeTabBadge"
                transition={{ type: "spring", bounce: 0.15, duration: 0.3 }}
                className="absolute inset-0 rounded-lg bg-secondary shadow-xs"
              />
            )}
            <span className="relative z-10">{tab}</span>
          </button>
        );
      })}
    </div>
  );
}
```
