import 'dart:async';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/repository/user_repository.dart';

class MainViewModel extends BaseViewModel {
  String content = '';
  int numberMessageUnread = 0;

  final UserRepository userRepository;
  StreamSubscription? streamSubscription;

  MainViewModel(this.userRepository) : super(userRepository);



  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}
