# mmd-sdd: Phân tích phương pháp phát triển dựa trên đặc tả cho Arena

- Version: v001.
- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Trạng thái: draft for review; chưa được phê duyệt.
- Nguồn chính: yêu cầu và các vòng trao đổi với người dùng, kết hợp khảo sát workspace ở lượt phân tích trước.
- Mục đích: chuyển giao đủ ngữ cảnh cho AI/người khác phản biện phương pháp.
- Không phải: spec feature Minitest, kế hoạch implement đã chốt hoặc bộ OpenSpec đã scaffold.

## 1. Tóm tắt điều cần giải quyết

Arena cần một phương pháp chuyển từ tài liệu BA sang thay đổi phần mềm có thể triển khai và nghiệm thu. Input có thể nhiều lớp, lặp, mâu thuẫn, mô tả theo UI, dùng nhiều câu "như hiện hành", thiếu contract hoặc trộn phạm vi.

Người dùng muốn phân tích có trọng tâm, gắn với các repo đang có, hiểu luồng cũ trước khi đề xuất luồng mới. Với yêu cầu sửa đổi, ưu tiên tái sử dụng hợp lý và xác định điểm nối để giảm phạm vi sửa và ảnh hưởng đến chức năng hiện hữu.

Phương pháp cũng cần tạo bản phân tích dễ trao đổi với BA và câu hỏi thực sự cần chốt, cho phép phản biện nhiều vòng. Không mặc định đề xuất ban đầu của người dùng hoặc AI là phương án cuối cùng.

**Luận điểm đề xuất:** mmd-sdd là phương pháp quản lý sự chưa rõ và sự thay đổi của yêu cầu, dựa trên bằng chứng từ hệ thống hiện hữu. OpenSpec, templates và skills chỉ đóng gói phương pháp đó.

**Mục tiêu tối ưu:** thay đổi nhỏ nhất về phạm vi ảnh hưởng mà vẫn đúng nghiệp vụ, có thể kiểm chứng và có chi phí bảo trì chấp nhận được; không phải số dòng code sửa ít nhất.

## 2. Những gì đã được yêu cầu và những gì chưa chốt

### 2.1. Định hướng từ người dùng

- Tài liệu Minitest CN4/CN5 là ví dụ để hiểu chất lượng input BA, không phải phạm vi duy nhất của SDD.
- Phân tích cần liên hệ với repo và luồng hiện tại, không chỉ viết lại BRD thành Markdown.
- Mong muốn thấy flow cũ và flow mới nối vào flow cũ như thế nào.
- Muốn giảm sửa code và giảm impact đối với yêu cầu thay đổi.
- Cần bản phân tích trọng tâm để trao đổi BA, sau đó câu hỏi trọng tâm để làm rõ.
- Cho phép xoay vòng phản biện và xây dựng ý tưởng; không buộc làm đúng cấu trúc được nêu ban đầu.
- Giai đoạn này chỉ thiết kế phương pháp và tài liệu; không sửa product code hoặc scaffold workflow nếu chưa được yêu cầu.

### 2.2. Các đề xuất chưa được phê duyệt

- Sáu hoạt động phân tích, hai vòng phản biện và mô hình hồ sơ thay đổi trong tài liệu này.
- Cấu trúc artifact, bộ skills, gate và nơi sở hữu canonical spec.
- Dùng OpenSpec làm định dạng chốt yêu cầu; dùng indexion ở giai đoạn sau nếu có ích.
- Đặt hub phương pháp/spec ở `mmd-sdd/` và cách version-control hub lâu dài.

### 2.3. Phạm vi ngoài tài liệu này

- Chốt nghiệp vụ hoặc API cụ thể của Minitest.
- Xây orchestrator, gate resolver, lifecycle hooks, task-github hoặc two-PR workflow bắt buộc.
- Chuyển đổi topology Git, migrate spec CRM hoặc triển khai hệ thống drift tự động.
- Đánh giá toàn diện bảo mật, kiến trúc hoặc test coverage của các repo.

## 3. Bối cảnh workspace và giới hạn bằng chứng

Các đường dẫn dưới đây tương đối với `area1/`.

