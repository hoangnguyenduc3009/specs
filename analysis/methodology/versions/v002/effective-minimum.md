# Thực sự hiệu quả — tối thiểu, không phức tạp

- Gắn: v002; pain trong `core-problem-and-loop.md`.
- Ngày: 2026-11-15.
- Vai trò: chốt ngắn “làm gì là đủ” — không phải catalog tool.

---

## Đủ dùng (3 thứ)

| # | Việc | Vì sao ăn pain |
|---|------|----------------|
| **1. Dừng hỏi trước khi code** | AI/Dev gen câu hỏi: mục tiêu, path cũ, **API/page liên quan**, cái mới vs reuse, out of scope | Chặn đoán feature từ expect |
| **2. As-is → to-be trên cùng flow** | Vài dòng/node: **giữ / sửa / thêm**; as-is lấy từ code nếu BA không có | Thấy “chỉ sửa một chút” thay vì viết lại |
| **3. Một trang tóm + điểm nối** | In/Out, unknown, seam (đụng API/service nào), hành vi giữ | Scope hẹp trước khi chia task |

Thêm **rẻ** (không bắt buộc ngay): `Change-Id` + ghi vài câu hỏi/decision sau task để lần sau hỏi tốt hơn. Không cần agent mining ngay.

---

## Không cần (giai đoạn này)

- Multi-agent / orchestrator  
- OCR / 5-area code review  
- Full mzspec `/opsx` + two-PR  
- Dynamic workflow engine  
- OpenSpec đầy đủ cho mọi task nhỏ (ticket 1 trang đủ)  
- Full `/qa`, CI gate phức tạp  

Những cái trên giải khâu khác (review diff, giao hàng). Pain hiện tại là **đầu vào BA thiếu flow cũ/mới**.

---

## Một câu

**Hiệu quả = hỏi trước + bắt buộc as-is trước to-be + tóm tắt 1 trang.**  
Còn lại để sau khi quen tay trên 1–2 task thật.

## Liên kết

- Vòng đủ [1]–[7]: `core-problem-and-loop.md`  
- Phản biện tool: `tooling-fit-vs-core-pain.md`  
- Phương pháp: `analysis.md`
