
import 'package:akwatv/providers/navigators.dart';
import 'package:akwatv/services/onboarding_http_service.dart';
import 'package:akwatv/view_models.dart/home_vm.dart';
import 'package:akwatv/view_models.dart/login_vm.dart';
import 'package:akwatv/view_models.dart/movie_controller_vm.dart';
import 'package:akwatv/view_models.dart/video_service_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navService =
    Provider.autoDispose<NavigationService>((ref) => NavigationService());

final homeViewModel =
    ChangeNotifierProvider.autoDispose<HomeViewModel>((ref) => HomeViewModel(ref.read));

final loginViewModel =
    ChangeNotifierProvider<LoginViewModel>((ref) => LoginViewModel(ref.read));
final onboardingProvider =
    Provider<OnBoardingService>((ref) => OnBoardingService(ref.read));
final passwordObscureProvider = StateProvider.autoDispose<bool>((ref) => true);

