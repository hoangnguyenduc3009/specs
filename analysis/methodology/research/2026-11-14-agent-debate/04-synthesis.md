# Tổng hợp tranh luận ba agent

- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Trạng thái: hai vòng tranh luận đã hoàn tất; người dùng đã chốt D-01/D-04 cho pilot, nhưng phương pháp chưa được nghiệm thu sau pilot.
- Nguồn: `README.md`, Round 1–2 của `01-architect.md`, `02-problem-framer.md`, `03-adversarial-reviewer.md`.
- Không biểu quyết theo số agent; các chủ đề có quyết định đề xuất và bất đồng được tách riêng.

## 1. Kết quả cốt lõi sau hai vòng

### Đề xuất 1 — Dùng hồ sơ quyết định, không dùng pipeline artifact làm trung tâm

Cả ba vai bắt đầu từ hướng khác nhưng hội tụ: đơn vị làm việc nên là **lát hành vi + quyết định còn thiếu**, không phải “đã xong intake/design/review”. Không mặc định tạo OpenSpec change, sơ đồ hoặc bộ BA mới. Ticket hiện hữu đủ ổn định thì dùng ticket; chỉ mở thêm artifact khi độc giả hoặc vòng đời thực sự khác.

Phần cần chống lại là decision-driven trở thành chỉ chạy theo câu hỏi nổi bật. Trước khi tuyên bố đủ rõ cho một lát, cần một lượt coverage sweep theo actor, quyền, state, biên, side effect/error, dependency và consumer. Với task nhỏ, sweep có thể chỉ vài dòng. “Không tìm thấy consumer” phải khác “chưa tìm consumer”; vùng chưa biết được ghi `unknown`.

| Nguồn ý tưởng | Điều chỉnh cho Arena |
|---|---|
| mzspec: quality axes, traceability, handoff | Dùng làm checklist; không buộc artifact/agent/command tương ứng |
| code-review: context, claim check, completeness critic | Đưa lên giai đoạn phân tích; không tạo pipeline review mặc định |
| Arena bổ sung | Input BA nhiều lớp, truy flow cũ, semantic reuse/impact, phân quyền và trạng thái bằng chứng |

### Đề xuất 2 — Ba trạng thái và evidence có phạm vi

Đây là safeguard đáng giữ nhất, có sự chỉnh của Adversarial Reviewer:

| Trạng thái | Nghĩa | Điều kiện dùng |
|---|---|---|
| `accepted intent` | Nghiệp vụ/phương án đã được owner chốt cho tương lai | Không dùng làm bằng chứng flow/API hiện có |
| `observed / implemented` | Hành vi hiện có hoặc phần đã làm | Ghi revision, môi trường và giới hạn quan sát |
| `verified` | Đã kiểm chứng trong phạm vi cụ thể | Ghi cách kiểm chứng, revision/môi trường; khi điều kiện đổi thành `stale-needs-recheck` theo phần liên quan |

Cần thêm `implemented-unverified`. Done một task/lát chỉ giữ lịch sử, không giữ hiệu lực kiểm chứng vô điều kiện. Skip, pass hoặc findings rỗng phải có bằng chứng thực thi và lý do; không suy Ready/Done từ verdict xanh, validation cấu trúc hoặc số lượng assertion.

### Đề xuất 3 — “Ít impact” phải có bằng chứng theo semantics

Không tối ưu số dòng diff và không bias ngược lại reuse. Một seam note chỉ cần ở mức đủ cho rủi ro:

- UI cục bộ: điểm chạm, shared/local, hành vi cần giữ, cách kiểm chứng; có thể một dòng.
- Shared rule: phạm vi áp dụng, nhóm consumer khác semantics, source of truth, ví dụ ranh giới và regression cũ; thiếu consumer trọng yếu thì không tuyên bố low-impact.
- Integration: state, side effect, unknown, retry ownership, idempotency và lỗi tại seam; local units xanh không là Done xuyên hệ thống.

Chỉ có thể nói “thiết kế nhằm giữ flow cũ” trước kiểm chứng; sau đó mới nói “đã kiểm chứng giữ X trong phạm vi Y”. Phương án non-code, nếu có, cần xuất hiện trước hoặc cạnh phương án kỹ thuật để BA chọn theo kết quả người dùng, không theo thứ dễ code.

### Đề xuất 4 — Phân quyền và trạng thái chờ rõ ràng

