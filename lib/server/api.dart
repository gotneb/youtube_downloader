import 'package:youtube_downloader/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube_downloader/models/video.dart';

class Api {
  static const _path = 'youtube-downloader-ymzg.onrender.com';

  static Future<Video> getVideo({required String videoURL}) async {
    const pattern = 'https://www.youtube.com/watch?v=';
    final id = videoURL.replaceAll(pattern, '');
    logger.d('video id: $id');

    final url = '/api/data/$id';

    final raw = await http.get(Uri.https(_path, url));
    dynamic json = jsonDecode(utf8.decode(raw.bodyBytes));

    return Video.fromJson(json);
  }
}