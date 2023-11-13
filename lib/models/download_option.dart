import 'package:youtube_downloader/models/media_stream.dart';
import 'package:youtube_downloader/models/video.dart';

// Wrapper for which option user has choosed
class DownloadOption {
  const DownloadOption({
    required this.video,
    required this.stream,
  });

  final Video video;
  final MediaStream stream;
}
