# Review 2026-11-14-composer-02 — bổ sung sau khi đọc hub code-review

- Ngày: 2026-11-14
- Người/AI phản biện: Composer (Cursor)
- Tài liệu đã đọc: `analysis.md` v001; `foundational-clearance.md`; `code-review-idea-fit.md`; `code-review/docs/08-sdlc-workflow-analysis.md`, `09-code-review-context.md` (workspace)
- Phạm vi: **bổ sung** finding cho analysis — không thay `2026-11-14-composer-01.md`
- Giới hạn: không chạy OCR/CI; chỉ đọc doc hub

## 1. Hiểu bài toán

Analysis v001 chưa nói rõ ranh giới với hub code-review/mzspec delivery. Hub đó giải **cuối** pipeline (review code, QA, CI); mmd-sdd giai đoạn 0 giải **đầu** (BA → delta). Cần bổ sung nguyên tắc mượn được và non-goals — chi tiết đã ghi ở `../code-review-idea-fit.md`.

## 2. Findings bổ sung

### R08 - Thiếu nguyên tắc Spec Review ≠ Code Review và «không mù contract»

- Mức độ: major
- Mục tài liệu: analysis §9–§11; thiếu hẳn
- Nhận định: gates Ready/Complete đủ; chưa nói review code/spec khác axes
- Vấn đề: dễ hiểu nhầm bước sau là cài OCR/5-area khi mới intake BA
- Hệ quả: lệch P1 H1; ceremony cuối pipeline sớm
- Bằng chứng: `code-review/docs/08` W-11, W-17; inferred khoảng trống analysis
- Mức chắc chắn: verified (hub) / inferred (gap analysis)
- Chỉnh sửa: thêm mục ngắn trong v002 — Spec-side vs Code-side; brief bắt buộc (In/Out, scenario, blast-radius)
- Có thể bỏ bớt: không cần pipeline OCR trong analysis

### R09 - Thiếu Change-Id / audit trail trên fast path

- Mức độ: minor → major nếu nhiều task song song
- Mục: analysis §10–§11
- Vấn đề: chưa có id nối lát làm việc ↔ sau này PR
- Hệ quả: khó trace; hotfix không để dấu
- Bằng chứng: W-03, W-12; foundational P3/P5
- Mức chắc chắn: inferred
- Chỉnh sửa: mọi đường (kể Fast) có Change-Id + vài dòng ghi nhận
- Có thể bỏ bớt: chưa cần CI fail thiếu Change-Id

### R10 - Không liệt kê non-goals từ hub (OCR, two-PR, full QA)

- Mức độ: minor
- Mục: analysis §2.3 đã loại mzspec factory nhưng chưa nhắc hub code-review
- Hệ quả: contributor kéo sample-app SDLC vào Arena
- Chỉnh sửa: §2.3 hoặc mục ranh giới — trỏ `code-review-idea-fit.md` §4
- Mức chắc chắn: inferred

## 3. Thử loại task

Không lặp bảng composer-01. Bổ sung: với **CODE PR sau này**, brief từ delta (W-17) là bắt buộc; giai đoạn 0 chỉ chuẩn bị nội dung brief, chưa gắn OCR.

## 4. Phương án thay thế

Giữ companion `code-review-idea-fit.md` + backlog `v002-merge-backlog.md`; không phình analysis v001.

## 5. Kết luận

- Kết luận: **revise** (cùng hướng composer-01; thêm R08–R10 vào merge v002)
- Ba quyết định: (1) accept A–G trong idea-fit, (2) Change-Id naming, (3) có/không soft 4-axis REVIEW khi có delta
- Chưa kết luận: thời điểm cài OCR/CI

## 6. Xử lý của người tổng hợp

| Finding | Accept / Reject / Defer | Lý do | Version/mục |
|---|---|---|---|
| R08 | | | |
| R09 | | | |
| R10 | | | |
