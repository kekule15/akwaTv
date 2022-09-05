import 'dart:async';

import 'package:akwatv/providers/network_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/network_checker.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/image_widgets.dart';
import 'package:akwatv/widgets/network_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ViewNotificationScreen extends ConsumerStatefulWidget {
  const ViewNotificationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewNotificationScreenState();
}

class _ViewNotificationScreenState
    extends ConsumerState<ViewNotificationScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final notificationModel = ref.watch(viewModel);
    //final network = ref.watch(networkProvider);
    //networkChecker();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //centerTitle: true,
          backgroundColor: AppColors.black,
          title: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Notifications',
              style: TextStyle(color: AppColors.white, fontSize: 25),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  notificationModel.getNotifications();
                },
                child: const Icon(
                  Icons.refresh,
                  color: AppColors.white,
                  size: 25,
                ),
              ),
            )
          ],
        ),
        backgroundColor: AppColors.black,
        body:RefreshIndicator(
                onRefresh: () async {
                  notificationModel.getNotifications();
                },
                strokeWidth: 2,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    notificationModel.notificationData.data == null
                        ? const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        : notificationModel
                                    .notificationData.data?.data?.isEmpty ==
                                true
                            ? Column(
                                children: const [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'No Notifications Yet',
                                    style: TextStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: List.generate(
                                    notificationModel.notificationData.data!
                                        .data!.length, (index) {
                                  return Card(
                                    color: AppColors.gray4,
                                    child: ListTile(
                                      title: Text(
                                        notificationModel.notificationData.data!
                                            .data![index].title!,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        notificationModel.notificationData.data!
                                            .data![index].message!,
                                        style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 13),
                                      ),
                                    ),
                                  );
                                }),
                              )
                  ],
                ),
              )
           );
  }
}
