# Adversarial Reviewer — Round 1

- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Vai trò: Averroes / Adversarial Reviewer; phân tích độc lập, chưa đọc lập luận Round 1 của hai agent còn lại.
- Trạng thái: đề xuất để tranh luận, không phải phê duyệt nghiệp vụ hoặc phương pháp.
- Quy ước: giữ nguyên Round 1; Round 2 chỉ append sau dấu kết thúc bên dưới.
- Phạm vi: failure modes khi lấy ý tưởng từ `mzspec/` và `code-review/` vào mmd-sdd; không audit toàn repo, không chạy workflow/test sản phẩm, không sửa product code.
- Mọi đường dẫn evidence tính từ `area1/`. Số dòng là tại snapshot đọc, không phải permalink.

## 1. Phạm vi bằng chứng và kết luận đầu tiên

Đã đọc `analysis.md`, `foundational-clearance.md`, `code-review-idea-fit.md`, `v002-merge-backlog.md` và các review trong `mmd-sdd/analysis/methodology/versions/v001/`. Đã đối chiếu có mục tiêu validator, verdict, spec sync, handoff trong mzspec; verifier, routing, brief builder và QA baseline trong code-review.

- mzspec HEAD: `a1301f8c6c144fefde1a1e1bc6e9eda5d394ef6d`; working tree không báo thay đổi lúc kiểm tra.
- code-review HEAD: `fda02dedcccfd11b49179e9dd6eeb9353d09780c`; có trạng thái thay đổi ở `sample-app`, không dùng nội dung đó làm bằng chứng. Các file kiểm tra dưới đây thuộc root repo.
- Bằng chứng là đọc tĩnh. Các counterexample là tình huống giả định hoặc đường đi suy ra từ code; không tuyên bố đã tái hiện runtime.
- `supported`: nguồn được đọc hỗ trợ claim trong phạm vi nêu rõ. `contradicted`: nguồn trực tiếp bác claim. `unresolved`: chưa đủ bằng chứng hoặc chưa có người có thẩm quyền chốt.

**Luận điểm phản biện:** ý tưởng đáng mượn là cách đặt câu hỏi và giới hạn kết luận, không phải nhãn APPROVE, số reviewer hoặc số gate. Rủi ro lớn nhất là một chuỗi suy luận chưa chắc chắn đi qua nhiều artifact rồi trở thành “sự thật đã xác nhận”.

Tám rủi ro dưới đây không phải tám bước bắt buộc. Có thể xử lý phần lớn trong cùng một hồ sơ ngắn; chỉ mở thêm chi tiết khi có trigger.

## 2. R01 — Verdict xanh không bảo đảm validation hoặc coverage review

**Mức độ:** cao; false confidence từ control flow của công cụ.

**Claims và evidence:**

- **supported:** `mzspec/core/workflows/spec-change.js:250` lấy `validatePass` và danh sách `remaining` từ agent revise; tại dòng 259 verdict chỉ phụ thuộc `openCount === 0`; tại dòng 278 `ok` theo verdict. Giá trị validation vẫn được báo riêng nhưng không là điều kiện của verdict.
- **contradicted:** “APPROVE của workflow này bảo đảm strict validation pass”. Có đường logic `remaining=[]`, `validatePass=false` vẫn dẫn đến `approve`; chưa chạy tái hiện.
- **supported:** tại `mzspec/core/workflows/spec-change.js:217`, kết quả reviewer rỗng/null được lọc; biểu thức verdict không kiểm tra số axis hoàn thành. Đây là thiếu điều kiện trong đoạn tính verdict, không phải khẳng định runner chắc chắn nuốt lỗi.
- **supported:** validator native kiểm tra file, frontmatter, prefix và reference tại `mzspec/lib/openspec.js:116`; `archiveChange` tại dòng 214 chỉ chuyển thư mục. Không được suy diễn tên command thành năng lực kiểm chứng nghiệp vụ hoặc sync đầy đủ.
- **unresolved:** xác suất lỗi xuất hiện trong workflow đầy đủ; downstream có thể có gate riêng. `mzspec/core/workflows/spec-pr.js:4` mô tả preflight validation độc lập, nên không kết luận mọi lỗi đều đi đến merge.

**Counterexample:** spec có cú pháp sai nhưng agent revise báo đã xử lý hết findings. Người tổng hợp nhìn APPROVE rồi chuyển sang implement, bỏ qua trường `validatePass=false`. Hoặc command archive chạy được bị hiểu nhầm là canonical spec đã cập nhật.

**Điều kiện tối thiểu:** tách ba kết luận: nội dung được ai chốt; check cấu trúc nào thực sự chạy và kết quả; scenario nào đã được xác minh. Thiếu lượt review phải là “chưa kiểm tra”, không phải “không có lỗi”. Ghi đúng executable/version trước khi dùng gate từ repo mẫu.

**Chi phí:** một bảng kết quả ngắn; thêm kiểm tra máy độc lập nếu đã dùng OpenSpec. **Đơn giản hơn:** chưa dùng validator thì ghi “chưa kiểm tra cấu trúc bằng tool”; không cần dựng gate resolver. Không chạy full factory chỉ để có badge xanh.

