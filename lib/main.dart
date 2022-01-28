import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/module/home/view/home_view.dart';
import 'package:pet_app/module/home/widget/home_drawer.dart';

void main() {
  runApp(GetMaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeDrawer(),
          HomeView(),
        ],
      ),
    );
  }
}
