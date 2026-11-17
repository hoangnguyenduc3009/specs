# Vấn đề cần giải trước — làm rõ bức tranh tổng quan

- Version gắn: v001 (`analysis.md`).
- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Trạng thái: nhận định để chốt; chưa phải quyết định được phê duyệt.
- Mục đích: trước khi tinh chỉnh 6 hoạt động / OpenSpec / skills, **làm rõ đang muốn làm gì** và **chặn nào phải gỡ trước**.
- Không phải: thiết kế feature Minitest; không phải scaffold tool.

---

## 0. Tóm tắt một trang

Hiện tại có nhiều mục tiêu **đúng nhưng chưa cùng một hàng ưu tiên**. Nếu không xếp thứ tự, mọi thảo luận về artifact/skill sẽ trôi.

**Bức tranh mong muốn (đề xuất diễn đạt lại):**

> Xây một **cách làm việc lặp lại được** để, khi nhận tài liệu BA (đặc biệt SP tiềm năng), team/AI: (1) hiểu đúng yêu cầu dù doc rối, (2) neo vào hệ thống hiện hữu trước khi đề xuất sửa, (3) thu hẹp phạm vi ảnh hưởng có kiểm chứng, (4) chỉ đóng gói thành OpenSpec/skills sau khi cách làm đã chứng minh trên vài task thật.

**Chưa phải mục tiêu giai đoạn này:** thay BA; thay Jira; cài full mzspec; ship Minitest end-to-end; drift tooling tự động.

**Sáu nút thắt phải chốt (hoặc tạm ghi giả định có owner) trước khi thiết kế sâu tool:**

| # | Nút thắt | Nếu không chốt | Hệ quả |
|---|----------|----------------|--------|
| P1 | Một câu thành công của giai đoạn phương pháp | Mỗi người tối ưu tiêu chí khác | Tool/process phình hoặc vô dụng |
| P2 | Ai là người dùng chính của mmd-sdd | Artifact viết cho sai audience | BA không đọc / Dev bỏ qua |
| P3 | Đơn vị công việc tối thiểu (fast path vs full) | Mọi task bị ceremony giống nhau | Không ai dùng khi gấp |
| P4 | Nguồn chân lý khi BA / chat / code / spec lệch | AI/dev tự chọn | Rework, nghiệm thu giả |
| P5 | Ownership hồ sơ (hub `mmd-sdd` vs từng repo) | Spec lạc khỏi PR code | Không truy được requirement → commit |
| P6 | Ranh giới «phương pháp» vs «pilot product» | Minitest nuốt roadmap SDD | Không học được quy trình tổng quát |

Phần dưới đào sâu từng nút: vấn đề, nhận định, lựa chọn cần quyết, điều kiện đủ để sang bước kế.

---

## 1. P1 — Thành công của giai đoạn này là gì?

### Vấn đề

Trong các vòng trao đổi đã xuất hiện **nhiều “thành công” chồng nhau**:

- A. Đọc BA tốt hơn (intake, câu hỏi, conflict).
- B. Ít sửa / ít impact khi đổi hệ thống hiện hữu.
- C. Có OpenSpec + skills (đóng gói).
- D. Pilot Minitest / SP tiềm năng chạy được.
- E. Phản biện nhiều AI / version ý kiến.

A–E đều hợp lệ nhưng **không cùng KPI**. Nếu không chọn 1–2 tiêu chí giai đoạn 0, sẽ thiết kế như đang làm product SDD hoàn chỉnh.

### Nhận định

- Giai đoạn hiện tại trong `analysis.md` §2.1 đã nói: **chỉ thiết kế phương pháp và tài liệu**, chưa scaffold. Vậy thành công gần nhất phải đo bằng **chất lượng quyết định và độ dùng được của khung**, không bằng số file OpenSpec.
- «Ít impact» (§1, §7) là **tiêu chí chất lượng phương án kỹ thuật**, không phải tiêu chí thành công của việc *dựng phương pháp*. Trộn hai tầng này làm mất trọng tâm.
- Pilot product (Minitest) chỉ là **phương tiện thử**, không phải definition of done của mmd-sdd ở bước này.