## 3. R02 — Canonical/accepted spec bị hiểu thành hiện trạng triển khai

**Mức độ:** cao; làm sai quyết định reuse ngay từ đầu.

**Claims và evidence:**

- **supported:** `mzspec/core/workflows/spec-pr.js:4` đặt sync delta vào canonical trước implementation và giữ change ACTIVE.
- **contradicted:** “thấy trong canonical là có thể coi API/hành vi đã tồn tại”. Chính thứ tự trên cho phép canonical mô tả tương lai được chấp nhận.
- **supported:** `analysis.md` v001 §11 muốn canonical phản ánh phần đã giao; đây là khác biệt semantics phải giải quyết, không phải chỉ đổi tên command.
- **unresolved:** mmd-sdd cuối cùng chọn canonical là desired contract hay delivered baseline; ownership vẫn chưa chốt trong v001 §2.2 và foundational P5.

**Counterexample:** spec đã duyệt nói profile trả eligibility; agent đọc spec rồi thiết kế FE reuse field đó, trong khi backend chưa merge hoặc đã merge nhưng chưa deploy. Diagram “as-is” trở thành bản vẽ tương lai mà không ai nhận ra.

**Điều kiện tối thiểu:** ít nhất phân biệt `proposed/accepted` với `observed/implemented/verified`; mỗi claim reuse dẫn về code hoặc runtime phù hợp. Ghi môi trường khi tuyên bố hành vi đã có ở môi trường đó. Accepted chỉ có nghĩa đúng về ý định, không phải khả dụng.

**Chi phí:** một nhãn trạng thái và reference cho capability/lát liên quan. **Đơn giản hơn:** giữ change accepted trong hồ sơ change; chỉ cập nhật delivered baseline khi đã có evidence. Không cần state-machine engine hay hai PR bắt buộc. Nếu chọn canonical desired-state, phải có liên kết implementation status rõ ràng.

## 4. R03 — Evidence và trạng thái done sống lâu hơn điều kiện đã chứng minh

**Mức độ:** cao với nhiều repo hoặc yêu cầu sửa giữa chừng.

**Claims và evidence:**

- **supported:** `mzspec/core/workflows/ship-plan.js:115` yêu cầu giữ unit `done` khi re-plan; riêng chỉ dẫn này không ràng buộc done vào revision của spec/contract.
- **supported:** `code-review/templates/github/scripts/check-qa-baseline.mjs:31` kiểm tra Test-ID bằng chuỗi trong source; dòng 62 đếm assertion và dòng 72 chỉ cảnh báo skip. Không thực thi scenario trong script này.
- **contradicted:** “baseline-check ok chứng minh scenario vẫn pass trên implementation hiện tại”. Test-ID có thể nằm trong comment hoặc test bị skip; số assertion không nói assertion đang kiểm tra đúng hành vi.
- **unresolved:** workflow khác có bổ sung invalidation/runtime evidence đầy đủ hay không; nhận định chỉ áp dụng các cơ chế vừa đọc, không phủ nhận toàn bộ QA pipeline.

**Counterexample:** lát FE từng pass với BE revision A. Rule BE đổi ở revision B, FE giữ nguyên nên unit vẫn done. Báo cáo cũ và baseline count vẫn xanh, dù response mới phá điều kiện hiển thị. Một commit hub không định danh được tổ hợp FE/BE đã kiểm tra.

**Điều kiện tối thiểu:** evidence ghi scenario, spec revision, revision của các repo liên quan, cách kiểm tra và giới hạn. Khi dependency/quyết định thay đổi, đánh dấu evidence liên quan `needs-recheck`; giữ lịch sử done nhưng không giữ hiệu lực xác minh vô điều kiện. Không cần chạy lại tất cả vì một sửa typo không liên quan.

**Chi phí:** vài trường metadata và một lượt impact check khi thay đổi đầu vào. **Đơn giản hơn:** bảng thủ công chỉ cho scenario trọng yếu, dùng commit + ghi nhận working tree nếu dirty; chưa cần hash graph, test mining hoặc assertion-peak gate.

## 5. R04 — Đồng thuận AI hoặc hết timebox bị biến thành quyền quyết định BA

**Mức độ:** cao; sai nguồn thẩm quyền.

**Claims và evidence:**

- **supported:** `code-review/code-review/rules/phase-2b-verify.md:34` dùng mặc định REFUTED, dòng 49 dùng đa số refuter; dòng 24 cho finding lint-confirmed qua mà không verify. Đây là lựa chọn của review code, không là cơ chế phê duyệt nghiệp vụ.
- **contradicted:** “hai agent không tìm thấy bằng chứng thì câu hỏi nghiệp vụ có thể đóng”. Không tìm thấy không phải bằng chứng phủ định, và agent không có thẩm quyền chọn chính sách.
- **supported:** foundational-clearance P4 tại dòng 141 cho nhánh “timebox + giả định”; ví dụ mẫu dòng 156 cho phép conflict giả định mang dạng Resolved. Nếu copy sang hồ sơ thật mà mất nhãn giả định, quyết định có thể trông đã được chốt.
- **unresolved:** owner nghiệp vụ mặc định và phạm vi ủy quyền cho agent tại Arena vẫn là câu hỏi P4; review hiện có chưa giải quyết.

