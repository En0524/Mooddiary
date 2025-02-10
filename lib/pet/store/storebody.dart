import 'package:diary/pet/store/set.dart';
import 'package:diary/pet/store/store_products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storebody extends StatefulWidget {
  final int rewards;

  Storebody({Key? key, required this.rewards}) : super(key: key);

  @override
  _StorebodyState createState() => _StorebodyState();
}

class _StorebodyState extends State<Storebody> {
  int totalRewards = 0;
  bool isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _loadRewards();
  }

  void _loadRewards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /*if (isFirstLaunch) {
      isFirstLaunch = false;
      await prefs.remove('rewards'); // 刪除代幣紀錄
    }*/
    int savedRewards = prefs.getInt('rewards') ?? 0;
    setState(() {
      totalRewards = savedRewards + widget.rewards;
    });
    _saveRewards(totalRewards);
  }

  Future<void> _saveRewards(int rewards) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rewards', rewards);
  }

  void _showPurchaseConfirmationDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確定購買 ${product.title}?'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('確認'),
              onPressed: () {
                if (totalRewards >= product.price) {
                  _performPurchase(product);
                  Navigator.of(context).pop();
                  _showPurchaseSuccessDialog(context);
                } else {
                  Navigator.of(context).pop();
                  _showPurchaseFailureDialog(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _performPurchase(Product product) {
    // Perform the purchase logic here
    // For example, deduct the price from the user's rewards
    // and update the total rewards accordingly
    setState(() {
      totalRewards -= product.price;
    });
    _saveRewards(totalRewards);
  }

  void _showPurchaseSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('購買成功'),
          content: Text('代幣: $totalRewards'),
          actions: <Widget>[
            TextButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPurchaseFailureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('購買失敗'),
          content: Text('代幣不足'),
          actions: <Widget>[
            TextButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "代幣: $totalRewards",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        //Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Container(
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => itemcard(
                    product: products[index],
                    press: () {
                      _showPurchaseConfirmationDialog(context, products[index]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class itemcard extends StatelessWidget {
  final Product product;
  final Function press;

  const itemcard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            press();
          },
          child: Container(
            padding: const EdgeInsets.all(kDefaultPaddin),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
              color: product.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(product.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 10),
          child: Text(
            product.title,
            style: const TextStyle(color: kTextLightColor),
          ),
        ),
        Text(
          "\$${product.price}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
