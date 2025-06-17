// main.dart
import 'package:flutter/material.dart';
import 'ListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFD7BBEC), // 设置背景为浅紫色
          centerTitle: true, // 居中标题
          title: const Text(
            'Flutter Demo Home Page',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // 如果你不想用默认白色
            ),
          ),
        ),

        body: ListPage(),
      ),
    );
  }
}