**Counterexample:** BA chưa trả lời khi eligibility timeout thì ẩn hay hiện CTA. Ba agent thống nhất “ẩn để an toàn”; sau hai vòng, accepted spec ghi ẩn như yêu cầu BA. Việc ít rủi ro kỹ thuật hơn không tự đồng nghĩa đúng ưu tiên kinh doanh.

**Điều kiện tối thiểu:** dùng `supported/contradicted/unresolved` cho claim; quyết định ghi người có thẩm quyền, nội dung và phạm vi chốt. Hết timebox chỉ đổi hành động: hỏi/escalate, tách lát độc lập hoặc làm spike chưa cam kết; không tự nâng giả định thành accepted. Phân biệt mock decision dùng thử phương pháp với decision thật.

**Chi phí:** một decision row và có thể phải chờ người chốt phần phụ thuộc. **Đơn giản hơn:** link tới câu trả lời trong ticket/chat kèm xác nhận phạm vi; không cần chữ ký formal hoặc hội đồng. Nếu không có owner, ghi blocker; không dựng thêm agent để thay người đó.

## 6. R05 — Tối ưu ít diff hoặc routing theo file che giấu blast radius

**Mức độ:** cao với shared rule, medium với component dùng chung.

**Claims và evidence:**

- **supported:** v001 `analysis.md` §7 đã bác bỏ ít dòng = ít impact; đây là nguyên tắc cần giữ, không phải finding mới về thiếu nguyên tắc.
- **supported:** `code-review/code-review/rules/phase-1-collect.md:67` kích hoạt integration khi có contract BE và UI cùng xuất hiện hoặc có integration test đổi. Không bao phủ tự động mọi ca contract đổi nhưng consumer không đổi file.
- **contradicted:** “chỉ một repo/file đổi thì integration hoặc caller ngoài diff không liên quan”. Đây là heuristic không an toàn khi chuyển từ review diff sang phân tích yêu cầu trước code.

**Counterexample:** đổi một default eligibility trong service dùng chung, không sửa FE. Luồng mới đúng, nhưng caller cũ không truyền context nhận default mới. Hoặc chỉnh CSS một shared button để phù hợp một màn, vô tình làm các màn khác mất text vì overflow.

**Điều kiện tối thiểu:** trước tuyên bố ít impact, nêu semantic của reuse, điểm nối, nhóm caller quan trọng và hành vi cần giữ. Kích hoạt góc integration theo contract/state/side effect, không theo số repo sửa. Dừng truy code khi đủ chọn phương án và chỉ rõ phần chưa bao phủ; nếu uncertainty nằm ở dependency trọng yếu, chưa được gọi là low-impact.

**Chi phí:** một lượt tìm caller/consumer có mục tiêu và ví dụ regression đại diện; lớn hơn việc chỉ đếm diff. **Đơn giản hơn:** blast-radius note 3–5 dòng với một old-path case và một new-path case; không bắt vẽ call graph toàn hệ thống hoặc luôn so sánh ba phương án cho việc hiển nhiên.

## 7. R06 — Giới hạn brief/câu hỏi/scenario biến thành cắt mất yêu cầu

**Mức độ:** cao nếu dùng brief làm đầu vào duy nhất cho mọi agent.

**Claims và evidence:**

- **supported:** `code-review/templates/github/scripts/build-review-brief.mjs:95` lấy spec `todos` hoặc file Markdown đầu tiên tìm được; `clip` tại dòng 43 cắt nội dung dài. Không thể coi brief này là danh mục đầy đủ mọi capability của change.
- **supported:** `code-review-idea-fit.md:132` đề xuất Standard+ có “≤3 scenario”; foundational-clearance tại dòng 108 và review composer-01 R05 có giới hạn ba câu P0. Có rủi ro biến mục tiêu giao tiếp gọn thành hard cap coverage.
- **contradicted:** “tối đa ba scenario đủ cho mọi lát Standard+”. Một rule có bốn trạng thái phân biệt không thể loại trạng thái thứ tư chỉ để hợp template.
- **unresolved:** các tác giả có chủ ý dùng con số như ví dụ hay hard cap; cần sửa cách diễn đạt trước khi agent tự động áp dụng.

**Counterexample:** brief nạp capability UI nhưng bỏ capability retry. Ba agent cùng đọc một brief nên đều kết luận đầy đủ. Tình huống save thành công/enqueue timeout không xuất hiện trong câu hỏi hoặc test; sự đồng thuận chỉ phản ánh cùng thiếu input.

