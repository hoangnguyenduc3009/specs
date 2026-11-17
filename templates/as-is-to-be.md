# As-is → to-be (Phase B)

Khung mở rộng tùy chọn. Có thể thêm xóa/thay thế; flow thực sự mới thì ghi boundary
tích hợp thay vì ép có node cũ. Khác biệt được BA yêu cầu rõ là delta, không phải conflict.

Change-Id: `c-…`  
Nguồn as-is: BA / code (ghi path file nếu có) / mixed

## Flow hiện tại (as-is)

```text
[ ] → [ ] → [ ]
```

Evidence (file/API):

## Expect BA gắn vào đâu

| Expect (tóm) | Node as-is | Giữ / Sửa / Thêm / Xóa / Thay thế | Ghi chú |
|--------------|------------|-----------------------------------|---------|
| | | | |

## Flow đề xuất (to-be)

```text
[ ] → [ ] → [ ]
```

- **Giữ:**  
- **Sửa:**  
- **Thêm:**  
- **Xóa / thay thế:** (consumer bị ảnh hưởng + kế hoạch chuyển tiếp)  
- **Boundary tích hợp:** (chỉ cho flow thực sự mới; ghi phạm vi đã tìm reuse)  

## Lệch / unknown

| Mục | Cách hiểu A vs B | Cần mũ | Blocker? |
|-----|------------------|--------|----------|
| | | | |
