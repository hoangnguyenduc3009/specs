# mmd-sdd: Phương pháp Spec-Driven Development nhẹ cho Arena

- Version: v002.
- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Trạng thái: phương pháp đã có quyết định pilot từ người dùng; chưa phải phương pháp production và chưa được nghiệm thu sau pilot.
- Nguồn: `versions/v001/analysis.md`, `versions/v001/foundational-clearance.md`, `versions/v001/code-review-idea-fit.md`, `versions/v001/v002-merge-backlog.md`, review composer-01/composer-02 và tranh luận đa agent `research/2026-11-14-agent-debate/`.
- Quyết định mới của người dùng: primary user là Dev; cùng một người có thể làm rõ yêu cầu và đóng vai Tech Lead/BA, nhưng phải đổi “mũ” và ghi rõ vai trò khi quyết định.
- Không phải: bộ skill đã scaffold, workflow CI, orchestrator, spec product Minitest hoặc cam kết hai-PR.

## 1. Thay đổi chính so với v001

| Vấn đề v001 | Quyết định v002 |
|---|---|
| Sáu hoạt động dễ hiểu là pipeline bắt buộc | Đổi trung tâm thành “lát hành vi + quyết định còn thiếu”; activity chỉ là góc kiểm tra. |
| Fast/Standard/Heavy chưa đủ vận hành | Giữ ba nhãn dự báo, nhưng độ sâu thực tế theo semantic, shared surface, side effect và reversibility. |
| Primary user chưa chốt | Chốt Dev là người dùng chính; BA/Tech Lead là “mũ quyết định” có thể do cùng một người đảm nhiệm khi phù hợp. |
| Câu hỏi BA có nguy cơ thành quota | Không hard-cap số blocker/scenario; chỉ giới hạn số mục gửi trong một lượt trao đổi. |
| “Ít code” dễ hiểu là “ít impact” | Yêu cầu seam note theo semantic; UI nhỏ có thể một dòng, shared rule/integration phải có bằng chứng sâu hơn. |
| Validate có thể bị hiểu là nghiệm thu | Tách decision, review/test, validation và verified evidence. |
| Canonical có thể bị hiểu là hiện trạng | Tạm dùng `accepted intent` khác `observed/implemented` khác `verified`; topology canonical defer. |

## 2. Quyết định vận hành

### P1 — Đích giai đoạn này

Đích là **phương pháp pilot dùng được bằng tay**: đủ rõ để Dev nhận task BA, truy hiện trạng, khoanh delta và biết phần nào phải hỏi/chốt trước khi sửa.

Không lấy số file, số scenario hay việc ship một product làm Definition of Done của phương pháp. Sau ít nhất hai pilot thật khác loại, mới cân nhắc đóng gói thành skill/template.

### P2 — Primary user và ba “mũ”

**Dev là người dùng chính của hồ sơ phân tích.** Người này chịu trách nhiệm chuyển yêu cầu thành quyết định làm gì, giữ gì và kiểm chứng gì.

Vì Arena đang vận hành nhẹ, một người có thể đảm nhiệm nhiều vai. Nhưng mỗi quyết định phải ghi rõ “mũ” tại thời điểm chốt:

| Mũ | Quyết định được phép chốt |
|---|---|
| BA | Mục tiêu người dùng, phạm vi, nghĩa nghiệp vụ, ví dụ đúng/sai, thứ tự ưu tiên. |
| Tech Lead | Điểm nối, kiến trúc cục bộ, phạm vi ảnh hưởng, migration/rollout, trade-off kỹ thuật. |
| Dev | Cách triển khai trong khung đã được chốt, thứ tự task nội bộ, test cụ thể. |

Quy tắc chống tự lừa:

1. Không ghi “BA đã chốt” chỉ vì chính Dev nghĩ ra ý định nghiệp vụ.
2. Khi cùng một người đổi mũ, phải tách dòng quyết định: ai quyết, theo mũ nào, căn cứ gì.
3. Nếu tổ chức có BA/Tech Lead thật hoặc owner khác có thẩm quyền, quyền thật thắng quyền giả định trong hồ sơ.
4. Agent/AI không có thẩm quyền chốt nghiệp vụ hay tự nâng draft thành accepted.

Moment of use chính là **trước khi cam kết scope/cách làm**, và khi code/evidence bác bỏ giả định ban đầu.