**Điều kiện tối thiểu:** brief có danh mục nguồn và đánh dấu phần chưa đọc/cắt; số câu hỏi trong một lượt là giới hạn trình bày, không là số blocker thực tế. Giữ unresolved backlog; thêm scenario theo phân lớp hành vi cần phân biệt. Reviewer kiểm tra ít nhất các nguồn chứa ngoại lệ ảnh hưởng quyết định, không chỉ bản tóm tắt của agent khác.

**Chi phí:** mục lục nguồn và vài dòng overflow; đôi khi thêm vòng hỏi BA. **Đơn giản hơn:** link nguồn + chỉ mục các rule còn mở trong cùng file; bỏ script tự gom ở giai đoạn đầu. Không cần duplication toàn bộ BRD vào context pack.

## 8. R07 — Chia lát theo toolchain tạo các đơn vị xanh nhưng giao dịch tổng thể sai

**Mức độ:** cao với integration partial failure.

**Claims và evidence:**

- **supported:** `mzspec/core/workflows/ship-plan.js:4` mô tả work-unit single-toolchain và test-first. Có ích cho thực thi, nhưng không tự chứng minh hành vi xuyên unit.
- **contradicted:** “mọi unit pass thì lát nghiệp vụ đã hoàn tất”. Các test cục bộ có thể mock bỏ ranh giới thất bại.
- **unresolved:** mỗi feature Arena cần guarantee at-most-once, at-least-once hay cơ chế phục hồi nào; không thể chốt chính sách retry chung chỉ từ công cụ.

**Counterexample:** API lưu record thành công; gọi worker timeout trong khi worker có thể đã nhận việc. FE coi cả request thất bại và retry tạo thêm record/job. Test FE mock success/error; test BE mock queue success; từng unit pass nhưng tổng thể tạo trùng hoặc báo sai trạng thái.

**Điều kiện tối thiểu:** mô tả riêng trạng thái nghiệp vụ đã lưu và trạng thái side effect, kể cả `unknown` khi chưa biết bên kia đã nhận. Chốt người sở hữu retry và cách nhận diện thao tác lặp phù hợp. Lát nghiệm thu xuyên các task repo/toolchain; có kiểm chứng tại điểm nối hoặc ghi rõ chưa kiểm chứng, không gọi Done end-to-end.

**Chi phí:** bảng trạng thái nhỏ và một kiểm tra lỗi tại ranh giới; test tích hợp thật có thể cần môi trường. **Đơn giản hơn:** walkthrough ba trường hợp save fail / save pass + effect fail / acknowledgement unknown, rồi kiểm tra thủ công có ghi revision nếu chưa có harness. Walkthrough chỉ đủ thiết kế, không thay bằng chứng runtime cho tuyên bố hoàn tất. Không mặc định xây outbox/saga cho mọi tích hợp.

## 9. R08 — Checklist bảo vệ biến thành ceremony bắt buộc cho task UI thuần

**Mức độ:** medium nhưng có thể làm phương pháp không được dùng.

**Claims và evidence:**

- **supported:** foundational-clearance §3 đã đề xuất Fast UI/copy/no-rule; review composer-01 R01 phản biện sáu hoạt động bị tuần tự hóa; backlog v002 §1 muốn map loại task sang hoạt động.
- **unresolved:** cách chọn đường, chi phí thực tế và tín hiệu nâng cấp đường chưa được thử trên task thật.
- **contradicted:** “muốn an toàn thì task nào cũng cần flow cũ/mới, nhiều agent và OpenSpec”. Với sửa text cục bộ không đổi hành vi, các artifact đó không thêm một quyết định hữu ích.

**Counterexample:** sửa nhãn ở một component cục bộ phải chờ BA duyệt ba scenario và diagram API không đổi. Dev né quy trình hoặc gắn nhãn mọi task là UI để đi Fast, kể cả thay disable-condition thực chất là rule.

**Điều kiện tối thiểu:** routing theo semantic. Fast khi không đổi điều kiện, trạng thái, contract hay side effect; shared visual component vẫn kiểm tra consumer đại diện. Nâng lên Standard ngay khi việc “đổi UI” thực tế đổi quyền/điều kiện hành động. Không bắt chờ BA nếu không có câu hỏi nghiệp vụ.

**Chi phí:** một câu tự kiểm tra scope và vài bằng chứng UI phù hợp. **Đơn giản hơn:** task/PR hiện hữu ghi yêu cầu, điểm chạm, hành vi giữ và kết quả kiểm tra; dùng ID ticket sẵn có. Không thêm directory, reviewer agent hoặc tên Change-Id mới chỉ để đủ quy trình.

## 10. Thử phương pháp trên ba task giả định

Đây là tabletop counterexamples, không phải kết quả test sản phẩm. Mục tiêu là phát hiện quy tắc phương pháp nào cần có và phần nào nên bỏ.

