import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:diary/info/infoscreen/profile_menu.dart';
import 'package:diary/info/infoscreen/profile_pic.dart';

class ThemeManager {
  Color primaryColor = Color.fromARGB(255, 211, 211, 211);

  void setPrimaryColor(Color color) {
    primaryColor = color;
  }
}

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool isMuted = false; // Variable to track if audio is muted
  double volume = 0.5; // Variable to track the volume level
  AudioPlayer audioPlayer = AudioPlayer();
  ThemeManager themeManager = ThemeManager();

  @override
  void dispose() {
    audioPlayer.dispose(); // 释放音频播放器资源
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    playBackgroundMusic();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(
            themeManager: themeManager,
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "改變主題",
            icon: "assets/info_page/palette.svg",
            press: () => _showColorPickerDialog(context),
          ),
          ProfileMenu(
            text: "音量控制",
            icon: "assets/info_page/audio1.svg",
            press: () => _showVolumeControlDialog(context),
          ),
          ProfileMenu(
            text: "備份",
            icon: "assets/info_page/backup.svg",
            press: () {},
          ),
        ],
      ),
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('選擇顏色'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorButton(
                        Color.fromARGB(255, 238, 224, 203), context),
                    _buildColorButton(
                        Color.fromARGB(101, 186, 168, 152), context),
                    _buildColorButton(
                        Color.fromARGB(112, 131, 151, 136), context),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorButton(
                        Color.fromARGB(93, 255, 209, 70), context),
                    _buildColorButton(Color.fromARGB(57, 4, 138, 168), context),
                    _buildColorButton(
                        Color.fromARGB(75, 254, 102, 79), context),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorButton(
                        Color.fromARGB(41, 155, 39, 176), context),
                    _buildColorButton(Color.fromARGB(37, 233, 30, 98), context),
                    _buildColorButton(Color.fromARGB(85, 0, 0, 0), context),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorButton(Colors.white, context),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showVolumeControlDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.volume_up),
              SizedBox(width: 10),
              Text('音量控制'),
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: volume,
                    onChanged: (newValue) {
                      setState(() {
                        volume = newValue;
                        audioPlayer.setVolume(volume);
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMuted = !isMuted;
                            if (isMuted) {
                              audioPlayer.setVolume(0.0); // 设置音量为静音
                            } else {
                              audioPlayer.setVolume(volume); // 恢复音量
                            }
                          });
                        },
                        child: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                          size: 30,
                          color: isMuted ? Colors.red : Colors.black,
                        ),
                      ),
                      Text('${(volume * 100).toInt()}%'),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void playBackgroundMusic() async {
    await audioPlayer.play(AssetSource('audio/piano.mp3'));
  }

  void pauseBackgroundMusic() async {
    await audioPlayer.pause();
  }

  void stopBackgroundMusic() async {
    await audioPlayer.stop();
  }

  Widget _buildColorButton(Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          themeManager.setPrimaryColor(color);
        });
        Navigator.pop(context);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
    );
  }
}
