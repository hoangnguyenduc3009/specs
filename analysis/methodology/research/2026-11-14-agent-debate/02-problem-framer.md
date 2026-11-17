# PROBLEM FRAMER / PRODUCT ANALYST

## Round 1 — Phản biện bài toán trước khi chọn phương pháp

- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Trạng thái: lập luận độc lập để tranh luận; chưa được người dùng phê duyệt.
- Giới hạn: không spawn agent, không thiết kế pipeline, không review implementation framework, không sửa product code.
- Evidence: đọc tài liệu tại workspace, không chạy runtime/test và không xác nhận lại các nhận định product code của các lượt trước.
- Round 1 giữ bất biến. Khi nhận lập luận Architect và Adversarial Reviewer, chỉ append Round 2; không viết lại để tạo cảm giác đã đồng thuận từ đầu.

### 1. Luận điểm cần thử bác bỏ

**Team có thể đang tối ưu việc tạo hồ sơ phân tích, trong khi nút thắt thật là không có người chốt quyết định hoặc không có đủ bằng chứng hiện trạng.** Thêm spec, flow, review axes không tự giải được hai vấn đề này.

Giả thuyết sản phẩm đề xuất:

> Khi Dev/tech lead nhận một thay đổi chưa đủ rõ để cam kết cách làm, mmd-sdd giúp họ đưa ra một quyết định có căn cứ: làm phần nào, giữ hành vi nào, hỏi ai điều gì, hoặc chưa nên làm. Chi phí phân tích phải tương xứng với quyết định được cải thiện.

Đây là giả thuyết để thử, không phải kết luận về cách team Arena thực sự đang vận hành. Chưa có quan sát trực tiếp về thời gian chờ BA, rework hoặc adoption.

**Phương án đối chứng:** một ticket tốt, một lượt Dev đọc code có mục tiêu và một cuộc trao đổi ngắn BA–Dev–QA. Nếu hồ sơ SDD không giúp hơn cách này, không nên bắt team duy trì nó chỉ vì có cấu trúc đẹp.

### 2. Primary user, moment of use và đầu ra có ích

| Thành phần | Default đề xuất, chưa phải quyết định đã chốt |
|---|---|
| Primary user | Dev/tech lead nhận yêu cầu và chịu trách nhiệm đánh giá phạm vi sửa; AI là trợ lý điều tra, không phải chủ thể chấp thuận |
| Secondary users | BA/PO chốt nghĩa nghiệp vụ; QA tìm ví dụ phân biệt và kiểm chứng |
| Moment of use | Trước khi cam kết scope/cách làm; mở lại đúng phần liên quan khi code hoặc nguồn yêu cầu bác bỏ giả định |
| Quyết định cần hỗ trợ | Làm/không làm; phần độc lập nào làm được; điều gì phải giữ; lựa chọn nào cần owner xác nhận |
| Output cho BA | Một khác biệt hành vi, ví dụ khiến hai cách hiểu cho kết quả khác nhau, lựa chọn và hệ quả |
| Output cho Dev | Điểm thay đổi có evidence, giới hạn reuse, caller/hành vi cần bảo vệ và điều chưa xác minh |
| Output cho QA | Các kết quả quan sát được để phân biệt đúng/sai, gồm regression quan trọng |

Một sơ đồ chỉ hữu ích khi nó làm lộ quyết định hoặc dependency chưa thấy. Một câu hỏi chỉ hữu ích khi đáp án có thể đổi scope, behavior, acceptance hoặc phương án. Không đánh giá output bằng số trang, số câu hỏi hay số diagram.

### 3. Các vấn đề P01–P08

#### P01 — Chưa có bằng chứng nút thắt chính là thiếu phương pháp

- Evidence: `mmd-sdd/analysis/methodology/versions/v001/foundational-clearance.md`, §1–2, thừa nhận mục tiêu và primary user chưa chốt; `analysis.md`, §14, mới đề xuất thử nghiệm.
- Phản biện: tài liệu BA mơ hồ có thể do chính sách chưa được quyết, không phải do thiếu bước phân tích. Một agent có thể phân tích đúng nhưng không ai có quyền trả lời.
- Đề xuất: phân biệt ba nguyên nhân trong task thử: thiếu thông tin tìm được, thiếu quyết định người sở hữu, hoặc thiếu biểu đạt. Chỉ nguyên nhân đầu/cuối được giải trực tiếp bằng agent/tài liệu.
- Dấu hiệu sai bài toán: hồ sơ ngày càng đầy đủ nhưng thời gian chờ quyết định và số lần mở lại cùng một câu hỏi không giảm.

