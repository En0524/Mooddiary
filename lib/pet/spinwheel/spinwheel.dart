import 'package:diary/pet/store/store.dart';
import 'package:diary/pet/store/storebody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  int rewards = 0;
  int tickets = 0; // 初始票卷数量为

  List<int> items = [100, 200, 300, 400, 500];

  List<Color> colors = [
    Colors.grey[300]!,
    Colors.grey[300]!,
    Colors.grey[300]!,
    Colors.grey[300]!,
    Colors.grey[300]!,
    Colors.grey[300]!,
    Colors.grey[300]!,
  ];
  int signInCount = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void coin() {
    int copy = 0;
    copy = rewards;
    rewards += copy;
  }

  void updateSignInStatus() {
    setState(() {
      //signInCount++;
      if (signInCount == 7) {
        colors[6] = Colors.yellow;
        signInCount = 1;
        colors = [
          Colors.yellow, // 將此處改為你想要的第一個元素的顏色
          for (int i = 0; i < 6; i++) Colors.grey[300]!,
        ];
      } else {
        colors[signInCount] = Colors.yellow;
        signInCount++;
      }
      tickets++; // 完成簽到后獲得一個票卷
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("已簽到！獲得 1 張票卷。"),
      ),
    );
  }

  void showNoTicketsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("沒有票卷"),
          content: Text("您目前沒有票卷，完成簽到可獲得票卷。"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("確定"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("商店"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.local_grocery_store_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Store(rewards: rewards)),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "票卷數量",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      tickets.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      7,
                      (index) => GestureDetector(
                        onTap: () {
                          if (index == signInCount) {
                            updateSignInStatus();
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text((index + 1).toString()),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (tickets >= 0) {
                updateSignInStatus();
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ]),
              //        color: Colors.grey[300],
              child: Text(
                '點擊簽到',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: FortuneWheel(
                      selected: selected.stream,
                      animateFirst: false,
                      indicators: <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment
                              .topCenter, // <-- changing the position of the indicator
                          child: TriangleIndicator(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                      items: [
                        for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                          FortuneItem(
                              child: Text(
                                items[i].toString(),
                                selectionColor: Colors.black,
                              ),
                              style: FortuneItemStyle(
                                  color: Color.fromARGB(255, 254, 221,
                                      57), // <-- custom circle slice fill color
                                  borderColor: Color.fromARGB(255, 0, 0,
                                      0), // <-- custom circle slice stroke color
                                  borderWidth: 5,
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        },
                      ],
                      onAnimationEnd: () {
                        setState(() {
                          rewards = items[selected.value];
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("你獲得了 $rewards 代幣!"),
                          ),
                        );
                        Store store =
                            context.findAncestorWidgetOfExactType<Store>()!;
                        coin();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (tickets > 0) {
                        setState(() {
                          selected.add(Fortune.randomInt(0, items.length));
                          tickets--;
                        });
                      } else {
                        showNoTicketsDialog();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text("轉動一次"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
