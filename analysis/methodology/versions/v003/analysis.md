# mmd-sdd v003: Pain-first — chặn code thừa trước khi code

- Version: v003.
- Ngày: 2026-11-17, Asia/Ho_Chi_Minh.
- Trạng thái: **pilot draft hợp nhất** — gộp user intent (`../v002/core-problem-and-loop.md`), review trọng tâm (`../v002/reviews/2026-11-15-core-focus-review.md`, CF01–CF07) và hiện trạng scaffold skill 0.1.0; chưa nghiệm thu sau pilot.
- Nguồn: `../v002/analysis.md` (P1–P6 và các mục guardrail), `../v002/core-problem-and-loop.md`, `../v002/tooling-fit-vs-core-pain.md`, `../v002/effective-minimum.md`, `../v002/scaffold-decision.md`, review 2026-11-15; chỉ đạo người dùng 2026-11-17: hợp nhất và cập nhật toàn bộ mmd-sdd.
- Kế thừa, không mở lại: P1–P6 của v002 (Dev là primary user; mô hình đổi mũ; ba nhãn dự báo; xử lý lệch nguồn; nơi sống hồ sơ; pilot hai task khác loại).
- Không phải: cài mzspec/OCR/OpenSpec đầy đủ, orchestrator, CI gate, hay thay đổi product code.

## 1. Pain cốt lõi

Tài liệu BA thường dài, không nêu trọng tâm, không mô tả **luồng cũ** và **luồng mới nối vào đâu**, chỉ nêu expect (UI, kết quả mong muốn), thiếu API/page/màn liên quan đã có. Hệ quả: AI/Dev **code thừa** — tạo module/API mới trong khi thực tế chỉ cần neo luồng hiện hữu và chỉnh hẹp.

Tinh chỉnh từ review 2026-11-15: "BA dài" là **biểu hiện**, không phải nguyên nhân duy nhất. Nguyên nhân gốc là **thiếu liên kết giữa mô tả mong muốn và hệ thống đang có**. Một yêu cầu rất ngắn vẫn khiến AI code thừa nếu thiếu ngữ cảnh hiện hữu; một BRD dài vẫn dùng được nếu có bản đồ tới đúng luồng và quy tắc. Vì vậy chỉ tóm tắt BA hoặc chỉ vẽ thêm sơ đồ đều chưa đủ.

> Bài toán trung tâm: chuyển mô tả mong muốn thành một thay đổi có căn cứ — **tận dụng gì, đổi gì, không đụng gì, vì sao và kiểm chứng thế nào.**

Pain này phải giải **trước** mọi thảo luận công cụ (OpenSpec vs mzspec, skill pack, multi-agent).

## 2. Vòng làm việc chuẩn

Vòng [1]–[7] của user intent, đã chỉnh theo CF02 (định vị code sớm) và CF05 (khép vòng sau code). Thứ tự là **thứ tự tư duy**, không phải pipeline cứng; mỗi bước có thể quay lại bước trước.

```text
[1] Nhận tài liệu BA / yêu cầu
       ↓
[2] Hiểu mục tiêu + ĐỊNH VỊ SƠ BỘ flow/page/API hiện hữu (đọc nông, chưa audit)
       ↔ hỏi–đáp clear bức tranh: actor, outcome, đầu mối chưa tìm được
       ↓
[3] Bản hiểu ngắn (working draft): cần gì, giữ gì, ngoài scope, unknown
       ↔ đối chiếu code có mục tiêu, sửa lại cách hiểu
       ↓
[4] Bảng expect → as-is → delta → điểm sửa (nội dung trung tâm, xem §3)
     + flow trước/sau nếu giúp thấy điểm nối
       ↓
[5] Impact/reuse check: seam, consumer, hành vi giữ
       ↔ hỏi/chốt CHỈ các quyết định làm đổi outcome/scope/acceptance
       ↓
[6] Chia task nhỏ hoặc xuất artifact spec theo nhu cầu (xem §8)
       ↓ (khi được phép implement)
[7a] Đối chiếu diff thực tế với delta đã chốt + kiểm chứng mới/cũ
       ↓
[7b] Lưu quyết định và bài học có kết quả thực tế (learn loop, xem §9)
```

