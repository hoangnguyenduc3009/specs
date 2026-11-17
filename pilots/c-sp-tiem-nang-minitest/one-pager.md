# Phân tích thay đổi: Minitest

- Change-Id: `c-sp-tiem-nang-minitest`
- Ngày / người phân tích: 2026-11-15 (Asia/Ho_Chi_Minh) / Codex.
- Skill: `mmd-ba-clarify@0.1.0` (vai trò analyze-change; playbook người yêu cầu cung cấp).
- Run: `run-20261115-c-sp-tiem-nang-minitest-01` (+ `run-02` Figma, `run-20261116-c-sp-tiem-nang-minitest-03` quyết định `targetType`).
- Bổ sung nguồn thiết kế: `run-20261115-c-sp-tiem-nang-minitest-02` (2026-11-15); chưa đọc được nội dung Figma.
- Trạng thái: **cần làm rõ**, chưa Dev/BA duyệt toàn bộ; đã chốt hướng discovery `targetType=minitest` (PO/chat, chưa Dev review); chỉ phân tích, không implement, không tạo OpenSpec change.

## Nguồn và baseline

Đường dẫn trong hồ sơ tính từ workspace `area1/`; ký hiệu FE, BE2, CRM dưới đây chỉ là tiền tố đường dẫn, không phải service mới.

| Ký hiệu | Repo / revision đã đọc | Local tại thời điểm phân tích |
|---|---|---|
| FE | `website-mmd-area1` @ `319a546de091a3d24d78c47d8eeca2445e21a555` | Clean |
| BE2 | `backend-mmd-v2-area1` @ `39e5f629778900f73e583f0f54343b0ddabb6fc2` | `docs/sp-tiem-nang/mini-test/` untracked, là nguồn BA của phiên này; không đồng nhất với nội dung commit |
| CRM | `backend-mmd-area1` @ `053576190468b67fea1e118b8ab1b9c2e98d87f7` | Clean |
| Hub | `mmd-sdd/` | Không nằm trong Git repository tại workspace này; không có revision để ghi |

- **CN4**: `backend-mmd-v2-area1/docs/sp-tiem-nang/mini-test/1.1-menu-thi-thu-va-mmini-test.md`, tiêu đề nội dung “2.1. Menu Thi thử và Minitest ... CN4”; SHA-256 `3a35e07dfcd91d0aa33c260baa9df59d9fd05376b4d5aeb47b66ba0e75f560a8`.
- **CN5**: `backend-mmd-v2-area1/docs/sp-tiem-nang/mini-test/1.2-ket-qua-mini-test.md`, tiêu đề nội dung “2.2. Kết quả Minitest ... CN5”; SHA-256 `2fb276c67db38886d35c33c5da68f20f9e7926717624d639f0490b1eb5863ec5`.
- Không có số phiên bản BA ngoài CN4/CN5. Đọc bản Markdown local; chưa đối chiếu ảnh Notion/Figma hay bản online. Dùng bảng DOD/quy tắc/AC/EC làm căn cứ, không suy diễn layout từ ảnh chưa xem.
- **Figma người yêu cầu cung cấp ngày 2026-11-15:** `https://www.figma.com/design/uNoQTgx66bOtICeeAK7Pel/Khoa-hoc-video?node-id=221-2&p=f&t=mLWsqChYZeOnxyIg-0` — file key `uNoQTgx66bOtICeeAK7Pel`, node `221:2`. Đây là nguồn thiết kế cần đối chiếu, chưa phải bằng chứng đã đọc. Web open không trả nội dung dùng được; không có connector Figma được expose, MCP resources/templates rỗng và browser runtime trả `No browser is available` (danh sách browser rỗng). Chưa xác định nguyên nhân truy cập Figma hay kết luận file bị private.
- **Đối chiếu Figma còn chờ:** tìm frame tương ứng H5/H6 (menu/bộ đề), H7.1/H7.2, H7.1a/b/c, H7.2a/c và H9/CN6 nếu có; ghi node thực tế cho từng frame, so nút/nhãn/điểm/band/absent skill/CTA/back-resume với D1–D8, rồi cập nhật Q1–Q7 khi thiết kế có bằng chứng giải đáp. Chưa biết node `221:2` chứa những frame nào; không coi ảnh tĩnh là bằng chứng của predicate lớp học, scoring hay runtime. Cần trình duyệt kết nối có quyền xem hoặc bản export PDF/ảnh các frame liên quan để tiếp tục.
- Đọc thêm boundary CN6: `backend-mmd-v2-area1/docs/sp-tiem-nang/lich-hen/1.1-dat-lich-tu-van.md` phần liên quan, `lich-hen/backend-api.md` và code appointment thực tế; tài liệu tích hợp không thay thế bằng chứng code.
- Đã đọc hướng dẫn repo và template/learning của hub. `backend-mmd-area1/AGENTS.md` yêu cầu graph-first; phiên này không có tool code-review-graph, danh sách MCP resources/templates đều rỗng, nên fallback tìm kiếm/đọc code. Không tuyên bố đã trace bằng graph.

