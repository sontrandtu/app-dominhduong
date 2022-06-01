import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dominhduong/constants/firestore_constants.dart';
import 'package:dominhduong/preference/preference.dart';
import 'package:dominhduong/repository/firebase_repository.dart';
import 'package:dominhduong/base/base_view_model.dart';

class MainViewModel extends BaseViewModel {
  String content = '';
  int numberMessageUnread = 0;

  final FirebaseRepository firebaseRepository;
  StreamSubscription? streamSubscription;

  MainViewModel(this.firebaseRepository) : super(firebaseRepository) {
    getNumberMessageUnRead();
  }

  pushFCMTokenToBackend(String? fcmToken) async {
    // final fcmToken = PreferenceManager.getValue<String>(PreferenceManager.KEY_FCM_TOKEN) ?? '';
    firebaseRepository.registerFCMToken(fcmToken);
  }

  // decreaseBadge() {
  //   repository.decreaseBadge(PreferenceManager.getValue<String>(PreferenceManager.KEY_FCM_TOKEN) ?? '');
  // }

  updateOnlineStatus(bool isOnline) async {
    final String userId = PreferenceManager.getValue<String>(PreferenceManager.KEY_USER_ID) ?? '';
    if(userId.isNotEmpty) {
      final result = firebaseRepository.firebaseFirestore.collection(FirestoreConstants.pathUserCollection).doc(userId);
      result.update({FirestoreConstants.isOnline: isOnline});
    }
  }

  Future<void> getNumberMessageUnRead() async {
    final String? userId = PreferenceManager.getValue<String>(PreferenceManager.KEY_USER_ID);
    streamSubscription = firebaseRepository.firebaseFirestore.collection(FirestoreConstants.pathUserCollection).doc(userId).collection(FirestoreConstants.lastMessageCollection).snapshots().listen((event) {
      numberMessageUnread = event.docs.where((e) => !e.get(FirestoreConstants.isRead)).toList().length;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    updateOnlineStatus(false);
    streamSubscription?.cancel();
    super.dispose();
  }
}
