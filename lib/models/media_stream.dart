// Dart
import 'dart:io';
// Packages
import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:gallery_saver/gallery_saver.dart';
// Mine
import 'package:youtube_downloader/constants.dart';

class MediaStream {
  factory MediaStream.fromJson(Map<String, dynamic> json) {
    logger.d(json);

    return MediaStream._(
      json['resolution'] as String,
      json['bitrate'] as String,
      json['size'] as String,
      json['type'] as String,
      json['url'] as String,
    );
  }

  const MediaStream._(
    this.resolution,
    this.bitrate,
    this.megabytesSize,
    this.type,
    this.url,
  );

  // Audio doesn't have bitrate
  final String? bitrate;
  // Audio doesn't have resolution
  final String resolution;
  final String megabytesSize;
  final String type;
  final String url;

  Future<void> download({
    required String filename,
    required String url,
  }) async {
    final tempDir = await getTemporaryDirectory();
    logger.d('temp: $tempDir');

    final path = '${tempDir.path}/$filename';
    logger.d('path: $path');

    var file = File(path);
    if (!(await file.exists())) {
      file = await file.create();
      logger.d('File created!');
    } else {
      logger.w('Deleting cache video file...');
      await file.delete();
    }

    logger.d('path: $path');
    logger.d('url: $url');

    await Dio().download(url, path);
    await GallerySaver.saveVideo(path);
    logger.i('Download finished!');

    logger.w('Deleting cache video file...');
    await file.delete();
  }

  void debugProgress(int? received, int? total) {
    final percent = (received! / total! * 100).toStringAsFixed(0);
    logger.d('$percent%');
  }

  @override
  String toString() => "$type | $bitrate | $megabytesSize";

  bool get isAudio => type.contains('audio');
  bool get isVideo => type.contains('video'); 
  String get format => type.split('/').last;
}