| Khu vực | Vai trò khi phân tích yêu cầu |
|---|---|
| `website-mmd-area1` | Điểm vào UI, state/handler, API caller và hành vi tham chiếu |
| `backend-mmd-v2-area1/libs/02.eTest` | Xử lý ETEST, API, nghiệp vụ và persistence liên quan |
| `backend-mmd-v2-area1/libs/00.core` | Hạ tầng/profile dùng chung; chỉ truy khi flow phụ thuộc |
| `backend-mmd-v2-area1/libs/01.edu` | Phần EDU liên quan; không mặc định task nào cũng cần đọc |
| `backend-mmd-area1` | CRM và spec cục bộ hiện có; chỉ truy khi có dependency thực |
| `mzspec` | Nguồn tham khảo phương pháp/skills, không phải nguồn chân lý nghiệp vụ |
| `mmd-sdd` | Nơi lưu hồ sơ phân tích này; chưa là bộ workflow đã triển khai |

Khảo sát trước ghi nhận các repo có Git root riêng. Vì vậy, nên coi `area1/` là workspace nhiều repo, không giả định một commit hoặc PR chứa toàn bộ thay đổi.

Những nhận định từ code trong bản này là bằng chứng đọc tĩnh ở lượt khảo sát trước. Không có commit SHA được chốt cho bản khảo sát đó; không chạy xác minh hành vi runtime. Reviewer có workspace cần kiểm tra lại trước khi dùng chúng làm căn cứ implementation.

Không quét cả repo theo mặc định. Bắt đầu từ hành vi và truy đường đi liên quan:

```text
UI entry → handler/state → API client → route/validation
         → service/business rule → dữ liệu/dependency → response/UI
```

Mỗi lần mở rộng phạm vi phải trả lời một câu hỏi về yêu cầu, phương án hoặc impact. Nếu không có câu hỏi đó thì dừng.

## 4. Chẩn đoán vấn đề input BA

Không nên coi mọi khoảng trống là lỗi của BA. Tài liệu BA và tài liệu triển khai phục vụ các mức chi tiết khác nhau. Cần một bước chuyển hóa, không ép BA viết toàn bộ thiết kế kỹ thuật.

| Dạng vấn đề | Hệ quả nếu đưa thẳng vào code | Cách xử lý đề xuất |
|---|---|---|
| Nhiều nguồn, export, nội dung lặp | Không biết nội dung nào có hiệu lực | Source map, revision và quyết định ưu tiên nguồn |
| Mâu thuẫn giữa tổng quan/CN/AC/UI | Dev/AI tự chọn cách hiểu | Conflict log, ví dụ phân biệt, owner chốt |
| "Như hiện hành" | Phụ thuộc trí nhớ hoặc đoán | Chuyển thành hành vi cụ thể kèm evidence |
| Mô tả thiên về UI | Đúng màn hình nhưng sai quy tắc | Tách actor, điều kiện, trạng thái và kết quả |
| EC thiếu contract | Không xác định được nguồn dữ liệu/fallback | Làm rõ subject, source of truth, lỗi và quyền |
| Không chỉ ra hệ thống sở hữu | Đặt logic sai nơi, thiếu dependency | Truy flow và phân định owner |
| Scope lẫn prerequisite và việc liên quan | Task phình hoặc nghiệm thu thiếu | Phân loại In/Out/Dependency/Prerequisite |
| AC chỉ là một số ví dụ | Bỏ sót tổ hợp và ranh giới | Decision table, state model, scenario phù hợp |
| Quyết định nằm trong chat | BA/spec/code/test khác phiên bản | Ghi quyết định và liên kết các phần bị ảnh hưởng |

Không đặt quy tắc "tài liệu mới hơn luôn thắng" hoặc "AC luôn thắng mô tả" nếu chưa được thống nhất. Code là bằng chứng hiện trạng, không tự có quyền phủ định yêu cầu tương lai.

## 5. Phương pháp đề xuất

Kết hợp ba cách làm: phân tích luồng hiện hữu bằng code evidence; phân nhóm story/rule/example/question để trao đổi; tìm ranh giới thay đổi thích hợp để giảm ảnh hưởng.

