# Chốt scaffold — ý tưởng, công nghệ, hình dạng

- Ngày: 2026-11-15.
- Trạng thái: **chốt giai đoạn pilot** (khớp code/scaffold đã có trong `mmd-sdd/`).
- Không phải: đóng gói mzspec/OCR/OpenSpec đầy đủ.

---

## 1. Ý tưởng tổng quan (1 câu)

**Trước khi code:** hỏi rõ BA + neo **luồng cũ (as-is)** + chỉ rõ **giữ/sửa/thêm** + **một trang scope/seam** — để AI/Dev không đoán feature và code thừa.

```text
BA doc  →  hỏi + API/page  →  as-is / to-be  →  one-pager  →  (sau) task / OpenSpec / code
              ↑____________________ hard stop: chưa as-is thì chưa implement
```

Sau mỗi pilot: giữ log (questions, decisions) để lần sau hỏi tốt hơn — **chưa** cần mining agent.

---

## 2. Chọn công nghệ gì

| Chọn | Dùng làm gì |
|------|-------------|
| **Cursor Agent Skill** (`SKILL.md`) | Encode playbook 3 phase; hard stop không code product |
| **Markdown templates** | `questions` / `as-is-to-be` / `one-pager` |
| **Thư mục `pilots/<change-id>/`** | Artifact + Change-Id; git được |
| **Đọc code hẹp** (readonly trong skill) | Bổ sung as-is khi BA thiếu flow |

| **Không chọn** (giai đoạn này) | Lý do |
|--------------------------------|--------|
| Full **mzspec** `/opsx` + two-PR + orchestrator | Factory giao hàng; lệch pain đầu vào |
| **OpenSpec** bắt buộc mọi task | Chỉ cân nhắc **sau** one-pager, task Standard+ |
| **OCR** / code-review 5-area / multi-agent song song | Cuối pipeline; không chặn overbuild từ BA |
| Dynamic workflow engine | Phức tạp sớm |
| Service/backend riêng cho SDD | Không cần |

**Tóm lại:** công nghệ = **Cursor skill + Markdown + folder pilots**. Không nền tảng mới.

---

## 3. Scaffold như thế nào (đã / nên giữ)

```text
area1/
  .cursor/skills/mmd-ba-clarify/SKILL.md   ← Cursor load (workspace root area1)
  mmd-sdd/
    README.md
    .cursor/skills/mmd-ba-clarify/SKILL.md ← canonical copy
    templates/
      questions.md
      as-is-to-be.md
      one-pager.md
    pilots/
      _template/          ← copy → pilots/<change-id>/
      README.md
    analysis/methodology/ ← giấy phương pháp (v001/v002)
```

**Một skill:** `mmd-ba-clarify` — Phase A hỏi → B as-is/to-be → C one-pager.

**Chưa scaffold:** skill implement, OpenSpec changes product, CI, OCR, mzspec install.

---

## 4. Cách dùng (vận hành)

1. User `@` BA/CN hoặc dán doc → gọi **mmd-ba-clarify**.  
2. Agent điền templates → ghi `mmd-sdd/pilots/<c-YYYYMMDD-slug>/`.  
3. User/BA trả lời Q còn mở → cập nhật one-pager.  
4. **Ready-to-slice = yes** mới được: chia task / (tuỳ) OpenSpec / code — **ngoài** skill này hoặc skill khác sau này.

---

## 5. Ranh giới thành công giai đoạn này

| Thành công | Thất bại |
|------------|----------|
| 1–2 pilot: có one-pager + as-is/to-be; scope hẹp hơn “đoán full CN” | Skill bị dùng để gen code feature ngay |
| Dev biết giữ gì / sửa gì trên flow cũ | Thêm tool (mzspec/OCR) trước khi thử 1 BA thật |

---

## Liên kết

- `../../../README.md` — dùng nhanh  
- `effective-minimum.md` — 3 bước  
- `core-problem-and-loop.md` — pain + vòng đủ  
- `tooling-fit-vs-core-pain.md` — vì sao không chọn factory  
- Skill: `../../../../.cursor/skills/mmd-ba-clarify/SKILL.md` (và copy dưới `area1/.cursor/skills/`)
