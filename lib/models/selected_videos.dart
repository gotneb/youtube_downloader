import 'package:flutter/foundation.dart';
import 'package:youtube_downloader/models/download_option.dart';

import '../constants.dart';

class SelectedVideos extends ChangeNotifier {
  final List<DownloadOption> _selecteds = [];

  List<DownloadOption> get videos => _selecteds;

  int get length => _selecteds.length;

  DownloadOption get(int index) => _selecteds[index];

  void add(DownloadOption video) {
    _selecteds.add(video);
    logger.i('Added new stream!');
    notifyListeners();
  }
}