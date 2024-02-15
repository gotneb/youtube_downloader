import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_downloader/models/download_option.dart';

class CardDownload extends StatefulWidget {
  const CardDownload({
    super.key,
    required this.option,
  });

  final DownloadOption option;

  static const _radius = 12.0;

  @override
  State<CardDownload> createState() => _CardDownloadState();
}

class _CardDownloadState extends State<CardDownload> {
  var _downloadStarted = false;
  var _receveid = 0;
  var _total = 0;

  Widget _buildVideoInfo() => Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.option.video.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text('${byte2Megabyte(_receveid)} / ${byte2Megabyte(_total)}'),
            LinearProgressIndicator(
              value: _total == 0 ? 0 : _receveid / _total,
              minHeight: 6,
              borderRadius: BorderRadius.circular(CardDownload._radius),
            ),
          ],
        ),
      );

  Widget _buildImageVideo(BuildContext context) => Container(
        height: 0.2 * MediaQuery.sizeOf(context).height,
        width: 0.35 * MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(CardDownload._radius)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(CardDownload._radius),
          child: Image.network(
            widget.option.video.thumb,
            fit: BoxFit.fitHeight,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (!_downloadStarted) {
      widget.option.stream.download(onProgress: onProgress);
      _downloadStarted = true;
    }

    return Card(
      elevation: 12,
      child: Container(
          padding: const EdgeInsets.all(CardDownload._radius),
          width: MediaQuery.sizeOf(context).width,
          height: 0.2 * MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CardDownload._radius),
          ),
          child: Row(children: [
            _buildImageVideo(context),
            const Gap(12),
            _buildVideoInfo(),
          ])),
    );
  }

  void onProgress(int receveid, int total) {
    setState(() {
      _receveid = receveid;
      _total = total;
    });
  }

  String byte2Megabyte(int bytes) {
    double mb = bytes / (1024 * 1024);
    return "${mb.toStringAsFixed(1)} MB";
  }
}
