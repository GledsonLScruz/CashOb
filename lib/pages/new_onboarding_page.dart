import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NewOnboardingPage extends StatefulWidget {
  const NewOnboardingPage({super.key});

  @override
  State<NewOnboardingPage> createState() => _NewOnboardingPageState();
}

class _NewOnboardingPageState extends State<NewOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerMove: (moveEvent) {
          if (moveEvent.delta.dx > 0) {
            print("swipe right");
          }
        },
        child: Container(
          color: Colors.amber,
          child: const Center(child: Text('Page 1')),
        ));
  }
}
