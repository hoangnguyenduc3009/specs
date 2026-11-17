# Bài toán cốt lõi và vòng làm việc mong muốn

- Gắn version: v002.
- Ngày: 2026-11-15, Asia/Ho_Chi_Minh.
- Nguồn: phát biểu trực tiếp của người dùng (pain thật khi nhận tài liệu BA + AI implement).
- Vai trò: **làm rõ bức tranh “muốn giải gì”** — bổ sung / neo trọng tâm cho `analysis.md` v002; không thay quyết định P đã chốt trong v002.
- Trạng thái: user intent đã ghi; **đã gộp vào `../v003/analysis.md` (2026-11-17)** — pain và vòng [1]–[7] thành mục trung tâm, có chỉnh theo review CF01–CF07. File này giữ nguyên làm bản ghi intent gốc.

---

## 1. Vấn đề cốt lõi (pain)

Tài liệu BA thường:

| Hiện tượng | Hệ quả |
|---|---|
| Quá dài, không nêu trọng tâm | Dev/AI không biết phần nào bắt buộc |
| Không mô tả **luồng cũ** và **luồng mới nối vào đâu** | Không thấy “chỉ cần sửa một chút trên flow đã có” |
| Chỉ nêu **expect / mong muốn** (UI, kết quả) | AI suy ra hệ thống mới hoặc đụng nhiều chỗ không cần |
| Thiếu API / page / màn hình liên quan đã có | Scope “cái mới” vs “cái reuse” không rõ |

**Hệ quả điển hình:** AI (hoặc Dev) **code thừa rất nhiều**, trong khi thực tế chỉ cần neo luồng hiện hữu và chỉnh hẹp.

Đây là bài toán mmd-sdd phải giải **trước** mọi thảo luận OpenSpec vs mzspec hay skill pack.

---

## 2. Vòng làm việc mong muốn (theo thứ tự)

Không bắt buộc nhiều file; bắt buộc **đúng thứ tự tư duy**. Mỗi bước có thể quay lại bước trước nếu phát hiện lệch.

```text
[1] Nhận tài liệu BA
        ↓
[2] Vẽ bức tranh BA bằng hỏi–đáp
    · AI gen câu hỏi để làm rõ bức tranh
    · Yêu cầu cung cấp API / page / màn liên quan (luồng đã có)
    · Phân biệt: cái nào đã có · cái nào mới · cái nào ngoài scope
        ↓
[3] Khi bức tranh đủ rõ → tổng hợp lại tài liệu BA
    · Ngắn, hệ thống, đi vào trọng tâm
    · Không viết lại BRD dày hơn bản gốc
        ↓
[4] Đối chiếu code + tài liệu tổng hợp
    · Vẽ / ghi flow trước (as-is) và flow sau (to-be)
    · Chỗ lệch → hỏi–đáp thêm nếu cần
        ↓
[5] Đánh giá nguy cơ impact
    · Shared rule, nhiều caller, side effect, tích hợp…
    · Hỏi–đáp thêm nếu cần (mũ BA / Tech Lead)
        ↓
[6] Khi đã rõ → chia task hoặc xuất artifact triển khai
    · Ticket/task nhỏ, hoặc
    · OpenSpec / mzspec-style (cân nhắc loại nào phù hợp — xem §4)
        ↓
[7] Sau mỗi task: lưu lịch sử học được
    · Câu hỏi, changelog, decision, review, các bước đã làm
    · Agent tổng hợp (ý tưởng kiểu pr-review-mining trong hub code-review)
      → cải thiện skill / checklist lần sau
```

### 2.1. Bước [2] — Clearify bức tranh (quan trọng nhất lúc nhận doc)

Mục tiêu: **hiểu BA đang nói về thế giới nào**, không phải bắt đầu code.

AI / Dev chủ động hỏi, ví dụ nhóm:

| Nhóm câu hỏi | Mục đích |
|---|---|
| Actor & mục tiêu | Ai làm gì, thành công nhìn thấy thế nào? |
| Luồng đã có | User đang đi path nào hôm nay? Page/API nào? |
| Expect gắn chỗ nào | Expect gắn màn/API cũ hay yêu cầu bề mặt mới? |
| Cái mới vs reuse | Field/API/màn nào chưa có? Cái nào chỉ đổi điều kiện hiển thị? |
| Ngoài scope | Phần nào thuộc task khác / “như hiện hành” chưa verify? |

**Đầu ra tối thiểu của [2]:** danh sách API/page liên quan (đã biết / cần BA cung cấp / Dev tự tìm trong repo), In/Out sơ bộ, unknown còn lại.

Không hỏi BA điều đã đọc được trong code (khớp v002 §8).

### 2.2. Bước [3] — Tổng hợp BA ngắn

Một bản “cách hiểu đã kiểm” — trọng tâm, có nguồn. Chưa phải accepted intent cho đến khi mũ BA chốt (v002 §6).

### 2.3. Bước [4] — Flow trước / sau

Bắt buộc trả lời: **giữ node nào, sửa node nào, thêm node nào**.  
Nếu BA chỉ có expect mà không có as-is → as-is lấy từ code (+ ghi `observed`); lệch expect → conflict/Q (v002 §4).

### 2.4. Bước [5] — Impact

Đúng pain “sửa 1 chút”: chứng minh điểm nối hẹp + hành vi giữ; tránh “viết lại module”. Khớp v002 §7 (seam note / blast-radius).

### 2.5. Bước [6] — Chia task hoặc xuất OpenSpec / mzspec

