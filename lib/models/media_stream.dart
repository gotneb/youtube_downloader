// Dart
import 'dart:io';
// Packages
import 'package:dio/dio.dart';
import 'package:file_support/file_support.dart';
import 'package:gallery_saver/gallery_saver.dart';
// Mine
import 'package:youtube_downloader/constants.dart';

class MediaStream {
  factory MediaStream.fromJson(
    Map<String, dynamic> json, {
    void Function(int, int)? onProgress,
  }) {
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

  Future<void> download({void Function(int, int)? onProgress}) async {
    final tempDir = await getTemporaryDirectory();
    logger.d('temp: $tempDir');

    final path = '${tempDir.path}/example.mp4';
    logger.d('path: $path');

    var file = File(path);
    if (!(await file.exists())) {
      file = await file.create();
      logger.d('Cache file created!');
    } else {
      logger.w('Deleting cache file...');
      await file.delete();
    }

    logger.d('url: $url');

    await Dio().download(url, path, onReceiveProgress: onProgress);
    await GallerySaver.saveVideo(path);
    logger.i('Download finished!');

    logger.i('Deleting cache video file...');
    await file.delete();
  }

  @override
  String toString() => "$type | $bitrate | $megabytesSize";
  String get format => type.split('/').last;
}
