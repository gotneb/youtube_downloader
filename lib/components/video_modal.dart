import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_downloader/components/media_item_row.dart';
import 'package:youtube_downloader/models/download_option.dart';
import 'package:youtube_downloader/models/media_controller.dart';
import 'package:youtube_downloader/models/video.dart';

import '../constants.dart';

class VideoModal extends StatefulWidget {
  const VideoModal({
    super.key,
    required this.media,
    required this.controller,
  });

  final Video media;
  final MediaController controller;

  @override
  State<VideoModal> createState() => _VideoModalState();
}

class _VideoModalState extends State<VideoModal> {
  late final List<bool> _selectedIndexes;

  @override
  void initState() {
    super.initState();
    _selectedIndexes = List.generate(
      widget.media.streams.length,
      (_) => false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: [
      Gap(12),
      Text('Video Downloader'),
      const Gap(8),
      _buildRuler(context),
      const Gap(8),
      _buildVideoDetail(),
      Gap(8),
      _buildRuler(context),
      Gap(8),
      _buildListOptions(context),
      Gap(8),
      _buildDownloadButton(context),
    ]);
  }

  Widget _buildListOptions(BuildContext context) => SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ListView(
          shrinkWrap: true,
          children: List.generate(
            widget.media.streams.length,
            (index) => InkWell(
              onTap: () => setState(() {
                _selectedIndexes[index] = !_selectedIndexes[index];
              }),
              child: MediaItemRow(
                stream: widget.media.streams[index],
                isSelected: _selectedIndexes[index],
              ),
            ),
          ),
        ),
      );

  Widget _buildDownloadButton(BuildContext context) => ElevatedButton(
        onPressed: () {
          logger.d('Selected streams: $_selectedIndexes');
          for (var index = 0; index < _selectedIndexes.length; index++) {
            if (_selectedIndexes[index]) {
              final stream = widget.media.streams.elementAt(index);
              final selected = DownloadOption(
                stream: stream,
                video: widget.media,
              );
              // TODO: add selected video
              widget.controller.addMedia(selected);
              Navigator.pop(context);
            }
          }
        },
        child: Center(child: Text('Download')),
      );

  Widget _buildVideoDetail() => SizedBox(
        height: 90,
        child: Row(children: [
          _buildVideoThumb(),
          const Gap(8),
          Flexible(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.media.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(8),
                  Text(widget.media.author),
                ]),
          ),
        ]),
      );

  Widget _buildVideoThumb() {
    final timeBox = Container(
      width: 40,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
          child: Text(
        widget.media.time,
        style: TextStyle(color: Colors.white),
      )),
    );

    final imageThumb = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        widget.media.thumb,
        filterQuality: FilterQuality.high,
        fit: BoxFit.fill,
      ),
    );

    return SizedBox(
        height: 84,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            imageThumb,
            Padding(
                padding: const EdgeInsets.all(4),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: timeBox,
                )),
          ],
        ));
  }

  Widget _buildRuler(BuildContext context) => Container(
        width: MediaQuery.sizeOf(context).width,
        height: 1,
        color: Colors.grey,
      );

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(24);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
      ),
      height: 0.7 * MediaQuery.sizeOf(context).height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: _buildBody(context),
      ),
    );
  }
}
