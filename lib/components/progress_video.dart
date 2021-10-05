import 'package:flutter/material.dart';
import 'package:youtube_downloader/styles/progress_video.dart' as style;

class ProgressVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final about = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Something.mp4', style: style.ProgressVideo.title),
        Icon(Icons.close_rounded),
      ],
    );

    final progress = LinearProgressIndicator(
      color: Colors.blueAccent,
      backgroundColor: Colors.grey[350],
    );

    final information = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [about, progress],
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 45,
            color: Colors.purple,
          ),
          information,
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
