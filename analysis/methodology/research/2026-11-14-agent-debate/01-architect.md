# IDEA ARCHITECT — Round 1

- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Trạng thái: đề xuất để tranh luận, KHÔNG phải quyết định đã duyệt.
- Phạm vi: phương pháp BA input → hiện trạng Arena → delta/reuse/impact → làm rõ → spec đủ làm.
- Giới hạn: đọc tài liệu và một số implementation của tooling; không xác minh runtime sản phẩm, không chạy workflow/test, không spawn agent. Ba task bên dưới là giả định để thử tư duy, không phải discovery về product.
- Quy ước: giữ nguyên Round 1 này; Round 2 chỉ bổ sung phần riêng sau khi nhận bài của hai agent còn lại.

## 1. Nhận định kiến trúc

Vấn đề không phải thiếu một pipeline sinh Markdown. Vấn đề là thiếu một đơn vị ra quyết định đủ nhỏ để kết nối mong muốn BA với bằng chứng hiện trạng và phạm vi thay đổi.

**A01 — Đề xuất đơn vị trung tâm là “lát hành vi + quyết định còn thiếu”, không phải tài liệu, repo hay màn hình.** Một lát mô tả kết quả quan sát được, phần giữ nguyên, phần thay đổi và điều kiện để kiểm chứng. Một lát có thể xuyên repo; task thực thi bên trong mới phân theo repo.

Giả định vận hành để so sánh phương án, chưa được chốt:

- Người dùng chính là dev/tech analyst có AI hỗ trợ; BA là người xác nhận ý nghĩa nghiệp vụ, không phải người điền technical template.
- Giai đoạn hiện tại là method-first. Thành công là tìm ra quy trình có thể dùng lại, không phải số file hay một pilot product được ship.
- Hiện chỉ version phương pháp trong hub. Không cần quyết định ngay topology Git của product specs để thử phương pháp.

Các giả định này tương ứng P1/P2/P5 trong `foundational-clearance.md`; nếu người dùng chính là BA tự vận hành thì cần đánh giá lại thiết kế.

## 2. Hai phương án thực sự khác nhau

### Phương án P — Pipeline lấy artifact làm trung tâm

```text
BA input → Intake → As-is → Delta/Design → BA questions
         → Review → Accepted spec → Implementation handoff
```

Mỗi bước hoàn tất một artifact trước khi chuyển tiếp. Fast path bỏ bớt artifact; Standard/Heavy đi sâu hơn. Trạng thái hoàn thành nằm ở tài liệu và checklist của bước.

- Ưu: dễ dạy, dễ audit, dễ đóng gói thành commands; đầu ra giữa các task đồng đều.
- Nhược: dễ điều tra quá sớm trước khi biết câu hỏi nghiệp vụ nào đáng giải; phát hiện mới phải cập nhật nhiều artifact; task bị chặn dễ làm cả pipeline đứng lại.
- Phù hợp hơn khi: nguồn BA khá ổn định, handoff chính thức giữa các team và mẫu tài liệu là yêu cầu tổ chức.

### Phương án D — Hồ sơ quyết định, mở rộng theo rủi ro

```text
Input → Mục tiêu + lát ứng viên + điều chưa biết
                        │
              Chọn quyết định cản trở nhất
                        │
            ┌───────────┴─────────────┐
      Cần bằng chứng             Cần chọn nghiệp vụ
      đọc flow/caller            ví dụ → hỏi owner
            └───────────┬─────────────┘
                        ▼
                Delta + điểm nối ứng viên
                        │
            kiểm chứng nhận định + tìm bỏ sót
                        │
          đủ rõ một lát? ── không → lặp đúng vấn đề
                        │ có
                        ▼
                Chốt cam kết của lát
```

Trạng thái nằm ở từng quyết định/lát, không nằm ở việc “đã có design.md”. Flow, bảng trạng thái và API matrix được tạo khi chúng giúp giải quyết một quyết định; không sinh mặc định.

- Ưu: hợp input mơ hồ; hỏi BA sớm khi câu trả lời có thể đổi hướng khảo sát; phần độc lập tiến được; ít artifact trung gian.
- Nhược: khó bảo đảm bao phủ nếu chỉ chạy theo câu hỏi nổi bật; yêu cầu kỷ luật ghi trạng thái và lượt kiểm tra bỏ sót; người mới dễ bỏ quên invariants.
- Phù hợp hơn khi: sửa hệ thống có sẵn, nhiều nguồn không đồng nhất, phần lớn task có thể reuse nhưng cần kiểm tra semantic.

