import 'package:get/get.dart';
import 'package:youtube_downloader/constants.dart';
import 'package:youtube_downloader/models/download_option.dart';

class MediaController extends GetxController {
  var medias = <DownloadOption>[].obs;

  addMedia(DownloadOption media) {
    logger.i('Adding media...');
    medias.add(media);
  }
}