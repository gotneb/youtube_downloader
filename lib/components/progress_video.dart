import 'package:flutter/material.dart';
import 'package:youtube_downloader/styles/progress_video.dart' as style;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ProgressVideo extends StatelessWidget {
  final VoidCallback onClickedClose;

  final Video video;

  ProgressVideo({
    required this.video,
    required this.onClickedClose,
  });

  @override
  bool operator ==(Object other) {
    if (other is ProgressVideo) {
      return other.video.title == video.title;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final about = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 0.7 * width),
          child: Text(
            video.title,
            style: style.ProgressVideo.title,
            maxLines: 1,
          ),
        ),
        Flexible(
          child: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: onClickedClose,
          ),
        ),
      ],
    );

    final progress = LinearProgressIndicator(
      color: Colors.blueAccent,
      backgroundColor: Colors.grey[350],
    );

    final information = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [about, progress, const SizedBox(height: 10)],
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.insert_drive_file,
            size: 50,
            color: Colors.purple,
          ),
          information,
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
