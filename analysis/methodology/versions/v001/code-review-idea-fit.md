# Tham chiếu hub `code-review/` — idea nào dùng được cho mmd-sdd

- Version gắn: v001.
- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Nguồn: `area1/code-review/docs/` (01–09), đặc biệt `08-sdlc-workflow-analysis.md`, `09-code-review-context.md`.
- Lọc theo: `foundational-clearance.md` (P1–P6, ưu tiên **H1 method-first**), `analysis.md` (không full mzspec factory).
- Mục đích: chọn ý tưởng **dùng ngay / sau / không dùng** — không scaffold CI hay OCR vào Arena.

---

## 0. Kết luận ngắn

Hub `code-review` mạnh ở **cuối pipeline** (review code, QA runtime, CI gate) và ở **ghép mzspec ↔ review không mù**.  
mmd-sdd giai đoạn 0 đang giải **đầu pipeline** (BA rối → hiểu → delta → điểm sửa hẹp).

| Nhóm | Dùng được? |
|------|------------|
| Nguyên tắc: Spec Review ≠ Code Review; review/QA không mù contract; Change-Id; validate deterministic; findings có severity; learning từ review | **Có** — lấy ý tưởng, đóng gói nhẹ |
| OCR CLI, code-review skill 5-area, ci-gate RISK, Playwright crystallize, full `/qa`, two-PR bắt buộc, mining cron | **Chưa / không** cho giai đoạn 0 |
| Overlay checklist + 6-axis spec critic rút gọn | **Sau** khi đã có delta thật và P1–P3 chốt |

---

## 1. Bản đồ nguồn trong hub

| Doc / package | Ý tưởng cốt | Liên quan mmd-sdd |
|---------------|-------------|-------------------|
| `01-code-review.md` | Pipeline lint → audit đa chiều → verify → findings; overlay theo project | Phase **sau** có code diff; overlay = checklist Arena sau này |
| `03-open-code-review.md` | OCR: deterministic selection + agent; `--background` | Context pack; không cần cài OCR ngay |
| `02-mzspec.md` | Spec-first, validate, human merge | Đã có trong `mzspec/` + v001; mmd-sdd chỉ lấy subset |
| `04-pr-review-mining.md` | Học pattern từ PR comment → knowledge base | Phase learn rất muộn |
| `05-qa.md` | `/qa` multi-phase; crystallize; baseline | QA full quá nặng; chỉ giữ ý «map scenario ↔ acceptance» |
| `07-templates.md` | GitHub Actions OCR/lint/mining | Không copy CI giai đoạn 0 |
| `08-sdlc-workflow-analysis.md` | Ba trụ + W-01…W-19; Spec vs Code CI; Change-Id; không mù | **Giàu nguyên tắc nhất** để mượn |
| `09-code-review-context.md` | Change-Id → brief → OCR `-B` | Pattern context pack — dùng khi có CODE PR |
| `sample-app/` | Pilot wiring đầy đủ | Tham chiếu hình dạng, không clone vào Arena |

---

## 2. Idea nên lấy — dùng ngay (method / tài liệu)

Không cần cài tool. Đưa vào v002 analysis hoặc template intake.

### A. Tách Spec Review và Code Review (W-11, §2.1 của 08)

- **Ý:** Spec dùng axes khác (testability, minimality, consistency); code dùng RISK/layer. Không chạy OCR trên tài liệu BA/spec.
- **Áp dụng mmd-sdd:** Vòng phản biện phương pháp / delta = **Spec-side**. Khi có PR code = **Code-side** (sau). Khớp P3: không ceremony review code lúc đang intake BA.
- **Độ fit:** cao.

### B. «Không mù contract» (W-17, W-18, doc 09)

- **Ý:** Review/QA phải mang brief từ change (proposal, scenarios, non-goals), không chỉ diff + rule chung.
- **Áp dụng mmd-sdd ngay:** Mọi bản phân tích / câu hỏi BA / (sau này) review code **bắt buộc** gắn: mục tiêu, In/Out, scenario đã chốt, hành vi cần giữ (blast-radius). Anti-pattern: AI review chỉ đọc diff Nest.
- **Độ fit:** rất cao — cùng hướng §7–§8 analysis + P4.

### C. Trace id / Change-Id (W-03, W-05, W-15)

- **Ý:** Một id nối ticket ↔ change ↔ PR ↔ findings ↔ QA.
- **Áp dụng nhẹ:** Mỗi hồ sơ thay đổi (kể cả 1 trang intake) có `Change-Id` hoặc `Task-Id` ổn định trước khi có OpenSpec folder. PR mô tả 1 dòng `Change-Id: …` khi đến code.
- **Độ fit:** cao; chi phí thấp. Chưa cần CI fail nếu thiếu id cho đến khi có CODE PR policy.

### D. Validate deterministic vs agent soft (C-03)

- **Ý:** Cấu trúc/scenario format = hard; chất lượng prose = soft.
- **Áp dụng:** Khi có delta: `openspec validate --strict` (hoặc native `openspec.js`) là gate cứng. Review 6-axis / BA sign-off là soft cho đến khi team muốn harden.
- **Độ fit:** cao; khớp «nhẹ hơn mzspec» vẫn giữ 1 hard gate.

### E. Findings có severity + completeness pass (01 + Spec REVIEW mẫu)

- **Ý:** Blocker / Required / clean; verify không sót; report có cấu trúc (`REVIEW.md`, `findings.md`).
- **Áp dụng:** Template phản biện methodology đã gần (`review-template.md`). Mở rộng cho **delta spec**: verdict APPROVE/REVISE + bảng finding theo axis rút (Clarity, Testability, Completeness, Minimality — đủ 4, chưa cần đủ 6+UX).
- **Độ fit:** cao cho vòng spec; chưa cần 5 agent BE∥FE∥DB.

