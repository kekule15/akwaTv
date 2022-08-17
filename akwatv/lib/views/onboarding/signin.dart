import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/providers/video_view_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/views/home/subscription/congratulation_page.dart';
import 'package:akwatv/views/onboarding/forgot_password/forgot_password_page.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/obscure_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final obscurePasswordProvider = passwordObscureProvider;
final viewModel = loginViewModel;
final videoViewModel = videoRequestProvider;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = true;
  bool btnLoader = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool _obscure = ref.watch(obscurePasswordProvider);
    final _loginViewModel = ref.watch(viewModel);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
          child: ListView(
            children: [
              const SizedBox(
                height: ySpace3 * 1,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  'login'.tr,
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'welcome'.tr,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                textInputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                headtext: 'email'.tr,
                validate: true,
                fillColor: AppColors.gray4,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: emailController,
                hint: 'enterEmail'.tr,
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                fieldType: TextFieldType.email,
              ),
              const SizedBox(
                height: ySpace1,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                fieldType: TextFieldType.password,
                textInputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                headtext: 'password'.tr,
                validate: true,
                fillColor: AppColors.gray4,
                obscureText: _obscure,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: passwordController,
                hint: 'enterPassword'.tr,
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                sIcon: const IsObscure(),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomButton(
                borderColor: false,
                color: AppColors.primary,
                onclick: () async {
                  // var locale = const Locale('fr');

                  // Get.updateLocale(locale);

                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    _loginViewModel.login(
                      emailController.text.toString(),
                      passwordController.text.toString(),
                    );
                  } else {}
                  // Get.to(() => const CongratulationScreen());
                },
                title: _loginViewModel.loginBtn
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'login'.tr,
                        style:
                            TextStyle(color: AppColors.white, fontSize: 16.sp),
                      ),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          activeColor: AppColors.white,
                          checkColor: AppColors.primary,
                          side: const BorderSide(
                              width: 1, color: AppColors.primary),
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          }),
                      Text(
                        'rememberMe'.tr,
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const ForgotPasswordPage());
                    },
                    child: Text(
                      'forgotPassword'.tr,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
