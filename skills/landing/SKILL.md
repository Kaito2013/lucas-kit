---
name: landing
description: Gu thiết kế và dựng Landing Page, trang Marketing, trang bán hàng, trang chủ sản phẩm SaaS / Mobile App / Dịch vụ. Quy trình chuẩn designer - brief thông điệp cốt lõi, khách hàng mục tiêu, 2–3 wireframe bố cục hero & sections, người dùng duyệt rồi mới dựng. Bám sát thư viện component và brand token của dự án. Mặc định flat hiện đại, gradient tinh tế, tối ưu tỷ lệ chuyển đổi (CRO), typography rõ ràng, không AI slop, responsive mượt mà từ 375px đến 1920px. Dùng khi dựng trang chủ, landing page, trang tính năng, trang bảng giá, marketing page, product showcase, tiếng Việt hay tiếng Anh, hoặc khi người dùng nhắc "dựng landing page", "làm trang chủ", "thiết kế landing", "trang marketing", "sales page", "build a landing page", "landing", "lucas:landing".
---

# 🚀 Thiết kế & Dựng Landing Page / Trang Marketing

> **Chưa đi qua bước Brief và Wireframe thì KHÔNG viết một dòng code nào trong lượt này** (trừ khi đề yêu cầu rõ "dựng luôn").
> **Mặc định là làm như một Product Designer & Conversion Copywriter**:
> 1. Brief: Định vị sản phẩm, khách hàng mục tiêu, giá trị cốt lõi (Value Proposition) và CTA chính.
> 2. Phác thảo 2–3 phương án Wireframe cấu trúc trang.
> 3. Người dùng chọn phương án.
> 4. Tiến hành dựng code hoàn thiện bằng đúng component và token của dự án.

---

## 0. BỐN CÂU HỎI TRƯỚC KHI DỰNG

1. **Sản phẩm là gì & Bán cho ai?** (B2B SaaS, B2C Mobile App, Khóa học, Agency dịch vụ, Nền tảng E-commerce).
2. **Hành động chuyển đổi chính (Primary CTA) là gì?** ("Dùng thử miễn phí", "Đặt lịch Demo", "Mua ngay", "Tải app", "Đăng ký nhận tin").
3. **Tech Stack & Component Library:** (Next.js, React, Tailwind CSS, shadcn/ui, Framer Motion, HTML thuần).
4. **Phong cách thị giác (Visual Style):**
   * *Modern Minimalist*: Nền trắng/xám siêu nhạt, card sắc nét, typography đậm, viền mờ tinh tế.
   * *Dark High-Tech*: Nền tối (`#090d16`), gradient phát sáng (glow accents), card bóng mờ (glassmorphism nhẹ).
   * *Playful & Vibrant*: Bo góc lớn (`rounded-2xl`), màu nhấn tươi sáng, icon nổi bật.

---

## 1. CẤU TRÚC CHUẨN CỦA MỘT LANDING PAGE CHUYỂN ĐỔI CAO

Một Landing Page tiêu chuẩn gồm 8 khối theo thứ tự tâm lý người dùng:

```
┌───────────────────────────────────────────────┐
│ 1. HEADER & HERO (Gây ấn tượng & Khơi gợi tò mò)│
├───────────────────────────────────────────────┤
│ 2. SOCIAL PROOF / LOGO CLOUD (Tạo dựng uy tín) │
├───────────────────────────────────────────────┤
│ 3. FEATURE SHOWCASE / BENTO GRID (Giải pháp)  │
├───────────────────────────────────────────────┤
│ 4. PRODUCT DEMO / METRICS (Chứng minh hiệu quả)│
├───────────────────────────────────────────────┤
│ 5. TESTIMONIALS / WALL OF LOVE (Khách hàng nói)│
├───────────────────────────────────────────────┤
│ 6. PRICING TABLE (Minh bạch chi phí)          │
├───────────────────────────────────────────────┤
│ 7. FAQ ACCORDION (Xoá tan do dự & rào cản)    │
├───────────────────────────────────────────────┤
│ 8. FINAL CTA & FOOTER (Chốt chuyển đổi)       │
└───────────────────────────────────────────────┘
```