Đây là tổ hợp được đề xuất cho Arena, không phải khẳng định một tiêu chuẩn duy nhất đúng cho mọi team. Các tên phương pháp không thay thế việc thử nghiệm quy trình với task thực tế.

### 5.1. Sáu hoạt động

| Hoạt động | Câu hỏi cần trả lời | Kết quả tối thiểu |
|---|---|---|
| 1. Khoanh vấn đề và nguồn | Người dùng cần kết quả gì? Nguồn nào đang có hiệu lực? | Mục tiêu, phạm vi, source map |
| 2. Truy hiện trạng | Luồng đang làm gì? Đã đáp ứng được phần nào? | Flow cũ và evidence có giới hạn rõ |
| 3. Chuẩn hóa và tìm delta | Quy tắc nào giữ/thêm/sửa/bỏ? Chỗ nào mâu thuẫn? | Behavior delta, ví dụ và câu hỏi mở |
| 4. Đề xuất điểm sửa | Nối vào đâu? Còn phương án nào ít impact hơn? | Phương án, trade-off, blast radius |
| 5. Phản biện và chốt | Ai quyết định điều gì? Phần nào đã đủ rõ? | Quyết định, scenario và contract đủ dùng |
| 6. Triển khai và khép vòng | Đã đáp ứng và bảo toàn luồng cũ chưa? | Code/test/evidence và baseline được cập nhật |

Các hoạt động có thể quay lại, không bắt buộc sáu tài liệu hoặc sáu vòng duyệt.

### 5.2. Luồng tổng thể

```text
BA input
   ↓
Khoanh vấn đề → truy flow hiện hữu → xác định delta
                                      ↓
                       Đề xuất cách sửa + câu hỏi trọng tâm
                                      ↓
                            Phản biện BA / Dev / QA
                              /                 \
                         Chưa rõ             Đủ rõ một lát
                            │                     ↓
                  quay lại phần liên quan     Chốt delta spec
                                                  ↓
                                          Code + kiểm chứng
                                                  ↓
                               Giả định sai? → mở lại quyết định
                                                  ↓ nếu đạt
                                        Cập nhật baseline
```

Không cần chốt toàn bộ tương lai của feature trước khi làm một lát độc lập. Nhưng không được lấy việc một lát hoàn tất làm bằng chứng cả phạm vi đã xong.

### 5.3. Phân loại thông tin

- Yêu cầu: điều stakeholder muốn hệ thống làm.
- Hiện trạng: điều có bằng chứng từ code, test hoặc runtime.
- Giả định: điều chưa xác nhận nhưng đang dùng để suy luận.
- Quyết định: lựa chọn đã được người có thẩm quyền chốt, có lý do.
- Câu hỏi mở: điều chưa biết, owner và ảnh hưởng nếu chưa trả lời.

Không dùng ngôn ngữ chắc chắn để che một giả định. "Có endpoint" khác với "contract đáp ứng yêu cầu"; "đọc thấy code" khác với "đã xác minh trên môi trường chạy".

## 6. Flow cũ, flow mới và điểm nối

### 6.1. Nguyên tắc biểu diễn

- Flow cũ chỉ vẽ tới mức giúp quyết định thay đổi, không phải sơ đồ toàn hệ thống.
- Flow mới giữ cùng tên/ID node để thấy phần tái sử dụng.
- Đánh dấu rõ giữ nguyên, điều chỉnh, thêm, bỏ và chưa xác minh.
- Nếu vấn đề nằm ở trạng thái, dùng state transition; nếu nhiều điều kiện, dùng decision table. Không ép mọi thứ thành sequence diagram.
- Ghi evidence cho node quan trọng và caller ngoài flow có thể bị ảnh hưởng.

### 6.2. Ví dụ minh họa phương pháp

Đây là flow giả định để minh họa, không phải mô tả đã xác minh của feature Arena.

```text
HIỆN TẠI
[A] Thao tác → [B] FE payload → [C] API → [D] Xử lý/lưu
                                              ↓
                                      [E] Response → [F] UI chung

ĐỀ XUẤT
[A] → [B] → [C] → [D] → [E]                  GIỮ NGUYÊN
                         ↓
                  [X] Xác định ngữ cảnh        THÊM
                     /            \
              Trường hợp cũ    Trường hợp mới
                   ↓                ↓
              [F] UI cũ         [G] UI biến thể
              GIỮ NGUYÊN       THÊM/ĐIỀU CHỈNH
```

