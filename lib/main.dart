import 'package:flutter/material.dart';
import 'package:notion_technologies_task/controller/menu_list_provider.dart';
import 'package:notion_technologies_task/view/menu_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NotionApp());
}

class NotionApp extends StatelessWidget {
  const NotionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuProvider(),
      child: const MaterialApp(
        home: MenuListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
