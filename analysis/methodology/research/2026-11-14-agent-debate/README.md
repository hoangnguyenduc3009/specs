# Tranh luận đa agent về phương pháp mmd-sdd

- Ngày: 2026-11-14, Asia/Ho_Chi_Minh.
- Trạng thái: đã hoàn thành hai vòng tranh luận; bản tổng hợp đề xuất nằm ở `04-synthesis.md`. Chưa có kết luận nào được người dùng phê duyệt.
- Mục đích: tìm phương pháp tối giản cho BA input -> hiểu hiện trạng -> delta/reuse/impact -> làm rõ -> spec và bằng chứng.
- Phạm vi: nghiên cứu và tài liệu; không sửa product code, không scaffold OpenSpec/skills/CI, không thay v001.

## Vai trò và phạm vi ghi

| Agent | Vai trò | Đầu ra riêng |
|---|---|---|
| Hilbert | Idea Architect: đề xuất các phương án và trade-off | `01-architect.md` |
| Rawls | Problem Framer: kiểm tra bài toán, người dùng, mục tiêu và quyết định | `02-problem-framer.md` |
| Averroes | Adversarial Reviewer: tìm phản ví dụ và kiểm chứng giả định | `03-adversarial-reviewer.md` |
| Agent điều phối | Cấp ngữ cảnh, tổ chức phản hồi chéo, tổng hợp và kiểm tra đầu ra | `README.md`, `04-synthesis.md` |

Agent không được tự spawn thêm agent. Mỗi agent chỉ ghi file riêng. Các file ngoài thư mục nghiên cứu này là input chỉ đọc.

## Hai vòng thảo luận

1. **Vòng 1 - Phân tích độc lập:** mỗi vai đưa lập luận, evidence, đề xuất và câu hỏi gửi hai vai còn lại. Nêu ID để phản hồi chính xác.
2. **Vòng 2 - Phản biện chéo:** mỗi agent đọc hai đầu ra kia, trả lời câu hỏi liên quan, ghi đồng ý/phản đối/sửa đề xuất của mình kèm lý do. Không xóa hoặc viết lại vòng 1.
3. **Tổng hợp:** điều phối tách kết luận có bằng chứng, phương án đề xuất, bất đồng và quyết định cần người dùng. Không biểu quyết theo số agent.

Hai vòng là giới hạn cho lượt làm việc này, không phải bằng chứng tất cả câu hỏi đã được giải quyết. Nếu còn bất đồng, giữ nguyên và nêu cách kiểm chứng tiếp; không tự điền quyết định nghiệp vụ.

Việc gửi lặp lại một nhắc nhở không thay đổi nội dung chỉ là thủ tục điều phối khi agent còn đang xử lý, không phải vòng tranh luận thứ ba.

## Tiêu chí tổng hợp

- Đúng bài toán: giúp BA/Dev ra quyết định, không chỉ sinh thêm Markdown.
- Có cơ sở: phân biệt source code, tài liệu mô tả, suy luận và đề xuất.
- Nhẹ: mỗi bước/artifact phải giải quyết rủi ro hoặc quyết định cụ thể.
- Bám hiện trạng: khả năng reuse phải có giới hạn semantic và phạm vi ảnh hưởng.
- Có điểm dừng: biết khi nào đủ làm, khi nào phải hỏi và phần nào vẫn làm độc lập được.
- Có thể chuyển giao: AI/người khác hiểu trạng thái và bước tiếp theo mà không cần toàn bộ chat.
- Không đánh đồng: draft, accepted, implemented và verified là các trạng thái khác nhau.

## Các tình huống thử bắt buộc

- UI thuần, không đổi rule.
- Thay đổi rule dùng chung, có nhiều caller.
- Tích hợp có lỗi một phần, retry hoặc trạng thái chưa xác định.

Đây là các tình huống giả định dùng thử phương pháp, không phải feature đã được phân tích hoặc nghiệm thu trong Arena. Minitest chỉ được dùng như ví dụ phụ.

## Snapshot nguồn

- Repo `mzspec/`: commit `a1301f8` (bản ở root workspace).
- Repo `code-review/`: commit `fda02de`.
- Phương pháp và companion hiện hữu: `../../versions/v001/`.
- Nhận định từ đọc mã là kiểm chứng tĩnh, không phải kết quả chạy workflow hoặc test sản phẩm.

SHA-256 input tại đầu phiên:

```text
77c4cf5a2caac931d00c04c1163fdec8f78c3df47df14e7bc1bf3c4037efdb89  versions/v001/analysis.md
b042626a865769e19cfd114fb37f838bab7d2fd61d5d675a6b232f643228d40c  versions/v001/foundational-clearance.md
2f4a27c51813ea2e7d86e22f1d10cb36baf081d34718c1df94ecda8bfd55cca6  versions/v001/code-review-idea-fit.md
9ce5dd3d3c8451519eeed839ce44f491b57aef85831852e5358561e2f1c54297  versions/v001/v002-merge-backlog.md
```

Các path trong block hash tương đối với `analysis/methodology/`, không phải thư mục phiên tranh luận.

## Cách đọc kết quả

Đọc `04-synthesis.md` trước khi cần quyết định. Đọc ba file agent khi cần kiểm tra lập luận gốc, bất đồng hoặc sự thay đổi quan điểm sau phản biện. Việc đưa một ý tưởng vào kết luận đề xuất không đồng nghĩa người dùng đã phê duyệt.

## Kết quả quan trọng cần xem trước

- Ứng viên phương pháp: hồ sơ quyết định theo lát hành vi, không phải pipeline artifact.
- Hai cổng đề xuất: `Ready-to-slice / estimate` và `Done-with-evidence`.
- Bảo vệ tối thiểu: accepted intent / observed–implemented / verified; sweep một lượt; revision cho claim trọng yếu.
- Bất đồng còn lại: primary user, canonical desired/delivered, mức sweep Heavy và hiệu quả so với ticket + trao đổi trực tiếp.
