import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shop_app/app.dart';
import 'package:shop_app/injector.dart' as dl;

void main() async {
  await dl.init();
  await Hive.initFlutter();
  runApp(const ShopApp());
}