| Task | Phương pháp ngây thơ sẽ sai ở đâu? | Gói tối thiểu đủ dùng | Điều kiện chưa được nói “Done” | Có thể bỏ |
|---|---|---|---|---|
| UI thuần: sửa text/hướng căn trong một màn, không đổi rule | Ép OpenSpec hoặc nhầm component cục bộ với shared; R05/R08 | Ticket + điểm chạm + xác nhận không đổi rule; kiểm tra kích thước hiển thị liên quan và interaction cũ | Chưa kiểm tra màn/consumer liên quan mà kết luận không regression | Flow BE, decision card BA nếu không có câu hỏi, phản biện nhiều agent |
| Rule dùng chung: đổi điều kiện đủ tư cách cho một nhóm | Một `if` global làm caller cũ đổi theo; BA chưa chốt default vẫn implement; R02/R04/R05 | Rule mới/cũ, ví dụ ranh giới, owner chốt, nhóm caller, điểm nối và test bảo vệ | Chưa rõ nhóm nào áp dụng hoặc test chỉ chứng minh new path | Audit toàn repo, full ADR nếu quyết định chỉ cục bộ |
| Integration: lưu kết quả rồi phát tác vụ ngoài hệ thống | Local units pass nhưng timeout/retry tạo lặp; evidence FE/BE khác revision; R03/R06/R07 | State + effect + unknown, retry ownership, source index, revision các bên, verification tại seam | Chưa kiểm chứng partial failure hoặc không biết ai phục hồi khi ack mất | Full orchestrator, bắt buộc saga/outbox, nguyên suite QA mẫu |

**Kết quả tabletop:** Fast/Standard/Heavy hữu ích nếu là độ sâu theo rủi ro, không là ba bộ folder. Cùng một nhãn “FE task” có thể là Fast hoặc Standard; cùng một repo có thể chứa nhiều hệ thống và cần Heavy. Không lấy số file/repo làm tiêu chí duy nhất.

## 11. Tối thiểu phải giữ và phần có thể bỏ

### Phải giữ

1. Tách ý định đã chốt khỏi hiện trạng quan sát và kết quả đã kiểm chứng; không mặc định canonical là deployed.
2. Quyết định nghiệp vụ có authority; unresolved không biến mất vì nhiều AI đồng ý hoặc hết thời gian.
3. Một delta hành vi rõ, điểm nối và hành vi cũ cần giữ; với UI nhỏ có thể chỉ vài dòng.
4. Evidence có phạm vi và phiên bản; thay đổi điều kiện chứng minh thì recheck phần liên quan.
5. Chỉ dùng kết quả gate trong giới hạn nó thực sự đo; ghi thiếu review/test thay vì “pass” giả.
6. Giới hạn chi phí bằng routing và timebox; không giới hạn số ngoại lệ thật bằng quota tài liệu.

### Có thể bỏ hoặc trì hoãn

- Review panel mặc định, biểu quyết AI và agent cho mỗi axis; một lượt tự phản biện có mục tiêu có thể đủ cho low-risk.
- Hai PR, resolver, hooks, tự archive/sync, mining, assertion counts và workflow mẫu.
- File riêng cho mọi bước; bản BA và bản kỹ thuật có thể là hai góc đọc trong một hồ sơ.
- Hard cap ba scenario/câu hỏi; thay bằng ba câu ưu tiên trong một lượt và giữ phần còn lại có trạng thái.
- Flow diagram cho thay đổi hiển nhiên; bảng delta hoặc một câu có thể đủ.
- Topology hub/per-repo hoàn chỉnh trong phase phương pháp; nhưng không bỏ quyết định ownership khi bắt đầu giao change thật.

**Lập trường tạm thời:** mượn traceability, critique hai chiều, context và rationale. Không mượn nguyên verdict/state machine hoặc script. Ready-to-slice và Done-with-evidence là hai thời điểm kiểm tra đủ dùng; các thông tin trên nằm bên trong, không tạo thêm sáu cổng.

## 12. Câu hỏi trực tiếp cho Round 2

### Gửi Idea Architect

- **R01-QA:** Phương án của bạn ngăn `APPROVE + validateFail` hoặc reviewer không chạy bị hiểu là Ready bằng cơ chế tối thiểu nào? Có cần thêm tool không?
- **R02-QA:** Canonical của bạn là desired hay delivered? AI nhìn đâu để biết một contract accepted chưa thể reuse từ code hiện tại?
- **R03-QA:** Khi spec đổi nhưng task cũ vẫn done, ai và theo dấu hiệu nào đánh dấu evidence mất hiệu lực mà không chạy lại mọi test?
- **R05-QA:** Với một shared rule có nhiều consumer, điểm dừng khảo sát nào đủ để chọn phương án mà không tuyên bố biết hết blast radius?
- **R07-QA:** Bạn chia lát và giữ một tiêu chí nghiệm thu xuyên repo thế nào để local units xanh không che partial failure?

### Gửi Problem Framer

- **R04-QP:** Khi BA chưa trả lời, quyền agent dừng ở đâu? Ai có thể cho phép triển khai một assumption, và khác gì việc xác nhận đó là yêu cầu?
- **R06-QP:** Bạn có đồng ý bỏ hard cap “≤3 scenario” và coi “≤3 P0” chỉ là giới hạn một lượt trao đổi, không là giới hạn blocker?
- **R08-QP:** Đâu là hồ sơ nhỏ nhất cho UI thuần; tín hiệu nào bắt buộc nâng đường khi nhãn task vẫn là “UI”?
- **R04/R08-QP:** Kênh nào thực sự đưa quyết định tới BA và nhận xác nhận lại? Nếu BA không đọc Markdown, ai chịu trách nhiệm không làm mất phạm vi khi chuyển qua chat/ticket?

