## 1. Cài đặt Flutter trên Window
Các bước cài đặt Flutter SDK trên Window

__Bước 1__ − Các bạn truy cập địa chỉ , https://flutter.dev/docs/get-started/install/windows và tải phiên bản mới nhất của Flutter SDK. Hôm nay 08/04/2020 phiên bản mới nhất là  1.12.13 và file tải về là  flutter_windows_v1.12.13+hotfix.9-stable.zip

__Bước 2__ − Giải nén vô thư mục bất kì ví dụ C:\flutter

__Bước 3__ − Cập nhật system path cho thư mục flutter\bin

Trong thanh tìm kiếm ở Start, bạn gõ ‘env’ sau đó chọn Edit environment variables for your account.. Dưới dòng chữ User variables bạn kiểm tra nếu thấy ô Path:, thì thêm đường dẫn đầy đủ của thư mục  flutter\bin sử dụng dấu  ; để ngăn cách với các biến khác.

__Bước 4__ − Flutter cung cấp một tool gọi là  flutter doctor để kiểm tra tất cả những yêu cầu cần thiết cho môi trường phát triển Flutter

```bash
flutter doctor
```

__Bước 5__ − Các bạn chạy lệnh phía trên để hệ thống kiểm tra và đưa ra báo cáo như sau

```bash
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, v1.2.1, on Microsoft Windows [Version
10.0.17134.706], locale en-US)
[√] Android toolchain - develop for Android devices (Android SDK version
28.0.3)
[√] Android Studio (version 3.2)
[√] VS Code, 64-bit edition (version 1.29.1)
[!] Connected device
! No devices available
! Doctor found issues in 1 category.
```

Như thông báo ở trên ta có thấy rằng Flutter SDK đã được cài, Android Tool đã được cài , Android Stuido đã được cài, chưa có kết nối tới thiết bị, bạn cần kết nối thiết bị điện thoại qua USB hoặc bật máy ảo

__Bước 6__ − Cài đặt bản Android SDK mới nhất nếu bạn chưa cài đặt và được cảnh báo bởi  flutter doctor

__Bước 7__ − Cài đặt Android Studio mới nhất nếu bạn chưa cài đặt và được cảnh báo

__Bước 8__ − Bật android emulator hoặc kết nối tới một thiết bị Android

__Bước 9__ − Cài đặt plugin Flutter và Dart cho Android Studio. Hai plugin này sẽ cung cấp các template để tạo ứng dụng Flutter và các tuỳ chọn để chạy và debug ứng dụng Flutter trên Android studio

* Mở Android Studio.
* Chọn File → Settings → Plugins.
* Tìm kiếm  Flutter plugin và click vào Install.
* Chọn Yes khi hệ thống yêu cầu cài đặt Dart plugin.
* Khởi động lại Android studio.

## 2. Cài đặt Flutter in MacOS

Để cài đặt Flutter SDK trên MacOS, các bạn thực hiện theo các bước sau

__Bước 1__ − Truy cập địa chỉ URL, https://flutter.dev/docs/get-started/install/macos và tải về phiên bản Flutter SDK mới nhất

__Bước 2__ − Giải nén vô thư mục bất kì /path/to/flutter

__Bước 3__ − Cập nhật system path bao gồm thư mục flutter bin (ở trong ~/.bashrc file). bằng cách chạy lệnh sau

```bash
&gt; export PATH = "$PATH:/path/to/flutter/bin"
```

__Bước 4__ − Update lại hệ thống và kiểm tra Path bằng lênh sau

```bash
source ~/.bashrc
source $HOME/.bash_profile
echo $PATH
```

Flutter cung cấp một tool, flutter doctor dùng để kiểm tra các yêu cầu cho Fullter tương tự bên Windows.

__Bước 5__ − Cài đặt bản mới nhất XCode nếu được yêu cầu bởi flutter doctor

__Bước 6__ − Cài đặt Android SDK nếu được yêu cầu bởi flutter doctor

__Bước 7__ − Cài đặt bản mới nhất  Android Studio, nếu được yêu cầu bởi flutter doctor