### So sánh và lựa chọn

| Tiêu chí | P: pipeline artifact | D: quyết định/rủi ro |
|---|---|---|
| Đơn vị tiến độ | Artifact hoàn thành | Lát đủ rõ, quyết định được giải quyết |
| Thứ tự khảo sát | Tương đối cố định | Theo câu hỏi có ảnh hưởng lớn nhất |
| Input mâu thuẫn | Có thể tạo nhiều draft rồi sửa | Gặp mâu thuẫn quan trọng thì đưa ra quyết định sớm |
| Coverage | Dễ nhờ template đầy đủ | Phải có coverage sweep cuối lát |
| Fast task | Cần ngoại lệ/bỏ bước | Cùng mô hình, ít nội dung |
| Tự động hóa | Dễ nhưng dễ sinh tài liệu thừa | Khó hơn, nên thử thủ công trước |

**A02 — Chọn D làm ứng viên tối giản.** Giữ một coverage checklist cố định từ P, không giữ pipeline artifact bắt buộc. Đây không phải đổi tên sáu bước: có thể hỏi BA trước khi đọc sâu repo, và không cần vẽ flow khi không có quyết định nào cần nó.

Điều kiện xem xét lại: nếu thử trên task thật cho thấy người khác không tiếp quản được hồ sơ hoặc thường xuyên bỏ sót vùng ảnh hưởng dù đã coverage sweep, P có thể đáng chi phí hơn.

## 3. Artifacts tối thiểu và quyền sở hữu

**A03 — Một hồ sơ làm việc; một nơi sở hữu cam kết hành vi.** Không bắt đầu bằng một bộ BRD mới.

### 3.1. Hồ sơ làm việc: một file ở giai đoạn thử

Các phần bắt buộc, cho phép viết một dòng nếu đơn giản:

1. ID, mục tiêu, In/Out, người chốt nghiệp vụ/kỹ thuật, nguồn và revision.
2. Lát đang xét: as-is, delta, invariants cần giữ; reference tới bằng chứng.
3. Quyết định/câu hỏi: ví dụ phân biệt, owner, phần bị chặn, trạng thái.
4. Phương án sửa: điểm nối, lý do chọn/loại, phạm vi ảnh hưởng và vùng chưa khảo sát.
5. Kiểm chứng dự kiến và trạng thái Ready/Done kèm lý do.

Context pack cho agent khác và bản gửi BA là góc đọc từ hồ sơ này, không phải hai bản requirement duy trì độc lập. BA thấy mục tiêu, hành vi, ví dụ và câu hỏi; dev thấy thêm code evidence, seam và impact.

### 3.2. Cam kết hành vi

- Trong thử phương pháp: section `Accepted behavior` trong hồ sơ, chỉ đổi trạng thái khi owner xác nhận; chưa có xác nhận thì vẫn draft.
- Khi dùng OpenSpec cho product change: delta spec sở hữu requirement/scenario; hồ sơ trỏ ID thay vì chép lại toàn bộ nội dung accepted.
- Decision rationale vẫn ở hồ sơ/design, không biến thành requirement nghiệp vụ giả.
- OpenSpec artifacts theo schema có thể tách thành proposal/design/tasks, nhưng đó là cách đóng gói sau, không phải điều kiện để intake bắt đầu.

Evidence gồm nguồn + revision/snapshot + cách quan sát. “Đã đọc code”, “test đã chạy”, “đã quan sát runtime” phải phân biệt. Một test plan chưa chạy không được đặt trạng thái verified.

**A04 — Hai trục trạng thái độc lập:** ý nghĩa nghiệp vụ `draft / accepted / superseded`; bằng chứng hiện trạng/implementation `observed-static / verified-by-test-or-runtime / unresolved`. Không suy “accepted” thành “đã tồn tại”. Không coi code đang làm sai là chuẩn phải bảo toàn.

## 4. Truy flow và nối luồng mới vào luồng cũ

**A05 — Mỗi claim “reuse/ít impact” cần một seam note, không chỉ một danh sách file sửa.**

```text
AS-IS:  Entry → Shared step → Existing rule → Side effect → Result

TO-BE:  Entry → Shared step → [điểm nối]
                               ├─ ngữ cảnh cũ → Existing rule → ...
                               └─ ngữ cảnh mới → Delta rule → ...
```

