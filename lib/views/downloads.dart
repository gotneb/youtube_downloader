import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_downloader/components/card_download.dart';
import 'package:youtube_downloader/models/selected_videos.dart';

class DownloadsView extends StatelessWidget {
  const DownloadsView({
    super.key,
  });

  Widget _buildBody() => Consumer<SelectedVideos>(
        builder: (context, toDownload, child) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: toDownload.length,
          itemBuilder: (_, i) => CardDownload(option: toDownload.get(i)),
        ),
      );

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