**Mức bằng chứng:** `observed` = đọc code tại revision trên; `proposed` = hướng sửa cần duyệt; `unknown` = chưa đủ fact. **Chưa có verified bằng test/runtime**; không gọi API thật, không chạy DB/queue/email, không chạy test sản phẩm.

## Mục tiêu và phạm vi

- Kết quả: học viên tìm đúng bộ Minitest, làm đề không bắt buộc đủ bốn kỹ năng, nhận màn nộp/kết quả phù hợp kỹ năng và đặt lịch CN6 khi đúng điều kiện.
- In: menu Thi thử; nhận diện bộ Minitest; danh sách đề công khai + active; routing vào màn làm bài hiện hành; H7.1/H7.2 và năm màn sau lựa chọn; band/điểm hiển thị; draft/resume; AI bất đồng bộ + thông báo hiện hành; CTA và prefill CN6; giữ bài làm cho consumer hiện có.
- Out: viết lại engine làm/chấm bài, AI provider mới, hệ thống thông báo mới, triển khai lại CN6/lịch hẹn hoặc CN9 Sale, thay toàn bộ rule full-test/LMS/appointment, migration dữ liệu diện rộng. Không gắn đề Minitest vào `web-supplement` hay nới global `list-exam-skill`.

## Quyết định kỹ thuật (draft, chưa Dev duyệt)

- **Nguồn:** PO/chat **2026-11-16** (`run-20261116-c-sp-tiem-nang-minitest-03`).
- **`targetType`:** thêm giá trị string **`minitest`** (`TargetTypeQuestion` / `TargetTypeEtestQuestion` trên examination, skill-test-set, question bank khi import/CRUD). Đề thuộc luồng Minitest **không** dùng `web-supplement`.
- **Discovery BE:** API **clone** `POST …/test-sets/get-list-test-sets` (tên đề xuất `get-list-minitest-test-sets` hoặc tương đương) — cùng semantics embed `examinations`, filter `isPublic` + `status=ACTIVE` + `targetType: ['minitest']`, **không** gate đủ bốn kỹ năng; **không** đổi handler `get-list-test-sets` hiện tại cho `web-supplement`.
- **Tùy chọn:** clone `list-exam-skill` bỏ filter đủ L/R/W/S chỉ trong nhánh `minitest` nếu caller học viên dùng list theo examination + progress thay vì nested list trong test-set.
- **Phân quyền admin (đề xuất):** key HRM `etest-minitest` map string `minitest` (pattern `etest-web-supplement`).
- **Setting ETEST:** thêm `minitest` vào `submitTargetTypes` / `aiGradeTargetTypes` khi triển khai dữ liệu, trừ khi Q3 chốt override hoàn toàn ở FE.
- **Không thay thế nhận diện bộ đề:** entity `test-sets` không có `targetType`; menu “bộ Minitest” vẫn cần tên/ID cấu hình (phần còn mở của Q1).

## Evidence index — hiện trạng đã trace

### E1. Bộ đề và danh sách không cùng semantics