- Agent tự điều tra kỹ thuật, tổ thông tin, đề xuất; không tự chốt nghiệp vụ hoặc tự cấp quyền implement.
- BA/policy owner chốt ý nghĩa nghiệp vụ, phạm vi, ngoại lệ và tổn hại chấp nhận được.
- Tech owner chốt kiến trúc/rủi ro kỹ thuật trong thẩm quyền, không thay BA chọn fallback sản phẩm.
- Default là đề xuất giúp owner quyết nhanh, không phải consent khi im lặng.
- Hết timebox sinh `ask/escalate/split/spike`, không chuyển quyền quyết định. Phần độc lập và đảo ngược được có thể làm, nhưng không khóa lựa chọn đang chờ.

### Đề xuất 5 — Hai cổng cho từng lát

| Cổng | Ý nghĩa đề xuất sau tranh luận |
|---|---|
| `Ready-to-slice / estimate` | Đủ rõ để lập kế hoạch và khoanh rủi ro; chưa đồng nghĩa có quyền tự implement hay mọi câu hỏi đã accepted |
| `Done-with-evidence` | Outcome và invariants của lát được kiểm chứng; ghi rõ phạm vi, revision và phần chưa kiểm chứng |

Điều kiện ở cổng đầu tách ba nhóm: quyết định nghiệp vụ, review/test cần thiết và validation khi áp dụng. Mỗi mục ghi đạt / chưa đạt / chưa chạy / không áp dụng kèm lý do. Không thêm sáu gate hay state machine.

## 2. Hai điểm hồ sơ tranh luận yêu cầu điều phối chốt

### 2.1. Tên cổng đầu

Architect dùng `Ready-to-implement`; Problem Framer phản đối vì dễ hiểu là quyền triển khai khi owner chưa xác nhận. Adversarial Reviewer yêu cầu evidence gate không suy từ status xanh.

**Đề xuất điều phối: dùng `Ready-to-slice / estimate`.**

Nó nghĩa là đủ rõ để chia lát và lập kế hoạch, không phải đã đủ điều kiện sửa code. Nếu muốn triển khai, cần một quyết định hoặc ủy quyền riêng của người dùng/team. Trong pilot, agent không tự thực thi product change.

### 2.2. Mức revision/source index tối thiểu

Problem Framer không muốn bảng metadata cho mọi dòng; Adversarial Reviewer yêu cầu evidence có revision và môi trường. Hai đề xuất có thể hòa bằng trigger:

| Nội dung | Mức tối thiểu bắt buộc |
|---|---|
| Hồ sơ chung | Một revision/snapshot chung hoặc ticket hiện hữu; danh sách nguồn đã xem/phần cắt và phần chưa xem |
| Claim as-is, reuse hoặc impact | Nguồn cụ thể, revision/working-tree của các bên liên quan và nhóm consumer đã biết/chưa biết |
| Accepted intent | Người chốt, ngày, phạm vi và kênh xác nhận |
| Verified | Kiểm chứng thực sự chạy/quan sát, revision/môi trường, kết quả và phần không phủ |
| Task UI nhỏ không đổi rule | Có thể chỉ một dòng delta + nguồn điểm chạm; không cần bảng riêng |

Nguyên tắc: metadata bắt buộc nơi nó có thể đổi kết luận; những phần khác không tạo bảng hình thức. Bắt buộc thêm nguồn khi claim trọng yếu, shared rule, integration hoặc quyết định vẫn mở.

## 3. Kết quả thử trên ba tình huống

| Tình huống | Kết luận sau tranh luận |
|---|---|
| UI thuần | Không cần sơ đồ, OpenSpec hay BA question nếu không đổi hành động, điều kiện, quyền, contract hoặc shared surface. Nhãn “UI” không tự quyết Fast; translation/accessibility/shared key là trigger nâng mức. |
| Rule dùng chung | Một dòng diff không đủ để nói ít impact. Phải xác định phạm vi áp dụng và nhóm consumer khác semantics; thiếu owner thì phần phụ thuộc không Ready. |
| Integration partial failure | Tiêu chí nghiệm thu phải bao gồm `saved`, `side-effect-started`, `acknowledged-unknown`, retry ownership và crash giữa các bước. “Lưu nội bộ” chỉ là lát giao độc lập nếu owner chấp nhận giá trị và hành vi khi chưa đồng bộ. |

## 4. Những điều đã được các vai phản biện và loại bỏ

