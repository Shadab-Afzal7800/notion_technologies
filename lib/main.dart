import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notion_technologies_task/view/menu_screen.dart';

void main() {
  runApp(const NotionApp());
}

class NotionApp extends StatelessWidget {
  const NotionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
