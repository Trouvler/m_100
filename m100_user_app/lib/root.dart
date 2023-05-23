import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/app.dart';
import 'package:m_100/src/controller/auth_controller.dart';
import 'package:m_100/src/models/m100_user.dart';
import 'package:m_100/src/pages/login.dart';
import 'package:m_100/src/pages/signup.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user) {
          if (user.hasData) {
            controller.loginUser(user.data!.uid);
            return FutureBuilder<MUser>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const App();
                } else {
                  return Obx(() => controller.user.value.uid != null
                      ? const App()
                      : SignupPage(uid: user.data!.uid));
                }
              },
            );
          } else {
            return const Login();
          }
        });
  }
}
