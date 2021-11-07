import 'package:flutter/material.dart';
import 'package:youtube_downloader/screens/downloads.dart';
import 'package:youtube_downloader/styles/banner_video.dart' as style;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'information/search_error.dart';
import 'information/waiting_data.dart';

class BannerVideo extends StatelessWidget {
  static const double width = 480;
  static const double height = 218;

  final String url;

  const BannerVideo({required this.url, Key? key}) : super(key: key);

  String formatedTime(Duration time) {
    final hours = time.inHours;
    if (hours == 0) {
      final minutes = time.inMinutes;
      final seconds = time.inSeconds - minutes * 60;
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    } else {
      final minutes = time.inMinutes - hours * 60;
      final seconds = time.inSeconds - hours * 3600 - minutes * 60;
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  Future<void> addToDownloads(BuildContext context, Video video,
      YoutubeExplode youtube, StreamManifest manifest) async {
    Downloads.add(video, manifest, youtube);

    const snackBar = SnackBar(
      content: Text('Realizando o download...', textAlign: TextAlign.center),
      duration: Duration(milliseconds: 800),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var yt = YoutubeExplode();

    Future<Video> video = yt.videos.get(url);
    Future<StreamManifest> manifest = yt.videos.streamsClient.getManifest(url);

    return FutureBuilder(
      future: Future.wait([video, manifest]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingData();
        } else if (snapshot.hasData) {
          Video v = snapshot.data![0];
          StreamManifest m = snapshot.data![1];
          return buildBanner(context, v, yt, m);
        } else {
          return const SearchError();
        }
      },
    );
  }

  Widget buildBanner(BuildContext context, Video video, YoutubeExplode yt,
      StreamManifest manifest) {
    final timeBox = Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        formatedTime(video.duration!),
        style: style.BannerVideo.time,
      ),
    );

    final downloadButton = Container(
      decoration: const BoxDecoration(
        gradient: style.BannerVideo.gradientDownload,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        color: style.BannerVideo.colorIconDownload,
        onPressed: () {
          addToDownloads(context, video, yt, manifest);
        },
        icon: const Icon(Icons.download),
      ),
    );

    final left = Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(video.title, style: style.BannerVideo.title),
          const SizedBox(height: 10),
          Text(video.author, style: style.BannerVideo.channel),
        ],
      ),
    );

    final right = Expanded(
      child: Column(
        children: [
          downloadButton,
          const Spacer(),
          timeBox,
        ],
      ),
    );

    return Container(
      width: BannerVideo.width,
      height: BannerVideo.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: NetworkImage(video.thumbnails.highResUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: BannerVideo.width,
            height: BannerVideo.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Container(
            width: BannerVideo.width,
            height: BannerVideo.height,
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Row(
              children: <Widget>[
                left,
                right,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
