---
name: mmd-ba-clarify
description: >-
  Clarify BA/BRD/CN docs before coding: generate questions, list related APIs/pages,
  map as-is vs to-be on the existing flow, write a one-page scope with seams.
  Use when the user pastes or @-mentions long BA docs, SP tiềm năng CN, or asks to
  intake/clarify requirements with mmd-sdd. Hard stop: do not implement product code.
---

# mmd-ba-clarify

Neo pain: tài liệu BA dài / thiếu luồng cũ–mới / chỉ expect → AI dễ code thừa. Skill này **chỉ** làm rõ scope.

## Hard rules

1. **Không** viết production code, không scaffold feature, không mở OpenSpec change trừ khi user **sau** one-pager yêu cầu rõ.
2. **Không** đề xuất to-be rộng khi chưa có as-is (từ BA hoặc từ code).
3. Không hỏi BA điều đã đọc được trong repo — tự điều tra rồi ghi `observed`.
4. Mỗi lần chạy: đề xuất hoặc dùng `Change-Id` dạng `c-YYYYMMDD-<slug>`.
5. Ưu tiên ghi file vào `pilots/<change-id>/` (template: `pilots/_template/`, khung: `templates/`).

## Phase A — Hỏi & scope sơ bộ

1. Đọc tài liệu user cung cấp.
2. Sinh câu hỏi theo `templates/questions.md` (không cần hỏi hết một lúc; ưu tiên blocker).
3. Liệt kê bảng: API / page / màn **đã biết** | **cần BA hoặc cần tìm trong code** | **ngoài scope**.
4. In/Out sơ bộ + unknown.
5. Nếu thiếu thông tin chặn as-is: dừng Phase A, liệt kê câu hỏi — **không** nhảy sang thiết kế giải pháp lớn.

## Phase B — As-is → to-be

1. Nếu có workspace: trace code theo API/page đã liệt kê (đọc hẹp, có mục tiêu).
2. Điền `templates/as-is-to-be.md`: node **giữ / sửa / thêm**.
3. Gắn mỗi expect BA vào một node; expect không gắn được → unknown hoặc conflict.
4. Lệch BA ↔ code → ghi câu hỏi thêm (mũ BA), không tự chốt nghiệp vụ.

## Phase C — One-pager

1. Điền `templates/one-pager.md`.
2. Bắt buộc có: seam (điểm nối), hành vi giữ, unknown còn lại, đề xuất lát làm tiếp (không phải full plan OpenSpec).
3. Kết thúc bằng: **Ready-to-slice?** yes/no + lý do; nếu no → liệt kê blocker.

## Output tối thiểu trong chat

- Change-Id đề xuất  
- Bảng API/page  
- As-is / to-be (ngắn)  
- One-pager (hoặc path file đã ghi)  
- Câu hỏi còn mở (nếu có)  

## Sau skill này (user quyết)

- Chia task / implement  
- hoặc OpenSpec nhẹ  
- Không tự làm trừ khi được yêu cầu sau khi one-pager xong  

## Tham chiếu

- `../../analysis/methodology/versions/v002/effective-minimum.md`
- `../../analysis/methodology/versions/v002/core-problem-and-loop.md`
- `../../analysis/methodology/versions/v002/scaffold-decision.md`