Nếu response chưa đủ dữ liệu cho X, mới khảo sát mở rộng contract. Nếu quy tắc cần bảo vệ nghiệp vụ ở backend, không coi nhánh FE là đủ chỉ vì ít sửa code.

| Điểm | Hiện tại | Mong muốn | Cách xử lý | Hành vi cần giữ |
|---|---|---|---|---|
| Ngữ cảnh | Chưa phân biệt | Một nhóm có hành vi khác | Dùng dữ liệu sẵn có hoặc mở rộng có kiểm soát | Nhóm cũ không đổi |
| Xử lý chính | Đã đáp ứng | Không đổi | Reuse | Không đổi side effect |
| Hiển thị | Một dạng | Thêm biến thể | Nhánh hẹp ở UI nếu đúng trách nhiệm | UI cũ vẫn hoạt động |

## 7. Nguyên tắc giảm impact

Thứ tự khảo sát phương án, không phải luật bắt buộc:

```text
Cấu hình/dữ liệu hiện có → reuse nguyên luồng → mở rộng ở ranh giới rõ
  → refactor cục bộ tạo ranh giới → thành phần/luồng mới nếu cần
```

Với thay đổi không hiển nhiên, so sánh tối đa 2-3 phương án theo:

- Đúng nghiệp vụ và xử lý ngoại lệ.
- Phạm vi caller, shared component và dữ liệu bị ảnh hưởng.
- Tương thích với contract và hành vi cũ.
- Khả năng test độc lập và regression.
- Chi phí bảo trì, duplicate logic và các nhánh đặc biệt.
- Rủi ro rollout/rollback nếu thay đổi dữ liệu hoặc tích hợp.

Các phản ví dụ cần giữ trong review:

- Một `if` vài dòng trong service dùng chung có thể impact lớn hơn một adapter dài hơn ở điểm vào riêng.
- Copy nguyên flow để tránh sửa code cũ có thể tạo hai nguồn logic lệch nhau.
- Tái sử dụng API có cùng tên gần đúng nhưng khác semantic có thể làm sai nghiệp vụ.
- Khóa cứng vào luồng cũ có thể giữ lại lỗi hoặc ngăn yêu cầu hợp lệ; cần tách lỗi cũ khỏi scope, nhưng không giả vờ đã đáp ứng.

"Ít impact" phải đi kèm danh sách luồng cần giữ và cách kiểm chứng, không chỉ số file hoặc số dòng diff.

## 8. Bản phân tích trao đổi BA và câu hỏi trọng tâm

### 8.1. Không sinh BRD thay thế nguồn gốc

Đề xuất tạo một bản phân tích để xác nhận với BA. Trước khi BA chốt, đây là cách hiểu và đề xuất, không phải nguồn yêu cầu có thẩm quyền mới.

Bản này gồm:

1. Mục tiêu, In/Out, dependency và prerequisite.
2. Hiện trạng liên quan bằng ngôn ngữ nghiệp vụ, flow cũ ngắn.
3. Thay đổi đề xuất, điểm nối flow mới và hành vi giữ nguyên.
4. Ví dụ nghiệm thu: thông thường, ranh giới và lỗi quan trọng.
5. Những quyết định cần xác nhận.

File/function/API chi tiết nằm ở phần kỹ thuật hoặc phụ lục. BA không cần duyệt kiến trúc repo để xác nhận một quy tắc nghiệp vụ.

### 8.2. Câu hỏi phải dẫn tới quyết định

```text
Q-ID / tiêu đề
Nguồn và phát biểu đang chưa rõ:
Ví dụ cụ thể phân biệt các cách hiểu:
Các cách hiểu/phương án:
Đề xuất và lý do, nếu có:
Ảnh hưởng nghiệp vụ/implementation/nghiệm thu:
Owner cần chốt:
Chặn phần nào, không chặn phần nào:
Trả lời, người chốt, ngày và requirement liên quan:
```