#### P02 — Bản BA có nguy cơ trở thành lời giải kỹ thuật dẫn dắt quyết định sản phẩm

- Evidence: `analysis.md`, §5 và §8, đặt flow hiện trạng, điểm sửa và bản trao đổi BA gần nhau; §8.3 đã phân quyền câu hỏi nhưng chưa chứng minh người đọc dùng được đầu ra.
- Phản biện: trình bày phương án reuse trước có thể khiến BA chọn nghiệp vụ theo thứ dễ code, không theo kết quả cần đạt.
- Đề xuất: trình bày kết quả người dùng và ví dụ phân biệt trước; chi phí kỹ thuật là trade-off sau đó. Luôn cho phép kết luận không làm, đổi scope hoặc thay quy trình vận hành.
- Không coi “đã có API” là lý do đủ để chọn một hành vi.

#### P03 — Fast/Standard/Heavy là nhãn tiện dụng nhưng không phải thước đo rủi ro

- Evidence: `foundational-clearance.md`, §3, gán UI/copy vào Fast và cross-repo vào Heavy; `v002-merge-backlog.md`, §2, dự kiến mang ba đường thành quy định vận hành.
- Phản ví dụ: đổi nhãn “Lưu” thành “Xác nhận” chỉ chạm UI nhưng có thể đổi kỳ vọng về tính cuối cùng của thao tác. Ngược lại, đổi tên hiển thị nhất quán ở hai repo không tự cần state model và rollback note riêng.
- Đề xuất: nhãn đường chỉ là dự báo ban đầu. Chọn độ sâu theo sự chưa rõ của hành vi, mức dùng chung, side effect, khả năng đảo ngược và thiệt hại nếu hiểu sai; cho phép tăng/giảm độ sâu khi có evidence.
- Bỏ yêu cầu “full” như một bộ giấy tờ phải hoàn tất. Giữ quyền kết thúc với một quyết định ngắn khi không có thay đổi semantic.

#### P04 — Quota câu hỏi có thể che giấu blocker thay vì giảm tải BA

- Evidence: review `reviews/2026-11-14-composer-01.md`, R05; `v002-merge-backlog.md`, §1, đề xuất ≤3 câu P0/lát. Trong khi `analysis.md`, §14, không đặt chỉ tiêu số câu hỏi.
- Phản biện: có bốn quyết định độc lập không thể biến thành ba chỉ để đạt quota. Gom quá mức còn khiến câu trả lời thiếu chính xác.
- Đề xuất: giới hạn số câu đưa ra trong một lượt trao đổi, không giới hạn sự thật cần giải quyết. Ưu tiên câu có ảnh hưởng lớn, ghi rõ các quyết định còn lại chưa được giải; không hạ severity để đạt hạn mức.
- Câu có default vẫn có thể blocking. Default là phương án khuyến nghị, không phải quyền tự phê duyệt khi owner im lặng.

#### P05 — “Ít code” và “reuse tốt” có thể bảo toàn chính lỗi cần sửa

- Evidence: `analysis.md`, §1 và §7, đã bác bỏ tối ưu LOC; composer-01 R02/R07 bổ sung semantic và blast radius. Tuy nhiên, kết luận §16 vẫn đặt khảo sát reuse thành nguyên tắc đi trước code mới.
- Phản biện: reuse hàm cùng tên chưa chắc giữ semantic, quyền truy cập, side effect, thời điểm đọc dữ liệu hoặc bảo đảm retry. Một dòng sửa trong rule chung có thể đổi nhiều caller; một nhánh cô lập dài hơn có thể an toàn hơn.
- Đề xuất: coi reuse là ứng viên phải chứng minh, không phải kết quả mặc định. Bảo vệ hành vi cũ được xác định là cần giữ, không bảo vệ mọi hành vi cũ gồm cả bug.
- Dừng tìm reuse khi đã có ứng viên đủ đúng và kiểm chứng được, hoặc khi semantic mâu thuẫn rõ; không quét toàn workspace để chứng minh tuyệt đối không còn lựa chọn tốt hơn.
- Mục tiêu phù hợp: đáp ứng đúng yêu cầu với rủi ro thay đổi và chi phí bảo trì chấp nhận được; không tuyên bố đã tìm “nhỏ nhất” nếu chưa thể so sánh đầy đủ.