| Tình huống | Hướng xuất |
|---|---|
| Lát nhỏ, team chỉ cần ticket | Goal + Slice + Decision + Verification trong ticket (v002 §4 hồ sơ tối thiểu) |
| Cần contract/scenario bền, nhiều người | Delta OpenSpec-style (proposal/design/tasks/scenarios) |
| Team đã gắn mzspec/`/opsx` | Có thể dùng mzspec artifact — **không bắt buộc** giai đoạn pilot phương pháp |

**Cân nhắc OpenSpec vs mzspec (chưa chốt tool):**

- **OpenSpec (model artifact):** đủ cho contract + validate; nhẹ hơn.
- **mzspec (pipeline + gates + /opsx):** chỉ khi cần factory giao hàng; pilot phương pháp **không** lấy full mzspec làm DoD (v002 §10).

Quyết định loại output thuộc mũ Tech Lead/Dev sau khi [4][5] xong — không chọn tool trước khi rõ flow cũ/mới.

### 2.6. Bước [7] — Learn loop (sau task)

Lưu theo Change-Id / task id:

- Câu hỏi đã hỏi + câu trả lời / blocked  
- Decision log (mũ, ngày)  
- Changelog thực tế so với kế hoạch  
- Review findings (nếu có)  
- Các bước đã đi (có skip bước nào vì Fast path)

Định kỳ (không mỗi commit): agent/người **tổng hợp pattern** → cập nhật checklist hỏi lúc nhận BA, semantic reuse, impact — cùng ý tưởng `pr-review-mining` trong hub `code-review`, nhưng trước hết mining **lịch sử clarify + decision**, chưa cần mining PR comment GitHub.

---

## 3. Ánh xạ sang v002 (đã có gì / còn lệch gì)

| Mong muốn người dùng | Trong v002 | Lệch cần lưu ý |
|---|---|---|
| Pain: BA dài, thiếu flow cũ → AI code thừa | §1, §7 gợi ý; **chưa đặt pain này làm mở đầu** | v003 nên đưa §1 pain + vòng [1]–[7] lên trước |
| Hỏi–đáp clear bức tranh + API/page | §5 flow, §8 câu hỏi | Thiếu checklist tường minh “xin API/page liên quan” |
| Tổng hợp BA ngắn | §4 Goal/Slice | Đủ ý; cần nhấn “không dày hơn BRD gốc” |
| Flow trước/sau + lệch → hỏi | §3 lát, §4 P4 | Đủ ý; cần bắt buộc as-is từ code khi BA không có |
| Impact → hỏi | §7 | Đủ |
| Chia task / OpenSpec / mzspec | §4 hồ sơ; §10 ranh giới | Thiếu mục “cân nhắc loại output” sau khi rõ |
| Lịch sử Q/decision/review → cải thiện skill | §11 learn gián tiếp; idea-fit mining | **Thiếu** Learn loop tường minh trong analysis |

---

## 4. Nguyên tắc chống code thừa (rút từ pain)

1. **Chưa được vẽ/ghi as-is thì chưa được đề xuất to-be rộng.**  
2. **Expect không đủ để mở scope** — phải gắn expect vào node flow cũ hoặc ghi rõ “bề mặt mới”.  
3. **Mỗi đề xuất sửa phải chỉ ra điểm nối** trên flow cũ; nếu không chỉ ra được → còn unknown, không implement.  
4. **Tái sử dụng là mặc định ứng viên**; viết mới phải giải thích vì sao điểm nối cũ không đủ.  
5. **AI không được “đoán full feature”** để lấp chỗ BA thiếu flow — phải hỏi hoặc spike đọc code.

---

## 5. Đầu ra tối thiểu theo giai đoạn (checklist nhanh)

**Sau [2] Ready-to-summarize**

- [ ] Actor + mục tiêu 1–3 câu  
- [ ] Danh sách API/page liên quan (có / thiếu / ngoài scope)  
- [ ] In/Out sơ bộ  
- [ ] Unknown còn lại (có owner)

**Sau [4] Ready-to-impact**

- [ ] As-is có nguồn (code/doc)  
- [ ] To-be: giữ / sửa / thêm  
- [ ] Conflict đã xử lý hoặc blocked có mũ  

**Sau [5] Ready-to-slice/estimate** (khớp cổng v002 §9)

- [ ] Seam + hành vi giữ  
- [ ] Cách kiểm chứng cũ/mới  
- [ ] Không còn blocker cho lát sắp làm  

**Sau [6] Hand-off implement**

- [ ] Task list hoặc artifact OpenSpec/mzspec đã chọn loại  
- [ ] Change-Id / task id  

**Sau [7] Closed-with-learn**

- [ ] Decision + Q log đã lưu  
- [ ] Diff kế hoạch vs thực tế (changelog)  
- [ ] 1–3 điểm rút kinh nghiệm cho checklist lần sau (nếu có)

---

## 6. Việc đề xuất cho bước tiếp

1. Người dùng xác nhận tài liệu này đúng pain + vòng [1]–[7].  
2. Khi tạo **v003**: đưa §1–§2 của file này lên đầu `analysis.md`; bổ sung Learn loop và mục “chọn OpenSpec vs ticket vs mzspec”.  
3. Pilot thật: áp [1]–[7] lên một task BA dài (có thể SP tiềm năng) và đo “code thừa tránh được”.  
4. Chưa scaffold mining agent — chỉ quy ước thư mục log theo Change-Id khi làm pilot.

## Liên kết

- `analysis.md` (v002)  
- `tooling-fit-vs-core-pain.md` — mzspec / code-review / multi-agent / playbook nào giải pain  
- `../v001/code-review-idea-fit.md` (mining / không mù contract)  
- `../v001/foundational-clearance.md` (P1–P6)