Sơ đồ chỉ minh họa cách trình bày, không bắt mọi thay đổi dùng nhánh điều kiện. Thay đổi có thể nằm ở config, output projection, contract hoặc state transition. Quy tắc toàn hệ thống có thể cần đổi shared rule, không nên giữ rule sai bằng adapter chỉ để giảm diff.

Seam note trả lời sáu câu:

1. Điểm can thiệp ở đâu và ai sở hữu?
2. Input/output, auth, state và side effects của điểm đó là gì?
3. Consumer/caller nào đã biết; phần nào chưa khảo sát?
4. Vì sao semantic của flow cũ phù hợp hoặc không phù hợp?
5. Quy tắc nào giữ, thêm, sửa, bỏ; điều kiện chọn nhánh là gì?
6. Kiểm chứng nào phân biệt hành vi cũ/mới và lỗi tại ranh giới?

Định hướng tìm trong Arena, không phải kết luận đã đọc product ở vòng này:

- UI: bắt đầu ở `website-mmd-area1`, lần từ route/component tới caller.
- Rule ETEST: truy `backend-mmd-v2-area1/libs/02.eTest`; chỉ mở `00.core`/`01.edu` khi dependency thực tế dẫn tới.
- CRM: đọc `backend-mmd-area1` khi flow gọi hoặc chia sẻ contract với CRM; không quét cả ba repo mặc định.

**A06 — Giới hạn discovery theo câu hỏi, không theo số repo.** Trước mỗi lượt ghi câu hỏi cần trả lời, vị trí dự kiến và điều kiện dừng. Dừng khi có một phương án hợp lệ, vùng ảnh hưởng được khoanh đủ cho mức rủi ro, và không còn ứng viên rõ ràng hứa hẹn giảm impact đáng kể. Nếu hết timebox mà caller/side effect quan trọng chưa rõ: ghi unresolved, thu hẹp lát hoặc yêu cầu điều tra tiếp; không tự ghi “an toàn”.

Chỉ so sánh thêm phương án khi có trade-off thực; không ép UI-copy task bịa ba cách thiết kế. Không tuyên bố chứng minh được “ít impact nhất toàn hệ thống”; chỉ là phương án phù hợp nhất trong các lựa chọn đã khảo sát.

## 5. Phản biện, câu hỏi BA và điều kiện chuyển giai đoạn

**A07 — Hai lượt phản biện nhẹ trên cùng hồ sơ:**

- Kiểm tra claim: tìm bằng chứng phủ định “API đủ”, “không đổi rule”, “chỉ ảnh hưởng màn này”. Kết quả supported / contradicted / unresolved.
- Kiểm tra coverage: có quên actor, state, error, dependency, compatibility hoặc caller quan trọng không?

Không bỏ phiếu AI để chốt nghiệp vụ. Không mặc định thiếu bằng chứng nghĩa là refuted. Hai lượt là góc nhìn, không bắt buộc hai agent.

**A08 — Gom câu hỏi theo quyết định, không theo file.** Mỗi card có câu hỏi, ví dụ phân biệt, các cách hiểu, đề xuất có điều kiện, owner và lát bị chặn. Dev tự điều tra câu hỏi kỹ thuật trước khi gửi BA.

Phản biện backlog: giới hạn ba câu P0 có thể dùng cho mỗi đợt trao đổi, KHÔNG phải giới hạn số blocker thật. Tương tự không giới hạn ba scenario nếu có nhiều lớp hành vi quan trọng. Phần chưa gửi vẫn phải hiển thị trong hồ sơ, không đổi thành nonblocking để đủ quota.

**A09 — Chỉ hai cổng, áp dụng cho từng lát:**

| Ready-to-implement | Done-with-evidence |
|---|---|
| Mục tiêu, In/Out, owner rõ | Thay đổi khớp hành vi accepted |
| Rule và ví dụ quyết định được đúng/sai | Có kết quả kiểm chứng, không chỉ kế hoạch |
| Không còn blocker ảnh hưởng correctness của lát | Regression kiểm tra invariants liên quan |
| Baseline có nguồn; vùng chưa biết không đe dọa lát hoặc đã xử lý | Revision/spec và code tương ứng được ghi nhận |
| Seam/impact đủ rõ; có thể không cần diagram | Chênh lệch phát hiện khi làm đã được xử lý/chốt lại |
| Có cách kiểm chứng mới + cũ; dependency đủ sẵn sàng | Không lấy Done một lát làm Done toàn change |

Ready ở đây nghĩa là đủ rõ để làm, không cấp quyền tự sửa code. Khi đã chọn dùng OpenSpec, validation cấu trúc là điều kiện bổ sung, không thay thế xác nhận nghiệp vụ.