### Đề nghị cả hai phản biện lại reviewer

Chọn ít nhất một mitigation ở đây mà các bạn thấy không đáng chi phí; đưa counterexample và phương án nhẹ hơn vẫn bảo toàn kết luận trung thực. Đừng chỉ đồng ý rồi cộng tất cả mitigation thành checklist bắt buộc. Nếu không có bằng chứng để giải bất đồng, giữ `unresolved` và đề xuất một phép thử nhỏ, không biểu quyết.

---

**Kết thúc Round 1 — giữ bất biến. Round 2 sẽ được append sau dòng này khi nhận lập luận của hai agent còn lại.**

# Adversarial Reviewer — Round 2

- Ngày: 2026-11-14.
- Đã đọc Round 1 của `01-architect.md` và `02-problem-framer.md`. Không sửa Round 1.
- Mỗi mục nhận diện đồng ý/bác bỏ/điều chỉnh; bất đồng chưa giải được ghi `unresolved` và có phép thử đề xuất. Không coi điểm chung của ba vai là phê duyệt.

## 1. Phản hồi trực tiếp theo ID

### A06 — “Discovery dừng khi một phương án hợp lệ” là chưa đủ

**Trạng thái:** bác bỏ dạng generic; chấp nhận nếu thêm coverage sweep tối thiểu.

**Phản ví dụ:** task đổi copy dùng cho nút xác nhận xóa ở một shared component. A06 có thể dừng vì tìm được phương án hợp lệ “sửa key cục bộ trong màn này”, trong khi câu hỏi ban đầu chỉ đặt theo màn gọi ra. Consumer khác dùng cùng key vẫn đổi hành vi hiển thị; condition dùng để render nút không được hỏi. Đúng như A06 nói caller/side effect quan trọng phải `unresolved`, nhưng rule hiện chưa buộc lượt kiểm tra bỏ sót trước khi chọn phương án.

**Điều chỉnh:** dừng phải qua hai bước: (1) đủ câu trả lời cho câu hỏi đã đặt; (2) sweep cố định actor/state/error/dependency/caller/consumer và đánh dấu mỗi loại `covered`, `not-applicable` hay `unknown`. “Không tìm thấy consumer” khác “chưa tìm consumer”; chỉ loại sau mới cho phép thu hẹp lát. Đây là checklist một lượt, không phải quét toàn workspace.

### A04 — Hai trục trạng thái cần thêm ranh giới lỗi thời và implemented

**Trạng thái:** sửa.

**Phản ví dụ hồi quy:** lát FE `done` với BE revision A; BE đổi contract sang revision B. `accepted` cũ thành `superseded`, nhưng evidence cũ vẫn ghi `verified-by-test-or-runtime`. Người đọc lại có thể hiểu task vẫn còn hiệu lực. Trường hợp khác: code đã merge nhưng chưa có test/runtime phù hợp; A04 không có nhãn riêng nên dễ ghi `verified` vì “đã làm xong”.

**Điều chỉnh:** thêm trạng thái `implemented-unverified` và thuộc tính evidence `valid-for: contract + revision/working-tree + môi trường`. Khi quyết định/contract thay đổi, không giữ nguyên `verified`; đổi thành `stale-needs-recheck` hoặc ghi rõ miền còn áp dụng. `done` giữ lịch sử, không giữ hiệu lực xác minh vô điều kiện.

### A09 — Hai cổng đúng, nhưng evidence gate cần điều kiện phủ

**Trạng thái:** sửa.

`Done-with-evidence` không có nghĩa chứng minh toàn hệ thống. Test bảo vệ chỉ chứng minh những case/revision/ranh giới nó bao phủ. Ví dụ test create + timeout pass không phủ ca acknowledgement `unknown`; test FE mock BE không chứng minh hợp đồng thực. Gate nên viết: có evidence cho lát này; đã nêu phạm vi và phần chưa kiểm chứng; không có assertion màu xanh chưa chạy được dùng làm `pass`. Skip phải có lý do và scope; script chỉ thấy `test.skip()` chưa chứng minh “đã bỏ qua có kiểm soát”.

### A05 — Nguyên tắc seam đúng, nhưng sáu câu là quá nặng cho một lớp task

**Trạng thái:** chấp nhận nguyên tắc; bác bỏ áp dụng đồng đều.

Với task UI thuần đổi khoảng cách cục bộ, trả lời sáu câu auth/state/side effect là ceremony không tạo quyết định. Đây là chỗ phương pháp quá nặng. Tối thiểu chỉ cần: điểm chạm, shared/local, hành vi giữ, cách kiểm tra. Nếu khảo sát phát hiện translation key dùng chung, handler đổi hoặc accessibility semantics đổi thì mới nâng lên seam note đầy đủ. Trigger nâng cấp quan trọng hơn số câu cố định.

