import 'package:flutter/material.dart';
import 'package:notion_technologies_task/controller/cart_item_provider.dart';
import 'package:notion_technologies_task/controller/menu_list_provider.dart';
import 'package:notion_technologies_task/view/menu_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const NotionApp());
}

class NotionApp extends StatelessWidget {
  const NotionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider())
      ],
      child: const MaterialApp(
        home: MenuListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
