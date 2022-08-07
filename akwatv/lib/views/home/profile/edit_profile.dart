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
import 'package:get_storage/get_storage.dart';

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
  GetStorage box = GetStorage();
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
    if (box.read('username') != '') {
      nameController.text = box.read('username');
    }
    if (box.read('email') != '') {
      emailController.text = box.read('email');
    }
    if (box.read('phone') != '') {
      phoneController.text = box.read('phone');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.watch(viewModel);
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: ySpace1,
              ),
              box.read('avatar') != null
                  ? CircleAvatar(
                      radius: 40.r,
                      backgroundColor: AppColors.primary,
                      backgroundImage: NetworkImage(box.read('avatar')),
                    )
                  : CircleAvatar(
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
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    loginViewModel.updateUserProfile(
                        email: emailController.text.toString(),
                        phone: phoneController.text.toString(),
                        username: nameController.text.toString());
                  } else {}
                },
                title: loginViewModel.updateUser
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'Update',
                        style:
                            TextStyle(color: AppColors.white, fontSize: 16.sp),
                      ),
              ),
              const SizedBox(
                height: ySpace3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
