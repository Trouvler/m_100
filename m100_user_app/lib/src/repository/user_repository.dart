import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_100/src/models/m100_user.dart';

class UserRepository {
  static Future<MUser?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if(data.size == 0){
      return null;
    }else{
      return MUser.fromJson(data.docs.first.data());
    }
  }

  static Future<bool> signup(MUser user) async{
    try{
    await FirebaseFirestore.instance
        .collection('users').add(user.toMap());
    return true;
    }catch(e){
      return false;
    }
  }
}
