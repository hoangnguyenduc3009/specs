# Vòng học từ Dev — v0.1.0

Thu thập từ lúc phân tích và tiếp tục sau triển khai. Không cần telemetry, workflow
engine hay tự động khai thác toàn bộ chat. Chỉ lưu đoạn cần thiết, không secrets/PII.

## Trong mỗi task

1. Ghi run vào `runs.md` sau phiên phân tích/phản biện, kể cả không có correction.
   Dùng run ID riêng, gắn Change-Id, skill/version và repo revision trong hồ sơ task.
2. Khi Dev sửa/bác bỏ/bổ sung có ý nghĩa, AI tạo mục trong `corrections.md`, trỏ về run.
   Tách nội dung Dev thực sự nói với nguyên nhân AI suy đoán. Thiếu lý do thì để unknown.
3. Dev có thể xác nhận ngay bằng chat; ghi nguồn/thời điểm. Không yêu cầu Dev viết báo cáo.
   Chưa xác nhận thì để pending, không tự xem là chân lý.
4. AI sửa kết quả task theo chỉ dẫn. Cập nhật kết quả correction sau khi có bằng chứng;
   Dev đồng ý chưa tương đương test/runtime đã xác minh.
5. Khi kết thúc task hoặc có kết quả triển khai, bổ sung điều gì giúp ích, mắc ở bước nào,
   phần chưa biết. Không suy ra hiệu quả từ số lần Dev sửa đơn thuần.

## Khi đề xuất thay đổi skill

- Thông tin riêng task: giữ tại task. Fact Arena: tài liệu tham chiếu có nguồn/revision,
  không biến thành quy tắc phổ quát. Yêu cầu BA đổi không mặc định là lỗi skill.
- Lỗi phương pháp có bằng chứng: tạo đề xuất trong `skill-changelog.md`, nối correction
  và case kiểm tra. Một lỗi nghiêm trọng có thể đủ; không đặt ngưỡng lặp máy móc.
- Dev duyệt trước khi áp dụng. Ghi version trước/sau, kỳ vọng, cách kiểm tra và rollback.
  Không sửa skill âm thầm trong lúc làm task; bản cũ phải truy xuất được qua Git hoặc snapshot.
- Chạy case liên quan bằng bản cũ và mới nếu có thể; so sánh evidence và hành động,
  không so wording. Ghi fail/regression/unresolved trung thực. Chưa chạy không ghi pass.
- Review log khi kết thúc pilot hoặc khi có lỗi lặp/nghiêm trọng; Dev có thể yêu cầu
  bất kỳ lúc nào. Chưa tự lên lịch hay chạy background.

## Đọc hiệu quả theo bước

Nhóm theo hiểu BA / tìm hiện trạng / delta / impact / câu hỏi / chia task / phản biện.
Xem lỗi lặp, đề xuất thừa bị loại có chứng cứ, thiếu sót được phát hiện, rework và lệch
plan–diff. Dùng runs để biết mẫu đã review hay chưa, không chỉ đếm failures.
Không gộp task khác độ khó thành điểm chất lượng duy nhất; không dùng “code tránh được”
hay “không có feedback” như bằng chứng thành công. Kết luận ban đầu là pilot, chưa chứng minh
hiệu quả ngoài thực tế cho đến khi có task thật và kiểm chứng.