### P01 — Phân loại bottleneck không nên có quyền dừng phân tích sớm

**Trạng thái:** chấp nhận cảnh báo; bổ sung một lỗ hổng.

Framer đúng khi nói thiếu quyết định người sở hữu không thể giải bằng thêm tài liệu. Nhưng nhãn “nút thắt là BA” có thể quá nhẹ và trở thành cớ dừng. Có những case chỉ khi truy code mới thấy yêu cầu đã đáp ứng một phần, có dependency có thể cô lập, hoặc câu hỏi thật hẹp hơn nhiều. Nếu không điều tra, team chờ sai owner trong khi lát độc lập làm được.

**Phép thử nhỏ:** một task ghi chờ BA >1 ngày. Trước khi dừng, thực hiện một lượt điều tra 30–60 phút theo ba câu: yêu cầu đang được đáp ứng phần nào; lát nào độc lập; câu hỏi nghiệp vụ còn lại thuộc ai. Kết quả so sánh: có mở được lát hay vẫn chỉ chờ. Không dùng kết quả này để tự thay quyết định BA.

### P03 — Đồng ý nhãn Fast/Heavy không phải thước đo, nhưng không nên bỏ vai trò routing

**Trạng thái:** chấp nhận với điều chỉnh.

“UI/cross-repo” không xác định rủi ro; đổi nhãn `Lưu` thành `Xác nhận` có thể đổi cam kết nghiệp vụ, còn đổi display name nhất quán hai repo có thể không cần state model. Tuy vậy, nhãn vẫn hữu ích làm dự báo chọn góc kiểm tra và ngân sách lượt đầu. Quy tắc nên là: nhãn dự kiến có thể sai; semantic, shared surface, side effect và reversibility quyết định độ sâu. Không biến ba nhãn thành ba bộ thư mục.

### P08 — Đồng ý phản đối đồng thuận agent, nhưng Framer đang quá nhẹ ở khâu phân xử

**Trạng thái:** bổ sung.

Framer chỉ ra ba agent cùng đọc một nguồn không tạo ba nguồn bằng chứng độc lập và phản đối verdict nhị phân. Đúng, nhưng chưa nói xong điểm quan trọng: khi `supported` và `contradicted` cùng tồn tại, ai và theo tiêu chí nào xử lý? Nếu chỉ giữ “chưa biết” vô hạn, decision-driven analysis có thể bị kẹt; nếu agent chọn phía hợp lý hơn, lại biến đánh giá kỹ thuật thành quyết định nghiệp vụ.

**Tối thiểu:** mỗi conflict ghi hai bằng chứng, phạm vi áp dụng và `unresolved` nếu chưa giải. Agent được đề xuất decision card, không được gắn `accepted`. Người có thẩm quyền xử lý; hết vòng thì tách lát độc lập hoặc nêu blocker, không im lặng默认. Đây là điểm cần đề xuất rõ hơn ở synthesis.

### P02 — Đúng về thứ tự trình bày, cần chống lại hồi quy “reuse trước”

**Trạng thái:** chấp nhận và đưa thành guard cụ thể.

Bản BA nên mở đầu bằng kết quả người dùng và ví dụ phân biệt; chi phí kỹ thuật chỉ là trade-off sau. Có API/t config là fact hiện trạng, không phải lý do nghiệp vụ đủ. Nhưng cũng không nên quay sang bias ngược “mọi thứ cũ đều nguy hiểm”. Reuse tốt hơn tách nhánh khi: semantic nghiệp vụ giống nhau; shared rule phải có một nguồn chân lý; hành vi cũ cần cập nhật theo thay đổi; config/parameter đủ và không tạo nhánh đặc biệt khó hiểu. Tách nhánh tốt hơn khi ngữ cảnh cũ/mới có nghĩa khác nhau, cần tương thích song song, side effect hoặc lifecycle khác, và điều kiện phân nhánh có thể kiểm chứng tại một seam.

**Hồi quy cần chống:** agent trình bày “cách A rẻ” trước; BA chọn A mà không thấy option đổi quy trình vận hành. Cách giảm: đặt ít nhất một non-code alternative khi tồn tại, ghi rõ đây là option không phải khuyến nghị, và yêu cầu owner xác nhận outcome trước khi ghi reuse là `accepted`.

## 2. Safeguards tối thiểu và phần có thể bỏ

Decision-driven chỉ an toàn nếu coverage không giảm thành “những gì agent nhớ hỏi”. Sweep một lượt theo actor/state/error/dependency/consumer là bắt buộc; UI thuần có thể gộp thành hành vi cũ, shared surface và kiểm chứng hiển thị. Shared rule cần phạm vi áp dụng, caller đã/chưa biết, source of truth và regression cũ. Integration cần local state, side effect, unknown, retry owner và failure tại seam. Phần chưa tìm thấy phải ghi `unknown`; không đổi thành “đã xem xét” chỉ vì có checklist.