__Bước 8__ − Bật máy ảo android emulator hoặc kết nối tới thiết bị Android nếu bạn phát triển ứng dụng Android

__Bước 9__ − Bật iOS simulator hoặc kết nối tới thiết bị iPhone nếu bạn phát triển ứng dụng iOS

__Bước 10__ − Cài đặt Flutter và Dart plugin cho  Android Studio tương tự như trên

## 3. Tạo ứng dụng Flutter đầu tiên
Trong bài này, mình sẽ hướng dẫn các bạn tạo một Flutter Application đầu tiên trên Android Studio, quan đó giúp các bạn hiểu cơ bản cấu trúc của một project ứng dụng Flutter

__Bước 1__ − Mở Android Studio

__Bước 2__ − Tạo Flutter Project mới: Chọn __Start a New Flutter Project__ hoặc từ menu  __File → New → New Flutter Project__

![img](images/setup-1.jpg)

__Bước 3__ − Có nhiều loại proect Flutter khác nhau chúng ta chọn Flutter Application và nhấn Next.

![img](images/setup-2.jpg)

__Bước 4__ − Đặt tên và mô tả cho Project sau đó chọn Next.

Bạn đặt tên cho project là hello_app hoặc tên bất kì. Chọn đường dẫn thư mục Flutter SDK, nơi lưu trữ project và mô tả của ứng dụng

![img](images/setup-3.jpg)

__Bước 5__ − Điền package_name cho ứng dụng

![img](images/setup-4.jpg)

__Bước 6__ − Nhấn Finish và đợi một lúc để Android Studio tiến hành việc tạo project

Sau khi tạo xong, chúng ta có thể thấy cấu trúc của một project Flutter như bên dưới

![img](images/setup-5.jpg)

## 4. Tạo ứng dụng hỗ trợ build dạng website

__Bước 1__ Thiết lập

Chạy các lệnh sau để sử dụng phiên bản Flutter SDK mới nhất:

```bash
flutter channel stable
flutter upgrade
```

Nếu Chrome được cài đặt, flutter devices lệnh sẽ xuất ra một Chromethiết bị mở trình duyệt Chrome với ứng dụng của bạn đang chạy và một Web Serverthiết bị cung cấp URL phân phối ứng dụng.

```bash
flutter devices
1 connected device:

Chrome (web) • chrome • web-javascript • Google Chrome 88.0.4324.150
```

__Bước 2__ Tạo và chạy

Tạo một dự án mới với hỗ trợ web không khác gì [tạo một dự án Flutter mới](https://flutter.dev/docs/get-started/test-drive) cho các nền tảng khác.

Tạo một ứng dụng mới trong IDE của bạn và nó tự động tạo các phiên bản iOS, Android và web cho ứng dụng của bạn. (Và cả macOS nữa, nếu bạn đã bật hỗ trợ máy tính để bàn .) Từ trình đơn thiết bị kéo xuống, hãy chọn Chrome (web) và chạy ứng dụng của bạn để xem ứng dụng khởi chạy trong Chrome.

Để tạo một ứng dụng mới bao gồm hỗ trợ web (ngoài hỗ trợ di động), hãy chạy các lệnh sau, thay thế myappbằng tên dự án của bạn:

```bash
flutter create myapp
cd myapp
```

Để phân phối ứng dụng của bạn từ localhost trong Chrome, hãy nhập thông tin sau từ đầu gói:

```bash
flutter run -d chrome
```

__Bước 3__ Build ra website

```bash
flutter build web
```

Một bản phát hành sử dụng dart2js (thay vì trình biên dịch phát triển ) để tạo một tệp JavaScript duy nhất main.dart.js. Bạn có thể tạo một bản phát hành bằng cách sử dụng chế độ phát hành ( flutter run --release) hoặc bằng cách sử dụng flutter build web. Điều này điền vào một build/webthư mục với các tệp được xây dựng, bao gồm cả một assetsthư mục, cần được phân phát cùng nhau.

Bạn cũng có thể bao gồm --web-renderer html hoặc --web-renderer canvaskitchọn giữa các trình kết xuất HTML hoặc CanvasKit, tương ứng. Để biết thêm thông tin, hãy xem Trình kết xuất trang web.


