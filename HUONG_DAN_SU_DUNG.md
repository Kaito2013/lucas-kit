# 📘 CẨM NANG SỬ DỤNG HIỆU QUẢ LUCAS:UI-UX

> **Mục tiêu:** Giúp bạn khai thác tối đa sức mạnh của bộ skill `/lucas:ui-ux`, biến AI từ một công cụ sinh code ngẫu nhiên thành một **Senior UI/UX Designer** đồng hành cùng bạn trong mọi dự án.

---

## 📑 MỤC LỤC
1. [Tư duy cốt lõi khi làm việc với Skill](#1-tư-duy-cốt-lõi)
2. [5 Kịch bản thực chiến & Mẫu câu lệnh](#2-5-kịch-bản-thực-chiến--câu-lệnh-chuẩn)
3. [Công thức viết Prompt "Chuẩn Điểm 10"](#3-công-thức-viết-prompt-chuẩn-điểm-10)
4. [Nghệ thuật duyệt & góp ý Wireframe](#4-nghệ-thuật-duyệt--góp-ý-wireframe)
5. [Tận dụng bộ đo kiểm Responsive `probe.mjs`](#5-tận-dụng-bộ-đo-kiểm-responsive-probemjs)
6. [Các "Bẫy AI" mà skill tự động triệt tiêu](#6-các-bẫy-ai-mà-skill-tự-động-triệt-tiêu)
7. [Checklist 5 bước nghiệm thu bài](#7-checklist-5-bước-nghiệm-thu-giao-diện)

---

## 1. TƯ DUY CỐT LÕI

Để làm việc hiệu quả nhất với `lucas:ui-ux`, hãy ghi nhớ 3 nguyên tắc:

### 🎯 Nguyên tắc 1: AI là Designer, không phải thợ gõ code mù
AI thông thường khi nhận lệnh sẽ ngay lập tức nhả ra một đống mã JSX/HTML lộn xộn. `lucas:ui-ux` ép AI phải:
* **Hỏi & Brief trước**: Xác định rõ mục đích màn hình, dữ liệu hiển thị và phân cấp thông tin.
* **Vẽ Wireframe trước**: Dựng khung tĩnh 2–3 phương án để bạn trực quan so sánh.
* **Chốt xong mới viết code**: Chỉ code khi phương án đã được duyệt, tránh lãng phí token và thời gian sửa lại.

### 🧩 Nguyên tắc 2: "Skill lo hình thức — Bạn lo logic"
* **Phần việc của Skill**: Bố cục, tỷ lệ padding/margin, typography, màu sắc, phân cấp thị giác, responsive, và hiển thị **mọi trạng thái** (đang chọn, rỗng, tải, lỗi, phân trang).
* **Phần việc của bạn**: Kết nối API, state management, lưu trữ dữ liệu, router và validate form. Skill sẽ để sẵn các handler rỗng (`onFilterChange`, `onRowClick`, `onSubmit`) để bạn ráp nối.

### 🛡️ Nguyên tắc 3: Tôn trọng Stack của dự án
Skill không bao giờ tự tiện cài thêm thư viện UI khác nếu dự án đã có sẵn (`shadcn/ui`, `MUI`, `Tailwind v4`...). Hãy nói rõ thư viện bạn đang dùng để AI tái sử dụng component có sẵn.

---

## 2. 5 KỊCH BẢN THỰC CHIẾN & CÂU LỆNH CHUẨN

### Kịch bản A: Dựng mới màn hình phức tạp (Mặc định - Khuyên dùng)
Dành cho: Dashboard, Quản lý đơn hàng, Hồ sơ khách hàng, Trang thanh toán.
```bash
/lucas:ui-ux Dựng màn danh sách đơn hàng cho hệ thống E-commerce.
Dữ liệu gồm: Mã đơn (#ORD-xxx), Ngày tạo, Khách hàng (tên + avatar + email), Tổng tiền, Trạng thái thanh toán (Badge màu), Nút thao tác.
Tech stack: Next.js App Router, Tailwind CSS, shadcn/ui.
```
* **Quy trình diễn ra:**
  1. AI tóm tắt Brief (Hành động chính của người dùng là gì?).
  2. Bạn gõ `ok`.
  3. AI tạo 2–3 Wireframe HTML tương tác (có thanh công cụ bật màu, xem mobile).
  4. Bạn chọn phương án (ví dụ: `Phương án B`).
  5. AI tiến hành sinh code chi tiết.

---

### Kịch bản B: Cần dựng siêu tốc (Bỏ qua Wireframe)
Dành cho: Màn hình đơn giản, cài đặt cá nhân, trang profile phụ hoặc khi bạn đã có cấu trúc rõ ràng trong đầu và muốn tiết kiệm token.
```bash
/lucas:ui-ux Dựng luôn màn cài đặt thông báo tài khoản, không cần wireframe.
Gồm các nhóm: Thông báo Email, Thông báo đẩy Web, Thông báo SMS. Dùng Switch toggle và mô tả phụ cho từng mục.
```
* **Hành vi:** AI tự động chọn bố cục tối ưu nhất theo quy chuẩn và viết code hoàn chỉnh ngay lập tức.

---

### Kịch bản C: Soi và sửa lỗi giao diện hiện có (Audit UI)
Dành cho: Trang web đang chạy localhost nhưng trông "phèn", rối mắt hoặc vỡ responsive.
```bash
/lucas:ui-ux Xem giúp trang này chỗ nào chưa ổn: http://localhost:3000/admin/products
Trang này dùng Tailwind v4. Hãy chạy probe kiểm tra từ 375px đến 1920px.
```
* **Hành vi:** AI dùng Playwright đo đạc, xuất bảng danh sách lỗi (spacing sai nhịp, nút quá nhỏ, rớt dòng ở mobile...) kèm giải pháp sửa đổi. Bạn chọn `sửa 1, 3` để AI tiến hành sửa code.

---

### Kịch bản D: Thiết kế Design System nền tảng trước
Dành cho: Dự án mới bắt đầu, chuẩn bị phát triển nhiều màn hình liên tiếp.
```bash
/lucas:ui-ux Dựng design system cho app quản lý nha khoa trước, chưa cần màn nào.
Yêu cầu tạo trang /design-system chứa bảng token màu, typography và 7 component cơ bản.
```
* **Hành vi:** Chuẩn hóa toàn bộ Token màu sắc, Spacing, Typography và 7 component nền tảng: Button, Badge, Input, Card, List Row, Modal, Empty State. Mọi màn hình dựng sau này sẽ tuân thủ tuyệt đối theo bộ này.

---

### Kịch bản E: Refactor làm sạch CSS nhưng giữ nguyên 100% giao diện
Dành cho: Dọn dẹp mã nguồn cũ, chuyển từ CSS thuần sang Tailwind mà sợ lệch pixel.
```bash
/lucas:ui-ux Refactor CSS trang /checkout sang Tailwind CSS, cam kết giữ nguyên 100% diện mạo cũ.
```
* **Hành vi:** Thay thế class, dọn dẹp CSS rườm rà, đo đạc ảnh trước/sau để đảm bảo không lệch bố cục.

---

## 3. CÔNG THỨC VIẾT PROMPT "CHUẨN ĐIỂM 10"

Một prompt chất lượng giúp AI hiểu đúng ngay từ đầu gồm 4 thành phần:

$$\text{Prompt} = \text{[Mục tiêu]} + \text{[Dữ liệu mẫu chân thực]} + \text{[Tech Stack]} + \text{[Chế độ mong muốn]}$$

### ❌ Prompt sơ sài (AI dễ làm ẩu):
> *"Dựng cho tôi trang dashboard bán hàng đẹp đẹp tí."*
*(Hậu quả: AI tự bịa dữ liệu hoạt hình, card bóng bẩy lộn xộn, viền chồng chéo, không sát thực tế).*

### ✅ Prompt chuẩn chỉnh:
> *"/lucas:ui-ux Dựng trang Dashboard tổng quan cho phần mềm quản lý kho (Warehouse).  
> **Dữ liệu thật gồm:**  
> - 4 thẻ KPI đầu trang: Tổng tồn kho, Đơn chờ xuất, Hàng sắp hết hạn (cảnh báo đỏ), Doanh thu tuần.  
> - 1 Bảng hàng nhập gần đây: Mã SKU, Tên sản phẩm, Số lượng, Kho lưu, Ngày nhập, Trạng thái.  
> - 1 Biểu đồ đường biến thiên xuất/nhập 7 ngày.  
> **Tech stack:** React + Tailwind CSS + Lucide icons.  
> **Phong cách:** Flat tối giản, nhịp nhàng, có trạng thái Empty khi kho chưa có hàng."*

---

## 4. NGHỆ THUẬT DUYỆT & GÓP Ý WIREFRAME

Khi AI gửi liên kết xem 2–3 phương án Wireframe:

### 1. Dùng thanh công cụ tương tác trên đầu trang Wireframe:
* **Nút "Màu"**: Bật/tắt màu sắc nhận diện để xem bản đen trắng (tập trung vào cấu trúc) hoặc bản có màu.
* **Nút "Mobile (375px)"**: Bấm để xem màn hình co lại kích thước điện thoại. Kiểm tra xem thanh menu có chuyển thành hamburger không, bảng có bị tràn cuộn ngang không.
* **Nút "Trạng thái rỗng / Lỗi"**: Xem thử nếu không có dữ liệu thì giao diện hiển thị thế nào.

### 2. Góp ý theo số khối (Khối 1, Khối 2, Khối 3):
Mỗi góc của một thành phần trên Wireframe đều có đánh số nhỏ. Đừng mô tả dài dòng, hãy gõ ngắn gọn:
* `"Chọn B nhưng bỏ khối 3, đưa khối 4 lên cạnh khối 2"`
* `"Phương án A ổn, nhưng đổi bảng ở khối 5 sang dạng card"`
* `"ok"` *(Nếu bạn đồng ý với phương án khuyên dùng của AI)*

---

## 5. TẬN DỤNG BỘ ĐO KIỂM RESPONSIVE `probe.mjs`

Trong repo có sẵn script Playwright chuyên dụng để kiểm tra lỗi mắt thường dễ bỏ sót:

```bash
# Quét kiểm tra trang đang chạy
node skills/ui-ux/scripts/probe.mjs http://localhost:3000/dashboard --sweep
```

### Script này tự động bắt các lỗi:
1. **Sweep Test (1440px xuống 375px, bước nhảy 20px)**: Bắt các đoạn chữ bị nhảy dòng dở dang ở khoảng cách giữa tablet và mobile (ví dụ ở 860px).
2. **Kích thước bấm (Tap Target)**: Cảnh báo bất kỳ nút, icon hay ô nhập nào có chiều cao/rộng nhỏ hơn `32px` (hoặc `< 44px` trên mobile).
3. **Focus Ring (Phím Tab)**: Tự động bấm Tab liên tục xem viền focus có hiển thị rõ cho người khuyết tật không, có bị hiệu ứng bóng đè mất không.

---

## 6. CÁC "BẪY AI" MÀ SKILL TỰ ĐỘNG TRIỆT TIÊU

Khi dùng `lucas:ui-ux`, bạn sẽ không bao giờ gặp phải các lỗi thiết kế đặc trưng của AI thông thường:

| Lỗi AI thông thường hay mắc | Cách `lucas:ui-ux` xử lý triệt để |
| :--- | :--- |
| **Nút Primary khắp nơi**: Trang có 5 cái nút thì cả 5 đều màu xanh/tím nổi bần bật. | Quy tắc **I2/I3**: Mỗi vùng nhìn chỉ duy nhất 1 nút `primary`. Các hành động phụ đều là `secondary` hoặc `ghost`. |
| **Cắt chữ mất dữ liệu (Truncate ẩu)**: Cắt ngắn chuỗi như `0912345...` hoặc `tran.nguyen@c...`. | Quy tắc **T7**: Không bao giờ cắt số điện thoại, số tiền, mã đơn. Email chỉ cắt phần tên, giữ nguyên `@domain.com`. |
| **Bóng đổ & Viền giả tạo**: Card vừa đóng khung viền đen vừa đổ bóng đậm xám xịt. | Quy tắc **M8**: Chọn viền mờ hoặc bóng nhẹ phân lớp, cấm dùng cả hai đồng thời gây bẩn giao diện. |
| **Tràn màn hình ở mobile (375px)**: Bảng dữ liệu đâm toạc lề màn hình điện thoại. | Quy tắc **R1/R4**: Tự động chuyển bảng sang dạng danh sách thẻ (card list) hoặc bọc khung cuộn ngang chuyên biệt. |
| **Hành động xoá nguy hiểm không phân biệt**: Nút Xoá dùng màu xanh như nút Lưu. | Quy tắc **I4**: Toàn bộ thao tác xoá vĩnh viễn/huỷ dịch vụ bắt buộc mang token cảnh báo đỏ (`rose-500`) và phải có modal xác nhận. |

---

## 7. CHECKLIST 5 BƯỚC NGHIỆM THU GIAO DIỆN

Trước khi đồng ý nghiệm thu một màn hình do AI dựng xong, hãy lướt nhanh qua 5 câu hỏi này:

- [ ] **1. Phân cấp nút bấm:** Nhìn vào màn hình, bạn có thấy ngay đâu là hành động chính cần làm không? (Chỉ có 1 nút nổi bật nhất).
- [ ] **2. Nhịp khoảng cách (Spacing):** Khoảng cách giữa các phần tử có theo bội số 4px/8px không? Hay chỗ thì dính sát, chỗ thì rộng ngoác?
- [ ] **3. Trải nghiệm Mobile 375px:** Co cửa sổ trình duyệt về 375px xem có bị thanh cuộn ngang trang (Horizontal scrollbar) không?
- [ ] **4. Trạng thái biên:** Màn hình này khi chưa có đơn hàng nào (Empty) trông ra sao? Khi mạng chậm (Loading skeleton) trông thế nào?
- [ ] **5. Khả năng gõ phím Tab:** Bấm phím `Tab` trên bàn phím xem vệt sáng focus có di chuyển tuần tự và dễ nhìn không?

---

> 🚀 **Chúc bạn tạo ra những sản phẩm phần mềm với giao diện đẳng cấp, chuẩn mực và tiện dụng nhất cùng `lucas-kit`!**
