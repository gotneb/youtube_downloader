import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_downloader/components/media_item_row.dart';
import 'package:youtube_downloader/models/video.dart';

class VideoModal extends StatelessWidget {
  const VideoModal({
    super.key,
    required this.media,
  });

  final Video media;

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
      _buildDownloadButton(),
    ]);
  }

  Widget _buildListOptions(BuildContext context) => SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ListView(
          shrinkWrap: true,
          children: List.generate(
            media.streams.length,
            (index) => MediaItemRow(stream: media.streams[index]),
          ),
        ),
      );

  Widget _buildDownloadButton() => ElevatedButton(
        onPressed: () {},
        child: Center(child: Text('Download')),
      );

  Widget _buildVideoDetail() => Container(
        height: 90,
        color: Colors.yellow,
        child: Row(children: [
          _buildVideoThumb(),
          const Gap(8),
          Flexible(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    media.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(media.author),
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
        media.time,
        style: TextStyle(color: Colors.white),
      )),
    );

    final imageThumb = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        media.thumb,
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
      decoration: BoxDecoration(
        color: Colors.green,
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