### Cần quyết (chọn một hướng chính)

| Lựa chọn | Definition of done giai đoạn 0 | Không làm gì trong giai đoạn 0 |
|----------|-------------------------------|-------------------------------|
| **H1 — Method-first (đề xuất)** | Có khung intake + delta + blast-radius đã thử thủ công trên ≥2 loại task; có 3 quyết định P2–P4 đã chốt hoặc giả định có owner | Không scaffold skills/OpenSpec; không implement Minitest |
| **H2 — Pack-first** | Có `mmd-sdd` + OpenSpec template + 2–3 skills chạy được trên 1 change mẫu | Có thể chưa chứng minh khung trên task thật |
| **H3 — Product-first** | Minitest CN4/CN5 (phần BE) có contract + tasks sẵn triển khai | Phương pháp chỉ là phụ lục của feature |

### Điều kiện đủ để coi P1 đã clear

Viết được một câu: *“Sau 2 tuần, ta biết mmd-sdd thành công nếu ___ và thất bại nếu ___.”*  
Đề xuất điền sẵn (H1): thành công nếu **một Dev/AI khác áp dụng khung thủ công ra được In/Out + 3 câu hỏi P0 + điểm nối reuse có blast-radius** trên task không phải Minitest; thất bại nếu chỉ sinh thêm Markdown không ai dùng để hỏi BA / ước lượng.

---

## 2. P2 — Ai dùng, để làm việc gì, ở bước nào?

### Vấn đề

Artifact đề xuất (bản phân tích BA, design, delta spec) phục vụ **nhiều vai** cùng lúc: BA xác nhận nghiệp vụ, Dev chọn điểm sửa, QA lấy scenario, AI agent điền hồ sơ. Nếu không tách **góc đọc**, sẽ viết một tài liệu «đủ cho mọi người» → không ai đọc hết.

### Nhận định

- §8 đã đúng hướng: BA không cần duyệt kiến trúc repo. Nhưng chưa chốt **ai bắt buộc mở hồ sơ trước estimate**.
- Nếu người dùng chính là **AI coding agent**, ưu tiên contract + scenario + đường dẫn code. Nếu chính là **Dev lead + BA**, ưu tiên tiếng nghiệp vụ + câu hỏi có ví dụ phân biệt.
- SP tiềm năng hiện đang ở `docs/sp-tiem-nang/` (Notion export) — BA/PO có thể **không bao giờ** vào `mmd-sdd/`. Khi đó «bản trao đổi BA» phải có kênh xuất (Notion/MR description), không chỉ file git.

### Cần quyết

1. **Primary user** giai đoạn 0: (a) Dev/AI trong Cursor, (b) BA/PO, (c) cả hai với hai góc đọc rõ.
2. **Moment of use**: trước grooming / trong spike / trước mỗi PR / chỉ khi task «có ý nghĩa hành vi».
3. **Kênh xuất BA**: git-only hay bắt buộc summary 1 trang ra ticket/Notion.

### Điều kiện đủ

Có câu: *“Trước khi estimate task X, [vai] phải có [artifact tối thiểu]; BA chỉ bị hỏi khi [điều kiện].”*

---

## 3. P3 — Đơn vị công việc tối thiểu (tránh ceremony bằng nhau)

### Vấn đề

§5 mô tả sáu hoạt động; §10 có bảng độ sâu theo loại task — nhưng **chưa khóa** fast path. Đây là nút thắt lớn nhất khiến bức tranh «muốn nhẹ hơn mzspec» vẫn trông nặng.

### Nhận định

Ba lớp việc đang bị gọi chung là «làm SDD»:

| Lớp | Ví dụ | Cần gì |
|-----|--------|--------|
| L0 — Meta phương pháp | Viết/sửa `analysis.md`, review AI | Hồ sơ methodology (đang làm) |
| L1 — Intake yêu cầu | Nhận CN4/CN5, hỏi BA | 1 trang + ≤3 Q P0 |
| L2 — Change có hành vi | EC3 flag, API mới | Delta + design ngắn + tasks |

