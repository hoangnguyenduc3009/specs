# Review trọng tâm: bài toán cốt lõi và vòng làm việc mmd-sdd

- Ngày: 2026-11-15, Asia/Ho_Chi_Minh.
- Version được phản biện: v002, đặc biệt `../core-problem-and-loop.md`.
- Người phản biện: agent điều phối, lượt phân tích tiếp theo; không phải một vòng tranh luận đa agent mới.
- Trạng thái: đề xuất để xem xét; không thay đổi quyết định người dùng đã chốt hoặc tự nâng thành v003.
- Bằng chứng: đọc v002, README methodology, tổng hợp tranh luận trước và template review; kế thừa ngữ cảnh khảo sát trước nhưng không xác minh lại product runtime trong lượt này.
- Không sửa v001/v002 analysis, companion gốc, product code hoặc workflow.

## 1. Kết luận trực tiếp

**Các phân tích trước đúng về hướng nhưng lệch về trọng số.** Luồng hiện hữu, delta, reuse, impact và câu hỏi BA đã có từ đầu. Tuy nhiên, chúng bị che bởi thảo luận về artifacts, gates, trạng thái, authority, topology và công cụ trước khi có một ví dụ hoàn chỉnh cho thấy phương pháp ngăn AI đề xuất code thừa.

Không cần bỏ kết quả trước. Cần đưa phần hữu ích xuống vai trò hỗ trợ và đưa bài toán sau lên trung tâm:

> Dev nhận mô tả kết quả mong muốn nhưng AI thiếu liên kết tới hệ thống đang có. mmd-sdd phải giúp chuyển mô tả ấy thành một thay đổi có căn cứ: tận dụng gì, đổi gì, không đụng gì, vì sao và kiểm chứng thế nào.

“BA dài” là một biểu hiện, không phải nguyên nhân duy nhất. Một yêu cầu rất ngắn vẫn khiến AI code thừa nếu thiếu ngữ cảnh hiện hữu. Một BRD dài vẫn dùng được nếu có bản đồ giúp tìm đúng luồng và quy tắc. Vì vậy chỉ tóm tắt BA hoặc chỉ tạo thêm sơ đồ đều chưa đủ.

Người dùng chính là Dev đã được chốt ở `../analysis.md:7`, `../analysis.md:30`. Không mở lại quyết định đó chỉ vì review cũ còn câu hỏi về primary user.

## 2. Đánh giá các hướng đã đi

| Nhánh phân tích trước | Đánh giá với pain mới được nêu rõ | Xử lý đề xuất |
|---|---|---|
| Truy UI/API/service, flow cũ và điểm nối | Đúng trọng tâm nhất | Đưa lên phần đầu và chứng minh bằng task thật |
| Phân biệt cái có sẵn, thiếu, chưa xác minh | Đúng, nhưng còn thiếu bảng đối chiếu từng mong muốn | Biến thành nội dung bắt buộc của bản phân tích, không bắt file riêng |
| Hỏi BA bằng ví dụ phân biệt | Đúng | Hỏi điều làm đổi outcome/scope; technical fact tự tìm trước |
| Semantic reuse, caller và regression | Đúng, bảo vệ mục tiêu sửa hẹp | Giữ mức chi tiết theo rủi ro; không dùng số dòng làm bằng chứng |
| Hồ sơ theo quyết định thay vì artifact | Hữu ích nhưng quá trừu tượng nếu đứng một mình | Giữ nó như cách ghi nhận, không để thay thế flow/bản đồ thay đổi |
| Status, authority, evidence revision | Cần nhưng là rào bảo vệ | Gộp ngắn; không tiếp tục thiết kế state machine |
| Ready-to-estimate hay Ready-to-implement | Đã tốn nhiều trọng tâm cho nhãn | Nói rõ estimate có thể có khoảng chưa rõ; implement phần nào thì phần đó phải đủ rõ và được phép |
| Topology canonical, OpenSpec vs mzspec, skills | Còn sớm để làm trung tâm | Đóng gói đầu ra sau khi chứng minh phân tích có ích |
| Nhiều reviewer/agent | Có ích để tìm lỗi lập luận, chưa chứng minh hiệu quả sản phẩm | Không lấy số finding hoặc đồng thuận làm thành công phương pháp |
| Learn loop | Đúng hướng nếu học từ kết quả thực | Lưu lỗi hiểu/thiết kế và cách sửa đã được kiểm chứng, không chỉ lưu toàn bộ chat |

Nguồn đối chiếu: `../analysis.md:90`, `../analysis.md:106`, `../analysis.md:168`, `../analysis.md:199`; `../../../research/2026-11-14-agent-debate/04-synthesis.md`.

## 3. Findings trọng tâm

### CF01 — Major: thiếu cơ chế nối từng expect với phần thay đổi thực sự

