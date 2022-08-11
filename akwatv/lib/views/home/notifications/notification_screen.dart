import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewNotificationScreen extends ConsumerStatefulWidget {
  const ViewNotificationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewNotificationScreenState();
}

class _ViewNotificationScreenState
    extends ConsumerState<ViewNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          InkWell(
            onTap: () {
              DateTime today = DateTime.now();
              print(today.add(Duration(days: 30)));
            },
            child: Center(
              child: Text(
                'Hello',
                style: TextStyle(color: AppColors.primary, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
