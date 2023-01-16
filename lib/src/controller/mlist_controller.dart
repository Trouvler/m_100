import 'package:get/get.dart';
import 'package:m_100/src/models/mList.dart';
import 'package:m_100/src/repository/MListRepository.dart';

class MlistController extends GetxController {
  late MListRepository _MListRepository;
  RxList<Ml> mlist = <Ml>[].obs;

  @override
  void onInit(){
    super.onInit();
    _MListRepository = MListRepository();
    fetchMlist();
  }

  Future fetchMlist() async {
    var result = await _MListRepository.fetchMlist();
    if(result.isNotEmpty){
      mlist.addAll(result);
    }
  }

}