- Bằng chứng: companion §1 mô tả đúng pain; §2 yêu cầu flow cũ/mới; §4 yêu cầu điểm nối. Nhưng chưa chỉ rõ cách kiểm tra một task/code mới có thực sự cần để đáp ứng một expect hay không.
- Nguồn: `../core-problem-and-loop.md:13`, `../core-problem-and-loop.md:84`, `../core-problem-and-loop.md:136`.
- Phản ví dụ: hai sơ đồ trước/sau nhìn hợp lý nhưng cả hai đều dùng một API mới do AI tự nghĩ ra; flow có node không chứng minh node đó cần mới.
- Hệ quả: hoàn thành mọi tài liệu nhưng vẫn tạo trùng service/API hoặc sửa nhầm tầng.
- Đề xuất: bảng đối chiếu tối thiểu ở §4 dưới đây; mỗi expect có hành vi hiện tại, evidence, delta và cách kiểm chứng. Task kỹ thuật phải trỏ về delta, dependency hoặc nhu cầu an toàn có lý do.
- Mức chắc chắn: khoảng trống biểu đạt được quan sát trong tài liệu; tác động là rủi ro suy luận, chưa đo bằng pilot.

### CF02 — Major: thứ tự hỏi BA -> tổng hợp -> đọc code quá cứng

- Nguồn: `../core-problem-and-loop.md:30`, `../core-problem-and-loop.md:35`, `../core-problem-and-loop.md:44`; đồng thời dòng 78 yêu cầu không hỏi BA điều có trong code.
- Vấn đề: ở bước hỏi, AI đã phải biết cái nào có/mới/reuse, nhưng bước đối chiếu code lại ở sau. Nếu hiểu cứng, agent phải hỏi BA thông tin kỹ thuật hoặc suy đoán trước khi có bằng chứng.
- Đề xuất: giữ thứ tự ý nghĩa mong muốn của người dùng, nhưng chèn một lượt định vị nông trước/trong hỏi–đáp. Chỉ cần biết feature/page/entry point và ứng viên luồng liên quan; chưa phải audit hay thiết kế sâu.
- Bản tổng hợp ban đầu là working draft; sau đọc sâu mới xác nhận phần reuse/delta. Không đợi BA trả lời mọi câu rồi mới đọc repo.
- Người dùng có thể cung cấp URL, màn hình hoặc thao tác; API là đầu mối nếu đã biết, không phải nghĩa vụ của BA.
- Mức chắc chắn: sự căng giữa thứ tự và trách nhiệm được quan sát trực tiếp; đề xuất thứ tự là phương án cần thử.

### CF03 — Major: khác biệt as-is/to-be không mặc định là conflict cần hỏi

- Nguồn: `../core-problem-and-loop.md:87` ghi “lệch expect -> conflict/Q”.
- Phản ví dụ: BA đã rõ ràng yêu cầu đổi giới hạn từ X sang Y; code vẫn là X. Đây là delta hợp lệ, không phải câu hỏi BA mới.
- Cần phân biệt: thay đổi có chủ đích; xung đột giữa các nguồn yêu cầu; hiện trạng khác lời mô tả; dữ liệu chưa đủ; lỗi cần sửa theo expected behavior đã chốt.
- Đề xuất: chỉ hỏi khi có nhiều outcome hợp lý hoặc một phát hiện làm thay đổi scope/acceptance đã hiểu. Không hỏi lại quyết định đã chốt chỉ vì code khác to-be.
- Giá trị giảm ceremony: bớt câu hỏi không cần thiết và tránh biến code cũ thành chuẩn phủ định yêu cầu mới.

### CF04 — Major: “mọi sửa đổi phải có điểm nối cũ” cần ranh giới áp dụng

- Nguồn: `../core-problem-and-loop.md:138`.
- Đồng ý với yêu cầu sửa flow đang có: phải khảo sát và chỉ rõ vùng giữ/sửa/thêm/bỏ.
- Nhưng một capability thực sự mới, thay thế flow không còn đúng, hoặc task loại bỏ hành vi không thể bị ép chứng minh reuse logic cũ. Không tìm thấy ứng viên sau khảo sát có phạm vi cũng không chứng minh toàn hệ thống không có.
- Đề xuất: với modification, nối delta vào flow cũ; với addition, nêu boundary với hệ thống đang có và phạm vi đã tìm reuse; với removal/replacement, nêu consumer và kế hoạch chuyển tiếp. Không bịa seam hoặc tạo adapter để giữ logic sai.
- Thêm “bỏ/thay thế” vào ký hiệu flow, không chỉ giữ/sửa/thêm.

### CF05 — Major: anti-overcoding mới là hướng dẫn trước code, chưa khép vòng sau code

