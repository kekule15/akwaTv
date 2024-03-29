import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/home/navigation_page.dart';
import 'package:akwatv/views/home/subscription/choose_plan.dart';
import 'package:akwatv/views/onboarding/onboarding_screen.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
    var subname = PreferenceUtils.getString(key: 'subName');
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _time = Tween(begin: 0.0, end: 20.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          Get.to(() => PreferenceUtils.getString(key: 'userId') == ''
              ? const OnboardingScreen()
              : PreferenceUtils.getString(key: 'userId') != '' &&
                      PreferenceUtils.getString(key: 'plan') != ''
                  ? const HomeNavigation()
                  : subname == 'Free'
                      ? const ChoosePlanPage()
                      : const HomeNavigation());
        }
      }));

    _controller.forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _loginViewModel = ref.watch(viewModel);
    final _videoViewModel = ref.watch(videoViewModel);
    _loginViewModel.getProfile;
    _videoViewModel.getVideoList;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = ref.watch(viewModel);
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
