import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_downloader/models/video_detail.dart';
import 'package:youtube_downloader/styles/progress_video.dart' as style;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class ProgressVideo extends StatefulWidget {
  static const double _side = 50;

  final VideoDetail videoDetail;

  const ProgressVideo({
    required this.videoDetail,
    Key? key,
  }) : super(key: key);

  @override
  _ProgressVideoState createState() => _ProgressVideoState();
}

class _ProgressVideoState extends State<ProgressVideo> {
  bool _isFinished = false;
  bool _isThereError = false;
  int _id = 10;

  late FileSize _total;
  var _received = 0;
  double _percent = 0;

  @override
  void initState() {
    super.initState();
    _total = widget.videoDetail.streamInfo.size;
    _startDownload();
  }

  void _notifyDownloadError() {
    setState(() {
      _isThereError = true;
      _isFinished = true;
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (isAllowed) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: _id++,
              channelKey: 'basic_channel',
              title: widget.videoDetail.video.title,
              body: 'Sentimos muito :( Não foi possíve realizar o download.',
            ),
          );
        }
      });
    });
  }

  Future<void> _startDownload() async {
    /*
    // NOTE: Only for tests
    Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      _notifyDownloadDone();
    });
    */
    try {
      var streamInfo = widget.videoDetail.streamInfo;

      var stream = widget.videoDetail.yt.videos.streamsClient.get(streamInfo);

      var downloadPath = '/storage/emulated/0/Download';
      final container = widget.videoDetail.type == Type.video ? 'mp4' : 'mp3';
      final name = widget.videoDetail.video.title
          .replaceAll('/', '_')
          .replaceAll('\\', '_');
      debugPrint('NAME: $name');
      var file = File('$downloadPath/$name.$container');

      // Delete the file if exists.
      if (file.existsSync()) {
        file.deleteSync();
      }

      var output = file.openWrite();

      await for (final data in stream) {
        setState(() {
          _received += data.length;
          _percent = (_received / _total.totalBytes);
          output.add(data);
        });
      }

      await output.close();
      _notifyDownloadDone();
    } catch (e) {
      debugPrint('Error: $e');
      _notifyDownloadError();
    }
  }

  void _notifyDownloadDone() {
    setState(() {
      _isFinished = true;
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (isAllowed) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: _id++,
              channelKey: 'basic_channel',
              title: widget.videoDetail.video.title,
              body: 'Download concluído',
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final about = SizedBox(
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              widget.videoDetail.video.title.trim(),
              style: style.ProgressVideo.title,
              maxLines: 1,
              softWrap: true,
            ),
          ),
        ],
      ),
    );

    final sizeInfo = Row(
      children: <Widget>[
        Text(
          '${FileSize(_received)} / $_total',
          style: style.ProgressVideo.size,
        ),
      ],
    );

    final progress = LinearProgressIndicator(
      minHeight: 5,
      color: Colors.blueAccent[700],
      backgroundColor: Colors.grey[350],
      value: _percent,
    );

    final information = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          about,
          sizeInfo,
          const SizedBox(height: 8),
          progress,
        ],
      ),
    );

    var icon = Container(
      width: ProgressVideo._side,
      height: ProgressVideo._side,
      decoration: BoxDecoration(
        color: style.ProgressVideo.iconBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        _getIcon(),
        color: style.ProgressVideo.iconColor,
        size: ProgressVideo._side - 10,
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 75,
      decoration: BoxDecoration(
        color: style.ProgressVideo.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          icon,
          const SizedBox(width: 10),
          information,
        ],
      ),
    );
  }

  IconData _getIcon() {
    var option = widget.videoDetail.type;

    if (_isThereError) {
      return Icons.report_problem;
    } else if (_isFinished) {
      return Icons.file_download_done_outlined;
    } else {
      return option == Type.video ? Icons.videocam : Icons.headset;
    }
  }
}
