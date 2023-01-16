import 'package:get/get.dart';
import 'package:m_100/src/models/mList.dart';
import 'package:m_100/src/repository/MsearchRepository.dart';
import '../repository/MListRepository.dart';

class SearchMlistController extends GetxController {
  late MsearchRepository _MsearchRepository;
  RxList<Ml> mlist = <Ml>[].obs;
  @override
  void onInit(){
    super.onInit();
    _MsearchRepository = MsearchRepository();

  }
  Future fetchSearchlist(String? searchItem) async {
    var result = await _MsearchRepository.fetchSearchlist(searchItem);
    if(result.isNotEmpty){
      mlist.addAll(result);
    }
  }

}