- `BE2/libs/02.eTest/src/entities/test-sets/test-set.entity.ts:7`, `TestSetEntity`: có name/status/order/level; không thấy marker Minitest chuyên biệt trong entity này. CRUD bộ đề đã tồn tại ở `controllers/test-sets/test-sets.controller.ts`; FE admin ở `FE/apps/etest/src/packages/TestSets/components/FormMutation/FormMutation.tsx` (đã xác định vị trí, chưa audit form).
- `BE2/libs/02.eTest/src/services/test-sets/test-set.service.ts:114`, `getListTestSets`: lấy đề `deleted != true`, `isPublic=true`, `status=ACTIVE`, `targetType` có `WEB_SUPPLEMENT`; lấy bộ đề từ ID của các đề đó. Bộ đề không có đề hợp lệ bị loại khỏi response. Đề sắp `order:1`; bộ đề dùng options caller. Không có kiểm tra đủ bốn kỹ năng ở hàm này.
- `BE2/libs/02.eTest/src/services/examinations/examinations.service.ts:751`, `getListExamSkill`: tìm skill-test-set theo examinationId + target WEB_SUPPLEMENT, chỉ nhận examination có **đủ L/R/W/S**. Status skill-test-set đang không được filter (comment BA cũ). Query examination cuối thêm `buildQuery` và deleted, không hard-code public/active. Response còn gắn skillTestSets, parts, lịch sử bài làm của current user và progress, không chỉ danh sách đề.
- API tương ứng: `controllers/test-sets/test-sets.controller.ts:56` (`POST get-list-test-sets`) và `controllers/examinations/examinations.controller.ts:192` (`POST list-exam-skill`). Wrapper FE: `FE/libs/cms/src/services/etest/test-sets/test-sets.service.ts:32`, `FE/libs/cms/src/services/etest/examinations/examinations.service.ts:59`.
- **Unknown caller trang học viên:** tìm `getListTestSets`, `getListExamSkill`, endpoint literals, `practice_test`, “Thi thử”, Minitest trong FE apps/libs và toàn repo TS/TSX chỉ tìm được wrapper/locales/admin/report, chưa thấy caller menu/danh sách học viên. `FE/libs/cms/src/packages/ETestEntryTestBank/utils/getLinkETestByEnv.ts:3` trả về host etest riêng. Đây là dấu hiệu boundary, không chứng minh repo ngoài có flow gì. Không kết luận menu chưa tồn tại; chưa đủ repo để chỉ định file sửa CN4 frontend.

### E2. Màn nộp dùng chung và config AI

- `FE/libs/cms/src/packages/ETestEntryTestBank/components/Preview/components/ModalSubmitTest.tsx:124`: danh sách kỹ năng từ `formValues.listSkill`, phân W/S; nút hiện hành là “Nộp bài”, AI và draft. `canSubmitNormally = !hasWritingOrSpeaking || allowNormalSubmit === true`; AI có gate `allowAiGrade`; draft phụ thuộc `donSaveDraff`.
- `FE/apps/etest/src/packages/SettingEtest/utils/getAiGradeSubmissionOptions.ts:12`: config theo target, không theo bộ đề. Thiếu config/không match trả undefined; với W/S, modal có thể không có nút nộp thường. Không thể chỉ đổi label và coi đã đạt ba nút H7.1.
- Caller chính đã đọc: `FE/apps/etest/src/routes/TakeComputerBasedEntryTest/src/_take-computer-based-entry-test.$entryTestId.doing-test-view-idp.tsx:95` load đề qua `getPublicExamination` hoặc `getPublicExaminationFull` theo typePractice; `:288` lấy AI options; `:625` create/update record; `:955` truyền options xuống preview. Route thường `...$entryTestId.doing-test.tsx` cũng dùng helper; appointment và LMS có route riêng cùng dùng helper. Phải scope Minitest, không sửa global để áp lên mọi consumer.

### E3. Lưu bài, chấm L/R, parent/child và side effects

- `FE/libs/cms/src/services/etest/examination-record/examination-record.service.ts:240`: create/update ETEST gọi `POST examination-record/e-test`, `PATCH examination-record/e-test/:id`; khác method generic có thể route qua Sale.
- `BE2/libs/02.eTest/src/controllers/examination-record/examination-record.controller.ts:99`, `createETest`: khi examinationDetail có nhiều hơn một section, tạo parent rồi child theo recordSection, map skillTestSet theo kỹ năng. **Child L/R bị đặt COMPLETED cả khi parent gửi IN_PROGRESS**. `:198` updateETest gọi update service, không lặp tạo/cập nhật children như create.
- `BE2/libs/02.eTest/src/services/examination-records/examination-record-etest.service.ts:183` và `:2270`: chấm section, tổng hợp `resultReview`, trả record + kết quả tính ngay; enqueue cập nhật record và learning progress. Event TAKE_TEST_AND_SUBMIT chỉ khi statusExercise COMPLETED ở lời gọi service đó; vì controller ép child L/R completed nên không được mặc định draft không gây side effect.
- `buildResultReview` tại `:1020`: `correctAnswer` là số đúng; `points` là điểm; `totalQuestion` lấy answeredQuestions, `totalQuestionExam` lấy totalQuestions. Không dùng tên field để đoán mẫu số. `getIeltsBandScore` tại `:1127` khớp toàn bộ ngưỡng 3–40 của CN5, trả 0 khi không match. Không cần viết engine quy đổi mới; dưới 3 hiển thị `--` ở presentation Minitest, không đổi mọi band=0 trong DB thành null.
- Record ETEST có `userETest`, `examinationDetail`, resultReview; chưa thấy contract eligibility lớp học trong entity đã đọc. Việc có CRM student không tự chứng minh đang thuộc danh sách lớp.

