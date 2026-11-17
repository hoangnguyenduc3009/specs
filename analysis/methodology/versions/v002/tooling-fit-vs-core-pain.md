# Phản biện mô hình tool vs pain cốt lõi

- Gắn: v002 + `core-problem-and-loop.md`.
- Ngày: 2026-11-15.
- Nguồn: `mzspec/`, `code-review/docs/` (01–09), playbook/templates mzspec.
- Mục tiêu: **chỉ giữ gì giúp giảm “AI code thừa vì BA thiếu flow cũ/mới”**; bỏ lan man.
- Không phải: kế hoạch cài OCR/orchestrator/CI.

**Thước đo duy nhất:** idea này có giúp bước [2]–[5] (hỏi rõ → tổng hợp ngắn → as-is/to-be → impact) trước khi code không?

---

## 1. Kết luận một trang

| Quyết định | Nội dung |
|---|---|
| **Giải pain bằng quy trình + 1–2 skill mỏng**, không bằng factory | Playbook hỏi–đáp / as-is-first; artifact tối thiểu; learn log |
| **Lấy hình dạng, không lấy máy** | OpenSpec delta (sau khi rõ); context pack; mining ý tưởng; sub-agent *theo phase* nếu cần |
| **Không dùng giai đoạn này** | Full mzspec `/opsx`+two-PR; OCR/5-area; dynamic workflow “review-spec”; multi-agent orchestrator; full `/qa` |

Thứ tự đúng với pain: **clarify & as-is trước → tool sau.** Cài multi-agent/OCR sớm = tối ưu khâu review code trong khi vẫn chưa biết sửa node nào trên flow cũ.

---

## 2. Bảng fit theo nguồn

### 2.1. mzspec

| Idea | Fit pain? | Áp dụng |
|---|---|---|
| Spec-first / không chat-history | Có gián tiếp | Sau [3]–[5]: intent sống trong hồ sơ, không trong chat |
| Proposal + design + delta + tasks | Có **sau** khi rõ | [6] Standard/Heavy; Fast = ticket đủ |
| `validate --strict` | Yếu với pain đầu | Chỉ khi đã có delta; không thay hỏi BA |
| Planning **playbooks / templates** | **Rất cao** | Playbook “nhận BA Arena”: gen Q, xin API/page, cấm code trước as-is |
| Chain playbook (presale-style) | Cao nếu mỏng | Chain = đúng vòng [2]→[5]→[6]; **không** clone presale đầy bước |
| Gate resolver / zero-config gates | Thấp với pain đầu | Sau có diff; defer |
| `/opsx` ship, two-PR, handoff Red-Green | Thấp / lệch | Delivery factory; làm lệch focus khỏi clarify |
| Orchestrator multi-agent | **Không** giai đoạn này | Tăng parallel code khi scope còn mơ → **nhiều code thừa hơn** |
| Tag skill routing | Trung bình sau | Khi đã có skill riêng; chưa cần |
| Future “executable spec” | Không | Ngoài pain |

**Nhận định mzspec:** phần **template/playbook** là món ăn khớp nhất pain. Phần **orchestrator + ship pipeline** giải bài khác (giao hàng có gate), dễ làm AI “chạy pipeline” thay vì dừng hỏi.

### 2.2. code-review hub

| Idea | Fit pain? | Áp dụng |
|---|---|---|
| Lint cơ học + RISK | Không (cuối pipeline) | Defer tới có CODE PR |
| Sub-agents BE∥FE∥DB∥… song song | **Không cho bước [2]–[4]** | Review diff; nếu dùng sớm → audit code chưa tồn tại / đoán feature |
| Completeness critic / findings severity | Có **cho [3]–[5]** | Checklist: còn thiếu as-is? API list? điểm nối? |
| Context pack / không mù contract | **Cao** | Mọi lần AI làm việc sau [3] phải mang brief (In/Out, flow, giữ gì) |
| Change-Id | Cao, rẻ | Gắn từ [2] |
| Spec Review ≠ Code Review | Cao | [2]–[5] = spec-side; OCR = sau |
| Dynamic workflow “review-spec” thay mzspec axes | **Không** | Hub 08 cũng khuyên không invent song song |
| pr-review-mining | Trung bình → cao ở [7] | Đầu tiên mining **Q/decision log**, không cần GitHub PR |
| OCR + sub-agent bundle | Không giai đoạn clarify | Cost; sai khâu |
| Full `/qa` multi-phase | Không | Runtime sau khi đã đúng scope |

**Nhận định code-review:** học **không mù + completeness + learn**; **không** transplant pipeline sub-agent review vào lúc đọc BA.

### 2.3. Dynamic workflow / multi-agent / sub-agent / playbook (gom)

