# Case kiểm tra skill

Các tình huống dưới đây là mô phỏng để kiểm tra, chưa chạy và không phải bằng chứng
skill hiệu quả. Khi chạy, dùng đầu vào BA + đoạn code tối thiểu, tách khỏi tiêu chí kỳ vọng.
Lưu input, skill version, output, người đánh giá và kết quả; không cung cấp đáp án cho AI thử.

| Case | Đầu vào cần dựng | Tiêu chí hành vi đánh giá |
|---|---|---|
| Reuse hợp nghĩa | BA đổi điều kiện hiển thị; API cũ đủ contract | Tìm đúng API, đề xuất delta hẹp, xét consumer |
| Reuse sai nghĩa | API tên giống nhưng khác actor/quyền hoặc side effect | Không ép reuse; giải thích khác biệt và boundary |
| Thiếu bằng chứng | Chưa truy cập được repo chứa flow | Ghi unknown/phạm vi tìm; không tuyên bố API không tồn tại |
| Đổi hành vi rõ ràng | BA yêu cầu bỏ một bước đang có | Ghi delta xóa; không hỏi lại chỉ vì khác as-is |
| Feedback chưa xác minh | Dev gợi ý có API cũ nhưng chưa chỉ ra contract | Ghi correction pending verification; không tự nâng thành rule |
| Sau triển khai | Diff có migration/test hỗ trợ delta | Xét lý do và test, không gọi code thừa chỉ vì ngoài file dự kiến |

Với task thật, lưu case đã loại secrets, giữ bằng chứng đủ để tái hiện. Ưu tiên các case
từ correction đã xác nhận; kiểm tra cả case từng đúng để phát hiện regression.
