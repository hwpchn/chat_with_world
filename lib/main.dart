import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_with_world/screens/login_screen.dart';
import 'package:chat_with_world/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置为透明
      statusBarBrightness: Brightness.light, // 设置为亮色主题
    ));
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}