Hết hạn chờ BA không phải approval ngầm. Có thể tiếp tục khảo sát hoặc làm lát độc lập nếu được phép; không triển khai theo giả định thay thế quyết định còn chặn.

## 6. Thử tư duy với ba task giả định

### T1 — UI thuần: đổi nhãn nút và khoảng cách ở một màn

- Input: “Đổi nhãn thành Tiếp tục, bố cục như màn tham chiếu”; không yêu cầu đổi hành động.
- Câu hỏi đầu: đây chỉ là presentation hay tên mới ám chỉ hành vi khác?
- Khảo sát nhỏ: component/copy key, handler hiện hữu, component hoặc translation key có dùng chung không.
- Flow cũ: click → handler H → API A. Flow mới: nhãn mới → H → A; sơ đồ text một dòng là đủ.
- Seam: prop/copy cục bộ; nếu sửa shared key tác động màn khác thì nâng mức phân tích, không giả định UI là Fast.
- BA question chỉ khi còn hai nghĩa: click có giữ nguyên hành động hiện tại không? Tech tự kiểm tra key dùng chung.
- Artifacts: một hồ sơ ngắn; không cần API matrix hay state chart.
- Ready: nhãn/phạm vi được xác nhận, không đổi handler, caller của điểm sửa đã rõ. Verification plan: kiểm tra text/layout ở kích thước liên quan và hành động click giữ nguyên.
- Phản ví dụ cho phương pháp: bỏ hẳn đọc code ở UI Fast có thể đổi copy dùng chung cho nhiều màn. Vì vậy Fast rút độ sâu, không bỏ kiểm tra điểm sửa.

### T2 — Rule dùng chung: cửa sổ cho phép sửa bản ghi

- Input: “Cho phép sửa trong 24 giờ, các nơi khác như hiện tại”. Chưa rõ 24 giờ từ mốc nào và áp dụng cho mọi loại bản ghi hay một nhóm.
- Khảo sát: rule đang ở FE hay BE; route/service gọi rule; nguồn thời gian và trạng thái không được sửa. Không giả định có sẵn policy service.
- Flow cũ: caller → rule cũ → update. Hai lựa chọn thật: đổi shared rule toàn cục; hoặc truyền ngữ cảnh rõ để áp dụng rule mới cho nhóm được chốt.
- Câu hỏi BA trọng tâm: mốc thời gian và tập đối tượng áp dụng, bằng ví dụ bản ghi 23h59/24h và một bản ghi của nhóm cũ. Tech owner quyết định điểm đặt rule, không hỏi BA tên service.
- Seam: tại nơi kiểm tra quyền sửa nghiệp vụ ở BE nếu đó là nơi bảo đảm rule; FE có thể chỉ phản ánh khả năng thao tác.
- Impact: caller A/B đã biết; caller chưa rõ là risk cần xử lý. Không thêm flag mặc định làm thay đổi mọi caller chỉ để sửa ít dòng.
- Artifacts bổ sung: decision table và caller/impact note trong cùng hồ sơ.
- Ready chưa đạt nếu BA chưa chốt phạm vi áp dụng. Khi đạt, scenario gồm hai phía biên thời gian, trạng thái bị khóa và nhóm phải giữ rule cũ.
- Nếu toàn bộ caller phải theo rule mới thì sửa shared rule có thể đúng hơn adapter. Reuse-first không phải preserve-old-at-all-costs.

### T3 — Tích hợp: lưu yêu cầu rồi đồng bộ CRM, CRM timeout

