import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum Type { video, music }

class VideoDetail {
  Type type;
  final StreamManifest manifest;
  late StreamInfo streamInfo;
  final Video video;
  final YoutubeExplode yt;

  VideoDetail({
    required this.manifest,
    required this.video,
    required this.yt,
    this.type = Type.video,
  });
}
