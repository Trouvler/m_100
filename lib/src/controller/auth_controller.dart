import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_100/src/binding/init_bindings.dart';
import 'package:m_100/src/models/m100_user.dart';
import 'package:m_100/src/repository/user_repository.dart';

class AuthController extends GetxController{
  static AuthController get to => Get.find();

  Rx<MUser> user = MUser().obs;
  Future<MUser?> loginUser(String uid)async{
    var userData = await UserRepository.loginUserByUid(uid);
    if(userData!=null){
      user(userData);
      InitBinding.additionalBinding();
    }
    //DB조회

    print(userData);
    return userData;
  }

  void signup(MUser signupUser, XFile? thumbnail) async {
    if (thumbnail == null) {
      _submitSignup(signupUser);
    } else {

      var task = uploadXFile(thumbnail,
          '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
      task.snapshotEvents.listen((event) async {
        print(event.bytesTransferred);
        if (event.bytesTransferred == event.totalBytes && event.state == TaskState.success){
          var downloadUrl = await event.ref.getDownloadURL();
          var updateUserData = signupUser.copyWith(thumbnail : downloadUrl);
          _submitSignup(updateUserData);
        }
      });
    }
  }
  UploadTask uploadXFile(XFile file, String filename){
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);

    return ref.putFile(f);
    //users/{uid}/porfile.jpg
  }
    void _submitSignup(MUser signUser) async {
      var result = await UserRepository.signup(signUser);
      if (result){
        loginUser(signUser.uid!);
      }

    }
}