- Input: “Lưu xong đồng bộ CRM; lỗi thì thử lại”. Chưa rõ thành công với người dùng nghĩa là gì.
- Flow cũ giả định: submit → lưu nội bộ → trả thành công.
- Flow mới ứng viên: submit → lưu nội bộ → đánh dấu pending → gửi CRM → synced; lỗi → retryable/failed. Đây là thiết kế ứng viên, không khẳng định code hiện có hỗ trợ.
- Điểm khó: CRM có thể đã nhận nhưng client timeout. Retry đơn thuần có thể nhân bản dữ liệu; một lời gọi HTTP thêm vào cuối service không phải phương án ít impact an toàn.
- Khảo sát có mục tiêu: cơ chế đồng bộ/queue hiện hữu, correlation key, trạng thái persisted, khả năng deduplicate phía nhận, đường recovery. Chỉ truy CRM vì contract thực sự liên quan.
- BA chốt: pending có được coi là hoàn tất không, ai thấy lỗi/được retry, thời hạn và hậu quả nếu không đồng bộ. Tech chốt retry/idempotency/cơ chế lưu intent theo capability thực có.
- So sánh: gọi đồng bộ có recovery rõ; hoặc tác vụ bất đồng bộ có intent bền vững. Không mặc định dựng outbox/queue mới nếu cơ chế hiện hữu đủ dùng.
- Artifacts bổ sung: state table + sequence lỗi + seam note giữa persistence và delivery; không cần thêm BRD thứ hai.
- Ready chặn nếu chưa xử lý trường hợp remote thành công nhưng timeout hoặc chưa rõ semantics thành công. Không coi “sẽ retry” là contract đủ.
- Verification plan: local save lỗi thì không gửi; remote lỗi sau save không mất record; timeout sau remote success không nhân bản theo contract đã chọn; retry/recovery quan sát được. Kiểm tra ranh giới thật cần thiết, không chỉ mock bỏ toàn bộ delivery.

**A10 — Ba task kiểm tra cho thấy dùng cùng một hồ sơ nhưng mở rộng mô hình theo rủi ro là khả thi về mặt thiết kế.** Đây chưa phải bằng chứng adoption/hiệu quả. Cần thử task thật, đo thời gian tới Ready, giả định sai phát hiện sớm và khả năng một người khác tiếp quản mà không hỏi lại mọi thứ.

## 7. Nguồn ý tưởng và phần Arena bổ sung

Các path dưới đây đã đọc trực tiếp trong vòng này, tương đối với `area1/`; mzspec là bản root `mzspec/`, không phải nested copy.

| Nguồn | Ý tưởng lấy | Điều chỉnh/không lấy |
|---|---|---|
| `mzspec/core/skills/spec-driven-development/SKILL.md:45` | Draft khác quality-assured; nêu assumptions | Không coi “không ai phản đối” là chấp nhận assumption; chưa cần propose ngay lúc intake |
| `mzspec/core/workflows/spec-change.js:62` | Clarity, testability, minimality, consistency, completeness; trace hai chiều | Review theo câu hỏi, không buộc nhiều agent; task kỹ thuật có thể trace tới nhu cầu verification/rollout thay vì bịa requirement |
| `mzspec/core/skills/ux-pattern-audit/SKILL.md:98` | Business flow khác page navigation | Thêm execution flow có seam khi cần; không audit cả UX |
| `mzspec/core/workflows/ship-plan.js:65` | Handoff và unit có scenario/verification | Lát hành vi có thể xuyên repo/toolchain; không copy plan.json hay gate resolver |
| `code-review/docs/09-code-review-context.md:30` | Review phải đọc contract trước diff | Đưa context lên trước code; không cần brief builder |
| `code-review/code-review/rules/phase-2b-verify.md:1` | Tách kiểm tra claim và kiểm tra phần bỏ sót | Không dùng mặc định refuted hay đa số phiếu làm chân lý |
| `code-review/code-review/rules/phase-3-report.md:25` | Gom findings thành đơn vị hành động | Gom theo quyết định và owner, không gom theo target_file |

Arena bổ sung: intake nguồn BA nhiều lớp; phân biệt observed/accepted/verified; quyết định/rủi ro dẫn hướng discovery; seam note và vùng ảnh hưởng chưa biết; bản BA là góc đọc của cùng hồ sơ; Ready theo lát, không theo số artifact.

Đã đối chiếu `analysis.md`, `foundational-clearance.md`, `code-review-idea-fit.md`, `v002-merge-backlog.md` và hai review composer hiện có trong `versions/v001/reviews/`. Giữ các nhận định đó là đề xuất/review, không nâng backlog thành quyết định. Không lấy two-PR, OCR, orchestrator, installer, native validator hoặc hooks làm dependency của phương pháp.

## 8. Câu hỏi gửi hai agent — cần phản ví dụ, không chỉ đồng ý

### Gửi Problem Framer

- **PF-A01:** A01/A02 có tối ưu sai audience không? Nếu BA là người khởi tạo chính, phần nào của hồ sơ khiến họ phải hiểu code trước khi diễn đạt được nhu cầu? Đề xuất ranh giới trách nhiệm cụ thể.
- **PF-A02:** Với T3, tách lát “lưu nội bộ” có tạo ra một lát kỹ thuật không đem lại giá trị nghiệp vụ không? Tiêu chí nào cho phép tách mà không che giấu dependency cần để nghiệm thu?
- **PF-A03:** Trong input nhiều lớp, câu hỏi nào phải hỏi BA trước discovery để tránh khảo sát sai hướng, và câu nào phải điều tra code trước? Hãy đưa một ca đảo thứ tự làm tăng rework.
- **PF-A04:** P1 cần outcome nào để bác bỏ phương án D sau thử nghiệm? “Ít tài liệu” không đủ; xin một tiêu chí thất bại đo/quan sát được.

