import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';

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
    if (PreferenceUtils.getString(key: 'username') != '') {
      nameController.text = PreferenceUtils.getString(key: 'username');
    }
    if (PreferenceUtils.getString(key: 'email') != '') {
      emailController.text = PreferenceUtils.getString(key: 'email');
    }
    if (PreferenceUtils.getString(key: 'phone') != '') {
      phoneController.text = PreferenceUtils.getString(key: 'phone');
    }
  }

  XFile? image;
  final ImagePicker _picker = ImagePicker();

  takePhoto(ImageSource source, cxt) async {
    final loginViewModel = ref.watch(viewModel);
    setState(() {
      loginViewModel.uploadPicBTN = true;
    });
    final pickedFile = await _picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
      String fileName = image!.path.split('/').last;
      loginViewModel.uploadProfilePic(
        image: await DIO.MultipartFile.fromFile(image!.path,
            filename: fileName, contentType: MediaType('image', 'jpg')),
      );

      setState(() {
        loginViewModel.uploadPicBTN = false;
      });
    } else {
      setState(() {
        loginViewModel.uploadPicBTN = false;
      });
    }

    // Navigator.pop(cxt);
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.watch(viewModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'editProfile'.tr,
          style: const TextStyle(color: AppColors.white),
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
              InkWell(
                  onTap: () {
                    takePhoto(ImageSource.gallery, context);
                  },
                  child: PreferenceUtils.getString(key: 'avatar') == ''
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary,
                          child: loginViewModel.uploadPicBTN
                              ? const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.person))
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary,
                          backgroundImage: NetworkImage(
                              PreferenceUtils.getString(key: 'avatar')),
                          )),
              const SizedBox(
                height: ySpace1,
              ),
              Text(
                'changePicture'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp, color: AppColors.white),
              ),
              const SizedBox(
                height: ySpace3,
              ),
              CustomField(
                style: const TextStyle(color: AppColors.white),
                validate: true,
                 fillColor: AppColors.gray4,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: nameController,
                headtext: 'name'.tr,
                hint: 'enterName'.tr,
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
                headtext: 'email'.tr,
                validate: true,
                fillColor: AppColors.gray4,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: emailController,
                hint: 'enterEmail'.tr,
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
                headtext: 'phone'.tr,
                validate: true,
                 fillColor: AppColors.gray4,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: phoneController,
                hint: 'enterPhone'.tr,
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
                        'continue'.tr,
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