Ví dụ: thay vì hỏi "điều kiện này là gì?", đưa trường hợp người dùng thuộc nhóm A nhưng giao dịch không thuộc nhóm A và hỏi quy tắc áp dụng theo đối tượng nào. Đây là ví dụ giả định, không phải quy tắc đã chốt trong Arena.

### 8.3. Không chuyển câu hỏi kỹ thuật sang BA

| Loại chưa rõ | Người xử lý |
|---|---|
| Mong muốn, chính sách, phạm vi nghiệp vụ | BA/PO/người sở hữu nghiệp vụ |
| Field/API/hành vi hiện có | Dev/agent tự điều tra trước |
| Phương án kỹ thuật, ranh giới trách nhiệm | Tech owner; hỏi Product nếu ảnh hưởng sản phẩm |
| Kỳ vọng nghiệm thu và dữ liệu kiểm thử | QA phối hợp BA và Dev |

Không hỏi BA điều có thể tự xác minh trong repo. Cũng không tự quyết định một fallback nghiệp vụ chỉ vì implementation thuận tiện.

## 9. Hai vòng phản biện

### 9.1. Vòng A: làm rõ bài toán

Đọc yêu cầu → tìm hiện trạng → dựng ví dụ phân biệt → chốt nghiệp vụ → cập nhật cách hiểu.

Câu hỏi phản biện:

- Đang giải nhu cầu hay chỉ làm đúng mô tả màn hình?
- Có phát biểu nào cho phép hai cách hiểu khác nhau?
- Giả định nào chưa được ai chốt?
- Phần tưởng mới có sẵn chưa?
- Scope có bị kéo sang task phụ thuộc không?

### 9.2. Vòng B: làm nhỏ phương án sửa

Đề xuất điểm nối → kiểm tra caller/dependency → phản biện impact → chọn phương án → xác định test bảo vệ.

Câu hỏi phản biện:

- Vì sao phải sửa điểm này?
- Reuse có giữ đúng semantic không?
- Ai khác đang dùng logic này?
- Có đang chuyển rủi ro vào shared component?
- Test nào chứng minh hành vi cũ không đổi ngoài ý muốn?

Hai vòng không đòi hỏi nhiều agent hay tự động hóa. Chỉ cần các góc nhìn được áp dụng rõ ràng. Không dùng số lượng AI đồng ý thay cho người có thẩm quyền hoặc bằng chứng.

### 9.3. Điều kiện dừng

Đủ để triển khai một lát khi mục tiêu/phạm vi rõ; flow liên quan có evidence; quy tắc có ví dụ phân biệt đúng/sai; phương án và phần cần bảo toàn rõ; không còn blocker cho lát đó; có cách kiểm chứng.

Nếu câu hỏi chặn không thể tự giải quyết, ghi owner và quyết định cần có rồi dừng phần phụ thuộc. Không lặp vô hạn hoặc tự điền đáp án. Phần độc lập có thể tiếp tục nếu không khóa cứng quyết định còn mở.

## 10. Artifacts và độ nhẹ

Đề xuất một hồ sơ thay đổi duy nhất, có góc đọc BA và kỹ thuật; không tạo hai bộ tài liệu cùng sở hữu một yêu cầu.

| Thông tin | Nơi đặt nếu dùng OpenSpec | Khi nào cần |
|---|---|---|
| Mục tiêu, phạm vi, thay đổi chính | `proposal.md` | Thay đổi có ý nghĩa hành vi |
| Flow cũ/mới, evidence, phương án, impact | `design.md` | Khi cần lý giải cách sửa |
| Câu hỏi và quyết định | Mục trong tài liệu hoặc `clarifications.md` | Chỉ tách file khi đủ phức tạp |
| Quy tắc và scenario đã chốt | Delta `specs/` | Phần hành vi được cam kết |
| Công việc và cách kiểm chứng | `tasks.md` | Khi đi vào triển khai |
| Kết quả test/review và revision | Mục evidence hoặc file riêng | Khi cần chứng minh đã hoàn thành |

Đây là ánh xạ đề xuất, không phải scaffold đã được tạo. Nếu dùng workflow OpenSpec cụ thể, cần kiểm tra schema thực tế trước khi áp dụng quy tắc lược bớt artifact.