Điểm khác so với vòng gốc trong `core-problem-and-loop.md`:

1. **Định vị code nông diễn ra ngay trong [2]**, không đợi đến [4] (CF02). AI tự tìm feature/page/entry point trước khi hỏi; BA chỉ cần chốt nghiệp vụ, không có nghĩa vụ cung cấp danh sách API. Bản tổng hợp [3] là working draft, được sửa sau khi đọc sâu — không đợi BA trả lời hết mới đọc repo.
2. **Khép vòng sau code bằng [7a]** (CF05): mỗi thay đổi ngoài plan phải trả lời đang phục vụ expect/delta/dependency/nhu cầu an toàn nào; không giải thích được thì đánh dấu để loại hoặc xin chốt lại scope. Test/migration/refactor cục bộ cần thiết không mặc định là code thừa — đánh giá theo lý do và semantics, không theo quota file/LOC.

Hard stop giữ nguyên: **chưa có as-is có nguồn thì chưa đề xuất to-be rộng, chưa implement.**

## 3. Nội dung trung tâm: bảng expect → as-is → delta

Đây là cơ chế nối từng expect với phần thay đổi thực sự (CF01) — một section của one-pager, không phải artifact mới:

| Mong muốn BA | Flow/node hiện có + evidence | Kết luận | Giữ / sửa / thêm / xóa / thay thế | Không đụng / impact cần kiểm | Kiểm chứng |
|---|---|---|---|---|---|

Các nhóm kết luận hợp lệ:

- **Đã đáp ứng** — không cần implementation mới; có thể chỉ cấu hình, nội dung hoặc xác minh.
- **Có cơ chế, cần cấu hình/dữ liệu** — task vận hành, không tạo feature mới.
- **Có cơ chế gần đúng** — ghi chính xác thiếu điều kiện/output/state nào; không nhận reuse theo tên API.
- **Cần mới** — ghi phạm vi đã khảo sát và vì sao ứng viên không phù hợp; không tuyên bố đã tìm toàn workspace nếu chưa làm.
- **Ngoài scope / dependency** — ghi lý do và ảnh hưởng nghiệm thu.
- **Chưa xác minh** — trạng thái unknown; không biến thành "chưa có" rồi code mới.

Quy tắc kiểm: **mỗi task/code đề xuất phải trỏ về một delta, dependency hoặc nhu cầu an toàn có lý do trong bảng này.** Flow trước/sau đẹp không thay được bảng — hai sơ đồ có thể cùng chứa một API mới do AI tự nghĩ ra.

Bảng này đã được hiện thực trong `templates/one-pager.md` (mục "Mong muốn → hiện trạng → thay đổi").

## 4. Nguyên tắc chống code thừa

Bản sửa của §4 `core-problem-and-loop.md` theo CF03/CF04:

1. **Chưa vẽ/ghi as-is có nguồn thì chưa đề xuất to-be rộng.** As-is lấy từ code (+ ghi `observed`) khi BA không có.
2. **Expect không đủ để mở scope** — phải gắn expect vào node flow cũ hoặc ghi rõ là bề mặt mới.
3. **Điểm nối theo loại thay đổi** (CF04):
   - *Modification*: nối delta vào flow cũ, chỉ rõ vùng giữ/sửa.
   - *Addition thực sự mới*: nêu boundary tích hợp với hệ thống đang có và phạm vi đã tìm reuse — không bịa seam hay tạo adapter giữ logic sai.
   - *Removal/replacement*: nêu consumer bị ảnh hưởng và kế hoạch chuyển tiếp.
   - "Không tìm thấy ứng viên sau khảo sát có phạm vi" khác "toàn hệ thống không có" — ghi phạm vi tìm.