| Ý tưởng ban đầu | Kết luận sau tranh luận |
|---|---|
| Fast/Standard/Heavy theo loại file hoặc số repo | Giữ nhãn như dự báo chọn góc kiểm tra; semantic, shared surface, side effect và reversibility quyết định độ sâu. Cần ghi ai được hạ/nâng path. |
| Giới hạn ≤3 câu hỏi hoặc scenario | Bỏ hard cap. Có thể giới hạn số mục gửi trong một lượt trao đổi, nhưng mọi blocker/scenario thật vẫn hiển thị với trạng thái. |
| Nhiều agent/panel/refuter mặc định | Không dùng cho phase thử. Hai góc kiểm tra một lần là đủ ứng viên; cần owner xử lý xung đột, không bỏ phiếu AI. |
| “Một phương án hợp lệ là dừng discovery” | Chỉ dừng sau sweep một lượt và ghi vùng unknown; không tìm thấy khác chưa tìm. |
| Six-question seam note cho mọi task | Chuyển thành trigger-based; UI hiển nhiên dùng impact note ngắn. |
| Verdict APPROVE hoặc validate pass là Ready | Không. Ready tách quyết định nghiệp vụ, review/test và validation; thiếu chạy phải ghi “chưa chạy”, không phải “pass”. |
| Canonical accepted là hiện trạng | Không. Chọn ownership canonical vẫn chưa chốt; tạm thời phân biệt accepted intent và observed/implemented. |

## 5. Bất đồng hoặc chưa đủ bằng chứng

| ID | Chủ đề | Trạng thái và điều tiếp theo |
|---|---|---|
| D-01 | Primary user mặc định là Dev/tech lead hay BA | `resolved by user`. Người dùng chọn Dev làm primary user; cùng người có thể đổi mũ Tech Lead/BA khi làm rõ yêu cầu. Chi tiết ở §7. |
| D-02 | Canonical spec là desired hay delivered, và nơi sống khi nhiều repo | `unresolved`. Tạm dùng hai nhãn accepted intent / observed–implemented; chốt khi có product change đầu tiên. |
| D-03 | Hai góc critique hay hai lượt riêng cho Heavy path | `unresolved`. Là ứng viên phase thử, chưa có bằng chứng hiệu quả. |
| D-04 | mmd-sdd có tốt hơn ticket + một trao đổi trực tiếp | `deferred to pilot`. Chạy ít nhất hai task thật khác loại trước khi kết luận; thành công không đo bằng số tài liệu. |

## 6. Đề xuất kế tiếp cho người dùng

1. Chốt D-01 và D-04 trước khi tạo v002 hoặc đóng gói template.
2. Chọn ít nhất hai task thật khác loại để thử phương pháp rút gọn; Minitest chỉ được dùng như một mẫu phụ.
3. Nếu đồng ý đề xuất tổng hợp, yêu cầu tạo v002 từ các nguồn v001 và kết quả debate; không tự scaffold skills/OpenSpec/CI trong bước này.

Đề xuất rút gọn cho thử nghiệm:

```text
Ticket/hồ sơ: mục tiêu, nguồn, giữ/đổi, unknown
   → giải quyết uncertainty ảnh hưởng lớn nhất
   → seam/impact đủ theo semantics
   → coverage sweep + claim check
   → Ready-to-slice/estimate nếu phần phụ thuộc đủ rõ
   → khi được ủy quyền: implement và kiểm chứng outcome + invariants
```

Không coi kết quả tranh luận là phê duyệt phương pháp. Ba agent có thể cùng sai nếu thiếu người quyết và task thật.

## 7. Quyết định người dùng ngày 2026-11-14

| ID | Quyết định | Hệ quả |
|---|---|---|
| D-01 | Chốt primary user là **Dev**. Cùng một người có thể làm rõ yêu cầu và đóng vai Tech Lead/BA, nhưng phải ghi rõ mũ quyết định; quyền thật của owner khác vẫn ưu tiên khi tồn tại. | Hồ sơ v002 dùng Dev làm độc giả chính và thêm quy tắc đổi mũ BA/Tech Lead. |
| D-04 | Đồng ý chạy pilot trước khi đóng gói; cần ít nhất hai task thật khác loại. | Tạo `versions/v002/analysis.md` làm bản pilot draft. Hai task thật cụ thể sẽ chọn ở lượt áp dụng tiếp theo. |

D-02 và D-03 vẫn giữ `deferred`: canonical ownership sẽ chốt khi có product change thật; mức critique cho Heavy path sẽ đánh giá sau pilot.
