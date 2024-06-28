import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:noteapp/screens/view/add_screen.dart';
import 'package:noteapp/screens/view/home_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/add',
          page: () => AddScreen(),
        ),
      ],
    ),
  );
}