#### P06 — Sự nghiêm ngặt có thể đang đặt nhầm chỗ

- Evidence: `code-review-idea-fit.md`, §2.D, gọi validation là gate cứng và BA sign-off là soft; `mzspec/core/skills/spec-review-and-quality/SKILL.md`, Axes/Process, tập trung tính hợp lệ và chất lượng spec.
- Phản biện: đúng định dạng không bù được quyết định nghiệp vụ sai hoặc thiếu thẩm quyền. Các trục chất lượng có ích nhưng không chứng minh team cần change này hay chấp nhận trade-off của nó.
- Đề xuất: không bắt mọi câu chữ phải BA duyệt; nhưng thay đổi quyền, dữ liệu, cam kết với người dùng hoặc fallback có tác hại phải có owner phù hợp chốt. Không nâng draft thành accepted chỉ vì validate pass hoặc nhiều agent đồng ý.

#### P07 — Đầu ra đang có nguy cơ nhiều hơn quyết định cần đưa ra

- Evidence: `analysis.md`, §10, có nhiều ánh xạ artifact; các companion và `v002-merge-backlog.md` đang tiếp tục bổ sung quy định. Đây là nguy cơ, chưa phải bằng chứng team thực tế bị quá tải.
- Đề xuất: mỗi phần thêm vào phải chỉ ra người đọc và quyết định được hỗ trợ. Một task nhỏ có thể kết thúc bằng một ghi chú trong ticket; không tự sinh proposal, brief, BA pack và handoff chứa cùng một thông tin.
- Phản biện với context pack: `code-review/docs/09-code-review-context.md` giải quyết review code không mù contract. Trước code, pack phải chấp nhận uncertainty; không bắt agent điền scenario “đã chốt” khi chưa có quyết định.

#### P08 — Tranh luận agent có thể tạo độ tự tin giả

- Evidence: `code-review/code-review/rules/phase-2b-verify.md` có refuter và completeness critic, nhưng verdict nhị phân và cơ chế đa số thuộc bối cảnh review code.
- Đề xuất học hai góc nhìn: nhận định có bị bác bỏ không, và phần nào chưa được xem xét. Không mang bỏ phiếu hoặc verdict nhị phân sang chính sách chưa quyết.
- Trạng thái cần phân biệt: có evidence / có evidence phản bác / chưa biết / chờ quyết định. Ba agent cùng đọc một nguồn không tạo ba nguồn bằng chứng độc lập.
- Dấu hiệu vòng tranh luận thất bại: phát sinh thêm tiêu chí và tài liệu nhưng không đổi một quyết định, không loại một giả định sai, không thu hẹp phần chưa biết.

### 4. Ba phản ví dụ bắt buộc

Các tình huống sau là giả định để thử phương pháp, không phải kết luận code Arena đã có các hành vi này. Repo là nơi sẽ điều tra khi gặp task tương ứng.

| Task | Điều phải biết để quyết định | Output đủ dùng | Cách phương pháp có thể thất bại |
|---|---|---|---|
| UI thuần: sửa khoảng cách/nhãn hiển thị không đổi hành động | Component trong `website-mmd-area1` có dùng chung không; handler/semantic có giữ nguyên không | Ảnh hoặc mô tả trước/sau, điểm chạm, xác nhận phần hành vi giữ và cách kiểm tra | Ép vẽ flow BE, sinh ba scenario giả, hỏi BA chuyện tìm được trong component |
| Rule chung: đổi điều kiện được thực hiện hành động | Quy tắc mới áp dụng toàn bộ caller hay một ngữ cảnh; source of truth và ngoại lệ | Bảng ví dụ cũ/mới, phạm vi áp dụng và quyết định owner; truy vùng ETEST/core/EDU hoặc CRM chỉ khi có dependency | Một dòng sửa shared rule được gọi “ít impact”; hoặc reuse rule cũ làm sai đối tượng áp dụng |
| Tích hợp partial failure: hệ thống A lưu thành công, B timeout | Người dùng thấy thành công ở bước nào; retry có tạo trùng không; ai xử lý trạng thái treo | Một chuỗi thành công/lỗi minh họa, kết quả mong muốn ở từng điểm và quyết định về retry/trạng thái; chỉ truy cả v2/CRM nếu quan hệ đó tồn tại | Flow mới chỉ có happy path; gọi lại API cũ vì “reuse” gây side effect lặp; BA bị hỏi cách implement queue thay vì kết quả nghiệp vụ |

