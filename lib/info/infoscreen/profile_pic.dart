import 'package:diary/info/infoscreen/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  final ThemeManager themeManager;
  const ProfilePic({
    Key? key,
    required this.themeManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              backgroundImage: AssetImage("assets/info_page/User Icon.png"),
              backgroundColor: Color.fromARGB(255, 211, 211, 211)),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Color(0xFFFFFFFF)),
                  ),
                  backgroundColor: themeManager.primaryColor,
                ),
                onPressed: () {},
                child: SvgPicture.asset(
                  "assets/info_page/Camera Icon.svg",
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
