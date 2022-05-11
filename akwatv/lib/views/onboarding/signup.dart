import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/obscure_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
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
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'SignUp',
                  style: TextStyle(color: AppColors.primary),
                ),
                subtitle: Text(
                  'Signup to start your free seven days trial',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                validate: true,
                fillColor: AppColors.gray,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: nameController,
                hint: 'UserName',
                hintstyle: const TextStyle(color: AppColors.white),
                fieldType: TextFieldType.name,
              ),
              const SizedBox(
                height: ySpace1,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                textInputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                validate: true,
                fillColor: AppColors.gray,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: emailController,
                hint: 'Email address',
                hintstyle: const TextStyle(color: AppColors.white),
                fieldType: TextFieldType.email,
              ),
              const SizedBox(
                height: ySpace1,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                textInputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                validate: true,
                fillColor: AppColors.gray,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: phoneController,
                hint: 'Phone number',
                hintstyle: const TextStyle(color: AppColors.white),
                fieldType: TextFieldType.phone,
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
                validate: true,
                fillColor: AppColors.gray,
                obscureText: _obscure,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: passwordController,
                hint: 'Password',
                hintstyle: const TextStyle(color: AppColors.white),
                sIcon: const IsObscure(),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomButton(
                borderColor: false,
                color: AppColors.primary,
                onclick: () async {
                  setState(() {
                    btnLoader = true;
                  });
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    _loginViewModel.register(
                        nameController.text.toString(),
                        emailController.text.toString(),
                        passwordController.text.toString(),
                        phoneController.text.toString());
                    await Future.delayed(const Duration(seconds: 2), () {
                      if (_loginViewModel.signupData.data != null) {
                        setState(() {
                          btnLoader = false;
                        });
                        Get.to(() => const LoginPage());
                      } else {
                        setState(() {
                          btnLoader = false;
                        });
                      }
                    });
                  } else {
                    setState(() {
                      btnLoader = false;
                    });
                  }
                  // Get.to(() => const CongratulationScreen());
                },
                title: btnLoader
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'Register',
                        style:
                            TextStyle(color: AppColors.white, fontSize: 16.sp),
                      ),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              const Text(
                'By creating an account you agree to our',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Get.to(const CreateAccountScreen());
                    },
                  text: 'terms ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'and ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Conditions',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Get.to(const CreateAccountScreen());
                        },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
