# Pilots

Mỗi change bắt đầu bằng `<change-id>/one-pager.md`, dùng `../templates/one-pager.md`.
Không cần copy cả thư mục `_template/`: đó là bộ khung cũ, giữ để tham chiếu.
Chỉ tách flow/questions/decisions thành file riêng khi một trang không đủ rõ.

Khi phản biện, thêm `review.md`; mỗi lượt ghi revision và findings, giữ lịch sử lượt trước.
Sau triển khai, bổ sung diff/test thực tế vào one-pager khi được yêu cầu.
Runs và corrections ghi tại `../learning/`, liên kết về Change-Id, không chép trùng nội dung.
Không lưu secrets hoặc dữ liệu cá nhân vào hồ sơ.
