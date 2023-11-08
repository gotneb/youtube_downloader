import 'package:youtube_downloader/debug/logging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube_downloader/models/download_option.dart';

class Api {
  static const _path = 'youtube-downloader-ymzg.onrender.com';

  static Future<List<DownloadOption>> getUrlDownloadVideo({required String id}) async {
    final url = '/api/video/$id';
    logger.d('URL video: $url');

    final raw = await http.get(Uri.https(_path, url));
    List<dynamic> json = jsonDecode(raw.body);

    json.forEach((element) { 
      logger.d('$element');
    });

    return json.map((e) => DownloadOption.fromJson(e)).toList();
  }
}