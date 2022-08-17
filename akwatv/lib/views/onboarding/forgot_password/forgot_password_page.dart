import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/onboarding/forgot_password/otp_verification_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _loginViewModel = ref.watch(viewModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'forgotPassword'.tr,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: ySpace3 * 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'linkEmail'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.white, fontSize: 13.sp),
                ),
              ),
              const SizedBox(
                height: ySpace3 * 2,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                headtext: 'email'.tr,
                validate: true,
                onChanged: (value) {},
                fillColor: AppColors.gray4,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: emailController,
                hint: 'enterEmail'.tr,
                hintstyle: const TextStyle(color: AppColors.gray, fontSize: 11),
                fieldType: TextFieldType.name,
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
                _loginViewModel.forgotPasswordService(
                    email: emailController.text.toString());
              } else {}
            },
            title: _loginViewModel.forgotPasswordBTN
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
