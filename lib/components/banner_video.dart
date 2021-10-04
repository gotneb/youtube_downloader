import 'package:flutter/material.dart';
import 'package:youtube_downloader/styles/banner_video.dart' as style;

class BannerVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title = 'Berserk 1997 edit || Little Dark Age';
    const channel = 'Izanaghi';
    const id = '06p2RUP-HqE';

    const url = 'https://i.ytimg.com/vi/$id/0.jpg';

    final downloadButton = Container(
      decoration: const BoxDecoration(
        color: style.BannerVideo.backgroundIconDownload,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        color: style.BannerVideo.colorIconDownload,
        onPressed: () {},
        icon: const Icon(Icons.download),
      ),
    );

    final left = Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: style.BannerVideo.title),
          const SizedBox(height: 10),
          Text(channel, style: style.BannerVideo.channel),
        ],
      ),
    );

    final right = Expanded(
      child: Column(
        children: [
          downloadButton,
        ],
      ),
    );

    return Container(
      width: 480,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  left,
                  right,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
