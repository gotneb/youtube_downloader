import 'package:flutter/material.dart';
import 'package:youtube_downloader/styles/progress_video.dart' as style;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ProgressVideo extends StatefulWidget {
  static const double _side = 50;
  final VoidCallback onClickedClose;

  final Video video;

  ProgressVideo({
    required this.video,
    required this.onClickedClose,
  });

  @override
  _ProgressVideoState createState() => _ProgressVideoState();
}

class _ProgressVideoState extends State<ProgressVideo> {
  bool _isFinished = false;

  _ProgressVideoState() {
    startDownload();
  }

  void startDownload() {
    // Only simulating
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      setState(() {
        _isFinished = true;
      });
    });
  }

  @override
  bool operator ==(Object other) {
    if (other is ProgressVideo) {
      return other.video.title == widget.video.title;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final about = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            widget.video.title,
            style: style.ProgressVideo.title,
            maxLines: 1,
          ),
        ),
        IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(Icons.close_rounded),
          onPressed: widget.onClickedClose,
        ),
      ],
    );

    final progress = LinearProgressIndicator(
      minHeight: 5,
      color: Colors.blueAccent,
      backgroundColor: Colors.grey[350],
      value: _isFinished ? 100 : null,
    );

    final information = Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [about, progress, const SizedBox(height: 10)],
      ),
    );

    var icon = Container(
      width: ProgressVideo._side,
      height: ProgressVideo._side,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        _isFinished ? Icons.file_download_done_outlined : Icons.videocam,
        color: Colors.white,
        size: ProgressVideo._side - 10,
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icon,
          const SizedBox(width: 10),
          information,
        ],
      ),
    );
  }
}