| Loại task | Độ sâu phù hợp |
|---|---|
| Copy/UI không đổi nghiệp vụ | Yêu cầu ngắn, điểm chạm, kiểm chứng trực quan/chức năng |
| Thay đổi rule | Rule, decision table hoặc scenario, impacted callers và test |
| Thay đổi vòng đời/tích hợp | Thêm state, contract, partial failure và dependency |
| Dữ liệu nhạy cảm hoặc migration | Thêm compatibility, migration, rollout/rollback và kiểm chứng dữ liệu |

Không bắt typo hoặc refactor thuần nội bộ đi qua toàn bộ ceremony. Nếu không đổi hành vi thì vẫn cần review/test phù hợp, nhưng không nhất thiết có một bộ spec mới.

## 11. Gates và liên kết tối thiểu

```text
Nguồn → Requirement → Quyết định → Implementation → Bằng chứng
```

- Ready: đủ rõ cho phần sắp làm; owner và blockers được ghi nhận.
- Spec: hành vi và scenario nhất quán; validate định dạng nếu dùng công cụ.
- Implementation: test/evidence tương ứng phần thay đổi và luồng cần bảo toàn.
- Complete: phần giao thực sự hoàn tất, revision và dependency được ghi, canonical spec phản ánh điều đã giao.

Validate Markdown/OpenSpec không chứng minh code đúng nghiệp vụ. Test một suite không liên quan không chứng minh requirement được đáp ứng. Chưa biết lệnh test hợp lệ thì ghi là khoảng trống cần xử lý, không tự giả định tên target.

Khi code cho thấy giả định sai: đánh giá ảnh hưởng, mở lại quyết định liên quan rồi cập nhật spec/test/code. Không sửa spec theo code chỉ để làm mất dấu drift.

## 12. Ví dụ từ khảo sát: chỉ dùng để kiểm tra phương pháp

Các ví dụ này không biến Minitest thành thiết kế trung tâm của phương pháp.

| Quan sát từ lượt đọc trước | Bài học phương pháp | Nguồn workspace |
|---|---|---|
| API danh sách bộ đề chọn bộ dựa trên danh sách đề tìm được | "Có API" chưa bảo đảm phân biệt bộ rỗng và bộ không tồn tại | `backend-mmd-v2-area1/libs/02.eTest/src/services/test-sets/test-set.service.ts`, `getListTestSets` |
| Tạo/cập nhật record và enqueue AI có route riêng | Cần tách thành công lưu bài và thành công bước tích hợp tiếp theo | `backend-mmd-v2-area1/libs/02.eTest/src/controllers/examination-record/examination-record.controller.ts` |
| EC diễn đạt lẫn học viên và bài làm thuộc danh sách lớp | Phải chốt subject của rule trước khi chọn field/API | `backend-mmd-v2-area1/docs/sp-tiem-nang/mini-test/1.2-ket-qua-mini-test.md` |
| Có runner test với danh sách file ghi cứng | Test sẵn có không tự chứng minh coverage cho feature mới | `backend-mmd-v2-area1/libs/02.eTest/test/run-tests.js` |

Các kết luận cần kiểm tra trên code revision hiện tại trước khi dùng cho triển khai. Tài liệu chưa chứng minh toàn bộ đường auth, dữ liệu runtime, test coverage hoặc readiness của các flow liên quan.

## 13. Rủi ro của chính phương pháp

| Rủi ro | Cách giảm đề xuất |
|---|---|
| Phân tích quá nhiều, không đến quyết định | Timebox theo task; mỗi lượt đọc phải trả lời câu hỏi cụ thể |
| Bám luồng cũ đến mức giữ thiết kế sai | Đánh giá semantic, correctness và chi phí dài hạn trước số dòng sửa |
| Sinh nhiều tài liệu trùng nhau | Một hồ sơ, một nơi sở hữu mỗi quyết định; bản BA là góc đọc |
| AI tự giải quyết xung đột | Ghi assumption và owner; không tự nâng thành accepted requirement |
| Câu hỏi quá dài hoặc không đúng người | Ưu tiên câu hỏi làm đổi quyết định, kèm ví dụ và ảnh hưởng |
| Sơ đồ trông chắc chắn nhưng chỉ suy luận | Ghi loại evidence và phần chưa xác minh |
| Review nhiều vòng không có điểm dừng | Dùng điều kiện Ready; tách phần độc lập và phần bị chặn |
| Agent gọi mọi thứ là best practice | Yêu cầu trade-off, phản ví dụ và bằng chứng áp dụng tại Arena |
| Quy trình nhẹ dần biến thành factory | Chỉ tự động hóa điểm đau lặp lại đã quan sát được |

