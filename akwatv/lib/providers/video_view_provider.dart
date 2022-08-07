import 'package:akwatv/services/video_view_http_services.dart';
import 'package:akwatv/view_models.dart/video_service_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoRequestProvider = ChangeNotifierProvider.autoDispose<VideoServiceViewModel>(
    (ref) => VideoServiceViewModel(ref.read));

final videoServiceProvider =
    Provider<VideoViewService>((ref) => VideoViewService(ref.read));
