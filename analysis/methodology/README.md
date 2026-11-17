# Phân tích phương pháp mmd-sdd

Hồ sơ thảo luận và phản biện phương pháp SDD cho Arena. Đây chưa phải quy trình được phê duyệt, bộ OpenSpec đã triển khai hoặc yêu cầu xây dựng một feature cụ thể.

## Bản hiện tại

- **Bản mới nhất: `versions/v003/analysis.md`** — hợp nhất pain-first, vòng [1]–[7] đã chỉnh theo review CF01–CF07, và ánh xạ sang scaffold skill 0.1.0. Đọc bản này trước khi pilot.
- Guardrail chi tiết kế thừa (P1–P6, trạng thái, hai cổng): `versions/v002/analysis.md`.
- Pain + vòng làm việc gốc (user intent): `versions/v002/core-problem-and-loop.md`.
- Review được v003 xử lý: `versions/v002/reviews/2026-11-15-core-focus-review.md` (CF01–CF07).
- Fit tool vs pain: `versions/v002/tooling-fit-vs-core-pain.md`; tối thiểu hiệu quả: `versions/v002/effective-minimum.md`; chốt scaffold: `versions/v002/scaffold-decision.md`.
- Nhận định nút thắt cần chốt trước (P1–P6): `versions/v001/foundational-clearance.md`.
- Tham chiếu hub `code-review/` (idea fit): `versions/v001/code-review-idea-fit.md`.
- Trạng thái: pilot draft hợp nhất (v003); chưa nghiệm thu sau pilot.
- Ngày cập nhật: 2026-11-17, múi giờ Asia/Ho_Chi_Minh.
- Bản được phê duyệt: chưa có.
- Prompt gửi AI phản biện: `review-request.md` (đã gồm companion + review cũ).
- Mẫu đầu ra phản biện: `review-template.md`.
- Review đã có: `reviews/2026-11-14-composer-01.md`, `reviews/2026-11-14-composer-02-code-review-fit.md`.
- Tổng hợp tranh luận đa agent: `research/2026-11-14-agent-debate/04-synthesis.md`; người dùng đã chốt D-01/D-04 cho pilot, chưa nghiệm thu sau pilot.

## Cấu trúc

```text
methodology/
  README.md
  review-request.md
  review-template.md
  versions/
    v001/
      analysis.md                 # Giữ nguyên sau khi gửi review
      foundational-clearance.md   # P1–P6 clear tổng quan
      code-review-idea-fit.md     # Idea hub code-review dùng được?
      v002-merge-backlog.md       # Việc mang vào analysis v002
      reviews/
        README.md
        2026-11-14-composer-01.md
        2026-11-14-composer-02-code-review-fit.md
    v002/
      analysis.md                 # Bản pilot sau khi tổng hợp debate
      core-problem-and-loop.md    # Pain BA + vòng hỏi→flow→impact→output→learn
      tooling-fit-vs-core-pain.md # Tool nào giải pain, tool nào defer
      effective-minimum.md        # Tối thiểu hiệu quả
      scaffold-decision.md        # Chốt ý tưởng + công nghệ + scaffold 0.1.0
      reviews/
        2026-11-15-core-focus-review.md  # CF01–CF07
    v003/
      analysis.md                 # Bản hợp nhất pain-first + xử lý CF01–CF07
  research/
    2026-11-14-agent-debate/
      README.md
      01-architect.md
      02-problem-framer.md
      03-adversarial-reviewer.md
      04-synthesis.md
```

`v003/` là bản pilot hiện hành. Không sửa `analysis.md` v001/v002 in-place; review đã gửi
cho version nào thì version đó đóng băng, thay đổi đi vào version mới.

## Cách gửi cho AI khác

1. Gửi `review-request.md` (đã liệt kê bộ tài liệu).
2. Đính kèm tối thiểu: `versions/v001/analysis.md` + `review-template.md`.
3. Nên đính: `foundational-clearance.md`, `code-review-idea-fit.md`; và review đã có để tránh trùng finding.
4. Nếu AI có workspace, cho đọc hub `code-review/docs/08` / `09` khi phản biện ranh giới tool. Nếu không, ghi giới hạn bằng chứng.
5. Lưu phản biện mới cho v002 vào `versions/v002/reviews/` (file riêng, ID finding mới).
6. Người tổng hợp pilot: chỉ áp thay đổi được chấp nhận vào v002; giữ lại `deferred` D-02/D-03 cho kết quả sau pilot.

## Quy tắc version

- Giữ nguyên nội dung một version sau khi đã gửi review; sửa nội dung bằng version mới, kể cả khi cần đính chính một nhận định.
- Review luôn ghi chính xác version được phản biện. Review cho v001 không tự động được coi là hợp lệ với v002.
- Không ghi đè review của AI khác; không dùng model name như bằng chứng về độ đúng.
- Version mới phải có mục thay đổi so với bản trước và cách xử lý các review quan trọng.
- Phân biệt bản mới nhất với bản được phê duyệt. Chỉ người có thẩm quyền mới đổi trạng thái phê duyệt.
- Không tự scaffold workflow, skills hay sửa product code từ kết quả review.

## Lịch sử

| Version | Ngày | Trạng thái | Nội dung |
|---|---|---|---|
| v001 | 2026-11-14 | Draft for review | Tổng hợp định hướng từ trao đổi; đề xuất phân tích từ luồng hiện hữu, làm rõ yêu cầu và giảm phạm vi ảnh hưởng |
| v001+ | 2026-11-14 | Companion | clearance P1–P6; code-review idea-fit; v002-merge-backlog; reviews composer-01 + composer-02 |
| Debate | 2026-11-14 | Draft synthesis | Hai vòng phản biện ba vai và tổng hợp đề xuất; D-01/D-04 đã được người dùng chốt cho pilot |
| v002 | 2026-11-14 | Pilot draft | Chốt Dev là primary user và mô hình đổi mũ BA/Tech Lead; chờ hai task thật để nghiệm thu phương pháp |
| v002+ | 2026-11-15 | User intent | `core-problem-and-loop.md`: pain BA thiếu flow cũ/mới → AI code thừa; vòng hỏi–đáp → tổng hợp → flow trước/sau → impact → task/OpenSpec → learn |
| v002+ | 2026-11-15 | Tooling fit | `tooling-fit-vs-core-pain.md`: playbook/as-is-first OK; multi-agent/OCR/dynamic workflow/full mzspec defer hoặc reject sớm |
| v002+ | 2026-11-15 | Review + scaffold | `reviews/2026-11-15-core-focus-review.md` (CF01–CF07); `scaffold-decision.md` + skill 0.1.0, templates, pilots/, learning/ |
| v003 | 2026-11-17 | Pilot draft hợp nhất | Gộp user intent + xử lý CF01–CF07: định vị code sớm trong vòng, bảng expect→as-is→delta làm trung tâm, ranh giới điểm nối theo loại thay đổi, khép vòng diff vs delta, learn loop phân biệt bài học kiểm chứng, đo lường pilot thay "code thừa tránh được" |
