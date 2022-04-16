import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/forgot_password/reset_password_page.dart';
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
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  var otpValue;
  @override
  void initState() {
    focus1.requestFocus();
    super.initState();
  }

  bool btnState = false;
  GetStorage box = GetStorage();

  bool autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SingleChildScrollView(
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
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty == true) {
                            return;
                          } else {}
                        },
                        controller: otp1,
                        focusNode: focus1,
                        onChanged: (value) {
                          if (value.length > 0) {
                            focus1.unfocus();
                            FocusScope.of(context).requestFocus(focus2);
                          } else {}
                        },
                        style: TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15.w),
                          hintText: '',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        controller: otp2,
                        focusNode: focus2,
                        onChanged: (value) {
                          if (value.length > 0) {
                            focus2.unfocus();
                            FocusScope.of(context).requestFocus(focus3);
                          } else {}
                        },
                        style: TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15.w),
                          hintText: '',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        controller: otp3,
                        focusNode: focus3,
                        onChanged: (value) {
                          if (value.length > 0) {
                            focus3.unfocus();
                            FocusScope.of(context).requestFocus(focus4);
                          } else {}
                        },
                        style: TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15.w),
                          hintText: '',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        controller: otp4,
                        focusNode: focus4,
                        onChanged: (value) {
                          if (value.length > 0) {
                            focus4.unfocus();
                            setState(() {
                              otpValue = "${otp1.text}" +
                                  "${otp2.text}" +
                                  "${otp3.text}" +
                                  "${otp4.text}";
                            });
                          } else {}
                          print(otpValue);
                        },
                        style: TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          hintText: '',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.h,
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
            onclick: otpValue == null
                ? () {}
                : () {
                    Get.to(() => const ResetPasswordPage());
                    // confirmOTP();
                  },
            title: btnState
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    'Reset',
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

  // confirmOTP() async {
  //   print(otpValue);
  //   setState(() {
  //     btnState = true;
  //   });
  //   final FormState? form = _formKey.currentState;
  //   if (!form!.validate()) {
  //     setState(() {
  //       autovalidate = true;
  //       btnState = false;
  //     });
  //   } else {
  //     Map<String, dynamic>? result = await UserSignIn()
  //         .passwordToken(
  //       otpValue!,
  //     )
  //         .catchError((error) {
  //       setState(() {
  //         btnState = false;
  //       });
  //     });
  //     if (result!['error'] == false) {
  //       setState(() {
  //         btnState = false;
  //       });
  //       NotifyMe().showAlert(result['message']);
  //       Get.offAll(() => ResetPassword(
  //             email: result['data'],
  //           ));
  //     } else {
  //       setState(() {
  //         btnState = false;
  //       });
  //       NotifyMe().showAlert(result['message']);
  //     }
  //   }
  // }

}
