import 'package:diary/calendar/calendar.dart';
import 'package:diary/diary/diary.dart';
import 'package:diary/loginpage/login_page.dart';
import 'package:diary/loginpage/register_page.dart';
import 'package:diary/navigationbar/navigationbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();
  FirebaseAuth.instance.setLanguageCode('zh-TW');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(onTap: null),
      // home: BottonNavBar(),

      //加route
      routes: {
        // "/": (context) => IntroScreen(),
        '/register': (context) => RegisterPage(onTap: null),
        '/LoginPage': (context) => LoginPage(onTap: null),
        '/calender': (context) => Calendar(),
        '/navBar': (context) => const BottonNavBar(),
        '/keepdiary': (context) => Diary(),
        //'/showdiary':(context) =>

        //'/store': (context) => Storebody(),
      },

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
        GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
        GlobalWidgetsLocalizations.delegate // 指定默认的文本排列方向, 由左到右或由右到左
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("zh"),
        Locale.fromSubtags(
            languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
      ],
    );
  }
}
