---
name: mmd-challenge-change
description: >-
  Challenge an existing mmd-sdd change analysis against BA sources and repository
  evidence. Find unnecessary changes, missing behavior and unsafe reuse before coding.
  Use for challenge-change or review of a change one-pager, not general code review.
metadata:
  version: "0.1.0"
---

# Challenge change

Tìm hub `mmd-sdd/` trong workspace (hoặc dùng root nếu đang mở hub).
Đọc one-pager được chỉ định, nguồn BA/code liên quan và `learning/README.md`.
Nếu chưa có phân tích, yêu cầu đường dẫn hoặc đề nghị chạy `mmd-ba-clarify` trước.

## Playbook

1. Xác định revision của phân tích, skill và repo. Kiểm tra bằng chứng còn áp dụng
   cho working tree hiện tại; không kế thừa trạng thái verified của lần trước.
2. Kiểm tra claim ảnh hưởng giải pháp: flow/API cũ có thật không, contract có
   đúng nghĩa không, tạo mới có cần không, consumer/side effect nào bị ảnh hưởng?
3. Quét độc lập phần có thể bị bỏ sót: từng mong muốn BA đã được xử lý chưa,
   hành vi cũ cần giữ có cách kiểm chứng không, câu hỏi có đổi quyết định không?
4. Phân loại: supported / contradicted / unresolved. Finding phải có claim,
   bằng chứng hoặc giới hạn tìm kiếm, hậu quả và hành động đề xuất.
   Không lấy đồng thuận agent làm bằng chứng; không bịa finding để đủ số lượng.
5. Trả findings quan trọng trước, phân biệt blocker với cải tiến tùy chọn.
   Không có finding thì nói rõ phạm vi đã kiểm tra và rủi ro chưa xác minh.

Không sửa product code, tự sửa skill hay tự phê duyệt nghiệp vụ. Giữ findings riêng
trong `pilots/<change-id>/review.md`; lần review tiếp nối thêm lượt và ghi finding đã
được xử lý thế nào, không ghi đè kết luận cũ. Sửa one-pager khi Dev yêu cầu/chấp nhận.
Không tự spawn agent; cùng AI chạy lượt phản biện vẫn dùng được.

Ghi run trong `learning/runs.md`. Findings của AI chưa phải correction đã được Dev
xác nhận; chỉ chuyển sang `learning/corrections.md` khi Dev điều chỉnh hoặc xác nhận,
vẫn phân biệt accepted với verified. Chưa đủ bằng chứng thì trả unresolved và
người cần quyết định; không tự chạy vòng tranh luận vô hạn.
