import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mosque_finder/ui/bottomBar/bottom_bar_screen.dart';
import 'package:mosque_finder/widgets/custom_text.dart';

import '../../navigation/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      NavigationHelper.pushReplacement(context, BottomBarScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 250,
                width: 250,
                child: Image.asset('assets/images/appIcon.jpg'))
          ],
        ),
      ),
    );
  }
}
