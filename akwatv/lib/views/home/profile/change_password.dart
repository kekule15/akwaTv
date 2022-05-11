import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/forgot_password/otp_verification_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/obscure_icon.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  bool btnState = false;
  GetStorage box = GetStorage();

  bool autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _obscure = ref.watch(obscurePasswordProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'Change Password',
          style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Update  password to secure your\n Akwa-Tv account',
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                headtext: 'Current Password',
                validate: true,
                fillColor: AppColors.termsTextColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: newPasswordController,
                hint: 'enter your current password',
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                fieldType: TextFieldType.password,
                obscureText: _obscure,
                sIcon: const IsObscure(),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                headtext: 'New Password',
                validate: true,
                fillColor: AppColors.termsTextColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: newPasswordController,
                hint: 'enter your new password',
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                fieldType: TextFieldType.password,
                obscureText: _obscure,
                sIcon: const IsObscure(),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                headtext: 'Confirm New Password',
                validate: true,
                fillColor: AppColors.termsTextColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: confirmPasswordController,
                hint: 'confirm your new password',
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                fieldType: TextFieldType.password,
                obscureText: _obscure,
                sIcon: const IsObscure(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: AppColors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: CustomButton(
            onclick: () {
              Get.to(() => const LoginPage());
            },
            title: Text(
              'Submit',
              style: TextStyle(color: AppColors.white, fontSize: 14.sp),
            ),
            borderColor: false,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
