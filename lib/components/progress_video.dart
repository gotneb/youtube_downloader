import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_downloader/styles/progress_video.dart' as style;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class ProgressVideo extends StatefulWidget {
  static const double _side = 50;
  final VoidCallback onClickedClose;

  final Video video;

  const ProgressVideo({
    required this.video,
    required this.onClickedClose,
    Key? key,
  }) : super(key: key);

  @override
  _ProgressVideoState createState() => _ProgressVideoState();
}

class _ProgressVideoState extends State<ProgressVideo> {
  bool _isFinished = false;
  bool _isThereError = false;
  int _id = 10;
  var _total = const FileSize(0);
  var _received = 0;
  double _percent = 0;

  @override
  void initState() {
    super.initState();
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
              title: widget.video.title,
              body: 'Sentimos muito :( Não foi possíve realizar o download.',
            ),
          );
        }
      });
    });
  }

  Future<void> _startDownload() async {
    /*
    // Only for tests
    Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      _notifyDownloadDone();
    });
    */
    var yt = YoutubeExplode();
    try {
      var manifest = await yt.videos.streamsClient.getManifest(widget.video.id);
      _total = manifest.muxed.withHighestBitrate().size;
      var streamInfo = manifest.muxed.withHighestBitrate();

      var stream = yt.videos.streamsClient.get(streamInfo);
      const downloadPath = '/storage/emulated/0/Download';

      var file = File('$downloadPath/${widget.video.title}.mp4');
      var fileStream = file.openWrite();

      await stream.map(_showDownloadProgress).pipe(fileStream);

      await fileStream.flush();
      await fileStream.close();
      _notifyDownloadDone();
    } catch (e) {
      _notifyDownloadError();
    } finally {
      yt.close();
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
              title: widget.video.title,
              body: 'Download concluído',
            ),
          );
        }
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
    final about = SizedBox(
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              widget.video.title.trim(),
              style: style.ProgressVideo.title,
              maxLines: 1,
              softWrap: true,
            ),
          ),
          Opacity(
            opacity: 0,
            child: IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(Icons.close_rounded,
                  color: style.ProgressVideo.cancelColor),
              onPressed: _isFinished ? widget.onClickedClose : null,
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

  List<int> _showDownloadProgress(List<int> data) {
    setState(() {
      _received += data.length;
      _percent = (_received / _total.totalBytes);
    });
    return data;
  }

  IconData _getIcon() {
    if (_isThereError) {
      return Icons.report_problem;
    } else if (_isFinished) {
      return Icons.file_download_done_outlined;
    } else {
      return Icons.videocam;
    }
  }
}