- Nguồn: companion chuyển từ task/artifact ở bước [6] sang học sau task ở [7], `../core-problem-and-loop.md:52`; v002 có Done-with-evidence tại `../analysis.md:204`.
- Vấn đề: dù plan hẹp, lúc implement agent vẫn có thể thêm API, helper, abstraction hoặc sửa shared module ngoài dự kiến. Nếu không đối chiếu lại diff với delta, pain vẫn tái diễn.
- Đề xuất: không thêm pipeline mới; đưa một kiểm tra vào verify hiện có: mỗi thay đổi ngoài dự kiến đang phục vụ expect/delta/dependency/an toàn nào? Không giải thích được thì đánh dấu để loại hoặc xin chốt scope, không tự xóa code người khác.
- Task/file mới không tự là code thừa: có thể là test, migration hoặc refactor cục bộ cần thiết. Đánh giá lý do và semantics, không dùng quota file/LOC.

### CF06 — Moderate: “code thừa tránh được” chưa phải thước đo trực tiếp

- Nguồn: `../core-problem-and-loop.md:184`.
- Vấn đề: không biết chính xác một agent sẽ viết bao nhiêu code trong tình huống không áp dụng phương pháp. Đếm ít dòng hơn cũng có thể che tác động shared rule lớn hơn.
- Đề xuất: lưu phương án ban đầu nếu thực sự có, các phần mới được loại sau khi tìm thấy reuse, evidence dẫn đến loại, thay đổi ngoài plan và rework do hiểu sai. Không dựng một phương án cố tình phình to để chứng minh tiết kiệm.
- Tách thời gian điều tra chủ động và thời gian chờ người quyết. Số câu hỏi hoặc số diagram không là kết quả.

### CF07 — Moderate: Learn loop cần phân biệt giả định với bài học đã kiểm chứng

- Nguồn: `../core-problem-and-loop.md:108`.
- Lưu Q/changelog/review là dữ liệu thô. Agent có thể lặp lại một assumption sai nhiều lần rồi đề xuất nó thành checklist/skill.
- Mỗi bài học nên ghi: đã hiểu sai gì; evidence/decision nào sửa cách hiểu; kết quả thực tế ra sao; phạm vi áp dụng; khi nào cần xem lại.
- Phân biệt tri thức dự án dễ lỗi thời (route, field, rule theo revision) và cách hỏi/điều tra có thể dùng lại. Chỉ promote quy tắc sau review phù hợp; không tự chỉnh skill sau mỗi task.

## 4. Nội dung trung tâm còn thiếu: bảng mong muốn -> hiện trạng -> delta

Đây là một section của hồ sơ hiện có, không phải artifact mới bắt buộc.

| Mong muốn BA | Flow/node hiện có + evidence | Đã đáp ứng / delta / chưa rõ | Giữ / sửa / thêm / bỏ | Không đụng / impact cần kiểm tra | Kiểm chứng |
|---|---|---|---|---|---|
| Outcome cụ thể | Page -> handler -> API -> service, chỉ phần cần thiết | Đủ điều kiện hay thiếu semantic nào? | Chọn mức sửa và lý do | Caller/side effect cần bảo vệ | Case mới và regression liên quan |

Các nhóm kết quả có thể là:

- Đã đáp ứng: không cần implementation mới; có thể chỉ cấu hình, nội dung hoặc xác minh.
- Có cơ chế nhưng cần cấu hình/dữ liệu: task vận hành/config, không tự tạo feature mới.
- Có cơ chế gần đúng: ghi chính xác thiếu điều kiện/output/state nào, không nhận reuse theo tên API.
- Cần mới: ghi phạm vi khảo sát và vì sao các ứng viên không phù hợp; không tuyên bố đã tìm toàn workspace nếu chưa làm.
- Ngoài scope/dependency: ghi lý do và ảnh hưởng nghiệm thu.
- Chưa xác minh: trạng thái chưa biết, không biến thành “chưa có” rồi code mới.

Không ép các nhóm này thành enum/tool ngay. Mục tiêu là không để một expect đi thẳng thành một module mới mà bỏ qua khả năng có sẵn.

## 5. Vòng làm việc đề xuất sau khi sửa trọng tâm

```text
BA input
   ↓
Hiểu mục tiêu + định vị sơ bộ flow/page hiện hữu
   ↔ hỏi người dùng về outcome và đầu mối chưa tìm được
   ↓
Bản hiểu ngắn: cần gì, giữ gì, ngoài scope, unknown
   ↔ đối chiếu code có mục tiêu và sửa lại cách hiểu
   ↓
Bảng expect -> as-is -> delta -> điểm sửa / evidence
   ↓
Flow trước/sau nếu cần để thấy điểm nối; impact/reuse check
   ↔ hỏi/chốt chỉ các quyết định làm đổi outcome/scope/acceptance
   ↓
Task nhỏ hoặc artifact spec theo nhu cầu
   ↓ khi được phép implement
Đối chiếu diff với delta + kiểm chứng mới/cũ
   ↓
Lưu quyết định và bài học có kết quả thực tế
```