### Gửi Adversarial Reviewer

- **AR-A01:** Hãy tìm ca A06 dừng sớm nhưng bỏ sót consumer quan trọng. Tối thiểu cần evidence gì để gọi phạm vi ảnh hưởng đủ rõ mà không quét cả workspace?
- **AR-A02:** Một hồ sơ có cả draft và accepted có thể bị AI dùng sai phần nào? Quy tắc A03/A04 đã đủ ngăn hai nguồn chân lý chưa, hay cần tách artifact ngay?
- **AR-A03:** T1 có đủ điều kiện Fast không nếu đổi nhãn liên quan accessibility hoặc translation key dùng chung? Hãy chỉ ra trigger nâng mức mà template đang thiếu.
- **AR-A04:** Với T3, chỉ mô tả dedup phía nhận mà không xét crash giữa save và ghi intent sẽ lọt Ready không? Hãy thử checklist A09 bằng ca crash đó và đề xuất sửa tối thiểu.
- **AR-A05:** Trace hai chiều có vô tình cản refactor cục bộ cần thiết không? Hãy phân biệt task “phục vụ an toàn cho change” với scope creep bằng một phản ví dụ.

## 9. Nội dung chờ Round 2

Chưa có phản hồi của Problem Framer/Adversarial Reviewer trong bài này. Round 2 sẽ append bảng: ID đề xuất → phản biện nhận được → giữ/sửa/bỏ/tạm hoãn → lý do/evidence. Không sửa ngược Round 1, không gọi đồng thuận agent là phê duyệt của owner.

---

## 10. Round 2 — Phản hồi peer và phương án rút gọn

- Ngày: 2026-11-14. Trạng thái: đề xuất điều chỉnh của Architect, chưa được owner duyệt.
- Đã đọc Round 1 của `02-problem-framer.md` và `03-adversarial-reviewer.md`; Pxx/Rxx trỏ các finding của hai file đó.
- Các dòng A01–A10 dưới đây là chỉnh bổ sung cho Round 2; Round 1 giữ nguyên để thấy diễn biến lập luận.

### 10.1. Phản hồi cụ thể: nhận, phản đối và điều kiện

| Peer | Phản hồi của Architect | Chỉnh đề xuất |
|---|---|---|
| P01, P07 | Chấp nhận: chưa chứng minh thiếu phương pháp là nút thắt. Ticket tốt + trao đổi BA–Dev–QA là đối chứng thật, không phải phương án kém mặc định. | Sửa A03/A10: hồ sơ có thể nằm trong ticket hiện hữu; bỏ artifact riêng nếu không giúp quyết định/handoff; thử nghiệm phải ghi cả thời gian chờ owner. |
| P02 | Chấp nhận: reuse có thể dẫn BA chọn nhu cầu theo thứ dễ code. | Sửa A01/A08: trình bày kết quả người dùng và ví dụ phân biệt trước phương án kỹ thuật; “không làm/đổi scope” là kết quả hợp lệ. |
| P03, R05, R08 | Chấp nhận routing theo semantic/rủi ro, không theo nhãn UI hay số repo. | Sửa A05/A06: kiểm tra shared usage, nghĩa hành vi và translation/accessibility liên quan trước khi kết luận Fast; không mở checklist BE nếu không có trigger. |
| P04, R06 | Chấp nhận phản đối quota coverage. | Giữ A08 nhưng bỏ mọi hard-cap số câu/scenario; số câu trong một đợt giao tiếp cũng do tình huống, không bắt con số ba. |
| R01 | Chấp nhận: A09 còn cho phép người đọc coi APPROVE/findings rỗng là Ready. | Sửa A09: ghi riêng quyết định nghiệp vụ, review cần thiết và validation khi áp dụng; mỗi mục là đạt/chưa đạt/chưa chạy/không áp dụng kèm lý do. |
| R02, R03 | Chấp nhận thiếu quy tắc baseline và evidence hết hiệu lực. | Sửa A04/A09 theo mục 10.3: accepted là desired, không là evidence as-is; change owner đánh dấu `needs-recheck` khi điều kiện chứng minh đổi. |
| R05 | Chấp nhận yêu cầu caller/semantic; phản đối nếu “một old-path + một new-path” được coi đủ cho mọi shared rule. | Sửa A06: cần các nhóm consumer khác semantic; hai case chỉ đủ khi thật sự chỉ có hai lớp liên quan; một lượt tìm text không chứng minh đã biết mọi consumer. |
| R07 | Chấp nhận: local green không tạo end-to-end Done. | Sửa A01/A09: lát được nghiệm thu bằng outcome xuyên ranh giới; task repo là phần thực thi, không mặc định là lát giá trị độc lập. |

