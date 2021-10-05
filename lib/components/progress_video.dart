import 'package:flutter/material.dart';
import 'package:youtube_downloader/styles/progress_video.dart' as style;

class ProgressVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    var title = SizedBox(
      width: width - 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Something.mp4', style: style.ProgressVideo.title),
          Icon(Icons.close_rounded),
        ],
      ),
    );

    var progress = SizedBox(
      width: width - 60,
      child: LinearProgressIndicator(color: Colors.blueAccent, backgroundColor: Colors.grey[350]),
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
          Icon(Icons.insert_drive_file, color: Colors.purple, size: 45),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              progress,
            ],
          ),
        ],
      ),
    );
  }
}
