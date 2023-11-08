import 'package:flutter/material.dart';
import 'package:youtube_downloader/models/video_detail.dart';
import 'package:youtube_downloader/server/api.dart';
import 'package:youtube_downloader/styles/progress_video.dart' as style;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:youtube_downloader/debug/logging.dart';

class ProgressVideo extends StatefulWidget {
  static const double _side = 50;

  final VideoDetail videoDetail;

  const ProgressVideo({
    super.key,
    required this.videoDetail,
  });

  @override
  State<ProgressVideo> createState() => _ProgressVideoState();
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

    final title = sanitizeFileName(widget.videoDetail.video.title);
    logger.d('Original title: ${widget.videoDetail.video.title}\nFormated title: $title');

    try {
      final options =
          await Api.getUrlDownloadVideo(id: widget.videoDetail.video.id.value);
      final video = options.last;
      video.download(filename: '$title.mp4', url: video.url);
      _notifyDownloadDone();
    } catch (e) {
      logger.e('Error when downloading/saving video/music...\n$e');
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

  String sanitizeFileName(String fileName) {
  final List<String> notAllowedChars = ['/', '\\', ':', '*', '?', '"', '<', '>', '|', '&', '%', '#', '\'', '!', '~'];

  for (final char in notAllowedChars) {
    fileName = fileName.replaceAll(char, '');
  }

  fileName = fileName.trim();

  if (fileName.isEmpty) {
    fileName = 'unnamed_file';
  }

  return fileName;
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
