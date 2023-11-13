import 'package:flutter/material.dart';
import 'package:youtube_downloader/components/card_download.dart';
import 'package:youtube_downloader/models/download_option.dart';

class DownloadsView extends StatelessWidget {
  const DownloadsView({
    super.key,
    required this.toDownload,
  });

  final List<DownloadOption> toDownload;

  Widget _buildBody() => ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: toDownload.length,
      itemBuilder: (_, i) => CardDownload(option: toDownload[i]),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
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
