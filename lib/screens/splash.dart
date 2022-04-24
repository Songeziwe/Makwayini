import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quicloc/screens/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  bool showHome = false;
  final double delaTime = 2;

  AnimationController? controller;
  Animation? motionAnimation;
  double size = 20; // for changing the size of the image

  @override
  void initState() {
    super.initState();
    delay();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
    );

    controller!.forward();
    controller!.addListener(() {
      setState(() {
        size = controller!.value * 250;
      });
    });

    motionAnimation = CurvedAnimation(
      parent: controller!,
      curve: Curves.ease,
    );
    controller!.repeat();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Future<void> delay() async {
    Timer(const Duration(milliseconds: 3500), () {
      controller!.dispose();
      showHome = true;
      Navigator.pushNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return showHome
        ? const Home()
        : Scaffold(
            backgroundColor: Colors.pinkAccent,
            body: Center(
              child: SvgPicture.asset('assets/images/quickloc8.svg',
                  width: size, semanticsLabel: 'Quicloc Logo'),
            ),
          );
  }
}