### E4. AI là job receipt, không phải kết quả đã chấm

- `BE2/libs/02.eTest/src/controllers/examination-record/examination-record.controller.ts:378` và `:410` enqueue Writing/Speaking. `services/examination-records/01.ex-records-ai-queue/examination-records-queue-ai.service.ts:43` trả `{ id, jobId, status: 'queued', type }`; có retry/backoff, job ID; phần quota đang comment. Không tự thay quota trong change này.
- Worker `01.ex-records-ai-queue/examination-record-ai-worker.service.ts:32` gọi `ExaminationRecordEtestService.aiAssessmentGeneral` / `aiAssessmentGeneralSpeaking` trong `services/examination-records/examination-record.service.ts:1736` / `:1929`. Với nhiều section, Writing tìm child Writing; không được bỏ parent/child mà không kiểm tra AI và lịch sử bài.
- `examination-record.service.ts:1828`, `:2041`, `:2054`: sau chấm gọi helper gửi notification và email; email cần user email + template CRM, link từ setting `ETEST_AI_ASSESSMENT_RESULT_LINK`. Đây là reuse có bằng chứng, nhưng delivery/config chưa verify.
- FE wrapper `FE/libs/cms/src/services/etest/examination-record/examination-record.service.ts:126` vẫn khai báo AI response là ExaminationRecordETestEntity. Caller IDP `:775` / `:798` lưu receipt vào responseSubmitAI, Writing mở popup, dòng setCurrentStep(conclusion_ai) đang comment. Cần sửa typing/adapter và state riêng cho H7.1b; không chờ job xong mới hiện kết quả, không render receipt như record hoàn chỉnh.
- Submit IDP `:671` / `:735` dispatch W+S hoặc W; nếu chỉ `needAISpeakingChecked` mà không Writing, nhánh này không gọi Speaking handler. Modal có đường chọn Speaking riêng. Cần test tận luồng S-only khi chốt Q2, không coi có method Speaking là đủ.

### E5. Kết quả, draft và điều hướng hiện có

- Caller IDP `:1064` mở modal “Nộp bài/Lưu nháp thành công”; nút Xem kết quả còn phụ thuộc typePractice. `:995` dùng AlphaConclusionETest, `:1018` dùng ConclusionAIETest; nhánh submit hiện không đảm bảo vào thẳng H7.1a/H7.2a.
- `FE/libs/cms/src/packages/ETestEntryTestBank/components/Conclution/AlphaConclusionETest.tsx:66` tổng hợp điểm/kỹ năng theo resultReview; không phải contract cố định đủ bốn dòng H7.1 hoặc hai dòng + tổng H7.2. Có thể reuse dữ liệu/handlers, không reuse nguyên màn mà bỏ qua delta.
- IDP `:1105` tiếp tục draft bằng đóng modal; `:1120` quay về returnUrl hoặc host ETEST. Loader `:114` đọc examinationRecordId cho resume. Cần giữ cùng attempt khi tiếp tục và attempt mới khi làm lại, kiểm tra lại sau reload chứ không chỉ trong state hiện tại.

### E6. CN6 đã có backend; membership vẫn chưa xác định

