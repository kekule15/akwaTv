import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieControllerViewModel extends BaseViewModel {
  BetterPlayerController? betterPlayerController;
  String movieUrl = '';
  MovieControllerViewModel(Reader read) : super(read);

  void setMovieUrl(String movieLink) {
    movieUrl = movieLink;
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, movieUrl);
    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
          //deviceOrientationsAfterFullScreen: const [DeviceOrientation.portraitUp],
          aspectRatio: 16 / 9,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableSkips: false,
            enableOverflowMenu: false,
          )),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    notifyListeners();
  }
}