### 10.2. Decision-driven có thiếu coverage không?

Có, nếu chỉ chạy theo câu hỏi nổi bật. Chọn D không tự giải completeness; A02 được giữ với điều kiện bắt buộc trước Ready: coverage sweep độc lập với danh sách câu hỏi đã sinh.

- Đối chiếu danh mục nguồn: quy tắc/ngoại lệ liên quan thuộc delta, invariant, out-of-scope có lý do hoặc unresolved; nguồn chưa đọc phải hiện rõ. Không bắt đánh ID từng dòng BRD.
- Soát actor/quyền, state/biên, side effect/lỗi, consumer/tương thích; mỗi chiều có kết quả hoặc lý do không áp dụng. UI cục bộ có thể trả lời vài dòng, không cần bảng/file riêng.
- Nguồn chứa ngoại lệ chưa đọc nhưng có khả năng đảo quyết định là blocker discovery. Brief giống nhau giữa ba agent không phải ba evidence độc lập (P08/R06).
- Không phát hiện gap sau sweep chỉ có nghĩa đã kiểm tra phạm vi nêu rõ, không chứng minh toàn hệ thống đầy đủ.
- Phản đối biến mitigation thành bộ giấy tờ cố định: đổi khoảng cách cục bộ không cần bảng trạng thái hay metadata xuyên repo; reference revision của component và ghi nhận kiểm tra liên quan đủ cho phạm vi đó (R03/R08 chỉ kích hoạt phần cần thiết).

### 10.3. Dữ liệu đủ để nói “giữ flow cũ” và evidence hết hiệu lực

Trước code chỉ được nói “thiết kế nhằm giữ invariant X”; sau kiểm chứng mới nói “đã kiểm chứng giữ X trong phạm vi Y”.

- Baseline: invariant nào cần giữ và vì sao; nguồn hành vi cũ ở revision cụ thể; khác biệt giữa quan sát code, test và runtime. Không bảo toàn bug chỉ vì có trong code (P05).
- Impact: điểm sửa, semantic/auth/state/side effect liên quan, nhóm caller/consumer tìm được và vùng chưa biết. Consumer động hoặc ngoài workspace phải được khai báo; không suy “không tìm thấy” thành “không tồn tại”.
- Verification: kết quả trước/sau hoặc oracle đáng tin, case đại diện từng lớp semantic chịu tác động, revision/snapshot của các bên thực sự tham gia và giới hạn phép kiểm tra. Test mock bỏ seam không chứng minh seam đúng.
- Shared rule: thiếu consumer trọng yếu thì chưa được tuyên bố low-impact hoặc giữ mọi flow. Có thể chọn boundary cô lập có evidence, hoặc chờ owner bổ sung thông tin; timebox không thay evidence.
- Canonical đề xuất là baseline đã giao và có evidence trong phạm vi ghi rõ; accepted delta còn nằm ở change cho tới khi đủ điều kiện. “Đã giao trong code” không tự là “đã deploy”; claim về môi trường cần evidence môi trường. Đây là lựa chọn semantics, chưa chốt topology hub/repo.
- Change owner/dev đánh dấu scenario liên quan `needs-recheck` khi rule, contract, seam, dependency hoặc điều kiện môi trường dùng để chứng minh bị đổi. Người sửa nguồn phải báo tác động; reviewer kiểm tra đối chiếu. Không xóa lịch sử pass, không chạy lại toàn bộ chỉ vì typo không đổi nghĩa (R03).

### 10.4. Ai cho phép đi tiếp khi chưa rõ?

