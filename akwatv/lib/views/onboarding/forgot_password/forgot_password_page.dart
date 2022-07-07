import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/forgot_password/otp_verification_page.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'Forgot Password',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
        child: ListView(
          children: [
            const SizedBox(
              height: ySpace3 * 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter your mail address linked with your Akwa-TV  account',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white, fontSize: 13.sp),
              ),
            ),
            const SizedBox(
              height: ySpace3 * 2,
            ),
            CustomField(
              style: const TextStyle(color: AppColors.white),
              headtext: 'Email Address',
              validator: () {},
              onChanged: (value) {},
              fillColor: AppColors.termsTextColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              controller: emailController,
              hint: 'Enter valid email address',
              hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
              fieldType: TextFieldType.name,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: AppColors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: CustomButton(
            onclick: () {
              Get.to(() => const OTPVerificationPage());
            },
            title: Text(
              'Recover',
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
