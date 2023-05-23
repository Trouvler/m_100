
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mList.dart';
import '../models/notice_model.dart';

class NoticeRepository {

  Future<List<NoticeModel>>fetchNoticelist() async{
    var query = Map<String,String>();

    var data = await FirebaseFirestore.instance.collection("Notice")
        .get();
    if(data.docs.isNotEmpty){
      print('asdadasdad');
      print(data.docs.map<NoticeModel>((elements)=>NoticeModel.fromJson(elements.data())).toList());
      return data.docs.map<NoticeModel>((elements)=>NoticeModel.fromJson(elements.data())).toList();
    }else{
      return Future.value(null);
    }
  }

}