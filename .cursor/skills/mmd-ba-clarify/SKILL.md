---
name: mmd-ba-clarify
description: >-
  Analyze BA/BRD/CN changes against existing Arena code before implementation.
  Identify evidence-backed reuse, necessary delta, impact and focused questions.
  Use for mmd-sdd intake or analyze-change requests, not product implementation.
metadata:
  version: "0.1.0"
---

# Analyze change

Giữ tên `mmd-ba-clarify` để tương thích; đây là vai trò `analyze-change`.
Playbook nằm ngay trong skill, không cần workflow engine.

## Phạm vi và nguồn

- Chỉ phân tích, ghi hồ sơ và đề xuất task. Không sửa product code hay tự tạo OpenSpec change.
- Tìm hub `mmd-sdd/` trong workspace; nếu mở trực tiếp hub thì dùng chính thư mục đó.
  Đọc `templates/one-pager.md` và `learning/README.md` trong hub.
  Không tìm thấy hub thì hỏi vị trí, không ghi vào đường dẫn đoán.
- Dùng Change-Id đã có hoặc đề xuất ID ổn định. Hồ sơ chính:
  `pilots/<change-id>/one-pager.md`; không bắt copy cả bộ template.
- Đọc hướng dẫn repo trước khi điều tra. Ghi repo + revision và thay đổi local liên quan;
  path/symbol cho bằng chứng. Không coi code đã đọc là runtime đã xác minh.

## Playbook linh hoạt

1. Rút mục tiêu BA và In/Out sơ bộ. Đọc hẹp code/page/API liên quan ngay để định hướng,
   không bắt BA trả lời endpoint hay cấu trúc kỹ thuật có thể tự tìm.
2. Trace hiện trạng đến nơi quyết định hành vi: caller, điều kiện, dữ liệu và side effect
   cần thiết. API tồn tại chưa chứng minh đáp ứng đúng semantics.
3. Với từng mong muốn, nối: hiện trạng + bằng chứng → delta cần thiết → điểm sửa,
   consumer bị ảnh hưởng và cách kiểm chứng. Phân biệt giữ/sửa/thêm/xóa/thay thế.
4. Rẽ nhánh theo bằng chứng:
   - Thiếu fact kỹ thuật: tìm repo; nếu không truy cập được, ghi giới hạn và hỏi Dev.
   - Mơ hồ nghiệp vụ làm đổi giải pháp: hỏi người có thẩm quyền, kèm lựa chọn và hệ quả.
   - BA yêu cầu đổi hành vi rõ ràng: ghi delta, không tự coi khác code là mâu thuẫn.
   - Có thể reuse: kiểm tra contract và consumer, không chỉ tên hàm giống nhau.
   - Chưa tìm thấy flow: ghi phạm vi đã tìm và unknown; không kết luận không tồn tại.
   - Thực sự mới: nêu căn cứ và boundary tích hợp; không ép tìm điểm nối giả.
5. Hoàn thiện one-pager. Chỉ thêm sơ đồ trước/sau khi giúp thấy điểm sửa; không audit
   toàn repo. Dừng mở rộng tìm kiếm khi đủ bằng chứng cho quyết định; nếu vẫn chưa đủ,
   ghi rõ unknown thay vì thiết kế chắc chắn dựa trên đoán.
6. Nêu phần có thể chia task, phần bị chặn và quyết định cần Dev/BA duyệt.
   Không tự gán approved. Người yêu cầu quyết định có chạy phản biện hay không.

## Khi Dev điều chỉnh và sau triển khai

- Khi nhận correction có ý nghĩa, ghi theo `learning/README.md`; lưu cả kết luận cũ
  và điều chỉnh, không xóa dấu vết bằng cách chỉ sửa one-pager.
- Có thể sửa hồ sơ task ngay theo chỉ dẫn; không tự sửa skill dùng chung từ một feedback.
- Nếu được yêu cầu kiểm tra sau triển khai: nối diff thực tế với delta, giải thích phần
  phát sinh và kiểm chứng hành vi mới/cũ. Test/migration/refactor cần thiết không mặc định
  là code thừa. Ghi kết quả và phần chưa verify; chưa chạy thì không báo pass.

## Đầu ra

Một one-pager, câu hỏi thực sự còn mở và đường dẫn hồ sơ. Khi kết thúc phiên, ghi một dòng
run trong `learning/runs.md`, kể cả chưa có correction; chỉ ghi thời gian nếu có đo.
Tối ưu thay đổi đúng và an toàn, không tối ưu số dòng code hay số artifact.
