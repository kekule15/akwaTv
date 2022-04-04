import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/onboarding/onboarding_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

// final viewModel = splashViewModel;

class SplashView extends ConsumerStatefulWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Animation? _time;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _time = Tween(begin: 0.0, end: 20.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          Get.to(() => OnboardingScreen());
          //ref.read(viewModel).navigateToReplacement(Routes.landing);
        }
      }));

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bool _visible = true;
    return Scaffold(
        body: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Center(
                child: AnimatedOpacity(
                  opacity: (_time!.value <= 12.5)
                      ? 1.0
                      : (_time!.value >= 14 && _time!.value < 19.8)
                          ? 1.0
                          : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: ImageWidget(
                      asset: (_time!.value <= 14) ? akwaTvLogo : akwaTvLogo),
                ),
              );
            }));
  }
}
