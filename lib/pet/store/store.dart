import 'package:diary/pet/spinwheel/spinwheel.dart';
import 'package:diary/pet/store/storebody.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  final int rewards;

  const Store({Key? key, required this.rewards}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  int totalTokens = 1000;
  int cumulativeRewards = 0;

  void updateTokens(int tokens) {
    print('updateTokens called with tokens: $tokens');
    setState(() {
      totalTokens += tokens;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Storebody(rewards: widget.rewards),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SpinWheel()),
            );
          },
        ),
      ),
    );
  }
}