Nếu L1 bị ép làm L2 (đầy OpenSpec), bức tranh tổng quan bị hiểu nhầm thành «mọi thứ đều là change».

### Cần quyết

Định nghĩa **3 đường** (tên có thể đổi):

1. **Fast:** UI/copy/no rule → intake ngắn, không delta OpenSpec.
2. **Standard:** đổi rule / contract → proposal + delta scenarios + blast-radius.
3. **Heavy:** vòng đời, tiền, migration, cross-repo → standard + state/partial-failure + rollback note.

Ai được quyền chọn đường? (Dev tự chọn có checklist / Tech owner).

### Điều kiện đủ

Một bảng 1 trang: loại task → đường → artifact bắt buộc. Không còn câu «có thể bỏ bớt» chung chung mà không map loại task.

---

## 4. P4 — Khi các nguồn lệch, cái gì thắng?

### Vấn đề

SP tiềm năng điển hình: `tong-quan-raw` vs CN chi tiết vs Figma vs chat vs code «hiện hành». §4 chẩn đoán đúng nhưng **cố ý không đặt quy tắc ưu tiên** — hợp lý lúc phân tích, **chặn** lúc muốn clear «ta đang làm theo cái gì».

### Nhận định

Không cần luật vĩnh viễn «AC luôn thắng». Cần **quy trình xử lý lệch** có điểm dừng:

```text
Phát hiện lệch → ghi Conflict (2 cách hiểu + ví dụ phân biệt)
  → Owner nghiệp vụ chốt (hoặc timebox + giả định ghi rõ)
  → Chỉ sau đó mới là baseline cho lát làm việc
```

Code là evidence **hiện trạng**, không tự thắng yêu cầu tương lai — giữ nguyên §4.  
Chat không được thành requirement trừ khi ghi vào conflict/decision log.

### Cần quyết

1. Owner mặc định cho conflict nghiệp vụ SP tiềm năng là ai?
2. Timebox trả lời P0 (vd 2 ngày làm việc) — hết hạn thì slice độc lập theo giả định nào?
3. Figma: minh họa UI hay nguồn rule? (đề xuất: UI only trừ khi CN viện dẫn rõ)

### Điều kiện đủ

Có **một conflict đã xử lý mẫu** (dù giả định): ví dụ «Nộp bài vs Chấm điểm nhanh» → Resolved theo CN5, owner X, ngày Y. Chứng minh quy trình chạy được, không chỉ mô tả.

---

## 5. P5 — Hồ sơ sống ở đâu so với code?

### Vấn đề

Workspace `area1/` là **nhiều git root**. Hub `mmd-sdd/` tiện cho thảo luận phương pháp; code ETEST nằm `backend-mmd-v2-area1`. Nếu không chốt ownership, «canonical spec» sẽ hoặc (a) không ai merge theo, hoặc (b) lệch repo.

### Nhận định

Tách hai thứ:

| Loại nội dung | Nơi hợp lý giai đoạn 0 | Lý do |
|---------------|------------------------|--------|
| Phương pháp, review, foundational clearance | `mmd-sdd/analysis/...` | Cross-repo, chưa gắn một service |
| Change/spec gắn triển khai ETEST | Sau này: trong repo code hoặc submodule link từ hub | PR review cùng diff |

Giai đoạn 0 **không bắt buộc** chọn xong topology Git lâu dài; chỉ cần quyết: *bây giờ ta chỉ version phương pháp ở mmd-sdd; chưa tạo openspec changes cho product.*

### Cần quyết

- **Ngắn hạn:** chỉ methodology trong `mmd-sdd` (đề xuất).
- **Khi có change product đầu tiên:** openspec nằm repo nào? (v2 / mmd-sdd / cả hai với link)

### Điều kiện đủ

Một dòng trong README methodology: *“Product OpenSpec: chưa mở / sẽ mở tại ___.”*

---

## 6. P6 — Ranh giới phương pháp vs pilot Minitest

### Vấn đề

Cuộc trò chuyện và khảo sát code đã neo rất mạnh vào Minitest. Dễ biến mmd-sdd thành «dự án phụ của CN4/CN5».

### Nhận định

Dùng Minitest như **stress test input BA** là đúng (§12). Sai khi:

- Chốt API Minitest trước khi chốt P1–P4.
- Đo thành công mmd-sdd bằng việc ship menu Thi thử.

Pilot thứ hai (khác loại: UI thuần hoặc tích hợp partial-failure) phải nằm trong kế hoạch **trước** khi đóng gói skills — khớp §14, cần biến thành cam kết thứ tự.

### Cần quyết

Thứ tự thử: (1) áp dụng khung thủ công lên **một task không phải Minitest** hoặc (2) chỉ Minitest trước?  
Đề xuất: **một lát Minitest-as-example (intake only) + một lát loại khác** trước pack tool.

### Điều kiện đủ

Danh sách 2 task thử đã đặt tên (dù chưa làm), không chỉ «vài task khác loại» chung chung.

---

## 7. Các mục tiêu đang cạnh tranh — xếp hàng đề xuất

Không phủ nhận mục tiêu phụ; chỉ **xếp hàng** để clear tổng quan.

| Ưu tiên | Mục tiêu | Thuộc P# | Ghi chú |
|--------|----------|----------|---------|
| 1 | Biết thành công giai đoạn 0 đo bằng gì | P1 | Chốt H1/H2/H3 |
| 2 | Biết ai dùng artifact ở bước nào | P2 | |
| 3 | Fast vs full path | P3 | Điều kiện để «nhẹ» có thật |
| 4 | Quy trình xử lý lệch nguồn | P4 | Điều kiện để «đúng yêu cầu» có thật |
| 5 | Nơi sống của hồ sơ giai đoạn 0 | P5 | Có thể tạm |
| 6 | Tách pilot product khỏi đóng gói tool | P6 | |
| sau | OpenSpec schema, skills Cursor, indexion | — | Chỉ sau khi 1–4 clear và đã thử thủ công |
| sau | Implement Minitest BE/FE | — | Product track riêng |

---

## 8. Nhận định tổng hợp (để phản biện tiếp)

1. **Bức tranh tổng quan chưa clear** chủ yếu vì đang **song song** ba việc: viết phương pháp, tưởng tượng tool, và giải bài Minitest. Cần **serialize**: clear P1–P4 → thử thủ công → mới pack.
2. `analysis.md` v001 đã đủ làm **luận điểm phương pháp**; thiếu lớp **quyết định vận hành** (P1–P6). Tài liệu này bổ sung lớp đó, không thay v001.
3. Nút thắt đắt nhất: **P3 (fast/full)** + **P1 (DoD giai đoạn)**. Không chốt hai cái này thì mọi tranh luận artifact đều sớm.
4. «Quản lý sự chưa rõ» (§1 analysis) chỉ đứng vững nếu **P4** có owner + timebox; nếu không, «chưa rõ» trở thành trạng thái vĩnh viễn.
5. Không cần thêm framework mới; cần **trả lời chọn H1/H2/H3 và primary user** trong một vòng chốt ngắn (người có thẩm quyền, không phải bỏ phiếu AI).

---

## 9. Việc làm ngay (không phải implement product)

1. Người có thẩm quyền đánh dấu P1: **H1 / H2 / H3** (khoanh vào §1).
2. Điền P2: primary user + moment of use (3 dòng).
3. Duyệt hoặc sửa bảng 3 đường P3.
4. Chọn 1 conflict mẫu + owner (P4) — có thể lấy «Chấm điểm nhanh vs Nộp bài».
5. Ghi P5 ngắn hạn = chỉ methodology tại `mmd-sdd` (nếu đồng ý).
6. Đặt tên 2 task thử cho P6.
7. Sau đó mới: tổng hợp review → v002 analysis, hoặc thử intake thủ công.

---

## 10. Liên kết

- Phương pháp đầy đủ: `analysis.md`
- Prompt phản biện phương pháp: `../../review-request.md`
- Review AI: `reviews/` (composer-01, composer-02)
- Idea từ hub code-review: `code-review-idea-fit.md`
- Backlog gộp analysis v002: `v002-merge-backlog.md`
- Không chỉnh `analysis.md` in-place; thay đổi lớn → `versions/v002/`.
