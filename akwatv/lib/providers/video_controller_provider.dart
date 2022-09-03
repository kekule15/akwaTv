
import 'package:akwatv/view_models.dart/movie_controller_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoControllerProvider =
    ChangeNotifierProvider.autoDispose<MovieControllerViewModel>(
        (ref) => MovieControllerViewModel(ref.read));