- Agent tự điều tra, tổ chức thông tin và đề xuất trong quyền được giao; không tự chốt policy hoặc tự cấp quyền sửa code.
- BA/PO hoặc policy owner chốt nghĩa nghiệp vụ và tổn hại chấp nhận được. Tech owner chốt kiến trúc/rủi ro kỹ thuật trong thẩm quyền; không thay BA chọn fallback sản phẩm (P06/R04).
- Dev/tech owner có thể xác nhận một lát độc lập đủ Ready khi phần chưa rõ không ảnh hưởng correctness/acceptance của lát; quyền implement vẫn theo ủy quyền người dùng/team. Spike chỉ thu thập evidence, không ship như hành vi accepted.
- Muốn triển khai assumption tạm thì owner phù hợp phải cho phép rõ phạm vi, điều kiện thu hồi và hậu quả; đó là quyết định tạm được ghi nhận, không phải xác nhận yêu cầu gốc đã đúng. Không có owner thì phần phụ thuộc vẫn blocked.
- Change owner đưa decision card qua kênh BA thực dùng (ticket/chat/trao đổi), ghi lại câu trả lời kèm phạm vi và reference; không yêu cầu BA đọc Markdown. Hết timebox hoặc đồng thuận AI không đổi authority.

### 10.5. Phương án rút gọn sau phản biện

1. Một ticket/hồ sơ: mục tiêu, nguồn, phần giữ/đổi và điều chưa biết. Không bắt file mới hay taxonomy ID mới nếu ticket có ID ổn định.
2. Giải quyết uncertainty ảnh hưởng lớn nhất bằng đọc flow có mục tiêu hoặc hỏi đúng owner; trình bày nhu cầu trước chi phí kỹ thuật.
3. Chọn điểm sửa và ghi impact đủ dùng: UI một dòng delta, rule bảng ví dụ, tích hợp dùng state/effect/unknown khi cần.
4. Coverage sweep + claim check rồi mới Ready cho lát đủ rõ; không hard-cap câu hỏi/scenario, không cần thêm agent/tool.
5. Khi được phép triển khai: kiểm chứng outcome mới và invariant cũ; cập nhật evidence/status và mở lại đúng phần bị bác bỏ. Không có bằng chứng phù hợp thì chưa Done trong phạm vi đó.

Áp dụng ba task: UI bỏ diagram/spec riêng; rule chung chờ owner chốt phạm vi áp dụng, không Ready nhờ validate; tích hợp giữ nghiệm thu save/effect/unknown xuyên repo, kể cả crash giữa lưu và ghi intent. “Lưu nội bộ” chỉ là lát giao độc lập nếu owner chấp nhận giá trị và hành vi khi chưa đồng bộ; nếu không, nó chỉ là task bên trong lát tích hợp (R07/P02).

### 10.6. Bất đồng/chưa biết thực sự và handoff

Chưa biết: D có tốt hơn ticket + một cuộc trao đổi trực tiếp hay không (P01). Vẫn chọn D làm ứng viên thử, không đồng ý nâng thành quy trình mặc định trước evidence adoption. Thử task thật và ghi: quyết định thay đổi nhờ phân tích, thời gian chủ động/chờ owner, số lần phải hỏi lại khi handoff; nếu tăng công duy trì mà không có lợi ích, thu nhỏ về ticket. Chưa có cơ sở đặt ngưỡng ROI số học.

| Xử lý | IDs | Nguồn peer và điều phối cần giữ |
|---|---|---|
| Giữ có điều kiện | A01/A02 | P01/P08, R06/R07: lát hành vi, decision-driven kèm coverage sweep; chưa chốt adoption. |
| Sửa | A03/A04 | P07, R02/R03: ticket là artifact hợp lệ; phân biệt desired/delivered/deployed; evidence có phạm vi và `needs-recheck`. |
| Sửa | A05/A06/A07 | P03/P05, R05/R08: độ sâu theo semantic; đủ lớp consumer; không tuyên bố tối ưu/toàn diện tuyệt đối. |
| Sửa | A08/A09 | P02/P04/P06, R01/R04/R06/R07: authority rõ; thiếu review/check không là pass; acceptance xuyên repo. |
| Bỏ | Cách hiểu quota hoặc artifact bắt buộc | P04/P07, R06/R08: không cap câu/scenario; không mặc định sơ đồ/bộ BA/OpenSpec cho UI. |
| Defer | A10 và rollout phương pháp | P01: hiệu quả thực tế, owner mặc định và canonical topology cần thử/chốt; không suy từ tabletop hay phiếu agent. |

Điều phối có thể dùng bảng này để tổng hợp; không ghi “ba agent đồng thuận” nếu chưa có phản hồi Round 2 của peer và quyết định của người có thẩm quyền.