Đánh giá:

- UI thật sự thuần: có thể không cần hỏi BA và không cần sơ đồ. Nếu nhãn mới hàm ý một cam kết khác, nó không còn là UI thuần dù diff nhỏ.
- Rule chung: phần tốn công là xác định phạm vi áp dụng và tác động semantic, không phải độ dài spec. Một câu hỏi owner đúng có giá trị hơn nhiều trang inventory.
- Partial failure: số câu hỏi có thể nhiều hơn quota vì các quyết định độc lập. Có thể phân tích phần an toàn, nhưng không được ship fallback nghiệp vụ theo im lặng mặc định.

### 5. Người quyết định gì, agent tự điều tra gì?

| Nội dung | Quyền và hành động phù hợp |
|---|---|
| Route, field, caller, trạng thái trong code, test hiện có | Agent tự điều tra có mục tiêu và ghi giới hạn; không đẩy câu hỏi sang BA |
| Runtime/data/environment không truy cập được | Agent ghi chưa xác minh và yêu cầu evidence từ người có quyền; không suy ra từ tên API |
| Ý định nghiệp vụ, scope, ngoại lệ, tổn hại chấp nhận được | BA/PO hoặc người sở hữu chính sách quyết; agent đưa ví dụ và phương án |
| Kiến trúc, quyền sửa shared component, migration/rollout | Tech owner quyết theo thẩm quyền team; agent đề xuất và kiểm tra dependency |
| Acceptance có thể quan sát | QA phối hợp BA/Dev; agent có thể soạn ví dụ nhưng không tự ký nghiệm thu |
| Định dạng ghi chú, thứ tự điều tra, gom câu trùng | Agent tự chọn, miễn không làm mất sự chưa rõ hoặc đổi nghĩa |

Hết timebox không chuyển quyền quyết định cho agent. Có thể tiếp tục phần độc lập và đảo ngược được, nhưng phải chứng minh nó không khóa lựa chọn đang chờ.

### 6. Tối đa năm câu hỏi cho người dùng có giá trị quyết định lớn

Đây là các câu hỏi đề xuất cho người điều phối, không yêu cầu trả lời tất cả trước khi tiếp tục phân tích.

| ID | Câu hỏi | Default đề xuất | Rủi ro nếu default sai / cách tiếp tục |
|---|---|---|---|
| Q1 | Ai sẽ dùng đầu ra đầu tiên để ra quyết định, ở thời điểm nào? | Dev/tech lead trước khi cam kết scope/cách làm; BA là người xác nhận nghiệp vụ | Nếu BA là primary, tài liệu quá kỹ thuật và khó dùng; vẫn thử bản ngắn hai góc đọc, chưa đóng gói template cứng |
| Q2 | Đau nhất hiện nay là làm lại vì hiểu sai, mất thời gian tìm code, hay chờ người chốt? | Ưu tiên giảm làm lại do hiểu sai; ghi riêng hai nguyên nhân còn lại khi thử | Nếu thực tế là thiếu owner, thêm phân tích làm chậm hơn; dừng mở rộng phương pháp và giải ownership |
| Q3 | Ai có quyền chốt khi nguồn nghiệp vụ mâu thuẫn hoặc fallback làm đổi kết quả người dùng? | Owner nghiệp vụ được chỉ định cho task; tech owner không tự thay thế | Nếu chưa có owner, phần phụ thuộc vẫn chưa được phép coi accepted; tiếp tục điều tra kỹ thuật/phần độc lập |
| Q4 | Ưu tiên là sửa ít dòng hay giảm rủi ro và tổng chi phí thay đổi, kể cả cần refactor cục bộ? | Đúng nghiệp vụ trước, sau đó giảm rủi ro/chi phí; cho phép thay đổi cục bộ có lý do | Nếu team cần hotfix khẩn cấp, phân tích có thể vượt thời gian; đề xuất phạm vi tạm với nợ và giới hạn rõ, không tự bỏ yêu cầu an toàn |
| Q5 | Kết quả nào sẽ khiến team bỏ hoặc thu nhỏ mmd-sdd sau thử nghiệm? | Bỏ artifact không giúp quyết định; thu nhỏ phương pháp nếu tăng công phân tích mà không phát hiện vấn đề hữu ích hoặc giảm hỏi lại/rework | Nếu thiếu baseline, dễ kể chuyện thành công; dùng task đối chứng và ghi cả thất bại, chưa tuyên bố hiệu quả thống kê |