Giữ tối thiểu: (1) tách accepted intent, observed/implemented reality và verified evidence, kèm revision/môi trường; (2) claim reuse/ít impact có semantic, seam, consumer và test bảo vệ đúng phạm vi; (3) sweep coverage một lượt; (4) decision card có owner và lát bị chặn; (5) evidence mất điều kiện đúng thì đánh dấu stale theo phần liên quan. Skip/pass phải có bằng chứng thực thi; không dùng assertion xanh chưa chạy làm chứng cứ.

Có thể bỏ/defer: panel agent, hai PR, gate resolver, validator/sample-app, hash evidence chung, full QA, state machine chi tiết, flow diagram bắt buộc và quota blocker. “Ba câu P0/lượt” chỉ là cửa sổ trình bày, không phải giới hạn số blocker. Chưa có painpoint truy vết thật thì dùng ticket ID hiện có.

## 4. Phản hồi các thách thức của peers

### Trả lời AR-A01 của Architect

Shared copy/handler có consumer ngoài màn đang xét. Bằng chứng đủ tối thiểu: nguồn định nghĩa/key, kiểm tra consumer cho đúng surface, một kiểm chứng consumer đại diện; nếu không truy được consumer thì `unknown` và thu hẹp lát. Chưa cần quét workspace hay API inventory toàn dự án.

### Trả lời AR-A04 của Architect

Chỉ dedup phía nhận chưa đủ Ready. Ca crash cần bảng `saved / side-effect-started / acknowledged-unknown`, retry owner và cách nhận diện yêu cầu trùng; kèm một kiểm chứng lỗi tại seam. Thiếu policy này thì chỉ Ready cho lát lưu nội bộ, với điều kiện không tự retry tổng thể.

### Trả lời PF-P03 của Framer

Đồng ý nhãn không phải thước đo, nhưng “chỉ theo sự chưa rõ” cần chống over-analysis. Giải pháp gọn: dự báo nhãn ban đầu + semantic checklist + quyền hạ/nâng sau một lượt sweep. Đây cũng là chỗ Framer quá nhẹ: chưa nêu ai được hạ từ Standard xuống Fast và bằng chứng nào đủ để hạ.

## 5. Bất đồng còn lại

- `unresolved` — authority mặc định: cả hai nghiêng Dev/tech lead và BA quyết nghiệp vụ, nhưng chưa có người Arena xác nhận.
- `unresolved` — canonical desired vs delivered: chưa chọn nơi sống và cách cập nhật khi có nhiều repo.
- `unresolved` — mức sweep/lượt phản biện cho Heavy: hai góc critique một lượt là đề xuất phase thử, chưa có bằng chứng hiệu quả.
- `unresolved` — evidence granularity: bảng thủ công có thể đủ; automation mapping scenario/test nên defer.

## 6. Handoff cho điều phối

| Chủ đề | Hành động đề xuất | Lý do |
|---|---|---|
| Accepted/observed/verified | **Giữ nhưng sửa** thành ba trục có revision, môi trường và stale/recheck | Chống accepted thành hiện trạng, done cũ thành verified |
| Decision-driven coverage | **Giữ nhưng sửa** thêm sweep một lượt và trạng thái unknown | Chống bỏ sót do chỉ theo câu hỏi nổi bật |
| “Ít impact” | **Giữ tối thiểu**: semantic + seam + consumers + test bảo vệ; UI nhỏ được một dòng | Không đòi bằng chứng toàn hệ thống, nhưng chặn claim từ diff size |
| Fast/Standard/Heavy | **Sửa thành routing dự báo**, semantic quyết định; ghi ai được hạ/nâng đường | Tránh label thành thước đo rủi ro hoặc bộ folder cứng |
| Agent debate | **Giữ hai góc critique**, bỏ vote/mặc định refuted; cần owner xử lý conflict | Có giá trị phát hiện, không có thẩm quyền quyết |
| Quota ba câu/scenario | **Sửa**: giới hạn một lượt trao đổi, không giới hạn blocker/scenario thật | Giữ hiệu quả giao tiếp mà không cắt coverage |
| Six-question seam note | **Sửa thành trigger-based**; UI hiển nhiên chỉ cần impact note ngắn | Tránh ceremony; vẫn nâng khi shared/accessibility/contract đổi |
| Reuse vs branch | **Giữ checklist chọn theo semantic**, trình bày outcome trước và non-code alternative khi có | Chống cả bias reuse và bias branch |
| Handoff/stale done | **Giữ handoff tối thiểu**; evidence stale theo decision/revision, không reset mọi done | Tiếp tục mà không mất tiến độ |
| Tooling/validator/multi-agent | **Bỏ hoặc defer** đến khi có change thật và painpoint đo được | Không bảo vệ cách vận hành chỉ vì tài liệu hay |

Điều phối không nên tổng hợp thành “mọi safeguards đã được đồng thuận”. Ba điểm trên là bất đồng/mổ xẻ cần user quyết hoặc phép thử: authority mặc định, canonical desired/delivered và mức sweep cho Heavy.
