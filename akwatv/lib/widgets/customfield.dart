import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class CustomField extends StatelessWidget {
  CustomField(
      {Key? key,
      this.hint = '',
      this.width,
      this.height,
      this.sIcon,
      this.pIcon,
      this.obscureText = false,
      this.isWordField = true,
      this.maxline,
      this.controller,
      this.contentPadding,
      this.onChanged,
      this.hintstyle,
      this.hintColor,
      this.headtext,
      this.keyboardType,
      this.validate = true,
      this.readonly = false,
      this.autoFocus = false,
      this.fieldType,
      this.maxLength,
      this.useNativeKeyboard = true,
      this.inputDecoration,
      this.fillColor,
      this.onCompleted,
      this.style,
      this.pinPutFieldCount,
      this.textInputFormatters,
      this.shape = BoxShape.rectangle,
      this.mainAxisAlignment,
      this.showPinPrefilledWidget = true,
      this.obscuringCharacter,
      this.validator})
      : super(key: key);

  final Function(String)? onCompleted;
  final String hint;
  final _pinPutFocusNode = FocusNode();
  final Color? fillColor;
  final bool useNativeKeyboard;
  final double? width;
  final double? height;
  final Widget? sIcon;
  final Widget? pIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final Function? validator;
  final TextStyle? hintstyle;
  final Color? hintColor;
  final int? maxline;
  final String? headtext;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextFieldType? fieldType;
  final bool isWordField;
  final bool validate;
  final bool readonly;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool autoFocus;
  final BoxShape? shape;
  final TextStyle? style;
  final int? pinPutFieldCount;
  final MainAxisAlignment? mainAxisAlignment;
  final bool showPinPrefilledWidget;
  final String? obscuringCharacter;
  final List<TextInputFormatter>? textInputFormatters;

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
      shape: shape ?? BoxShape.rectangle,
      borderRadius:
          shape == BoxShape.circle ? null : BorderRadius.circular(5.0),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headtext == null
            ? const SizedBox.shrink()
            : Text(headtext!,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6!
                    .copyWith(fontSize: 13)),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 0,
          //height: inputFieldHeight,
          child: SizedBox(
              width: width,
              height: height,
              child: isWordField
                  ? TextFormField(
                      maxLines: maxline ?? 1,
                      maxLength: maxLength,
                      obscureText: obscureText,
                      controller: controller,
                      readOnly: readonly,
                      autofocus: false,
                      scrollPadding:
                          EdgeInsets.only(bottom: keyboardHeight + 20),
                      enableSuggestions: true,
                      keyboardType: fieldType == TextFieldType.phone
                          ? TextInputType.phone
                          : keyboardType ?? TextInputType.text,
                      onChanged: onChanged,
                      style: style,
                      inputFormatters: textInputFormatters,
                      decoration: InputDecoration(
                        fillColor: fillColor,
                        filled: true,
                        focusColor: fillColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide.none),
                        contentPadding: contentPadding,
                        errorMaxLines: 6,
                        prefixIcon: pIcon,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(textFieldIconPadding),
                          child: sIcon,
                        ),
                        hintText: hint,
                        hintStyle: hintstyle ??
                            Theme.of(context)
                                .inputDecorationTheme
                                .hintStyle!
                                .copyWith(
                                    color: hintColor ??
                                        Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle
                                            ?.color),
                      ),
                      validator: (val) {
                        if (fieldType == TextFieldType.refferal) return null;
                        if (val == null) return 'Invalid input';
                        if (validator == null) {
                          if (fieldType == TextFieldType.bvn) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 11) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.accountNo) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 10) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.pin) {
                            if (val.isEmpty) {
                              return 'Field cannot be empty';
                            } else if (val.trim().isEmpty) {
                              return "Field cannot be empty";
                            } else if (val.length < 4) {
                              return 'Invalid Entry';
                            } else if (int.tryParse(val) == null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else if (fieldType == TextFieldType.phone) {
                            if (val.isEmpty || val.trim().isEmpty) {
                              return 'Field must not be empty';
                            } else if (val.length < phoneNumberFieldLength) {
                              return 'Invalid entry';
                            } else if (int.tryParse(val.replaceAll('+', '')) ==
                                null) {
                              return 'Invalid entry';
                            }
                            return null;
                          } else {
                            if (validate) {
                              if (val.isEmpty &&
                                  (fieldType != TextFieldType.pin)) {
                                return "Field cannot be empty";
                              } else if (val.trim().isEmpty) {
                                return "Field cannot be empty";
                              } else if (fieldType == TextFieldType.amount) {
                                if (double.tryParse(val.replaceAll(',', '')) ==
                                    null) {
                                  return 'Enter a valid amount';
                                } else if (double.tryParse(
                                        val.replaceAll(',', ''))! <=
                                    0) {
                                  return 'Enter a valid amount';
                                }
                              } else if (fieldType == TextFieldType.email) {
                                bool isValidEmail = RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(val);
                                return isValidEmail
                                    ? null
                                    : "Please provide a valid email address";
                              } else if (fieldType ==
                                  TextFieldType.setPassword) {
                                bool isValidPassword = val
                                    .isPasswordValid; //RegExp(r"^(?=.[a-z])(?=.[A-Z])(?=.\d)(?=.[^\da-zA-Z]).{8,15}$").hasMatch(val);
                                return isValidPassword
                                    ? null
                                    : "Password must contain at least one special character,one number,\none lower case letter, one upper case letter and between 8 and\n15 characters long";
                              } else if (fieldType == TextFieldType.nin) {
                                if (val.isEmpty || val.trim().isEmpty) {
                                  return 'Field must not be empty';
                                } else if (val.length < 11) {
                                  return 'Invalid entry';
                                } else if (int.tryParse(val) == null) {
                                  return 'Invalid entry';
                                }
                                return null;
                              }
                            }

                            return null;
                          }
                        } else {
                          validator!(val);
                        }
                        return null;
                      },
                    )
                  : Theme(
                      data: Theme.of(context).copyWith(
                          inputDecorationTheme: const InputDecorationTheme(
                        filled: false,
                      )),
                      child: Pinput(
                          length: pinPutFieldCount! > 0
                              ? pinPutFieldCount!.toInt()
                              : pinCodeFieldLength,
                          validator: (val) {
                            if (val == null) return 'Invalid input';
                            if (pinPutFieldCount! < 1
                                ? val.length < pinCodeFieldLength
                                : val.length < pinPutFieldCount!) {
                              return 'Complete the Pin Fields';
                            }
                            return null;
                          },
                          defaultPinTheme: PinTheme(
                              width: width ?? 45,
                              height: height ?? 50,
                              textStyle: Theme.of(context)
                                  .primaryTextTheme
                                  .headline3!
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                              decoration: pinPutDecoration),
                          onCompleted: onCompleted,
                          obscuringCharacter: obscuringCharacter ?? '*', //●
                          mainAxisAlignment:
                              mainAxisAlignment ?? MainAxisAlignment.center,
                          obscureText: true,
                          controller: controller,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          autofocus: autoFocus,
                          focusNode: _pinPutFocusNode,
                          preFilledWidget: showPinPrefilledWidget
                              ? Container(
                                  height: 35,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1.5,
                                              color: AppColors.white))),
                                )
                              : null),
                    )),
        )
      ],
    );
  }
}