### 7. Success/failure phải quan sát được

Không lấy việc hoàn tất ba tài liệu làm DoD. Với mỗi task thử, ghi ngắn:

- Quyết định trước phân tích là gì, có thay đổi sau phân tích không, dựa trên evidence nào.
- Câu hỏi nào được owner trả lời và thực sự đổi scope/behavior/acceptance; câu nào không cần hỏi.
- Thời gian chủ động đọc/viết và thời gian chờ người khác, ghi riêng để không gán mọi chậm trễ cho phương pháp.
- Những phần vẫn phải hỏi lại khi handoff; nguyên nhân là thiếu thông tin, thiếu quyết định hay tài liệu khó dùng.
- Nếu task được triển khai sau này: rework do hiểu sai, regression ngoài scope và assumption bị bác bỏ. Thay đổi ưu tiên sản phẩm sau đó không tự là lỗi của phân tích.

**Thành công sớm:** người nhận có thể nói rõ làm gì/không làm gì và vì sao, đồng thời một uncertainty có ảnh hưởng được giải quyết hoặc cô lập. Một task vốn rõ kết thúc nhanh, không sinh thêm ceremony.

**Thất bại:** tài liệu nhiều hơn nhưng owner vẫn không chốt được; agent giấu uncertainty để đạt Ready; hoặc chọn reuse gây sai semantic mà review không phát hiện.

Ba task giả định chỉ là stress test logic. Muốn kết luận hiệu quả thực tế cần task thật và phản hồi người dùng; không dùng số finding từ AI như ROI.

### 8. Cắt/giảm artifacts trước khi thêm công cụ

1. Không mặc định tạo một “bộ BA mới”. Một phần tóm tắt quyết định trong hồ sơ/ticket đủ nếu BA đọc được; nguồn BA gốc vẫn được tham chiếu.
2. Gộp context pack, intake và câu hỏi vào một ghi chú có cấu trúc; chỉ tách khi có độc giả hoặc vòng đời khác nhau.
3. Không bắt cặp flow cũ/mới cho mọi task. Một sơ đồ đánh dấu delta hoặc bảng ví dụ có thể đủ; không vẽ nếu không giúp quyết định.
4. Không tạo ADR riêng cho lựa chọn cục bộ; một dòng chọn/không chọn và lý do đủ dùng.
5. Dùng ID ticket hiện có nếu đủ ổn định; không bắt taxonomy Change-Id mới trước khi có vấn đề truy vết thật.
6. Không sinh spec accepted khi vẫn đang điều tra. Quyết định chờ owner được giữ rõ, không điền default để hoàn thiện template.
7. Chưa thêm file chỉ vì mzspec yêu cầu `ui.md` cho UI hoặc review framework có nhiều output. Lấy câu hỏi chất lượng cần thiết, không sao chép nghĩa vụ artifact.

### 9. Thách thức trực tiếp gửi hai agent — không phải câu hỏi thêm cho BA

**Gửi Architect:** Hãy chứng minh thiết kế của bạn hỗ trợ task UI không cần sơ đồ/spec riêng, một rule chung cần owner chốt và một tích hợp có uncertainty chưa giải quyết, mà không ép cả ba vào cùng bộ output. Chỉ ra artifact nào bạn sẽ bỏ trước nếu người dùng không đọc. Tôi phản đối thiết kế coi path routing hoặc validate pass là bằng chứng đủ để Ready.

**Gửi Adversarial Reviewer:** Hãy tìm một trường hợp bản phân tích của tôi làm team dừng quá sớm và bỏ sót rủi ro, đồng thời một trường hợp tôi vẫn yêu cầu quá nhiều. Phân biệt evidence phủ định với thiếu evidence. Nếu kết luận của bạn là “reuse nguy hiểm”, hãy chỉ ra khi nào reuse thực sự tốt hơn tách nhánh để tránh thiên kiến ngược lại.