### P3 — Ba nhãn dự báo, không phải ba bộ folder

| Nhãn | Dùng khi dự báo | Độ sâu tối thiểu |
|---|---|---|
| Fast | Không đổi điều kiện, quyền, trạng thái, contract hay side effect. | Ticket/ngắn ghi: mục tiêu, delta, điểm chạm, hành vi giữ, cách kiểm chứng. |
| Standard | Đổi rule dùng chung, điều kiện hiển thị gắn quyền, contract hoặc nhiều consumer. | Thêm decision table/ví dụ phân biệt, caller/impact note, test bảo vệ hành vi cũ/mới. |
| Heavy | Đổi vòng đời, tích hợp, dữ liệu quan trọng, migration hoặc side effect khó đảo ngược. | Thêm state/side effect/unknown, retry ownership, rollback/compatibility, kiểm chứng tại seam. |

Nhãn chỉ là dự báo ban đầu. Không route theo số file hay repo. Khi phát hiện shared key, accessibility, quyền, side effect hay caller ngoài dự kiến, phải nâng độ sâu. Ngược lại, có thể hạ sau một lượt sweep nếu không còn semantic thay đổi và người hạ được ghi rõ.

### P4 — Xử lý lệch nguồn

Khi BA, chat, design, spec hoặc code lệch nhau:

```text
Ghi hai cách hiểu → tạo ví dụ phân biệt → xác định owner/mũ phù hợp
  → chốt hoặc ghi blocked → chỉ lát phụ thuộc mới được coi accepted
```

Code là bằng chứng hiện trạng, không tự thắng yêu cầu tương lai. Chat không thành yêu cầu trừ khi được ghi lại. Default chỉ là đề xuất giúp owner quyết nhanh; im lặng không phải consent.

Hết timebox chỉ đổi hành động: hỏi/escalate, tách lát độc lập, hoặc làm spike chưa cam kết. Không tự nâng giả định thành accepted.

### P5 — Nơi sống hồ sơ giai đoạn này

Giai đoạn pilot chỉ version phương pháp tại `mmd-sdd/analysis/methodology/`. Product change thật chưa mở canonical OpenSpec tại hub. Khi có change thật, trước khi dùng OpenSpec cần chốt nơi sống spec theo capability/repo và cách tham chiếu revision.

Tạm thời không tạo hai nguồn chân lý cho cùng một hành vi.

### P6 — Pilot

Phải thử trên ít nhất hai task thật khác loại trước khi đóng gói skill/template. Ba mẫu tối thiểu cần đại diện:

1. UI không đổi rule.
2. Rule dùng chung có nhiều caller.
3. Integration có lỗi một phần, retry hoặc trạng thái chưa xác định.

Hai task thật sẽ chọn ở lượt áp dụng tiếp theo. Minitest chỉ dùng làm mẫu phụ, không phải DoD phương pháp.

## 3. Đơn vị trung tâm

Đơn vị làm việc là **lát hành vi + quyết định còn thiếu**, không phải “đã xong intake/design/review”.

Một lát đủ rõ phải trả lời:

1. Kết quả quan sát được là gì?
2. Điều kiện/actor/state nào chọn lát này?
3. Hành vi nào giữ nguyên?
4. Delta là gì?
5. Điểm nối hoặc seam ở đâu?
6. Quyết định nào còn thiếu và ai quyết?
7. Kiểm chứng nào phân biệt cũ/mới và lỗi tại ranh giới?

Không bắt mọi lát có đủ sơ đồ. Với task nhỏ, một bảng hoặc vài dòng là đủ.

## 4. Hồ sơ tối thiểu

Hồ sơ có thể nằm trong ticket hiện hữu. Chỉ mở file riêng khi cần handoff, review hoặc vòng đời khác ticket.

| Phần | Nội dung tối thiểu |
|---|---|
| Goal | Mục tiêu người dùng, In/Out, owner hoặc mũ quyết định, nguồn. |
| Slice | As-is, delta, invariant cần giữ. |
| Unknown | Điều chưa biết, phần bị chặn, trạng thái `unknown`. |
| Decision | Ví dụ phân biệt, owner/mũ, default đề xuất, trạng thái draft/accepted. |
| Seam/impact | Điểm nối, consumer, semantic reuse, hành vi cũ/mới cần kiểm chứng. |
| Verification | Cách kiểm chứng thực sự và điều kiện không phủ. |

