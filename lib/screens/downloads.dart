import 'package:flutter/material.dart';
import 'package:youtube_downloader/components/progress_video.dart';
import 'package:youtube_downloader/styles/downloads.dart' as style;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Downloads extends StatefulWidget {
  static const double _radius = 35;
  static final _progress = <ProgressVideo>[];

  static List<ProgressVideo> fetchProgress() => _progress;
  static void add(Video video) {
    _progress.add(ProgressVideo(
      video: video,
      onClickedClose: () => removeFromStackDownloads(video),
    ));
    notifyDataChanged();
  }

  static VoidCallback notifyDataChanged = () {};

  static void removeFromStackDownloads(Video download) {
    for (var i = 0; i < _progress.length; i++) {
      if (_progress[i].video == download) {
        _progress.removeAt(i);
        break;
      }
    }
    notifyDataChanged();
  }

  @override
  _DownloadingState createState() => _DownloadingState();
}

class _DownloadingState extends State<Downloads> {
  _DownloadingState() {
    Downloads.notifyDataChanged = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final aboutPage = Row(
      children: const <Widget>[
        Icon(Icons.download_for_offline_rounded, size: 40, color: Colors.white),
        SizedBox(width: 20),
        Text('Seus downloads', style: style.Downloading.title),
      ],
    );

    final topSection = Container(
      width: width,
      height: 0.22 * height,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topCenter,
          colors: [
            Color.fromRGBO(49, 77, 201, 1),
            Color.fromRGBO(23, 42, 125, 1),
          ],
        ),
      ),
      child: aboutPage,
    );

    final listSection = Container(
      height: 0.75 * height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Downloads._radius),
          topRight: Radius.circular(Downloads._radius),
        ),
      ),
      child: ListView.separated(
        itemCount: Downloads.fetchProgress().length,
        separatorBuilder: (_, i) => const SizedBox(height: 15),
        itemBuilder: (_, i) => Downloads.fetchProgress()[i],
      ),
    );

    final body = Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          topSection,
          Align(alignment: Alignment.bottomCenter, child: listSection),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: body,
    );
  }
}