### 10. Evidence ledger và giới hạn

Các path dưới đây đã đọc trực tiếp trong vòng này; reference theo section/finding để không giả định line ổn định:

- `mmd-sdd/analysis/methodology/versions/v001/analysis.md`: mục tiêu, giới hạn, sáu hoạt động, vòng phản biện, artifacts, thử nghiệm.
- `mmd-sdd/analysis/methodology/versions/v001/foundational-clearance.md`: P1–P6 và ba đường.
- `mmd-sdd/analysis/methodology/versions/v001/code-review-idea-fit.md`: ý tưởng A–G, đặc biệt context và hard/soft gate.
- `mmd-sdd/analysis/methodology/versions/v001/v002-merge-backlog.md`: R01–R07 và đề xuất quy định v002 chưa duyệt.
- `mmd-sdd/analysis/methodology/versions/v001/reviews/2026-11-14-composer-01.md`: R01–R07.
- `mmd-sdd/analysis/methodology/versions/v001/reviews/2026-11-14-composer-02-code-review-fit.md`: R08–R10.
- `mmd-sdd/analysis/methodology/versions/v001/reviews/README.md`: trạng thái các review.
- `mzspec/core/skills/spec-review-and-quality/SKILL.md`: axes chất lượng; không khẳng định đã nghiên cứu toàn bộ mzspec trong vòng này.
- `code-review/docs/09-code-review-context.md`: context cho CODE PR, không phải bằng chứng hiệu quả intake.
- `code-review/code-review/rules/phase-2b-verify.md`: refuter/completeness critic, giới hạn áp dụng sang quyết định sản phẩm.

Chưa nhận lập luận Round 1 của hai agent còn lại. Các thách thức ở §9 là yêu cầu kiểm tra, không gán cho họ quan điểm chưa phát biểu. Round 2 chỉ bắt đầu sau khi nhận bài của họ, sẽ chỉ rõ đồng ý/bác bỏ/điều chỉnh theo lập luận cụ thể.

---

<!-- Append Round 2 below this boundary; do not edit Round 1. -->

## Round 2 — Phản hồi lập luận Architect và Adversarial Reviewer

- Đã đọc toàn bộ Round 1 của hai tác giả trong cùng thư mục debate.
- Vị trí tranh luận: nhận các nguyên tắc kiểm soát sai lệch, nhưng phản đối biến chúng thành bộ artifact/routing bắt buộc. Quyết định vẫn phải có owner thật; độ sâu thay đổi theo rủi ro và uncertainty.

### 1. Phản hồi các đề xuất có ID