## 14. Cách thử phương pháp trước khi đóng gói

1. Chọn vài task khác loại: UI thuần, đổi rule dùng chung, tích hợp có lỗi một phần. Minitest chỉ là một mẫu bổ sung.
2. Áp dụng thủ công hồ sơ phân tích ngắn; ghi thời gian và câu hỏi thực sự tạo ra quyết định.
3. Phản biện với BA/Dev/QA: phần nào giúp hiểu đúng, phần nào thừa hoặc thiếu.
4. Theo dõi số giả định quan trọng được phát hiện sớm, rework do hiểu sai, khả năng truy requirement tới test và thời gian đến Ready.
5. Chỉnh phương pháp rồi mới đóng gói template/skills/OpenSpec workflow.
6. Chỉ thử drift tooling ở giai đoạn sau, advisory trước; không coi điểm similarity là bằng chứng đúng nghiệp vụ.

Không đặt chỉ tiêu số lượng tài liệu hoặc số câu hỏi. Nhiều tài liệu hơn không đồng nghĩa hiểu rõ hơn.

## 15. Các điểm cần AI/người khác phản biện

1. Phương pháp có đang giải đúng bài toán input BA của Arena hay bị nặng về phân tích kỹ thuật?
2. Sáu hoạt động và hai vòng phản biện có phần nào trùng, có thể gộp hoặc bỏ?
3. Mức evidence nào đủ để gọi một flow là baseline mà không phải chạy toàn hệ thống?
4. Cách nào giới hạn điều tra code khi dependency rộng hoặc repo thiếu test?
5. Làm sao ưu tiên câu hỏi BA mà không bỏ sót một ngoại lệ quan trọng?
6. Khi nào nên reuse, mở rộng, refactor hoặc tạo mới? Có cần tiêu chí cụ thể hơn không?
7. Hồ sơ thay đổi có tránh được hai nguồn chân lý BA/spec không?
8. Ready/Complete hiện đủ rõ để tránh vòng lặp và nghiệm thu giả chưa?
9. Canonical spec nên sở hữu theo capability xuyên repo hay theo repo? Cơ chế tham chiếu tối giản nào phù hợp?
10. Có phương án nhẹ hơn nhưng vẫn giữ được evidence, quyết định và regression protection không?

## 16. Kết luận đề xuất của v001

Ưu tiên vòng làm việc: hiểu flow cũ → xác định delta nghiệp vụ → tìm điểm sửa hẹp → dựng ví dụ → hỏi đúng owner → chốt spec → code và bảo vệ regression.

Ba nguyên tắc ứng viên:

1. Không đề xuất code mới trước khi khảo sát khả năng tái sử dụng liên quan, với phạm vi điều tra hợp lý.
2. Không tự biến giả định nghiệp vụ thành quyết định.
3. Không tuyên bố ít impact nếu chưa chỉ ra hành vi cần giữ và cách kiểm chứng.

Chưa chốt template cuối cùng, skills, cấu hình OpenSpec, hub ownership hoặc automation. Bước tiếp theo là phản biện tài liệu này và thử phương pháp trên nhiều loại task, không tự động scaffold.

## 17. Lịch sử phiên bản

v001 tổng hợp các vòng trao đổi ban đầu. Điều chỉnh trọng tâm so với hướng phân tích đầu tiên: từ thiết kế pilot Minitest và cấu trúc OpenSpec sang phương pháp tổng quát dựa trên luồng hiện hữu, làm rõ yêu cầu và giảm impact. Chưa có review ngoài được tổng hợp.