---

## 2. QUY CHUẨN THIẾT KẾ TỪNG KHỐI (SECTION SPECS)

### 1. Hero Section (Phần đầu trang)
* **Bố cục A — Căn trái, 2 cột (Khuyên dùng cho SaaS / Web App):**
  * Cột trái: Badge nhỏ ("✨ Phiên bản 2.0 đã ra mắt"), Tiêu đề H1 lớn (2–3 dòng), Đoạn giới thiệu (subheadline) 2 dòng, Cặp nút bấm [Primary CTA] + [Secondary "Xem Demo" hoặc "Video"], Dòng bảo chứng ("Không cần thẻ tín dụng • Miễn phí 14 ngày").
  * Cột phải: Mockup giao diện app thật với viền mỏng và đổ bóng đa tầng (`shadow-2xl`).
* **Bố cục B — Căn giữa, Mockup lớn phía dưới (Khuyên dùng cho Mobile App / Extension):**
  * Cụm tiêu đề và nút CTA căn giữa trang.
  * Phía dưới là ảnh chụp giao diện app góc rộng, hơi nhô lên trên nền.
* **⚠️ Luật cấm Hero:**
  * **Cấm làm Hero cao tròn 100vh**: Luôn phải để lộ 10%–15% đỉnh của khối tiếp theo (Logo cloud hoặc Tính năng) để người dùng tự nhiên cuộn xuống.
  * **Chỉ 1 nút Primary**: Nút thứ hai bắt buộc phải là `outline`, `ghost` hoặc nút có icon Play xem video.

---

### 2. Social Proof / Logo Cloud (Khách hàng & Đối tác)
* Đặt ngay dưới Hero.
* Hiển thị dòng chữ nhỏ: *"Được tin dùng bởi hơn 10,000+ đội ngũ công nghệ tại"*
* Logo đối tác hiển thị ở dạng **đơn sắc (Grayscale, opacity 50%)**, hover vào sáng 100%. Không để logo màu sắc xanh đỏ lộn xộn phá nát giao diện.

---

### 3. Feature Showcase (Khối tính năng)
* **Phương án Bento Grid (Hiện đại):** Lưới không đồng đều (1 ô lớn 2 cột + 2 ô nhỏ 1 cột). Mỗi ô chứa một tính năng kèm visual minh họa sống động (biểu đồ nhỏ, switch bấm được, mini card).
* **Phương án Zig-Zag (Xen kẽ):** Hàng 1: Chữ trái - Ảnh phải. Hàng 2: Ảnh trái - Chữ phải. Dành cho sản phẩm có 3–4 tính năng lớn cần giải thích kỹ.
* **⚠️ Luật cấm Tính năng:** Không bọc từng tính năng vào một chiếc card trắng có viền xám đóng hộp cứng nhắc nếu nền trang đã là màu trắng.

---

### 4. Metrics & Numbers (Con số biết nói)
* Lưới 3 hoặc 4 cột:
  * Số lớn font Sans-serif đậm (`text-4xl` hoặc `text-5xl font-extrabold`).
  * Nhãn mô tả bên dưới rõ ràng: `99.9% Uptime`, `10x Tốc độ triển khai`, `50,000+ Đơn hàng/ngày`.

---

### 5. Testimonials (Đánh giá khách hàng)
* Thẻ đánh giá bao gồm:
  * Đoạn nhận xét cụ thể (nêu rõ trước và sau khi dùng sản phẩm).
  * Avatar thật (ảnh người thật, không dùng icon hoạt hình).
  * Họ tên đầy đủ, chức danh và tên công ty (ví dụ: *Nguyễn Văn A — CTO tại TechCorp*).
  * Rating 5 sao màu vàng hổ phách (`amber-400`).

---