- `BE2/libs/02.eTest/src/controllers/appointments/appointments.controller.ts:13`, `services/appointments/appointments.service.ts:19`: create yêu cầu user isUserEtest, không employee, có auth; forward bearer token tới CRM và **tự gắn etestUserId**. Không gửi identity tùy ý từ UI.
- `CRM/src/modules/appointment/services/etest-appointment.service.ts:36` gọi AppointmentService.create rồi present; `services/appointment.service.ts:242` resolve customer bằng `info.idEtest`, `:263` resolve student bằng customerPotentialId, cho phép chưa có student và chặn nhiều match. Không có kiểm tra membership lớp ở các hàm này.
- Candidate dữ liệu EDU: `BE2/libs/01.edu/src/entities/registration-form/registration-form.entity.ts:44` / `:86` có student/class; `entities/student-learning-history/student-learning-history.entity.ts:14` / `:96` có student/class/status, là dữ liệu lịch sử tính lại. **Chưa trace được predicate BA “bài làm/học viên đã nằm trong Danh sách học viên lớp học”** hoặc mapping identity ETEST→EDU đến caller màn đó. Không chọn bảng này làm nguồn chuẩn chỉ vì tên phù hợp.
- Chưa tìm được frontend form CN6 trong scope đã đọc. Backend appointment tồn tại không chứng minh UI/prefill sẵn sàng. `lich-hen/backend-api.md` mô tả payload, nhưng hồ sơ này ưu tiên implementation: ví dụ customer lookup thực tế đang dùng `info.idEtest`.

## Mong muốn → hiện trạng → thay đổi

Tất cả delta dưới đây là **proposed**; evidence E1–E6 là **observed**. Chưa có delta được approved.