| ID | Đánh giá | Lý do và điều chỉnh |
|---|---|---|
| A01 | Đồng ý | “Lát hành vi + quyết định còn thiếu” phù hợp moment of use hơn việc hoàn thành artifact. Nhưng sửa thành **decision checkpoint**: trước khi đi sâu, chọn quyết định cản trở nhất; nếu câu trả lời có thể đảo hướng, hỏi owner trước; nếu chỉ là chi tiết hiển thị hoặc có thể đảo ngược dễ dàng, điều tra code trước. Tránh hai lỗi: hỏi mọi thứ trước khi có evidence và điều tra sâu rồi mới phát hiện thiếu owner. |
| A02 | Đồng ý có chỉnh | Chọn hồ sơ quyết định thay pipeline artifact. Coverage checklist cần là danh sách câu hỏi kiểm tra, không phải sản phẩm bắt buộc. Nếu checklist hoàn thành mà chưa chỉ ra ai quyết phần phụ thuộc, chưa đạt Ready. |
| A06 | Đồng ý, bổ sung điều kiện dừng | Dừng khi có một phương án hợp lệ và đủ khoanh rủi ro, không khi chỉ tìm thấy reuse đầu tiên. Bổ sung tối thiểu cho claim “ít impact”: nguồn đã xem, một consumer đại diện cho shared path/caller cũ, một new-path case và phần chưa kiểm tra. Đây là bộ lọc nhỏ để tránh dừng quá sớm mà không quét workspace. |
| A08 | Đồng ý | Gom theo quyết định đúng hơn file. Chấp nhận diễn đạt lại “≤3 câu” là số câu ưu tiên trong một lượt gửi, không phải số blocker. Nếu có bốn quyết định độc lập, gửi ba ưu tiên trước và giữ câu thứ tư hiện hữu với trạng thái chờ; không gộp để đạt hạn mức. |
| A09 | Chỉnh | Hai cổng là đủ. Đổi tên cổng đầu thành **Ready-to-estimate/slice**, không dùng “Ready-to-implement”, để tránh bị hiểu là quyền tự triển khai khi owner chưa xác nhận. Ready nghĩa là phần đó đủ rõ để đưa ra phương án/kế hoạch, chưa phải thỏa mãn câu hỏi nghiệp vụ còn mở. |
| R04 | Đồng ý mạnh | Default không phải consent. Default chỉ là phương án đề xuất giúp owner quyết nhanh. Khi chưa có owner trả lời: phần phụ thuộc là proposed/blocked; agent chỉ được làm spike hoặc lát đảo ngược được và không được ghi accepted. Hết timebox chỉ tạo hành động escalate/ask/splice, không tạo quyền quyết định. |
| R06 | Đồng ý | Bỏ hard cap scenario/câu hỏi. Không giới hạn số lớp hành vi thật; chỉ giới hạn số mục gửi cùng lúc. Phân lớp theo điều kiện cần phân biệt: success, boundary, permission/state change, partial failure, compatibility; một bảng nhỏ có thể chứa nhiều ca hơn một list cứng. |
| R07 | Đồng ý nguyên tắc, chỉnh biên | Không lấy local done làm done toàn change. Tuy nhiên không bắt buộc mỗi lát phải là một giao dịch nghiệp vụ đầy đủ. Nếu tách đúng seam, tách nhánh được phép, và lát sau có thể nghiệm thu toàn bộ, lát đầu ghi rõ “not end-to-end accepted”; nếu giao dịch tổng thể không đảm bảo thì không Ready. |
| R08 | Đồng ý | Routing theo semantic, không theo file. Nhãn “UI” chỉ Fast khi điều kiện, quyền, trạng thái, contract và side effect không đổi; shared copy/component/key phải kiểm tra consumer đại diện. |
| R02 | Đồng ý | Cho đến khi canonical ownership được chốt, giữ hai nhãn rõ rệt: accepted intent và observed/verified implementation. Không dùng accepted spec làm evidence reuse. |

### 2. Trả lời trực tiếp câu hỏi gửi Problem Framer

**PF-A01:** Primary vẫn là Dev/tech lead trong moment đánh giá scope; BA xác nhận ý nghĩa nghiệp vụ. Không ép BA hiểu code: bản BA chỉ gồm mục tiêu, kết quả quan sát được, ví dụ phân biệt và câu hỏi có hệ quả. Owner nghiệp vụ phải được đặt ở đầu hồ sơ. Nếu task do BA khởi tạo chính, hồ sơ bắt đầu từ behavior examples; flow code chỉ xuất hiện sau khi ý định đủ để khảo sát.

**PF-A02:** Tách lát “lưu nội bộ” hợp lệ khi ba điều kiện cùng đúng: (1) tách không khóa quyết định nghiệp vụ còn mở; (2) có giá trị kỹ thuật/rollback rõ; (3) ghi không phải acceptance cuối. Nếu user chỉ thấy hữu ích sau khi side effect hoạt động thì đó là spike/implementation slice, không được nghiệm thu riêng như feature hoàn tất. Điều này trả lời thách thức T3 của Architect mà không ép outbox/saga cho mọi integration.

**PF-A03:** Hỏi owner trước khi điều tra sâu nếu câu trả lời có thể đổi đối tượng áp dụng, kết quả chấp nhận được hoặc phạm vi kinh doanh. Đọc code trước nếu câu hỏi kỹ thuật có thể tự giải quyết hoặc giải quyết được mà không khóa scope. Ca đảo sai hướng: thấy endpoint có tên eligibility rồi hỏi BA field có tồn tại không; ngược lại, đọc sâu API trước khi biết có nên xét theo user hay record.

