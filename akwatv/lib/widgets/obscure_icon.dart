import 'dart:async';

import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsObscure extends ConsumerWidget {
  const IsObscure({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscure = ref.watch(passwordObscureProvider);
    return InkWell(
        onTap: () {
          final isObs = ref.watch(passwordObscureProvider.state);
          isObs.state = !isObs.state;
          // Timer(const Duration(milliseconds: 5000), () => isObs.state = true);
        },
        child: isObscure
            ? const Icon(
                Icons.remove_red_eye,
                color: AppColors.gray2,
              )
            : const Icon(
                Icons.visibility_off,
                color: AppColors.gray2,
              ));
  }
}
