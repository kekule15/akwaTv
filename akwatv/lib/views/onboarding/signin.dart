import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/views/onboarding/congratulation_page.dart';
import 'package:akwatv/views/onboarding/forgot_password/forgot_password_page.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final nameController = TextEditingController();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
          child: ListView(
            children: [
              const SizedBox(
                height: ySpace3 * 1,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'SignIn',
                  style: TextStyle(color: AppColors.primary),
                ),
                subtitle: Text(
                  'Welcome back!',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                validator: () {},
                onChanged: (value) {},
                fillColor: AppColors.gray,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: nameController,
                hint: 'Email',
                hintstyle: TextStyle(color: AppColors.white),
                fieldType: TextFieldType.name,
              ),
              const SizedBox(
                height: ySpace1,
              ),
              CustomField(
                validator: () {},
                onChanged: (value) {},
                fillColor: AppColors.gray,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: nameController,
                hint: 'Password',
                hintstyle: TextStyle(color: AppColors.white),
                fieldType: TextFieldType.name,
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomButton(
                borderColor: false,
                color: AppColors.primary,
                onclick: () {
                  Get.to(() => const CongratulationScreen());
                },
                title: Text(
                  'Login',
                  style: TextStyle(color: AppColors.white, fontSize: 16.sp),
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
                          side: BorderSide(width: 1, color: AppColors.primary),
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          }),
                      const Text(
                        'Remeber me',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const ForgotPasswordPage());
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.white),
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
