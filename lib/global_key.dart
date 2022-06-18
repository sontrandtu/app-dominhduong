import 'package:dominhduong/repository/booking_repository.dart';
import 'package:dominhduong/repository/home_repository.dart';
import 'package:dominhduong/screens/history/list_history_view_model.dart';
import 'package:dominhduong/screens/main_page/tabs/home/home_view_model.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();
late HomeViewModel homeVM = HomeViewModel(homeRepo: HomeRepository());
late ListHistoryViewModel historyVM = ListHistoryViewModel(repo: BookingRepository());