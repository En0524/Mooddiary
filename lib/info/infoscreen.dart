import 'package:flutter/material.dart';

import 'package:diary/info/infoscreen/body.dart';
import 'package:diary/info/infoscreen/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  //static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 180, 180, 180),
      appBar: AppBar(
        title: Text("個人資料"),
        backgroundColor: Color.fromARGB(199, 0, 0, 0),
      ),
      body: Info(),
    );
  }
}