### F. Conflict / dedup intent (W-06, W-07, sample c0003)

- **Ý:** Tránh hai change/PR cùng capability; conflict vs canonical.
- **Áp dụng ngay ở tầng BA:** conflict log P4 + (sau) scan open changes cùng capability khi có nhiều SP tiềm năng song song.
- **Độ fit:** trung bình–cao; sample conflict engine thì **chưa** implement.

### G. Hotfix vẫn có audit trail (W-12)

- **Ý:** Fast path không = không ghi gì.
- **Áp dụng:** Fast path P3 vẫn ghi Change-Id + 5 dòng as-is/delta; reconcile hậu kỳ nếu cần.
- **Độ fit:** cao — hỗ trợ P3.

---

## 3. Idea nên lấy — sau khi P1–P4 chốt và có change thật

| Idea | Từ đâu | Điều kiện mở | Ghi chú Arena |
|------|--------|--------------|---------------|
| Context pack + brief builder | 09, `build-review-brief.mjs` | Có `openspec/changes/<id>/` + CODE PR | Copy ý; script có thể viết lại mỏng, không phụ thuộc sample-app |
| Overlay checklist Nest/MikroORM/ETEST | 01 overlay | Có ≥1 CODE PR theo mmd-sdd | RISK patterns riêng Arena |
| Spec REVIEW.md trong change | sample-app `review/REVIEW.md` | Có delta + Standard/Heavy path | Không bắt UI-only |
| Scenario → Test-Id map | 08 Ship Plan / QA W-05 | Có test viết được | Jest trong `02.eTest` trước Playwright |
| Mechanical lint / ci-gate RISK | 01, 07 | CI sẵn sàng + policy fail | Không chặn method-first |
| OCR với `-B` brief | 03, 09 | Team chấp nhận OCR binary + LLM cost | Optional; skill Cursor có thể thay tạm |

---

## 4. Idea không dùng (giai đoạn 0) — và vì sao

| Idea | Lý do từ chối / trì hoãn |
|------|---------------------------|
| Two-PR bắt buộc (SPEC PR → CODE PR) | Trái H1 / foundational P1; analysis đã loại factory |
| Full `/opsx:*` + gate resolver + orchestrator | mzspec factory; mmd-sdd cố ý nhẹ |
| OCR / code-review 5-area pipeline trên mọi PR | Giải bài *code quality*, không giải *BA intake*; cost cao |
| Full `/qa` 10 phase + Chrome personas | Tutorial QA; Arena ETEST không phải sample Next.js |
| PR review mining cron | Cần lịch sử PR comment đủ; Learn phase sau archive |
| Templates GHA copy nguyên (self-hosted OCR runner) | Infra giả định khác Arena |
| Spec-conflict engine semantic như c0003 | Hay nhưng là product riêng; P4 thủ công đủ trước |

---

## 5. Ánh xạ sang P1–P6

| P | Idea từ code-review giúp gì |
|---|------------------------------|
| P1 DoD giai đoạn | Đừng lấy «CI OCR xanh» làm DoD; lấy «contract + brief + quyết định» (B, C, D) |
| P2 Audience | Spec-side artifact cho BA/Dev; Code-side findings cho reviewer (A) |
| P3 Fast/full | W-12 + đường Standard mới mang REVIEW/validate (G, D) |
| P4 Conflict | Conflict log + sau này W-06/07 (F) |
| P5 Ownership | Change-Id nối hub methodology ↔ repo code khi có PR (C) |
| P6 Pilot | sample-app chỉ là *hình dạng*; pilot Arena = intake thủ công, không clone SDLC đầy đủ |

---

## 6. Đề xuất đưa vào phương pháp (không implement tool)

Thêm vào checklist / v002 (khi tổng hợp):

1. **Mọi lát Standard+:** có `Change-Id`, In/Out, ≤3 scenario, blast-radius (hành vi giữ), brief 1 trang.
2. **Trước khi coi delta xong:** soft review 4 axis (Clarity, Testability, Completeness, Minimality) → bảng finding như `REVIEW.md` mẫu.
3. **Khi có CODE PR:** bắt buộc dòng `Change-Id:` + đính brief (thủ công paste cũng được); cấm review chỉ diff.
4. **Không** đưa OCR/QA crystallize vào DoD phương pháp giai đoạn 0.

---

## 7. Rủi ro nếu «mượn sai»

- Coi sample-app SDLC là target Arena → quay lại full mzspec (P1 lệch H2/H3).
- Cài OCR sớm → tối ưu cuối pipeline trong khi đầu pipeline (BA) vẫn rối.
- Copy 6-axis nguyên văn MeKnow/mzspec mà không có delta thật → ceremony giấy.

---

## 8. Việc làm tiếp (sau khi người có thẩm quyền đọc)

- [ ] Accept/reject bảng §2 A–G và §4.
- [ ] Nếu accept C: quy ước đặt tên `Change-Id` (vd `c-sp-tiem-nang-minitest`).
- [ ] Nếu accept E: rút 4-axis vào `review-template` bản «spec-delta» (file mới khi sang v002).
- [ ] Không mở PR cài OCR/GHA từ hub cho đến hết pilot thủ công (§14 analysis).

## Liên kết

- `foundational-clearance.md` — P1–P6  
- `analysis.md` — phương pháp  
- `reviews/2026-11-14-composer-01.md` — revise  
- Hub: `area1/code-review/docs/08-sdlc-workflow-analysis.md`, `09-code-review-context.md`
