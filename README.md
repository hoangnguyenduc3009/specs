# mmd-sdd

Phương pháp nhẹ: BA + đọc code → hiện trạng/delta/impact → Dev chỉnh → phản biện khi cần.
Baseline skill **0.1.0**, dùng thử; chưa đo hiệu quả trên pilot thật.

Mục tiêu giảm AI/Dev **code thừa** khi BA dài, thiếu luồng cũ/mới, chỉ có expect.

## Dùng nhanh

Cài skill từ root `area1/` bằng checkout có sẵn (Python 3, không tải package/network):

```bash
bash mmd-sdd/scripts/install.sh
```

Mặc định cài cả hai skill cho Codex và Cursor bằng symlink. Chạy lại an toàn;
skill đã trỏ đúng sẽ giữ nguyên, xung đột sẽ dừng trước khi ghi. Không có `--force`.

```bash
python3 mmd-sdd/scripts/install.py --client codex
python3 mmd-sdd/scripts/install.py --client cursor --dry-run
python3 mmd-sdd/scripts/install.py --dest /path/to/workspace --client all
```

`install.sh` cũng nhận `--dest`, `--client`, `--dry-run`; mặc định destination là thư mục
đang đứng. `install.py` giữ mặc định là thư mục cha của hub như trước.

### Cài từ GitHub

Sau khi commit **và push** `scripts/install.sh` lên `main`, chạy từ workspace muốn cài:

```bash
curl -fsSL https://raw.githubusercontent.com/hoangnguyenduc3009/specs/main/scripts/install.sh | bash -s -- --client all
```

Chỉ chạy script từ nguồn tin cậy; có thể tải về, đọc rồi mới chạy. Repo private yêu cầu
quyền tải raw và Git clone; nếu không có, clone bằng Git đã xác thực rồi dùng lệnh local.

Remote mode cần Git + Python 3, clone hub vào `<workspace>/mmd-sdd/` và giữ lại vì skill
dùng symlink. Không clone vào thư mục tạm rồi xóa. `--ref <branch-or-tag>` chọn bản clone;
muốn pin cả bootstrap thì đổi `main` trong URL thành cùng tag. Không có auto-update/force.
Nếu hub đã tồn tại, remote mode dừng; kiểm tra checkout rồi chạy installer local.
`--dry-run` remote chỉ in kế hoạch, không tải repo và chưa xác minh nội dung remote.
Nếu lỗi sau clone, hub có thể đã được tạo; kiểm tra và chạy lại bằng installer local.

Giữ hub nguồn vì symlink không copy skill. Nếu cài vào workspace khác, cung cấp đường
dẫn hub cho AI để tìm templates/learning; script không copy tài liệu hoặc cấu hình global.
Nếu client chưa nhận skill, mở phiên mới hoặc dùng đường dẫn file trực tiếp bên dưới.

1. Đưa tài liệu BA vào chat (hoặc `@` file CN/BRD).
2. Gọi skill **`mmd-ba-clarify`** (hoặc nói: làm clarify theo mmd-sdd).
3. Ghi một `pilots/<change-id>/one-pager.md` theo `templates/one-pager.md`.
4. Khi cần, gọi **`mmd-challenge-change`** để kiểm tra phân tích bằng nguồn BA/code.
5. AI ghi run và điều chỉnh của Dev vào `learning/`; Dev duyệt trước khi đổi skill.

Skill canonical được đặt ở `.cursor/skills/` trong hub này. Tại root `area1/`,
`.cursor/skills/` và `.agents/skills/` dùng symlink đến cùng nguồn, không nhân bản nội dung.
Nếu client chưa nhận skill, yêu cầu AI đọc trực tiếp file:

- `mmd-sdd/.cursor/skills/mmd-ba-clarify/` (canonical trong package)
- `mmd-sdd/.cursor/skills/mmd-challenge-change/SKILL.md`

Ví dụ: “Đọc skill mmd-ba-clarify, phân tích tài liệu BA này với các repo liên quan;
chỉ ghi one-pager, chưa code.” Sau đó: “Dùng mmd-challenge-change phản biện one-pager này.”

Không cần mzspec/OCR/OpenSpec để chạy bước này.

## Cấu trúc

| Path | Vai trò |
|------|---------|
| `.cursor/skills/mmd-ba-clarify/` | Skill Cursor |
| `templates/` | Khung questions / as-is-to-be / one-pager |
| `pilots/` | Log từng change |
| `learning/` | Runs, corrections, đề xuất cải tiến, case và version skill |
| `analysis/methodology/` | Phân tích phương pháp (bản hiện hành: `versions/v003/analysis.md`) |

## Vòng học liên tục

Đọc `learning/README.md`. Log có cả phiên chưa có correction và mức độ Dev review,
không dùng số lần sửa ít làm bằng chứng skill tốt. Chỉ lưu nội dung cần thiết, không secrets.
Không tự thay skill, chạy nền hay tự spawn agent. Playbook nằm trong hai skill;
không có dynamic workflow engine, CI gate hoặc product code trong lần triển khai này.

`mmd-sdd/` đã là Git repo độc lập. Baseline cũ lưu trong `learning/baselines/`;
trước mỗi lần nâng version tiếp theo lưu thay đổi qua Git, không ghi đè mất lịch sử.

## Tài liệu phân tích trước triển khai

Bản phương pháp hiện hành: `analysis/methodology/versions/v003/analysis.md` — pain-first,
vòng làm việc chuẩn, bảng expect→as-is→delta và nguyên tắc chống code thừa; đã xử lý
review CF01–CF07. Các bản v001/v002 giữ nguyên để đối chiếu lịch sử.
Khi chạy task, dùng skill + template + learning hiện tại; khi skill và giấy lệch nhau,
ghi nhận vào `learning/` thay vì sửa skill âm thầm.

## Chốt ý tưởng + công nghệ + scaffold

Xem `analysis/methodology/versions/v002/scaffold-decision.md`; ánh xạ giấy ↔ scaffold
trong `analysis/methodology/versions/v003/analysis.md` §12.
