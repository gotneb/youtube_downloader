import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path_provider/path_provider.dart';

class VideosForDownload {
  static final _videos = <Video>[];

  static List<Video> get fetchVideos => _videos;
  static Future<void> add(Video video) async {
    _videos.add(video);

    /*
    var yt = YoutubeExplode();
    var manifest = await yt.videos.streamsClient.getManifest(video.id);
    var streamInfo = manifest.muxed.withHighestBitrate();

    var stream = yt.videos.streamsClient.get(streamInfo);
    var downloadPath = '/storage/emulated/0/Download';

    var file = File('$downloadPath/${video.title}.mp4');
    var fileStream = file.openWrite();

    await stream.pipe(fileStream);

    await fileStream.flush();
    await fileStream.close();
    */
  }
}
