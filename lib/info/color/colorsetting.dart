import 'package:diary/info/color/theme_option.dart';
import "package:flutter/material.dart";

class colorsetting extends StatefulWidget {
  MainPage createState() => MainPage();
}

class MainPage extends State<colorsetting> {
  bool _isSwitchedOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            leading: Icon(Icons.palette),
            title: Text("Theme"),
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  ThemeOption(color: Colors.black),
                  ThemeOption(color: Colors.blue),
                  ThemeOption(color: Colors.blueGrey)
                ],
              )
            ],
          ),
          SwitchListTile(
            tileColor: _isSwitchedOn
                ? Color.fromARGB(255, 246, 194, 141)
                : Colors.white,
            title: Text(
                _isSwitchedOn ? 'Color Switched ON' : "Color Switched OFF"),
            value: _isSwitchedOn,
            onChanged: (bool value) {
              setState(() {
                _isSwitchedOn = value;
              });
            },
            subtitle: Text(_isSwitchedOn ? "black Color" : "White Color"),
            secondary: const Icon(Icons.color_lens),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("English"),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/setting/language");
            },
          ),
        ],
      ),
    );
  }
}
