import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.sizeOf(context).width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Cole o link aqui'),
        Gap(12),
        _buildSearchBar(context),
        Gap(12),
        _buildDowloadButton(context),
        Gap(16),
        _buildAds(context),
      ]),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    const heightRow = 60.0;

    final button = Container(
      width: heightRow,
      height: heightRow,
      color: Colors.pink[400],
      child: const Icon(
        Icons.content_copy_rounded,
        color: Colors.white,
      ),
    );

    final textField = TextField(
      decoration: InputDecoration(
        hintText: 'Long press to paste',
        border: OutlineInputBorder(),
      ),
    );

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: textField,
          ),
          button,
        ],
      ),
    );
  }

  Widget _buildDowloadButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: _buildBody(context),
      ),
    );
  }
}