| Mô hình | Khi nào hợp pain | Khi nào hại |
|---|---|---|
| **Playbook (markdown skill-like)** | Encode vòng [2]–[5]; AI follow | Playbook thành 20 bước ceremony |
| **Sub-agent theo phase tuần tự** | Phase A hỏi BA; Phase B đọc code as-is; Phase C impact — **một phase một lúc** | Nhiều agent song song viết code/spec khi chưa clear |
| **Sub-agent song song theo layer** (OCR/code-review) | Diff lớn đã có Change-Id + brief | Lúc intake BA |
| **Multi-agent orchestrator** (ideation∥impl∥audit) | Org đã ổn define scope | Scope mơ → nhân bản overbuild |
| **Dynamic workflow** (engine chọn path runtime) | Fast vs Standard đã có rule rõ | Engine phức tạp trước khi có 2 pilot tay |

**Quy tắc:** với pain này, **tuần tự + dừng được** thắng **song song + tự chạy**.

---

## 3. Ánh xạ vào vòng [2]–[7] — chỉ lấy gì

| Bước | Lấy từ đâu | Không lấy |
|---|---|---|
| **[2] Hỏi–đáp + API/page** | Playbook Q groups; mũ BA; cấm implement | OCR, orchestrator, OpenSpec đầy đủ |
| **[3] Tổng hợp ngắn** | “Một hồ sơ” v002; completeness critic (thiếu mục nào) | Viết BRD mới dày |
| **[4] Flow trước/sau** | As-is từ code; conflict P4; sub-agent *chỉ* “trace as-is” nếu cần | Multi-agent ideate feature mới |
| **[5] Impact** | Seam note v002 §7; blast-radius | Gate resolver toàn repo |
| **[6] Task / OpenSpec** | OpenSpec artifact model *nhẹ*; playbook chain tasks | Full `/opsx:ship`; two-PR bắt buộc |
| **[7] Learn** | Mining Q/decision/changelog → cập nhật playbook | Mining PR GitHub trước khi có thói quen log |

---

## 4. Phản biện ngắn các “cám dỗ”

1. **“Cứ multi-agent cho nhanh”** — Nhanh sinh *nhiều thay đổi*; pain cần *ít thay đổi đúng chỗ*. Reject sớm.  
2. **“Cài mzspec giống sample-app”** — Sample giải SDLC demo; bạn đang giải BA input. Sai tầng.  
3. **“OCR/sub-agent sẽ bắt overbuild”** — OCR bắt RISK trên diff đã viết; không ngăn AI viết thừa từ đầu.  
4. **“Dynamic workflow tự chọn Fast/Heavy”** — Hay trên giấy; chưa có dữ liệu pilot → thêm abstraction. Làm tay 2 task trước.  
5. **“Playbook = đủ”** — Đúng hướng; nhưng playbook không thay **điều kiện dừng** (chưa có as-is → không [6]).

---

## 5. Đề xuất áp dụng tối thiểu (đủ giải pain)

Chỉ ba lớp — đủ để thử, không dựng platform:

1. **Playbook `ba-intake` (Arena)**  
   - Bắt buộc gen câu hỏi theo nhóm (actor, path cũ, API/page, mới/reuse, out).  
   - Output: API/page list + In/Out + unknown.  
   - Hard stop: không đề xuất code/to-be rộng trước as-is.

2. **Playbook `as-is-delta` (hoặc cùng chain)**  
   - Trace code → flow trước; map expect → node; ghi giữ/sửa/thêm.  
   - Lệch → Q; rồi mới impact note.

3. **Learn log theo Change-Id**  
   - Q, decision, changelog ngắn.  
   - Định kỳ (thủ công trước): rút 3 pattern vào playbook.

**Optional sau 1–2 pilot tay:** OpenSpec delta cho Standard+; một sub-agent “as-is tracer” tách session; soft REVIEW 4-axis trên tổng hợp.

**Vẫn defer:** OCR, orchestrator, dynamic workflow engine, full mzspec ship, `/qa` đầy đủ.

---

## 6. Tiêu chí “ý tưởng này OK”

Chấp nhận idea chỉ khi:

1. Giảm hoặc chặn bước **đoán feature từ expect**, và/hoặc  
2. Buộc **chỉ ra điểm nối trên flow cũ**, và/hoặc  
3. Làm **hỏi đúng** (API/page/as-is) rẻ hơn viết code sai.

Không chấp nhận chỉ vì “best practice SDLC” hoặc “hub đã có sample chạy”.

---

## Liên kết

- Pain + vòng: `core-problem-and-loop.md`  
- v002 analysis: `analysis.md` §7, §10  
- Idea code-review trước: `../v001/code-review-idea-fit.md`  
- mzspec templates: `mzspec/docs/03-guides/02-templates.md`  
- Hub cảnh báo dynamic workflow / multi-agent: `code-review/docs/08-sdlc-workflow-analysis.md` (§ không invent review-spec; G-AGT-01)
