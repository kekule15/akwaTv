import 'package:akwatv/utils/images.dart';

class VideoModel {
  final String movieImage;
  final String movieName;

  VideoModel(this.movieImage, this.movieName);
}

class PlayModel {
 static List<VideoModel> movieList = [
    VideoModel(omoPreImage, 'Omo Ghetto'),
    VideoModel(wickedAccused1, 'Wicked Accused 1'),  
    VideoModel(badChildImage1, 'Bad Child 1'),
    VideoModel(redHatImage1, 'Red Hat'),
     VideoModel(wickedAccused2, 'Wicked Accused 2'),  
    VideoModel(quams, 'Quam’s Money'),
    VideoModel(redHatImage1, 'Red Hat'),
    VideoModel(badChildImage2, 'Bad Child 2'),
     VideoModel(redHatImage1, 'Red Hat'),
    VideoModel(badChildImage3, 'Bad Child 3'),
    VideoModel(privateteacher, 'Private Teacher'),
    // VideoModel(omoPreImage, 'Omo Ghetto'),
    // VideoModel(omoPreImage, 'Omo Ghetto'),
    // VideoModel(omoPreImage, 'Omo Ghetto'),
  ];
}