| ID | Mong muốn BA + nguồn | Hiện trạng + evidence | Delta cần thiết | Điểm sửa / consumer / impact | Kiểm chứng mới + hành vi giữ |
|---|---|---|---|---|---|
| D1 | CN4 DOD/F1: dropdown Minitest và Kho đề; kho focus bộ đầu tiên khác Minitest; chưa có bộ thì ẩn mục | E1: có CRUD/order, thiếu marker chuyên biệt và caller menu | **Giữ** CRUD; **thêm** bộ tên “Minitest” + đề gán `targetType: minitest`; **sửa** menu/focus. Nhận diện bộ: tên/ID cấu hình (Q1 phần lifecycle). Enum `minitest` đã chốt draft | TestSet + learner menu; admin cần quyền `etest-minitest` khi gán đối tượng | Bộ chưa tồn tại; có nhưng rỗng; đổi tên; không có bộ khác; order; vào từ home; hover và điều khiển cảm ứng/bàn phím. Không thay kho `web-supplement` ngoài focus yêu cầu |
| D2 | CN4 F2/AC3: mọi đề public + active trong bộ, không cần bốn kỹ năng; bộ rỗng hiện empty | E1: getListTestSets loại bộ rỗng; getListExamSkill lọc đủ bốn kỹ năng | **Thêm** enum + API list scoped `targetType=minitest` (clone `get-list-test-sets`); public/active ở BE; không gate 4 skills. **Bổ sung** endpoint/metadata bộ Minitest cho AC menu ẩn / màn rỗng (clone không trả bộ không có exam). Kho đề online giữ API `web-supplement` | BE2: `examinations.dto`, `skill-test-sets.dto`, `question-bank` label; controller/service mới; optional list-exam nhánh minitest | R-only, L-only, L/R/W, full; private/inactive/deleted không lọt; rỗng vs ẩn menu; pagination; regression `web-supplement` + `list-exam-skill` cũ |
| D3 | CN5 F1: có W hoặc S → ba nút; không có → hai; chỉ hiện kỹ năng có trong đề | E2: skills có sẵn, nút/config chưa tương đương BA | **Sửa** presentation và gate riêng Minitest: Chấm điểm nhanh thay Nộp bài; route theo cấu hình kỹ năng, không dựa bài đã trả lời đủ hay recordSections có response. Chốt Q2/Q3 | Shared ModalSubmitTest + preview/caller IDP/standard; không đổi appointment/LMS/practice khác | L, R, LR, LRW, LRS, LRWS; kỹ năng bỏ trắng; config AI có/không; S-only/W-only theo Q2; regression consumer dùng chung |
| D4 | CN5 H7.1a/H7.2a: quick vào thẳng kết quả; bảng và action khác nhau | E3/E5: kết quả L/R có ngay, vẫn qua success modal | **Giữ** scoring; **thay** bước success trong flow Minitest bằng màn tương ứng; H7.1a đủ bốn dòng W/S `--`, absent `--`; H7.2a hai dòng đúng/tổng + Tổng điểm, không band; reuse handlers đúng semantics | Caller + result presenter; lựa chọn `correctAnswer/totalQuestionExam` hay điểm theo Q5, không dùng receipt AI/overall thay kết quả kỹ năng | Tất cả ngưỡng band, 0/1/2 → `--`, absent khác zero; câu bỏ trống; đề ít hơn 40 câu; quick không enqueue AI; retry submit không nhân attempt; H7.1a Làm lại/Xem giải thích, H7.2a Quay lại |
| D5 | CN5 H7.1b: hiện ngay L/R, W/S có trong bài “AI đang chấm”; notify/email như cũ | E4: queue receipt và grading/notification có thật; typing FE sai semantics | **Giữ** queue/worker/provider/notify; **sửa** typed receipt + UI state và dispatch đúng từng kỹ năng. Dùng kết quả submit cho L/R, queued state cho W/S; lỗi enqueue không giả là đang chấm | Wrapper shared cần audit tất cả callsite trước đổi type; route Minitest, child record, setting link/template | W-only/S-only nếu cho phép, W+S, absent; một queue thành công/một lỗi; reload/retry; actual notification/email với config test; regression AI ngoài Minitest |
| D6 | CN5 H7.1c/H7.2c: lưu nháp, tiếp tục, quay lại; bài lưu danh sách hiện hành | E3/E5: IN_PROGRESS + resume có sẵn; child L/R completed và update parent không sync children | **Giữ** draft/resume mechanism; **sửa** popup thêm CTA; **kiểm chứng trước khi chốt sửa BE** consistency parent/child cho Minitest, tránh resume/AI đọc child cũ. Không đổi toàn bộ lifecycle draft ngoài phạm vi | createETest/updateETest, grading queue, lịch sử/learning progress và consumer bài làm; Q6 quyết định semantics | Save→reload→resume→quick/AI; parent/child đúng attempt và câu trả lời mới; không mất audio; không gửi thông báo AI khi chỉ draft; giữ record để Sale/CN9 dùng, không tự xây CN9 |
| D7 | CN5 EC3: ẩn đoạn dẫn/CTA nếu thuộc danh sách lớp; các nút khác giữ | E6: mới có candidate relation; không có eligibility contract đã xác minh | **Thêm/sửa** eligibility projection từ nguồn membership chuẩn sau Q4; truyền cho cả năm màn. Không dùng has student/isUserEtest/appointmentId làm proxy. Không lộ danh sách lớp qua UI public | BE chịu trách nhiệm identity/lookup khi cần; FE chỉ render; phạm vi repo EDU/CRM phụ thuộc fact còn thiếu | Cả năm màn × eligible/not eligible; nhiều lớp, nghỉ/hoàn thành/chờ lớp theo quyết định; lỗi lookup không tự kết luận chưa học; user không giả identity |
| D8 | CN5 F3/AC8: CTA mở CN6, prefill tên/SĐT/email | E6: backend booking đã có, UI chưa xác định | **Giữ/reuse** API CN6; **thêm** entry navigation/prefill từ profile hiện hành, fallback khi profile thiếu. Không tạo API consultation-form hay lịch hẹn song song | Frontend học viên/CN6; BE2 proxy + CRM là dependency, chưa có căn cứ phải sửa booking BE | Cả năm entrypoint; prefill đúng user; auth hết hạn; missing/multiple CRM mapping; double click; back về kết quả không mất attempt |

## Flow trước / sau (đề xuất)

- Trước, phần đã thấy: learner caller **unknown** → API danh sách (gate bốn skills ở list-exam-skill) → ETEST runner → modal theo target config → create/update record → success popup hoặc popup AI; AI enqueue trả receipt, worker ghi kết quả và gửi notify/email.
- Sau: learner menu → nhận diện bộ Minitest (tên/ID) → API list `targetType=minitest` (không gate bốn) → **runner cũ**, context từ exam có `minitest` → H7.1/H7.2 → quick / AI + receipt / draft → eligibility CTA → CN6. Không route discovery qua `web-supplement`.
- Không đổi global `/list-exam-skill` hay `get-list-test-sets` (`web-supplement`); Minitest là target và endpoint riêng.

## Câu hỏi làm thay đổi quyết định

