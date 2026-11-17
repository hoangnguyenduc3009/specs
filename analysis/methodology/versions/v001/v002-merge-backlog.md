# Backlog gộp vào analysis v002

- Ngày: 2026-11-14.
- Nguồn: `analysis.md` v001 (giữ nguyên) + companions + review `2026-11-14-composer-01` + `code-review-idea-fit.md`.
- Mục đích: khi tạo `versions/v002/analysis.md`, người tổng hợp biết **phải mang gì vào**, không quên companion.

**Chưa tạo v002** cho đến khi có accept/reject trên bảng dưới và (khuyến nghị) chốt P1 H1/H2/H3.

---

## 1. Từ review composer-01 (R01–R07)

| ID | Hướng xử lý đề xuất cho v002 | Mục analysis dự kiến |
|----|------------------------------|----------------------|
| R01 | Thêm bảng **loại task → hoạt động bắt buộc/tùy chọn**; vòng A/B = checklist góc nhìn | §5, §9, §10 |
| R02 | Thêm **điều kiện dừng** khảo sát reuse + semantic checklist | §7 |
| R03 | Quy tắc 1 câu: cam kết = delta/Quyết định đã ký; bản BA = draft\|accepted | §8, §10 |
| R04 | Thêm **Ready rubric** yes/no (5–7 mục); chỉ 2 cổng Ready / Done-with-evidence | §9.3, §11 |
| R05 | ≤3 câu hỏi P0/lát; mỗi câu ghi task bị chặn | §8.2 |
| R06 | Thêm ví dụ UI thuần + tích hợp partial-failure (không chỉ ETEST) | §12 |
| R07 | Blast-radius note **bắt buộc** khi chọn reuse/ít sửa | §7, §9.2 |

Cột Accept/Reject/Defer điền khi tổng hợp (copy từ §6 review).

---

## 2. Từ foundational-clearance (P1–P6)

Mang vào v002 dưới mục mới **«Quyết định vận hành»** (không để mãi ở companion):

| P | Nội dung tối thiểu trong v002 |
|---|-------------------------------|
| P1 | DoD giai đoạn 0 + lựa chọn H1/H2/H3 đã chốt (hoặc giả định có owner) |
| P2 | Primary user + moment of use |
| P3 | Ba đường Fast / Standard / Heavy + artifact bắt buộc |
| P4 | Quy trình conflict + timebox + owner mặc định |
| P5 | Nơi sống hồ sơ giai đoạn 0 (methodology hub vs product openspec) |
| P6 | Hai task thử đã đặt tên; Minitest không phải DoD phương pháp |

Nếu P chưa chốt: v002 ghi **Deferred** + owner, không xóa câu hỏi.

---

## 3. Từ code-review-idea-fit (A–G)

| Idea | Vào v002? | Cách viết ngắn |
|------|-----------|----------------|
| A Spec ≠ Code review | Có | Nguyên tắc: intake/delta không dùng OCR/code-audit |
| B Không mù contract | Có | Mọi Standard+ có brief: mục tiêu, In/Out, scenario, hành vi giữ |
| C Change-Id | Có | Mỗi lát/hồ sơ có id ổn định; CODE PR sau này ghi 1 dòng |
| D Validate cứng / review mềm | Có | Khi có delta: validate --strict; 4-axis soft |
| E Findings severity | Có (nhẹ) | Trỏ template REVIEW 4-axis; chưa bắt đủ 6+UX |
| F Conflict/dedup | Một phần | Gộp P4; engine semantic = ngoài phạm vi |
| G Hotfix audit trail | Có | Fast path vẫn Change-Id + 5 dòng |

**Không** đưa vào v002 như yêu cầu giai đoạn 0: OCR, two-PR, full `/qa`, mining, GHA templates.

---

## 4. Mục mới đề xuất trong outline v002

Ngoài chỉnh §5–§12 theo trên, thêm:

1. **§ Quyết định vận hành (P1–P6)** — từ foundational-clearance đã chốt/defer.
2. **§ Ranh giới với hub code-review / mzspec** — lấy A–G; non-goals rõ.
3. **§ Thay đổi so với v001** — bảng finding → xử lý.
4. **§ Ready rubric** — phụ lục ngắn.

Giữ: luận điểm §1, sáu hoạt động (có map path), giảm impact, BA Q, điều kiện dừng.

Bỏ hoặc rút: mọi đoạn dễ hiểu là «phải chạy đủ 6 hoạt động mọi task».

---

## 5. Việc không làm khi gộp v002

- Không scaffold OpenSpec/skills/CI từ backlog này.
- Không chép nguyên `code-review/docs/08` vào analysis.
- Không đổi trạng thái phê duyệt chỉ vì đã có backlog.
