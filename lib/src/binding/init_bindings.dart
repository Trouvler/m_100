import 'package:get/get.dart';
import 'package:m_100/src/controller/bottom_nav_controller.dart';
import 'package:m_100/src/pages/mypage.dart';

import '../controller/auth_controller.dart';
import '../controller/mypage_controller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding(){
    Get.put(MypageController(), permanent: true);
  }
}