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
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  bool btnState = false;
  GetStorage box = GetStorage();

  bool autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(25.w, 70.h, 20.w, 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp),
                  ),
                ),
                Container(),
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  'Create new password to access your Akwa-Tv account',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.sp),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: ySpace3,
                ),
                CustomField(
                  style: const TextStyle(color: AppColors.white),
                  headtext: 'Enter New Password',
                  validator: () {},
                  onChanged: (value) {},
                  fillColor: AppColors.termsTextColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  controller: newPasswordController,
                  hint: '****************',
                  hintstyle:
                      const TextStyle(color: AppColors.gray, fontSize: 11),
                  fieldType: TextFieldType.name,
                ),
                const SizedBox(
                  height: ySpace3,
                ),
                CustomField(
                  style: const TextStyle(color: AppColors.white),
                  headtext: 'Confirm New Password',
                  validator: () {},
                  onChanged: (value) {},
                  fillColor: AppColors.termsTextColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  controller: confirmPasswordController,
                  hint: '****************',
                  hintstyle:
                      const TextStyle(color: AppColors.gray, fontSize: 11),
                  fieldType: TextFieldType.name,
                ),
              ],
            ),
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
