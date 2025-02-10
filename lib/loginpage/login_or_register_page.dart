import 'package:diary/loginpage/login_page.dart';
import 'package:diary/loginpage/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: () {
        Navigator.pushNamed(context, '/LoginPage');
      });
    } else {
      return RegisterPage(onTap: () {
        Navigator.pushNamed(context, '/register');
      });
    }
  }
}