| ID | Chưa rõ gì / đã tìm ở đâu | Lựa chọn và hệ quả | Người trả lời | Chặn phần nào | Quyết định + nguồn/ngày |
|---|---|---|---|---|---|
| Q1 | **Đã chốt draft (PO 2026-11-16):** đề/skill Minitest dùng `targetType` string **`minitest`**; discovery qua API clone `get-list-test-sets`, tách khỏi `web-supplement`. **Còn mở:** bộ `test-sets` (tên "Minitest" vs `testSetId` cấu hình; đổi tên/trùng; bộ inactive; ẩn menu khi chưa có bộ vs màn empty) — E1 không có marker trên entity bộ | Enum + API scoped: Dev implement theo mục Quyết định kỹ thuật. Phần bộ: BA lifecycle + Dev ID/env | BA lifecycle bộ; Dev ID cấu hình + API exists/empty | D1 menu; D2 edge bộ rỗng; context D3–D6 dùng `minitest` trên exam | **Partial:** `targetType=minitest` + nhánh API — PO/chat 2026-11-16; phần bộ **Open** |
| Q2 | CN5 DOD nói “có W hoặc S”, bảng d lại ghi “gồm 3 hoặc 4 kỹ năng”; CN4 không yêu cầu đủ bốn | Theo predicate W/S thì W-only, S-only, W+S, L+W cũng thuộc H7.1; hoặc giới hạn tổ hợp hợp lệ, cần rule tạo/chọn đề và thông báo. Không tự loại đề hợp lệ chỉ vì UI chưa hỗ trợ | BA/PO | Ma trận D2–D5 | Open; LRW và full đã rõ, không hỏi lại |
| Q3 | Ba nút H7.1 BA yêu cầu có ưu tiên hơn target AI config/draft constraints không? E2 đã thấy gate hiện hành | Override riêng Minitest để đúng DOD; hoặc chỉ cho phép cấu hình Minitest thỏa ba nút và validate dữ liệu. Không bật submit/AI toàn target cho mọi đề | BA/PO + Dev owner ETEST | D3/D5 | Open; khác code là delta rõ, không mặc định BA sai |
| Q4 | CN5 dùng cả “bài làm đã nằm” và “học viên đã nằm trong Danh sách học viên lớp học”; E6 chưa có predicate/source of truth | Xét user có lớp (đang học hay từng học?) hoặc xét bài thuộc lớp. Người đã học nhưng làm Minitest tự do sẽ cho kết quả CTA khác nhau; chờ xếp lớp/nghỉ/hoàn thành cũng khác | BA xác định nghiệp vụ; Dev EDU chỉ nguồn/mapping và màn danh sách tương ứng | D7; có thể làm khung CTA trước, chưa chốt show/hide | Open |
| Q5 | CN5 gọi “điểm đúng/tổng điểm”, ví dụ 28/40; engine có points, correctAnswer, totalQuestion, totalQuestionExam khác nhau | Chọn số câu đúng/tổng câu theo ví dụ, Tổng điểm cộng tử/mẫu; hoặc điểm trọng số theo cấu hình. Band CN5 đã cho ngưỡng raw 3–40: không hỏi lại bảng, không tự normalize đề ngắn lên 40 | BA xác nhận metric; Dev kiểm tra fixture câu bỏ trắng/trọng số | Projection D4 và acceptance | Open |
| Q6 | Draft có được ghi child L/R completed, và child cũ có phải phản ánh câu trả lời khi resume không? E3 đã trace create/update lệch nhau | Giữ semantics hiện hành nếu BA chấp nhận, nhưng phải verify lịch sử/AI không lấy câu cũ; nếu draft phải đồng nhất attempt thì sửa scoped parent/child và regression side effects, không refactor toàn service | BA cho nghĩa draft; Dev owner xác định child consumer | Phần BE D6, độ an toàn AI sau resume | Open |
| Q7 | Chưa thấy source menu/list learner và form CN6 trong workspace; E1/E6 mô tả phạm vi đã tìm | Cung cấp repo/branch và entry route đang dùng; nếu nằm repo hiện có thì chỉ entrypoint để tiếp tục trace. Không yêu cầu BA thiết kế endpoint, không giả lập trang mới trong admin | Dev/frontend owner | File-level task CN4 frontend, CN6 navigation/prefill và E2E | Open |

## Hướng sửa và task đề xuất

**Reuse đã kiểm tra:** TestSet CRUD; runner theo cấu hình đề; create/update ETEST và resultReview; bảng band L/R; AI queue/worker + notify/email; draft/resume handlers; appointment ETEST→CRM. Mỗi reuse có giới hạn semantics ở E1–E6, chưa có tuyên bố runtime pass.