Không tạo bộ BRD mới, brief, BA pack, handoff và spec chứa cùng một thông tin chỉ để đủ mẫu.

## 5. Flow làm việc

```text
BA input / ticket
   ↓
Mục tiêu + lát ứng viên + unknown
   ↓
Chọn uncertainty ảnh hưởng lớn nhất
   ├─ kỹ thuật chưa rõ → Dev điều tra có mục tiêu
   ├─ nghiệp vụ chưa rõ → BA hat/BA thật chốt bằng ví dụ
   └─ kiến trúc/trade-off → Tech Lead hat chốt trong thẩm quyền
   ↓
Delta + seam + hành vi giữ
   ↓
Claim check + coverage sweep một lượt
   ↓
Ready-to-slice/estimate
   ↓
Được ủy quyền thì implement + verify
   ↓
Giả định sai → mở lại đúng quyết định bị ảnh hưởng
```

Coverage sweep kiểm tra actor, quyền, state, boundary, side effect/error, dependency và consumer. Với task nhỏ có thể vài dòng, nhưng phải phân biệt “không tìm thấy” với “chưa tìm”.

## 6. Trạng thái và bằng chứng

| Trạng thái | Nghĩa |
|---|---|
| `draft` | Đang phân tích hoặc đề xuất, chưa có owner chốt. |
| `accepted intent` | Nghiệp vụ/phương án đã được owner/mũ có thẩm quyền chốt cho tương lai. |
| `observed` | Hành vi hiện có được đọc/quan sát; không phải mong muốn tương lai. |
| `implemented-unverified` | Đã làm nhưng chưa có bằng chứng kiểm chứng. |
| `verified` | Đã kiểm chứng thật trong phạm vi, revision/môi trường cụ thể. |
| `stale-needs-recheck` | Điều kiện của bằng chứng cũ đã đổi. |

Bằng chứng tối thiểu theo trigger:

| Nội dung | Bắt buộc |
|---|---|
| Hồ sơ chung | Nguồn đã xem/phần cắt; revision/snapshot chung hoặc ticket ổn định. |
| Claim as-is/reuse/impact | Nguồn cụ thể, revision các bên liên quan, consumer đã biết/chưa biết. |
| Accepted intent | Người/mũ chốt, ngày, phạm vi, kênh xác nhận. |
| Verified | Kiểm chứng thực sự chạy/quan sát, revision/môi trường, kết quả và giới hạn. |

Validate cấu trúc chỉ chứng minh định dạng. Review pass hoặc nhiều AI đồng ý không thay quyết định owner hay test thực sự.

## 7. “Ít impact” và reuse

Không tối ưu số dòng diff; cũng không bias ngược lại reuse. Reuse là ứng viên phải chứng minh semantic phù hợp.

| Tình huống | Mức bằng chứng impact |
|---|---|
| UI cục bộ không đổi rule | Điểm chạm, shared/local, hành vi giữ, cách kiểm chứng; có thể một dòng. |
| Shared rule | Phạm vi áp dụng, nhóm consumer, source of truth, ví dụ boundary, regression hành vi cũ. |
| Integration | `saved`, `side-effect-started`, `acknowledged-unknown`, retry ownership, idempotency và lỗi tại seam. |

Chỉ được nói “thiết kế nhằm giữ flow cũ” trước kiểm chứng. Sau kiểm chứng mới được nói “đã giữ X trong phạm vi Y”.

## 8. Câu hỏi BA và phân quyền

Không hỏi BA điều có thể tự điều tra trong repo. Không để agent tự quyết fallback sản phẩm.

Mỗi câu hỏi đáng gửi phải có:

```text
ID:
Ví dụ phân biệt:
Cách hiểu A/B:
Default đề xuất:
Ảnh hưởng nếu chọn sai:
Owner / mũ cần chốt:
Chặn lát nào:
Trạng thái: draft | answered | blocked
```

Có thể gửi tối đa ba câu ưu tiên trong một lượt trao đổi để tránh quá tải, nhưng đây không phải giới hạn số blocker thật. Các câu còn lại vẫn hiển thị và không bị hạ severity chỉ để đủ quota.

## 9. Hai cổng