### 6. Pricing Section (Bảng giá minh bạch)
* **Bố cục 3 cột chuẩn:**
  * Gói 1: Cá nhân / Miễn phí (Khởi đầu).
  * Gói 2: Chuyên nghiệp / Doanh nghiệp vừa (**Gói nổi bật nhất**: viền màu accent, badge *"Phổ biến nhất"*, nút Primary).
  * Gói 3: Enterprise (Tùy biến cao, nút liên hệ).
* **Công tắc Tháng / Năm (Billing Toggle):** Nút chuyển kèm badge giảm giá nhỏ: *"Tiết kiệm 20% khi trả theo năm"*.
* Các gạch đầu dòng tính năng dùng icon check (`✓`) màu xanh lá dịu hoặc màu accent.

---

### 7. FAQ Accordion (Câu hỏi thường gặp)
* Chia 1 cột căn giữa (max-width `768px`).
* Dạng Accordion bấm mở từng câu, đóng các câu còn lại.
* Tập trung trả lời 5–6 thắc mắc lớn nhất: bảo mật dữ liệu, chính sách hoàn tiền, hủy gói, xuất hóa đơn VAT, hỗ trợ kỹ thuật.

---

### 8. Final CTA & Footer
* **Khối Final CTA:** Nền tương phản mạnh (gradient nhẹ hoặc dark panel), tiêu đề ngắn gọn thúc giục hành động, nút bấm to nổi bật.
* **Footer:** 4–5 cột liên kết (Sản phẩm, Tài nguyên, Công ty, Pháp lý), dòng bản quyền Copyright, mạng xã hội và bộ chọn ngôn ngữ.

---

## 3. CÁC "BẪY TỬ HUYỆT" CẦN TRÁNH TRÊN LANDING PAGE

1. **Không dùng ảnh minh họa 3D vector trôi nổi**: Ảnh hoạt hình người tím tay dài khiến landing page trông như bài tập của sinh viên. Hãy dùng **UI Screenshot thật**, bản vẽ mock tương tác, hoặc SVG Icon tối giản.
2. **Không viết gián đoạn, từ ngữ sáo rỗng**: Tránh các câu chung chung như *"Nền tảng tốt nhất cho mọi nhu cầu"*. Hãy viết cụ thể: *"Quản lý 1,000 đơn hàng mỗi ngày mà không sót một đơn nào"*.
3. **Phân cấp Typography rõ rệt**:
   * Tiêu đề chính H1: `clamp(2.25rem, 5vw, 3.75rem)` (36px - 60px).
   * Tiêu đề Section H2: `clamp(1.75rem, 3vw, 2.5rem)` (28px - 40px).
   * Nội dung thân bài: `1rem - 1.125rem` (16px - 18px), line-height thư thái `1.6 - 1.7`.
4. **Quy chuẩn Mobile 375px**:
   * Hero: Chữ xếp trước, ảnh xếp sau.
   * Bento grid / Tính năng: Co về 1 cột duy nhất, không để 2 cột gây vỡ chữ.
   * Bảng giá: Gói phổ biến nhất (Recommended) tự động đưa lên đầu tiên trên mobile.

---

## 4. CÁCH RA LỆNH VỚI `/lucas:landing`

| Nhu cầu | Câu lệnh mẫu |
| :--- | :--- |
| **Dựng toàn bộ Landing Page** | `/lucas:landing Dựng landing page cho phần mềm quản lý phòng gym (SaaS). Nhắm vào chủ phòng tập, phong cách hiện đại mạnh mẽ.` |
| **Dựng riêng Hero Section** | `/lucas:landing Thiết kế hero section căn trái cho app học tiếng Anh bằng AI, kèm form nhập email đăng ký sớm.` |
| **Dựng Bảng giá** | `/lucas:landing Dựng khối pricing 3 gói dịch vụ có switch thanh toán Năm/Tháng giảm giá 20%.` |
| **Dựng Bento Grid tính năng** | `/lucas:landing Dựng khối bento grid 4 tính năng vượt trội cho ứng dụng CRM quản lý khách hàng B2B.` |
| **Dựng nhanh không wireframe** | `/lucas:landing Dựng luôn landing page giới thiệu khóa học lập trình React, phong cách dark mode, không cần wireframe.` |
