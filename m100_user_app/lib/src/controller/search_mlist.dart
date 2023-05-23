import 'package:get/get.dart';
import 'package:m_100/src/models/mList.dart';
import 'package:m_100/src/repository/MsearchRepository.dart';
import '../repository/MListRepository.dart';

class SearchMlistController extends GetxController {
  late MsearchRepository _MsearchRepository;
  RxList<Ml> msearchArlist = <Ml>[].obs;
  RxList<Ml> msearchNmlist = <Ml>[].obs;
  String? searchItem;
  @override
  void onInit(){
    super.onInit();
    _MsearchRepository = MsearchRepository();

  }
  Future fetchSearchArlist(String? searchItem) async {
    var result = await _MsearchRepository.fetchSearchArlist(searchItem);
    if(result.isNotEmpty){
      msearchArlist(result);
    }else{
      msearchArlist.clear();
    }
  }

  Future fetchSearchMnlist(String? searchItem) async {
    var result = await _MsearchRepository.fetchSearchNmlist(searchItem);
    if(result.isNotEmpty){
      msearchNmlist(result);
    }else{
      msearchNmlist.clear();
    }
  }

}