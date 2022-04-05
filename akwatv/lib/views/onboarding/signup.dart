import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
                validator: () {},
                onChanged: (value) {},
                fillColor: AppColors.gray,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: nameController,
                hint: 'Name',
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
                hint: 'Phone Number',
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
                  Get.to(() => const LoginPage());
                },
                title: Text(
                  'Register',
                  style: TextStyle(color: AppColors.white, fontSize: 16.sp),
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