| Cổng | Điều kiện |
|---|---|
| `Ready-to-slice/estimate` | Goal, In/Out, owner/mũ rõ; ví dụ phân biệt đúng/sai; baseline có nguồn; không còn blocker ảnh hưởng lát; seam/impact đủ theo rủi ro; có cách kiểm chứng mới + cũ. |
| `Done-with-evidence` | Thay đổi khớp accepted intent; kiểm chứng thật chạy/quan sát; regression bảo vệ invariant; revision/spec/code tương ứng ghi rõ; khác biệt phát hiện khi làm đã xử lý/chốt lại. |

`Ready-to-slice/estimate` không phải quyền tự sửa code. Khi muốn triển khai cần một quyết định hoặc ủy quyền riêng.

## 10. Ranh giới với mzspec và code-review

Giữ ý tưởng:

- Draft khác accepted; chất lượng spec theo clarity, testability, minimality, consistency, completeness.
- Traceability hai chiều nhưng cho phép task phục vụ verification/rollout, không ép tạo requirement giả.
- Context không mù contract.
- Hai lượt kiểm tra: claim check và coverage sweep.
- Evidence có revision/môi trường và stale/recheck.

Không lấy ở giai đoạn này:

- Orchestrator, gate resolver, hooks, hai-PR bắt buộc.
- Nhiều agent/panel mặc định hoặc bỏ phiếu AI.
- OCR/code-review framework chạy trên spec.
- Full QA pipeline, mining, GHA template hoặc state machine engine.

## 11. Điều kiện nghiệm thu phương pháp

Thành công nếu trên pilot thật:

1. Hồ sơ giúp nói rõ làm gì, không làm gì, giữ gì và vì sao.
2. Ít nhất một uncertainty có ảnh hưởng được phát hiện sớm hoặc cô lập đúng phần bị chặn.
3. Người thực thi biết phần nào có thể làm độc lập và phần nào chờ owner/mũ nào.
4. Chi phí ghi chép thấp hơn hoặc tương xứng với rủi ro giảm được; task nhỏ không bị ép ceremony.
5. Evidence giúp kiểm tra lại đúng phần liên quan khi giả định/spec đổi.

Thất bại nếu:

1. Sinh nhiều tài liệu nhưng vẫn hỏi lại cùng một quyết định.
2. Agent giấu unknown để đạt Ready.
3. Reuse “ít diff” gây sai semantic mà claim check không bắt được.
4. Task UI nhỏ bị chờ BA dù không có câu hỏi nghiệp vụ.
5. Validate xanh bị hiểu là nghiệp vụ đã chốt hoặc hệ thống đã verified.

## 12. Lịch sử

| Version | Trạng thái | Nội dung |
|---|---|---|
| v001 | Draft for review | Đề xuất phân tích từ luồng hiện hữu, delta và giảm impact. |
| v002 | Pilot draft | Gộp review, companion và tranh luận đa agent; chốt Dev là primary user, mô hình đổi mũ BA/Tech Lead; chờ hai task thật để nghiệm thu phương pháp. |

<!-- Append pilot evidence below this boundary; do not edit the accepted v002 rationale retroactively. -->

## Phụ lục A — User intent bổ sung (2026-11-15)

Pain và vòng làm việc mong muốn được ghi đầy đủ tại `core-problem-and-loop.md` (cùng thư mục). Tóm tắt:

1. Pain cốt lõi: BA dài, thiếu trọng tâm và **luồng cũ/mới**, chỉ có expect → AI/Dev **code thừa**; thực tế thường chỉ cần neo flow cũ và sửa hẹp.
2. Thứ tự bắt buộc về tư duy: hỏi–đáp clear bức tranh (+ API/page liên quan) → tổng hợp BA ngắn → đối chiếu code, flow trước/sau → đánh giá impact → mới chia task hoặc xuất OpenSpec/mzspec (cân nhắc loại) → sau task lưu Q/decision/changelog/review để học lại (ý mining kiểu code-review).
3. v002 đã có đủ “lát / unknown / seam / mũ” nhưng chưa đặt pain và vòng này lên đầu; đề xuất gộp vào **v003** sau khi xác nhận phụ lục này.

**Cập nhật 2026-11-17:** v003 đã được tạo theo chỉ đạo hợp nhất của người dùng —
`../v003/analysis.md`. Bản đó đặt pain lên đầu, chỉnh vòng [1]–[7] theo review
`reviews/2026-11-15-core-focus-review.md` (CF01–CF07) và ghi disposition từng finding.
v002 đóng băng làm tài liệu đối chiếu guardrail.
