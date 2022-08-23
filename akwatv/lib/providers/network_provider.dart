import 'package:akwatv/services/payment_service.dart';
import 'package:akwatv/view_models.dart/network_vm.dart';
import 'package:akwatv/view_models.dart/subscription_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkProvider =
    ChangeNotifierProvider.autoDispose<NetWorkViewModel>(
        (ref) => NetWorkViewModel(ref.read));


