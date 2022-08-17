import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/obscure_icon.dart';
import 'package:flutter/services.dart';
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
  

  bool autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _obscure = ref.watch(obscurePasswordProvider);
    final loginViewModel = ref.watch(viewModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'resetPassword'.tr,
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
                'passwordSecurityText'.tr,
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
                style: const TextStyle(color: AppColors.white),
                headtext: 'currentPassword'.tr,
                validate: true,
                 fillColor: AppColors.gray4,
                textInputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: currentPasswordController,
                hint: 'enterCurrentPassword'.tr,
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                fieldType: TextFieldType.password,
                obscureText: _obscure,
                sIcon: const IsObscure(),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                headtext: 'newPassword'.tr,
                validate: true,
                textInputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                 fillColor: AppColors.gray4,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: newPasswordController,
                hint: 'newPasswordText'.tr,
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                fieldType: TextFieldType.password,
                obscureText: _obscure,
                sIcon: const IsObscure(),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                headtext: 'confirmNewPassword'.tr,
                validate: true,
                textInputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                fillColor: AppColors.gray4,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: confirmPasswordController,
                hint: 'confirmNewPassword'.tr,
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
              var form = _formKey.currentState;
              if (form!.validate()) {
                form.save();
                loginViewModel.changeUserPassword(
                    email:   PreferenceUtils.getString(key: 'email'),
                    password: currentPasswordController.text.toString(),
                    newPassword: newPasswordController.text.toString(),
                    confirmPassword: confirmPasswordController.text.toString());
              }
            },
            title: loginViewModel.changePasswordBTN
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    'continue'.tr,
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
