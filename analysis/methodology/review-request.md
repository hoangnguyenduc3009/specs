# Yêu cầu phản biện phương pháp mmd-sdd

Bạn được giao phản biện tài liệu `versions/v003/analysis.md`. Đây là thiết kế phương pháp đang thảo luận, không phải yêu cầu implement.

## Tài liệu kèm (nên đọc)

Bắt buộc:

- `versions/v003/analysis.md` — bản hợp nhất hiện hành
- `review-template.md` — format đầu ra

Nên đọc nếu có trong workspace (companion, không thay analysis):

- `versions/v002/analysis.md` — guardrail chi tiết P1–P6, trạng thái, hai cổng (v003 kế thừa)
- `versions/v002/core-problem-and-loop.md` — user intent gốc về pain và vòng [1]–[7]
- `versions/v002/tooling-fit-vs-core-pain.md` — vì sao defer multi-agent/OCR/full mzspec
- Skill đang chạy: `.cursor/skills/mmd-ba-clarify/SKILL.md`, `.cursor/skills/mmd-challenge-change/SKILL.md` — kiểm tra giấy và skill có lệch nhau không

Review đã có (không ghi đè; finding mới dùng ID mới, vd CF08+):

- `versions/v002/reviews/2026-11-15-core-focus-review.md` — CF01–CF07, v003 đã ghi disposition tại §11
- `versions/v001/reviews/2026-11-14-composer-01.md`
- `versions/v001/reviews/2026-11-14-composer-02-code-review-fit.md`

## Bối cảnh cần giữ đúng

- Người dùng muốn một phương pháp tổng quát cho tài liệu BA nhiều lớp, mâu thuẫn, thiếu contract và phụ thuộc hành vi hiện hữu.
- Minitest CN4/CN5 chỉ là mẫu input đã khảo sát; không chuyển nhiệm vụ này thành thiết kế riêng feature Minitest.
- Ưu tiên hiểu luồng cũ, tái sử dụng hợp lý, giảm phạm vi ảnh hưởng và có bằng chứng regression.
- Không tối ưu số dòng sửa bằng mọi giá; không dựng lại toàn bộ mzspec factory; không mặc định cài OCR / full QA / two-PR từ hub `code-review/`.
- Chưa có quyết định cuối cùng về phương pháp, artifacts, skills hay topology sở hữu spec.
- Giai đoạn 0 ưu tiên **method-first** (xem foundational-clearance P1): chứng minh cách làm trước khi pack tool.

## Nhiệm vụ

1. Tóm tắt cách bạn hiểu vấn đề trong tối đa 5 câu, chỉ ra nếu tài liệu đang giải sai bài toán.
2. Tìm các điểm yếu theo mức độ ảnh hưởng: giả định không có bằng chứng, thiếu bước, lặp tài liệu, vòng lặp không có điểm dừng, nguy cơ quá nặng hoặc quá nhẹ. Tránh trùng R01–R10 và CF01–CF07 đã có trừ khi bác bỏ có lý do hoặc chỉ ra v003 xử lý chưa đủ.
3. Phản biện riêng mục tiêu "ít sửa code": cách nào vẫn ít dòng nhưng impact lớn, hoặc reuse làm sai nghiệp vụ?
4. Đánh giá việc tạo tài liệu trao đổi BA và bộ câu hỏi: có thực sự giúp ra quyết định hay chỉ chuyển công việc sang BA?
5. Kiểm tra phương pháp với ít nhất 3 dạng thay đổi khác nhau, không chỉ Minitest: UI thuần, quy tắc nghiệp vụ dùng chung, tích hợp có lỗi một phần.
6. Đánh giá ranh giới với hub code-review/mzspec: analysis đã đủ non-goals chưa? Có kéo nhầm cuối pipeline (OCR/CI) vào đầu pipeline (BA) không?
7. Đề xuất phương án thay thế tối giản hơn nếu hợp lý. Không chỉ bổ sung bước hoặc thêm tool.
8. Kết luận: keep, revise hoặc rethink; nêu 3 quyết định cần chốt tiếp theo (có thể trùng P1–P3).

## Yêu cầu về bằng chứng

- Phân biệt: điều đã kiểm chứng, suy luận, đề xuất và câu hỏi mở.
- Nếu có workspace, kiểm tra có mục tiêu; nêu file/function liên quan. Không đọc toàn repo chỉ để tạo báo cáo dài.
- Nếu không có workspace, ghi rõ không kiểm chứng code. Không lặp lại nhận định trong tài liệu như sự thật độc lập.
- Khi nhắc best practice hoặc hành vi công cụ, kiểm chứng bằng nguồn chính thức nếu có điều kiện; không tạo citation hoặc đường dẫn giả.
- Không có đủ bằng chứng thì nêu điều cần kiểm tra, không kết luận chắc chắn.
- Chỉ đọc; không sửa analysis, review của người khác hoặc product code. Nếu được yêu cầu ghi file, chỉ tạo file review mới tại thư mục của đúng version.

## Đầu ra

Dùng `review-template.md` nếu có. Mỗi finding cần có:

- Mục tài liệu liên quan.
- Vấn đề cụ thể và tình huống khiến vấn đề xuất hiện.
- Hệ quả nếu giữ nguyên.
- Đề xuất chỉnh sửa nhỏ nhất hoặc phương án thay thế.
- Bằng chứng và mức chắc chắn.

Không cần khen chung chung, viết lại toàn bộ tài liệu hoặc tạo scaffold.
