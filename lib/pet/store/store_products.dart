import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "711禮卷",
      price: 100,
      size: 12,
      description: dummyText,
      image: "assets/store_page/711.png",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "全家禮卷",
      price: 100,
      size: 8,
      description: dummyText,
      image: "assets/store_page/FamilyMart.png",
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "家樂福禮卷",
      price: 150,
      size: 10,
      description: dummyText,
      image: "assets/store_page/carefour.png",
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "威秀電影票",
      price: 200,
      size: 11,
      description: dummyText,
      image: "assets/store_page/vieshow.png",
      color: Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "line點數",
      price: 50,
      size: 12,
      description: dummyText,
      image: "assets/store_page/linepoint.png",
      color: Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "mycard 點數",
    price: 350,
    size: 12,
    description: dummyText,
    image: "assets/store_page/mycard.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