4. **Reuse là ứng viên mặc định** — viết mới phải giải thích vì sao điểm nối cũ không đủ; reuse phải chứng minh semantic phù hợp (contract, consumer), không chỉ tên giống.
5. **AI không đoán full feature** để lấp chỗ BA thiếu flow — hỏi hoặc spike đọc code.
6. **Khác biệt as-is/to-be không mặc định là conflict** (CF03). Phân biệt:
   - Thay đổi có chủ đích BA đã yêu cầu rõ → delta hợp lệ, không hỏi lại.
   - Xung đột giữa các nguồn yêu cầu → xử lý theo P4 v002.
   - Hiện trạng khác lời mô tả / dữ liệu chưa đủ → unknown, điều tra hoặc hỏi.
   - Chỉ hỏi khi có nhiều outcome hợp lý hoặc phát hiện làm thay đổi scope/acceptance. Không biến code cũ thành chuẩn phủ định yêu cầu mới.
7. **Sau implement, diff phải đối chiếu lại với delta** (CF05) — xem §2 bước [7a].

## 5. Hồ sơ: một trang

Hồ sơ chính là `pilots/<change-id>/one-pager.md` theo `templates/one-pager.md`: mục tiêu/In/Out, bảng expect→as-is→delta, câu hỏi làm thay đổi quyết định, hướng sửa và task đề xuất, kết quả sau triển khai. Flow trước/sau (`templates/as-is-to-be.md`) và khung câu hỏi (`templates/questions.md`) là mở rộng tùy chọn — chỉ tách file khi một trang không đủ rõ.

Không tạo BRD mới dày hơn bản gốc; không tạo bộ brief/BA pack/handoff/spec chứa cùng thông tin chỉ để đủ mẫu. Đơn vị trung tâm vẫn là **lát hành vi + quyết định còn thiếu** (v002 §3).

## 6. Khi nào hỏi, khi nào tự tìm

- **Thiếu fact kỹ thuật** → tìm repo trước; chỉ hỏi Dev khi thiếu quyền truy cập hoặc không tìm được bằng chứng. Không hỏi BA điều đọc được trong code.
- **Mơ hồ nghiệp vụ làm đổi giải pháp** → hỏi người có thẩm quyền, kèm ví dụ phân biệt, lựa chọn và hệ quả (format câu hỏi v002 §8 giữ nguyên).
- **BA yêu cầu đổi hành vi rõ ràng** → ghi delta, không hỏi lại (CF03).
- Tối đa ba câu ưu tiên mỗi lượt trao đổi; không hạ severity câu còn lại để đủ quota.

## 7. Guardrail giữ ngắn (kế thừa v002, không thiết kế thêm)

Các mục sau vẫn hiệu lực nguyên văn theo `../v002/analysis.md`, giữ vai trò rào bảo vệ, không mở rộng thêm ở v003:

| Mục | Nguồn v002 |
|---|---|
| Mũ BA / Tech Lead / Dev và quy tắc chống tự lừa | §2 P2 |
| Ba nhãn Fast/Standard/Heavy là dự báo, nâng/hạ theo semantic | §2 P3 |
| Xử lý lệch nguồn (hai cách hiểu → ví dụ phân biệt → owner) | §2 P4 |
| Trạng thái draft / accepted intent / observed / implemented-unverified / verified / stale | §6 |
| Mức bằng chứng impact theo tình huống (UI cục bộ / shared rule / integration) | §7 |
| Hai cổng Ready-to-slice và Done-with-evidence | §9 |
| Ranh giới với mzspec và code-review | §10 |

Bổ sung một ý cho cổng: estimate có thể là khoảng kèm unknown; trước khi implement một phần, quyết định ảnh hưởng correctness của phần ấy phải được chốt và có ủy quyền — không cần thêm nhãn gate cho từng hộp trong sơ đồ.

## 8. Chọn loại output sau khi rõ ([6])

Quyết định thuộc mũ Tech Lead/Dev **sau khi** [4][5] xong — không chọn tool trước khi rõ flow cũ/mới:

| Tình huống | Hướng xuất |
|---|---|
| Lát nhỏ, team chỉ cần ticket | Goal + Slice + Decision + Verification trong ticket (mặc định) |
| Cần contract/scenario bền, nhiều người đọc | Delta OpenSpec-style (nhẹ, chỉ artifact model) |
| Team đã vận hành mzspec/`/opsx` | Có thể dùng mzspec artifact — không bắt buộc giai đoạn pilot; full pipeline không phải DoD |

## 9. Learn loop ([7b])

Lưu theo Change-Id tại `learning/` (đã scaffold): run log mỗi phiên, correction khi Dev sửa/bác bỏ có ý nghĩa, changelog thực tế so với kế hoạch, review findings, các bước đã đi.

Phân biệt theo CF07:

- **Dữ liệu thô** (Q/changelog/review) khác **bài học đã kiểm chứng**. Mỗi bài học ghi: đã hiểu sai gì, evidence/decision nào sửa cách hiểu, kết quả thực tế, phạm vi áp dụng, khi nào cần xem lại.
- **Tri thức dự án dễ lỗi thời** (route, field, rule theo revision) tách khỏi **cách hỏi/điều tra dùng lại được**. Chỉ cái sau mới là ứng viên vào checklist/skill.
- Chỉ promote quy tắc vào skill sau khi Dev duyệt theo quy trình `learning/README.md`; không tự chỉnh skill sau mỗi task. Định kỳ (không mỗi commit) mới tổng hợp pattern; mining tự động defer.

## 10. Đo lường pilot (thay "code thừa tránh được")

"Code thừa tránh được" không đo trực tiếp được — không có counterfactual đáng tin, và ít dòng hơn có thể che sai semantic ở shared rule (CF06). Thay bằng các quan sát ghi được:

1. Phương án ban đầu (nếu thực sự có) và các phần bị loại sau khi tìm thấy reuse, kèm evidence dẫn đến loại.
2. Thay đổi ngoài plan và rework do hiểu sai.
3. Điểm tưởng phải xây mới nhưng đã có; điểm tưởng reuse được nhưng sai semantic; câu hỏi thực sự thay đổi thiết kế.
4. Tách thời gian điều tra chủ động với thời gian chờ người quyết.

Không dựng phương án cố tình phình to để chứng minh tiết kiệm. Số câu hỏi, số diagram, số finding hay đồng thuận agent không phải kết quả.

## 11. Xử lý findings review 2026-11-15

| Finding | Nội dung | Xử lý trong v003 |
|---|---|---|
| CF01 (Major) | Thiếu cơ chế nối expect → thay đổi thực sự | **Áp dụng**: bảng §3 là nội dung trung tâm; đã có trong `templates/one-pager.md` |
| CF02 (Major) | Thứ tự hỏi → tổng hợp → đọc code quá cứng | **Áp dụng**: định vị nông trong [2], tổng hợp là working draft (§2); skill 0.1.0 đã làm vậy |
| CF03 (Major) | Lệch as-is/to-be không mặc định là conflict | **Áp dụng**: §4.6 và §6; skill 0.1.0 đã có nhánh tương ứng |
| CF04 (Major) | "Mọi sửa phải có điểm nối cũ" cần ranh giới | **Áp dụng**: §4.3 tách modification/addition/removal; thêm xóa/thay thế vào ký hiệu flow và templates |
| CF05 (Major) | Chưa khép vòng sau code | **Áp dụng**: bước [7a] đối chiếu diff vs delta (§2); one-pager có mục "Kết quả sau triển khai" |
| CF06 (Moderate) | "Code thừa tránh được" không đo trực tiếp | **Áp dụng**: §10 thay bằng quan sát ghi được |
| CF07 (Moderate) | Learn loop cần phân biệt giả định vs bài học kiểm chứng | **Áp dụng**: §9; `learning/README.md` đã quy định quy trình duyệt |

Việc áp dụng theo chỉ đạo hợp nhất của người dùng 2026-11-17; hiệu quả thực tế vẫn chờ pilot nghiệm thu.

## 12. Ánh xạ giấy ↔ scaffold hiện có

Scaffold 0.1.0 (2026-11-15) đã hiện thực trước phần lớn v003; giấy này hợp thức hóa và là tài liệu đối chiếu khi sửa skill:

