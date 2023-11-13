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
            Text('37.1 MB / 67.2 MB'),
            LinearProgressIndicator(
              value: 0.4,
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
            Gap(12),
            _buildVideoInfo(),
          ])),
    );
  }
}
