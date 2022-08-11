import 'package:akwatv/services/payment_service.dart';
import 'package:akwatv/view_models.dart/subscription_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subScriptionProvider =
    ChangeNotifierProvider.autoDispose<SubScriptionViewModel>(
        (ref) => SubScriptionViewModel(ref.read));


final subScriptionServices =
    Provider<PaymentService>((ref) => PaymentService(ref.read));

