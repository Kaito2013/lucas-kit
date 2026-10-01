# Theme Toggle (Nút chuyển Dark Mode)

> Tài liệu chuẩn cho việc tích hợp nút chuyển đổi giao diện Sáng / Tối vào Header, Thanh điều hướng hoặc Trang cài đặt. 
> Tuân thủ token màu trong `tokens.css` và quy chuẩn tương phản trong `rules-color.md`.

---

## 1. Cơ chế hoạt động & Nguyên tắc

* **3 Chế độ (Light · Dark · System)**: Nút bấm xoay vòng hoặc Dropdown chọn chế độ.
* **Đồng bộ class trên thẻ `<html>`**:
  ```css
  /* Tailwind v4 */
  @custom-variant dark (&:where(.dark, .dark *));
  ```
* **Chống giật sáng (FOUC - Flash of Unstyled Content)**: Đặt script nhỏ đầu `<body>` hoặc trong `<head>` để gán class `.dark` trước khi React hydrate.
* **Quy tắc nút bấm (`I1` / `I13`)**: Nút theme toggle ở header là nút `ghost` hoặc `outline` tròn (`size-9 rounded-xl`), không dùng nút đặc `primary`.

---

## 2. Script chống giật màn hình (Inline Script)

Thêm đoạn script này vào `<head>` của `app/layout.tsx` (Next.js) hoặc `index.html` (Vite):

```html
<script>
  (function() {
    try {
      const mode = localStorage.getItem('themeMode') || 'system';
      const isDark = mode === 'dark' || (mode === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches);
      if (isDark) {
        document.documentElement.classList.add('dark');
        document.documentElement.style.colorScheme = 'dark';
      } else {
        document.documentElement.classList.remove('dark');
        document.documentElement.style.colorScheme = 'light';
      }
    } catch (e) {}
  })();
</script>
```

---

## 3. Component A: Nút xoay vòng 3 chế độ (Không cần thư viện ngoài)

Nút bấm gọn gàng cho Header: bấm lần lượt **Tự động (System) → Sáng → Tối → Tự động**.

```tsx
"use client";

import React, { useEffect, useState } from "react";
import { Sun, Moon, Laptop } from "lucide-react";

type ThemeMode = "system" | "light" | "dark";

export function ThemeToggle() {
  const [mode, setMode] = useState<ThemeMode>("system");

  useEffect(() => {
    const saved = (localStorage.getItem("themeMode") as ThemeMode) || "system";
    setMode(saved);
    applyTheme(saved);
  }, []);

  function applyTheme(targetMode: ThemeMode) {
    const root = document.documentElement;
    const isDark =
      targetMode === "dark" ||
      (targetMode === "system" && window.matchMedia("(prefers-color-scheme: dark)").matches);

    if (isDark) {
      root.classList.add("dark");
      root.style.colorScheme = "dark";
    } else {
      root.classList.remove("dark");
      root.style.colorScheme = "light";
    }
  }

  function cycleTheme() {
    const nextMode: ThemeMode =
      mode === "system" ? "light" : mode === "light" ? "dark" : "system";

    setMode(nextMode);
    localStorage.setItem("themeMode", nextMode);
    applyTheme(nextMode);
  }

  return (
    <button
      type="button"
      onClick={cycleTheme}
      className="inline-flex size-9 cursor-pointer items-center justify-center rounded-xl border border-border bg-surface text-foreground transition-colors hover:bg-surface-hover outline-hidden"
      title={`Chế độ: ${mode === "system" ? "Hệ thống" : mode === "light" ? "Sáng" : "Tối"}`}
      aria-label="Đổi giao diện sáng tối"
    >
      {mode === "system" && <Laptop className="size-4.5 text-muted" aria-hidden />}
      {mode === "light" && <Sun className="size-4.5 text-amber-500" aria-hidden />}
      {mode === "dark" && <Moon className="size-4.5 text-sky-400" aria-hidden />}
    </button>
  );
}
```

---

## 4. Component B: Công tắc gạt (Switch Toggle với hiệu ứng trượt)

Phù hợp cho **Trang Cài đặt (Settings)** hoặc **Menu tài khoản**:

```tsx
"use client";

import React, { useEffect, useState } from "react";
import { Sun, Moon } from "lucide-react";

export function ThemeSwitch() {
  const [isDark, setIsDark] = useState(false);

  useEffect(() => {
    const darkActive = document.documentElement.classList.contains("dark");
    setIsDark(darkActive);
  }, []);

  function toggle() {
    const nextDark = !isDark;
    setIsDark(nextDark);
    const root = document.documentElement;

    if (nextDark) {
      root.classList.add("dark");
      root.style.colorScheme = "dark";
      localStorage.setItem("themeMode", "dark");
    } else {
      root.classList.remove("dark");
      root.style.colorScheme = "light";
      localStorage.setItem("themeMode", "light");
    }
  }

  return (
    <button
      type="button"
      role="switch"
      aria-checked={isDark}
      onClick={toggle}
      className="group relative inline-flex h-8 w-14 cursor-pointer items-center rounded-full border border-border bg-surface-hover p-1 transition-colors outline-hidden focus-visible:ring-2 focus-visible:ring-primary"
      aria-label="Bật tắt chế độ nền tối"
    >
      <span
        className={`pointer-events-none flex size-6 items-center justify-center rounded-full bg-surface text-foreground shadow-sm transition-transform duration-200 ease-in-out ${
          isDark ? "translate-x-6 text-sky-400" : "translate-x-0 text-amber-500"
        }`}
      >
        {isDark ? <Moon className="size-3.5" aria-hidden /> : <Sun className="size-3.5" aria-hidden />}
      </span>
    </button>
  );
}
```

---

## 5. Dùng với thư viện `next-themes` (Nếu dự án có sẵn)

Nếu dự án Next.js đã cài `next-themes`, chỉ cần bọc:

```tsx
"use client";

import { useTheme } from "next-themes";
import { Sun, Moon } from "lucide-react";

export function NextThemeToggle() {
  const { resolvedTheme, setTheme } = useTheme();

  return (
    <button
      type="button"
      onClick={() => setTheme(resolvedTheme === "dark" ? "light" : "dark")}
      className="inline-flex size-9 cursor-pointer items-center justify-center rounded-xl border border-border bg-surface text-foreground hover:bg-surface-hover outline-hidden"
      aria-label="Đổi giao diện"
    >
      {resolvedTheme === "dark" ? (
        <Moon className="size-4.5 text-sky-400" aria-hidden />
      ) : (
        <Sun className="size-4.5 text-amber-500" aria-hidden />
      )}
    </button>
  );
}
```
