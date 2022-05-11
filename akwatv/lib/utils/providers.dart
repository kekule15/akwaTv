// import 'package:altsub/services/services.dart';
// import 'package:altsub/utils/navigation.dart';
// import 'package:altsub/viewmodels/activ8_services/activ8_services_vm.dart';
// import 'package:altsub/viewmodels/home_vm.dart';
// import 'package:altsub/viewmodels/viewmodels.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

//...APP SERVICES...
import 'package:akwatv/providers/navigators.dart';
import 'package:akwatv/services/onboarding_http_service.dart';
import 'package:akwatv/view_models.dart/home_vm.dart';
import 'package:akwatv/view_models.dart/login_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navService =
    Provider.autoDispose<NavigationService>((ref) => NavigationService());

// //...ONBOARDING...
// final landingViewModel =
//     Provider.autoDispose<LandingViewModel>((ref) => LandingViewModel(ref.read));
final homeViewModel =
    ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel(ref.read));
final loginViewModel =
    ChangeNotifierProvider<LoginViewModel>((ref) => LoginViewModel(ref.read));
// final signUpViewModel =
//     ChangeNotifierProvider<SignUpViewModel>((ref) => SignUpViewModel(ref.read));
// final signupWithBvnViewModel = ChangeNotifierProvider<SignUpWithBvnViewModel>(
//     (ref) => SignUpWithBvnViewModel(ref.read));
// final passwordResetViewModel = ChangeNotifierProvider<PasswordResetViewModel>(
//     (ref) => PasswordResetViewModel(ref.read));
// final splashViewModel =
//     Provider.autoDispose<SplashViewModel>((ref) => SplashViewModel(ref.read));
// final tandCViewModel = Provider.autoDispose<TermsAndConditionsViewModel>(
//     (ref) => TermsAndConditionsViewModel(ref.read));
// final biometricProvider = Provider.autoDispose<BioMetricAuthentication>(
//     (ref) => BioMetricAuthentication());
final onboardingProvider =
    Provider<OnBoardingService>((ref) => OnBoardingService(ref.read));
// final securityQuestionProvider =
//     ChangeNotifierProvider<SecurityQuestionViewModel>(
//         (ref) => SecurityQuestionViewModel(ref.read));
final passwordObscureProvider = StateProvider.autoDispose<bool>((ref) => true);
// final securityQuestions = ChangeNotifierProvider<SecurityQuestionViewModel>(
//     (ref) => SecurityQuestionViewModel(ref.read));
// final tAndCAgreementProvider = StateProvider.autoDispose<bool>((ref) => false);

// //...CARD...
// final showCitiesDropdownProvider =
//     StateProvider.autoDispose<bool>((ref) => false);
// final checkBossToggle = StateProvider.autoDispose<bool?>((ref) => false);
// final subscriptionProvider = Provider.autoDispose<SubscriptionHttpService>(
//     (ref) => SubscriptionHttpService(ref.watch));

// //...VOUCHER & ACTIV8 SERVICES...
// final voucherCodeVisibleProvider =
//     StateProvider.autoDispose<bool>((ref) => false);
// final activ8ViewModel = ChangeNotifierProvider<Activ8ServicesViewModel>(
//     (ref) => Activ8ServicesViewModel(ref.read));
