import 'package:flutter/material.dart';
import 'package:youtube_downloader/models/video_detail.dart';
import 'package:youtube_downloader/screens/downloads.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadOptions extends StatelessWidget {
  static const double _iconSize = 40;
  static const double _height = 65;

  final Video video;
  final StreamManifest manifest;
  final YoutubeExplode yt;

  final VoidCallback onClicked;

  late final FileSize audioSize;
  late final FileSize videoSize;
  late final VideoDetail videoDetail;

  DownloadOptions({
    required this.video,
    required this.manifest,
    required this.yt,
    required this.onClicked,
    Key? key,
  }) : super(key: key) {
    audioSize = manifest.audioOnly.withHighestBitrate().size;
    videoSize = manifest.muxed.withHighestBitrate().size;
    videoDetail = VideoDetail(
      manifest: manifest,
      video: video,
      yt: yt,
    );
  }

  @override
  Widget build(BuildContext context) {
    final musicButton = _createButton(
      icon: Icons.music_note_outlined,
      text: '$audioSize',
      option: Type.music,
    );

    final videoButton = _createButton(
      icon: Icons.duo_outlined,
      text: '$videoSize',
      option: Type.video,
    );

    return AlertDialog(
      title: const Text('Qual desejas?'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        width: 400,
        height: _height,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(child: videoButton),
            Container(color: Colors.grey, width: 2),
            Flexible(child: musicButton),
          ],
        ),
      ),
    );
  }

  Widget _createButton({
    required IconData icon,
    required String text,
    required Type option,
  }) {
    return InkWell(
      onTap: option == Type.video ? downloadVideo : downloadAudio,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon, size: _iconSize),
            Text(text),
          ],
        ),
      ),
    );
  }

  void downloadVideo() {
    videoDetail.streamInfo = manifest.muxed.withHighestBitrate();
    Downloads.add(videoDetail);
    onClicked();
  }

  void downloadAudio() {
    videoDetail.streamInfo = manifest.audioOnly.withHighestBitrate();
    videoDetail.type = Type.music;
    Downloads.add(videoDetail);
    onClicked();
  }
}
