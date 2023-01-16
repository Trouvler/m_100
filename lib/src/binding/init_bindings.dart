import 'package:get/get.dart';
import 'package:m_100/src/controller/bottom_nav_controller.dart';
import 'package:m_100/src/controller/mlist_controller.dart';
import 'package:m_100/src/controller/search_mlist.dart';

import '../controller/auth_controller.dart';
import '../controller/mypage_controller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(MlistController(),permanent: true);
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);

  }

  static additionalBinding(){
    Get.put(SearchMlistController(), permanent: true);
    Get.put(MypageController(), permanent: true);
  }
}