**PF-A04:** Tiêu chí bác bỏ D: trên ít nhất ba task thật khác loại, D không phát hiện một uncertainty có ảnh hưởng, không giảm một câu hỏi trùng/làm lại, và chi phí hồ sơ cao hơn giải pháp đối chứng đơn giản; hoặc team vẫn chờ owner mà hồ sơ không giúp escalate đúng phần. “Ít file” không là tiêu chí.

**R06-QP:** Không cần hỏi BA khi không có hai kết quả nghiệp vụ khác nhau: sửa text cục bộ không đổi hành động; tên/key technical; layout với điều kiện hiển thị đã chốt; bug rõ với expected behavior đã có. Chỉ nâng cấp khi nhãn mới hàm ý hành động khác, shared component/translation đổi nhiều màn, accessibility/điều kiện hiển thị đổi quyền, hoặc input mô tả “UI” nhưng thực chất đổi rule.

**R04/R08-QP:** Ticket/chat hiện có phải là kênh quyết định nếu ghi đủ: nội dung, owner, phạm vi chốt và ngày. Nếu BA không đọc Markdown, hồ sơ là trace còn quyết định được sao chép ngắn vào ticket/chat; không hỏi lại trong Markdown rồi coi im lặng là đồng ý. Nếu không có kênh xác nhận, trạng thái vẫn draft/blocked.

### 3. Phản biện mitigation của Adversarial Reviewer

Không giữ mitigation mặc định refuted. Ba trạng thái supported/contradicted/unresolved đủ và trung thực hơn; trạng thái “needs decision” tách riêng để không nhầm chưa biết với đã phủ định.

Không bắt source index đầy đủ cho mọi task. Mức tối thiểu là danh sách nguồn đã đọc/phần cắt và nguồn chứa ngoại lệ ảnh hưởng quyết định. Với task low-risk, một dòng “đã xem X, chưa xem Y vì quyết định không phụ thuộc” trung thực hơn một bảng nguồn hình thức.

Không biến bảng revision thành metadata bắt buộc cho mọi dòng. Chỉ các scenario trọng yếu và claim as-is/reuse cần revision/snapshot; mọi phần khác ghi chung revision hồ sơ. Đây là mức tôi giữ, khác đề xuất nhãn everywhere của R03.

### 4. Bất đồng cần giữ

1. Không chấp nhận quy mô hồ sơ cố định theo Fast/Standard/Heavy. Nhãn chỉ là dự báo; trigger nâng cấp là sự thay đổi semantic, side effect, authority và khả năng đảo ngược. Một shared-rule một dòng có thể cần decision owner; một layout cục bộ có thể không cần BA.
2. Không chấp nhận “decision-driven” nghĩa là hỏi người trước mọi lúc. Moment đúng là trước khi commit hướng khảo sát hoặc trước khi làm phần khó đảo ngược; không phải ở mọi bước đọc code.
3. Không dùng nhiều agent đồng thuận hoặc validate pass làm bằng chứng quyền. Validate chỉ chứng minh cấu trúc check chạy; nhiều AI chỉ chứng minh cùng input cho cùng kết quả.
4. Không hạ một câu hỏi blocker thành default chỉ vì hết thời gian. Có thể làm phần độc lập, nhưng câu hỏi vẫn chờ owner.

### 5. Handoff cho người điều phối

| Quyết định | Đề xuất của Problem Framer |
|---|---|
| Giữ | Hồ sơ quyết định duy nhất; hai trục intent/evidence; hai cổng per-slice; phản biện hai chiều; routing semantic; evidence có revision cho claim quan trọng. |
| Sửa | Đổi cổng đầu thành Ready-to-estimate/slice; “≤3” thành giới hạn lượt gửi; default luôn proposed + owner + lát bị chặn. |
| Bỏ | Quota blocker/scenario cứng; routing theo số file; bản BA/spec hai nguồn; nhiều agent/panel mặc định; bảng revision cho mọi mục. |
| Defer | Canonical desired vs delivered và topology Git; dùng hai nhãn trạng thái tạm thời. |
| Tạm hoãn | Tự động hóa source index, state machine và validator tích hợp; chưa đủ bằng chứng pain lặp lại. |

Round 2 không đòi đếm phiếu. Hai điểm khác biệt thật cần người điều phối chốt: (1) tên và nghĩa cổng đầu; (2) mức revision/source index tối thiểu. Nếu hai tác giả có phản ví dụ mới, xử lý ở Round 3; không mở rộng thành một framework mới.

---