| v003 | Hiện thực |
|---|---|
| Vòng [2]–[6] | `.cursor/skills/mmd-ba-clarify/SKILL.md` (playbook linh hoạt, đọc code sớm, rẽ nhánh theo bằng chứng) |
| Phản biện [5]+ | `.cursor/skills/mmd-challenge-change/SKILL.md` |
| Bảng §3 + hồ sơ §5 | `templates/one-pager.md`; mở rộng: `templates/questions.md`, `templates/as-is-to-be.md` |
| [7a] diff vs delta | Mục "Khi Dev điều chỉnh và sau triển khai" trong skill + mục cuối one-pager |
| Learn loop §9 | `learning/` (runs, corrections, skill-changelog, cases) |
| Pilot | `pilots/<change-id>/`; pilot đầu: `pilots/c-sp-tiem-nang-minitest/` |

Lỗ hổng đã vá cùng v003: `templates/as-is-to-be.md` bổ sung xóa/thay thế và boundary cho flow thực sự mới (CF04).

## 13. Điều kiện nghiệm thu (giữ từ v002 §11, bổ sung)

Thành công nếu trên pilot thật: hồ sơ nói rõ làm gì/không làm gì/giữ gì/vì sao; ít nhất một uncertainty có ảnh hưởng được phát hiện sớm; người thực thi biết phần nào độc lập, phần nào chờ ai; chi phí ghi chép tương xứng rủi ro; evidence giúp recheck đúng phần khi giả định đổi. **Bổ sung v003:** sau implement, diff đối chiếu được với delta — thay đổi ngoài plan đều có lý do hoặc bị loại.

Thất bại nếu: sinh nhiều tài liệu nhưng hỏi lại cùng quyết định; agent giấu unknown để đạt Ready; reuse "ít diff" gây sai semantic không bị bắt; task UI nhỏ chờ BA dù không có câu hỏi nghiệp vụ; validate xanh bị hiểu là verified. **Bổ sung v003:** hoàn thành đủ mọi sơ đồ/bảng nhưng vẫn tạo trùng service/API — tức bảng §3 bị điền hình thức.

## 14. Bước tiếp

1. Tiếp tục pilot `c-sp-tiem-nang-minitest` đến hết [5] (bảng expect→delta + flow đánh dấu + câu hỏi còn mở), Dev kiểm từng task đề xuất có thực sự cần không — **chưa implement** cho đến khi được ủy quyền.
2. Chọn pilot thứ hai khác loại (theo P6 v002: UI thuần / shared rule / integration).
3. Sau hai pilot: review log theo `learning/README.md`, mới cân nhắc nâng skill 0.1.x và đóng gói.

## 15. Lịch sử

| Version | Trạng thái | Nội dung |
|---|---|---|
| v001 | Draft for review | Đề xuất phân tích từ luồng hiện hữu, delta, giảm impact. |
| v002 | Pilot draft | Chốt Dev primary user, mô hình đổi mũ, lát + quyết định thiếu, trạng thái/bằng chứng, hai cổng. |
| v002+ | User intent + review | `core-problem-and-loop.md` (pain + vòng [1]–[7]); review CF01–CF07; tooling-fit; effective-minimum; scaffold-decision + skill 0.1.0. |
| v003 | Pilot draft hợp nhất | Pain-first; vòng có định vị sớm + khép vòng diff/delta; bảng expect→as-is→delta làm trung tâm; nguyên tắc chống code thừa có ranh giới; learn loop và đo lường pilot; disposition CF01–CF07. |

## Liên kết

- Guardrail chi tiết: `../v002/analysis.md` (P1–P6, §6–§10)
- User intent gốc: `../v002/core-problem-and-loop.md`
- Review được xử lý: `../v002/reviews/2026-11-15-core-focus-review.md`
- Vì sao không chọn factory: `../v002/tooling-fit-vs-core-pain.md`
- Tối thiểu hiệu quả: `../v002/effective-minimum.md`
- Chốt scaffold: `../v002/scaffold-decision.md`
