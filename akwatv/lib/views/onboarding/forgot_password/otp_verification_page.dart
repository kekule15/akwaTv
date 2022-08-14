import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/forgot_password/reset_password_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OTPVerificationPage extends ConsumerStatefulWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OTPVerificationPageState();
}

class _OTPVerificationPageState extends ConsumerState<OTPVerificationPage> {
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

 

  bool autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _loginViewModel = ref.watch(viewModel);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(25.w, 70.h, 20.w, 20.h),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'OTP Verification',
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
                  'Enter OTP sent to your Akwa-TV account',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomField(
                  style: const TextStyle(color: AppColors.white),
                  validate: true,
                  isWordField: false,
                  showPinPrefilledWidget: true,
                  pinPutFieldCount: 6,
                  onChanged: (value) {},
                  fillColor: AppColors.gray4,
                  controller: otpController,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  hintstyle:
                      const TextStyle(color: AppColors.gray, fontSize: 11),
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
            borderColor: false,
            color: AppColors.primary,
            onclick: () {
              //print(otpController.text);
              var form = _formKey.currentState;
              if (form!.validate()) {
                form.save();
                _loginViewModel.otpVerificationService(
                    email:  PreferenceUtils.getString(key: 'email'),
                    token: otpController.text.toString());
              } else {}
            },
            title: _loginViewModel.otpLoader
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    'Confirm',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
                  ),
          ),
        ),
      ),
    );
  }

 
 
 
}
