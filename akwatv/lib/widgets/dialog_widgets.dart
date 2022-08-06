import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/widgets/custom_button.dart';

class DialogWidgets {
  static Future modalBottomSheetMenu(BuildContext context, Widget child,
      {dismiss = true,
      double? height,
      double? minHeight,
      bool isScrollControlled = true,
      bool showCancelButton = true,
      bool removeSpace = false}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        isDismissible: dismiss,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(bottomSheetBorderRadius),
          ),
        ),
        builder: (builder) {
          return Container(
              constraints: BoxConstraints(
                minHeight: minHeight ?? bottomSheetHeight, //
              ),
              height: height ?? bottomSheetHeight,
              padding: const EdgeInsets.symmetric(
                  horizontal: generalHorizontalPadding, vertical: ySpace1),
              margin: isScrollControlled
                  ? EdgeInsets.only(
                      bottom: MediaQuery.of(builder).viewInsets.bottom,
                    )
                  : null,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(bottomSheetBorderRadius),
                      topRight: Radius.circular(bottomSheetBorderRadius))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showCancelButton)
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.close,
                                color: AppColors.white,
                              ))
                        ],
                      ),
                    Center(child: child),
                  ],
                ),
              ));
        });
  }

  static Future dialog(Widget child, BuildContext ctx, bool dismiss) {
    return showDialog(
        context: ctx,
        barrierDismissible: dismiss,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: child,
          );
        });
  }
}