**Không chọn:** engine chấm Minitest riêng; collection bài làm mới; endpoint booking mới; lấy kết quả AI trực tiếp từ receipt; dùng tồn tại CRM student để ẩn CTA; **gắn Minitest vào `web-supplement`** hoặc sửa global `list-exam-skill` / `get-list-test-sets` cho mọi consumer. **Đã chọn (draft):** enum `minitest` + API discovery scoped. Tạo bộ đề + gán `targetType` qua quản trị là cấu hình dữ liệu; enum mới cần đồng bộ FE/HRM label.

| Task đề xuất | Gắn delta / phạm vi | Điều kiện và kiểm chứng |
|---|---|---|
| T0 — bổ sung caller và chốt contract | D1/D2/D8; repo learner + wrapper BE2 | Q7; trace menu→list→launch URL/context và CN6 form. Chốt Q1 phần bộ + Q4 với owner |
| T1 — discovery/list Minitest | D1/D2; BE2 + learner | Enum `minitest`; API clone `get-list-test-sets`; optional list-exam không gate 4 skills; API bộ rỗng/menu (Q1); regression `web-supplement`; test partial/empty/private/inactive/order/pagination |
| T2 — submit/result presenter scoped | D3/D4/D8; FE runner/shared component + learner | Q2/Q3/Q5; dùng submit result, đủ ma trận H7; giữ IDP/standard, practice thường, appointment, LMS không bị đổi |
| T3 — AI receipt và state | D5; FE service types/dispatch + runner | Contract receipt đã rõ, có thể chia task ngay; trước đổi type phải tìm tất cả consumer. Không đổi worker/provider nếu chưa có failure cần sửa; test W/S, queued/error và delivery trên môi trường test |
| T4 — draft/parent-child verification rồi patch nếu cần | D6; BE2 controller/service + FE resume | Repro parent draft/child completed, resume/update/AI đọc child, queue persistence; Q6 quyết định patch scope. Không báo lỗi đã tái hiện khi mới đọc code |
| T5 — eligibility + CN6 wiring | D7/D8; source membership chuẩn + learner | Q4/Q7; contract eligibility tối thiểu, prefill đúng profile, không thay booking auth/identity. Regression năm popup và negative cases |
| T6 — nghiệm thu liên repo | D1–D8 | CN4 AC1–AC3/EC1; CN5 AC1–AC8/EC1–EC3 và edge cases trong bảng delta. Dùng fixture non-prod và cấu hình queue/email test |

- **Đủ rõ để thiết kế task:** bỏ gate bốn kỹ năng có scope; quick bỏ success popup; UI theo skills; reuse band; sửa AI receipt; thêm CTA vào năm màn; reuse CN6 backend. Chưa đủ để implement toàn flow vì caller, identity/lifecycle và policy còn mở.
- **Cần Dev duyệt:** enum/API `minitest` (đã draft PO); ID/tên bộ Minitest; nhánh list không ảnh hưởng `web-supplement`; projection score và contract AI; parent/child; membership; repo frontend. **Cần BA duyệt:** Q1 lifecycle bộ, Q2, Q3, Q4, Q5, Q6.
- Duyệt phân tích không tự cấp quyền implement. Chưa chạy phản biện `mmd-challenge-change`; người yêu cầu quyết định có chạy hay không.

## Kiểm chứng và kết quả sau triển khai

- Phiên này chỉ đọc code/tài liệu, xác nhận revision/local status và hash nguồn; không có diff product, migration hay OpenSpec.
- Test/runtime chưa chạy: listing partial/empty, submit và điểm thực tế, parent/child consistency, AI worker/notification/email, identity lớp học, CN6 frontend. Test có sẵn gần phạm vi gồm `BE2/libs/02.eTest/src/services/examination-records/examination-record-answer.helper.spec.ts` và `services/appointments/appointments.service.spec.ts`; chưa kiểm coverage hay báo pass.
- Chưa triển khai nên chưa có commit/diff thực tế hoặc nghiệm thu. Chưa có correction từ Dev; không suy ra chất lượng hay hiệu quả từ việc chưa có feedback.
- Run được ghi tại `mmd-sdd/learning/runs.md`; không ghi thời lượng vì không đo.
