import 'package:youtube_downloader/models/media_stream.dart';

class Video {
  factory Video.fromJson(Map<String, dynamic> json) {
    final streams = <MediaStream>[];
    // Audio
    final List<dynamic> audioStreams = json['audio'];
    audioStreams.map((json) => streams.add(MediaStream.fromJson(json)));
    // Video
    final List<dynamic> videoStreams = json['video'];
    videoStreams.map((json) => streams.add(MediaStream.fromJson(json)));
  
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
  final List<MediaStream>? streams;

  @override
  String toString() => 'Title: $title\nAuthor: $author\nViews: $views\nDuration: $time';

  String get time {
    final total = duration;
    final minutes = (total ~/ 60).toString().padLeft(2, '0');
    final seconds = (total % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
