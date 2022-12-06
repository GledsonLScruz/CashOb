import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;

/**
 * Inspiration:
 * https://dribbble.com/shots/16886313-Conceptzilla-Onboarding-Animation-Concept
 * 
 * Code Ref Rive:
 * https://github.com/Richa0305/flutter_plant_growing_anim/blob/master/lib/plant_screen.dart
 * 
 * Doc:
 * https://help.rive.app/runtimes/state-machines
 * 
 * Progress indicator:
 * https://www.youtube.com/watch?v=TiH0HYBFMMI
 * 
 * 
 */
class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              controller: controller,
              children: [
                Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.green.withOpacity(0.3),
                            Colors.green.withOpacity(0.6),
                            Colors.green.withOpacity(0.9)
                          ],
                          begin: Alignment(-1.0, -2.0),
                          end: Alignment(1.0, 2.0),
                          transform: GradientRotation(math.pi / 4),
                          stops: const [0.0, 0.5, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: const Text("")),
                Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.purple.withOpacity(0.3),
                            Colors.purple.withOpacity(0.6),
                            Colors.purple.withOpacity(0.9)
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(0.0, 1.0),
                          stops: const [0.0, 0.5, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: const Text("")),
                Container(
                  color: Colors.green.withAlpha(60),
                  child: const Center(child: Text('')),
                ),
                Container(
                  color: Colors.purple,
                  child: const Center(child: Text('')),
                ),
                Container(
                  color: Colors.pink,
                  child: const Center(child: Text('')),
                )
              ],
            ),
            Center(child: Text("animation")),
            Positioned(
                bottom: 150,
                right: 100,
                left: 100,
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!isLastPage) {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showHome', true);
                        Modular.to.navigate("/home");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                    child: Icon(
                        isLastPage
                            ? Icons.check
                            : Icons.arrow_forward_ios_rounded,
                        color: Colors.white),
                  ),
                )),
            Positioned(top: 20, right: 30, child: Text("skip"))
          ],
        ),
      ),
    );
  }
}

/**
 * 
 
onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);

                  Modular.to.navigate("/home");
                },
                child: const Text('get started')

onPressed: () {
                          controller.jumpToPage(2);
                        }

controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                              */