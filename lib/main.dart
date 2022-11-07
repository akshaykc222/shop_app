import 'package:flutter/material.dart';
import 'package:shop_app/app.dart';
import 'package:shop_app/injector.dart' as dl;

void main() async {
  await dl.init();
  runApp(const ShopApp());
}
