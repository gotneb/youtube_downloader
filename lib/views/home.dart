import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:youtube_downloader/components/video_modal.dart';
import 'package:youtube_downloader/constants.dart';
import 'package:youtube_downloader/server/api.dart';

enum HomeState {
  idle,
  searchHasError,
  videoNotFound,
  loading,
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController controller;
  var state = HomeState.idle;
  var link = '';

  // TODO: Use `Riverpod` to menage states!

  Widget _buildBody(BuildContext context) {
    if (state == HomeState.loading) {
      _buildVideoModal(context);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cole o link aqui'),
          Gap(12),
          _buildSearchBar(context),
          Gap(12),
          _buildDowloadButton(context),
          Gap(16),
          if (state == HomeState.idle) ...[
            _buildAds(context)
          ] else if (state == HomeState.loading) ...[
            _buildLoading(context)
          ] else ...[
            _buildError()
          ],
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    const rowHeight = 60.0;

    final button = Container(
      width: rowHeight,
      height: rowHeight,
      color: Colors.pink[400],
      child: const Icon(
        Icons.content_copy_rounded,
        color: Colors.white,
      ),
    );

    final textField = TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Long press to paste',
        border: OutlineInputBorder(),
      ),
    );

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: rowHeight,
      child: Row(
        children: [
          Expanded(child: textField),
          button,
        ],
      ),
    );
  }

  Widget _buildDowloadButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() {
        state = HomeState.loading;
      }),
      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.download_rounded),
        Gap(8),
        Text('DOWNLOAD'),
      ]),
    );
  }

  Widget _buildAds(BuildContext context) => Container(
        color: Colors.grey[200],
        width: MediaQuery.sizeOf(context).width,
        height: 0.5 * MediaQuery.sizeOf(context).height,
      );

  Future<void> _buildVideoModal(BuildContext context) async {
    if (controller.text.isEmpty) {
      return;
    }

    try {
      final video = await Api.getVideo(videoURL: controller.text);
      setState(() {
        state = HomeState.idle;
      });
      logger.d('Building modal...');
      return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => VideoModal(media: video),
      );
    } catch (_) {
      setState(() {
        state = HomeState.searchHasError;
      });
    }
  }

  Widget _buildLoading(BuildContext context) => SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 0.5 * MediaQuery.sizeOf(context).height,
      child: Center(
        child: LoadingBouncingGrid.square(
          size: 0.55 * MediaQuery.sizeOf(context).width,
        ),
      ));

  Widget _buildError() => Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: Icon(Icons.error),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: _buildBody(context),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
