import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  bool btnLoader = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    updateData(context);
    super.didChangeDependencies();
  }

  updateData(BuildContext context) {
    final _loginViewModel = ref.watch(viewModel);
    var user = _loginViewModel.userProfileData.data!.data;
    if (user!.username != '') {
      nameController.text = user.username!;
    }
    if (user.email != '') {
      emailController.text = user.email!;
    }
    if (user.phone != '') {
      phoneController.text = user.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _loginViewModel = ref.watch(viewModel);
    var user = _loginViewModel.userProfileData.data!.data;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
        child: ListView(
          children: [
            const SizedBox(
              height: ySpace1,
            ),
            CircleAvatar(
              radius: 40.r,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.person),
            ),
            const SizedBox(
              height: ySpace1,
            ),
            Text(
              'Tap to change your picture',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: AppColors.white),
            ),
            const SizedBox(
              height: ySpace3,
            ),
            CustomField(
              style: const TextStyle(color: AppColors.white),
              validate: true,
              fillColor: AppColors.termsTextColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              controller: nameController,
              headtext: 'Name',
              hint: 'Name',
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
              headtext: 'Email address',
              validate: true,
              fillColor: AppColors.termsTextColor,
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
              headtext: 'Phone number',
              validate: true,
              fillColor: AppColors.termsTextColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              controller: phoneController,
              hint: 'Phone number',
              hintstyle: const TextStyle(color: AppColors.white),
              fieldType: TextFieldType.phone,
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
                } else {
                  setState(() {
                    btnLoader = false;
                  });
                }
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
                      'Update',
                      style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                    ),
            ),
            const SizedBox(
              height: ySpace3,
            ),
          ],
        ),
      ),
    );
  }
}
