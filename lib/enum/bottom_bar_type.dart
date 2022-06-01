enum TabType { home, booking, video, account, history }

extension TabTypeExtension on TabType {
  String get label {
    switch (this) {
      case TabType.home:
        return 'Trang chủ';
      case TabType.booking:
        return 'Lịch hẹn';
      case TabType.video:
        return 'Videos';
      case TabType.account:
        return 'Tài khoản';
      case TabType.history:
        return 'Lịch sử';
    }
  }
}
