import 'package:get/get.dart';
import 'package:m_100/src/controller/bottom_nav_controller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(BottomNavController(), permanent: true);
  }
}