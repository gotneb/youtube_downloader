import 'package:flutter/material.dart';
import 'package:youtube_downloader/components/card_download.dart';
import 'package:youtube_downloader/constants.dart';
import 'package:youtube_downloader/models/media_controller.dart';

class DownloadsView extends StatelessWidget {
  const DownloadsView({
    super.key,
    required this.controller,
  });

  final MediaController controller;

  Widget _buildBody() {
    logger.i('Building body...Controler has ${controller.medias.length}');
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.medias.length,
      itemBuilder: (_, i) => CardDownload(option: controller.medias[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text('Downloads'),
      ),
      body: _buildBody(),
    );
  }
}
