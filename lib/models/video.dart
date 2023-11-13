import 'package:youtube_downloader/models/media_stream.dart';

class Video {
  factory Video.fromJson(Map<String, dynamic> json) {
    final streams = <MediaStream>[];

    // TODO: Refactor it, I can use map on it
    // But for some odd reason, I'm it's triggering an error
    // do it in the future...

    // Audio
    // final List<dynamic> audioStreams = json['audio'];
    // for (final e in audioStreams) {
    //   final media = MediaStream.fromJson(e);
    //   streams.add(media);
    // }

    // Video
    final List<dynamic> videoStreams = json['video'];
    for (final e in videoStreams) {
      final media = MediaStream.fromJson(e);
      streams.add(media);
    }
  
    return Video._(
      author: json['author'] as String,
      duration: json['duration'] as int,
      thumb: json['thumbnail'] as String,
      title: json['title'] as String,
      views: json['views'] as int,
      streams: streams,
    );
  }

  const Video._({
    required this.author,
    required this.duration,
    required this.thumb,
    required this.title,
    required this.views,
    required this.streams,
  });

  final String title;
  final int duration;
  final String thumb;
  final int views;
  final String author;
  final List<MediaStream> streams;

  @override
  String toString() => 'Title: $title\nAuthor: $author\nViews: $views\nDuration: $time\nStreams: ${streams.length}';

  String get cover => 'https://i3.ytimg.com/vi/aO-ZaF4FJls/maxresdefault.jpg';

  String get time {
    final total = duration;
    final minutes = (total ~/ 60).toString();
    final seconds = (total % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