Không thay vòng người dùng bằng một framework mới. Các bổ sung chủ yếu là: đọc nông sớm hơn; delta rõ hơn; kiểm tra implementation không phình khỏi delta; học có căn cứ.

Estimate có thể là khoảng và kèm unknown. Trước khi implement một phần, quyết định ảnh hưởng correctness của phần ấy phải được chốt và có quyền thực hiện. Không cần thêm nhãn gate cho mỗi hộp trong sơ đồ.

## 6. Ví dụ kiểm tra phương pháp, không phải spec sản phẩm

Giả sử BA yêu cầu một lối vào mới dẫn tới danh sách đã có, chỉ lọc một nhóm và thay thông báo sau khi lưu. Không giả định trước rằng API hỗ trợ filter hoặc dữ liệu đủ.

| Bước | Câu hỏi cần giải | Kết quả có thể có |
|---|---|---|
| Định vị | Danh sách nào đang có? Entry point/caller ở đâu? | Một flow candidate, chưa kết luận reuse |
| Làm rõ | Khác biệt là lọc hiển thị hay giới hạn quyền truy cập? | Nếu là quyền, FE filter không đủ |
| Đối chiếu | Contract/filter/pagination và response hiện tại đáp ứng chưa? | Reuse nguyên, extend hẹp hoặc cần thay đổi thực |
| Delta | Phần mới là navigation, filter hay persistence? | Không tự tạo cả CRUD module |
| Impact | Caller khác có bị đổi default hay side effect không? | Giới hạn scope hoặc sửa shared có lý do |
| Verify | Flow cũ vẫn đạt điều kiện nào, flow mới đạt outcome nào? | Bằng chứng trong phạm vi, không tuyên bố toàn hệ thống |

Nếu khảo sát cho thấy hệ thống cũ không đáp ứng semantic, phương pháp phải chấp nhận code mới. Thành công là chọn phần cần thay đổi có căn cứ, không phải bắt buộc reuse.

## 7. Phần nên giữ và phần nên ngừng bàn thêm

**Giữ ở trung tâm:** mục tiêu BA; định vị flow; bảng expect/as-is/delta; điểm sửa và phần không đụng; câu hỏi có hệ quả; verify diff và regression.

**Giữ ngắn như rào bảo vệ:** quyền chốt, draft/accepted/verified, source/revision, điều kiện dừng, trạng thái chưa biết. Primary user đã chốt là Dev, không hỏi lại.

**Tạm ngừng mở rộng:** nhiều gates, tên framework, schema trạng thái, topology spec chi tiết, số reviewer, automation mining, installer và skills. Chúng không sửa trực tiếp việc AI tưởng phần đã có là phần phải tạo mới.

**Chưa làm:** tự tạo v003 hoặc thay đổi companion đã ghi user intent. Review này đề xuất chỉnh cách vận hành, không sửa lịch sử ý định người dùng.

## 8. Bước tiếp theo có giá trị nhất

Lấy một task thật có tài liệu BA và một flow hiện hữu đủ truy được. Làm đến bảng expect/as-is/delta, flow có đánh dấu thay đổi và câu hỏi còn thiếu; chưa implement. Cho Dev kiểm tra xem từng task đề xuất có thực sự cần không.

Đối chiếu kết quả với cách hiểu ban đầu nếu có: điểm nào tưởng phải xây mới nhưng đã có; điểm nào tưởng reuse được nhưng không đúng semantic; câu hỏi nào thực sự thay đổi thiết kế. Sau đó mới thử implementation có giới hạn để xem diff và regression có đúng phân tích không.

Đây là một lượt pilot cụ thể trong kế hoạch đã chốt, không phải thay thế yêu cầu thử nhiều loại task. Không cần chờ một bộ template hoàn hảo mới thử lượt đầu.

## 9. Kết luận review

- Verdict: **revise trọng tâm và vòng thao tác; không cần rethink toàn bộ phương pháp**.
- Điều chỉnh quan trọng nhất: thêm bảng đối chiếu expect/as-is/delta; cho định vị code diễn ra sớm; phân biệt delta hợp lệ với conflict; khép vòng bằng kiểm tra diff.
- Chưa thể kết luận: phương pháp đã làm giảm code thừa/rework hay không, vì chưa có kết quả pilot implementation tương ứng trong phạm vi lượt đọc này.
- Các CF01–CF07 là đề xuất của reviewer, chưa được người dùng accept/reject. Khi tạo version kế tiếp cần ghi cách xử lý, không coi việc có review là tự động chấp nhận.
