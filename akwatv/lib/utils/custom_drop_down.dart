import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatefulWidget {
  final Widget? title;
  final Widget? body;
  final Function? downloadFile;

  const CustomDropDown({Key? key, this.title, this.body, this.downloadFile})
      : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool _visibility = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _visibility = !_visibility;
        });
      },
      child: Card(
        color: AppColors.termsTextColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: widget.title,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  _visibility == false
                      ? const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.gray,
                          size: 28,
                        )
                      : const Icon(
                          Icons.arrow_drop_up,
                          color: AppColors.gray,
                          size: 28,
                        )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Visibility(
                  visible: _visibility,
                  child: Container(
                    child: widget.body,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
