import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:youtube_downloader/constants.dart';
import 'package:youtube_downloader/views/downloads.dart';
import 'package:youtube_downloader/views/home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  static const rowHeight = 40.0;

  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  Widget _buildIconTab({
    required IconData icon,
    required int index,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: rowHeight,
        width: double.infinity,
        decoration: ShapeDecoration(
          color: currentPage == index ? Colors.red : Colors.transparent,
          shape: const StadiumBorder(),
        ),
        child: Center(child: Icon(icon, color: Colors.blue)),
      );

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const HomeView(),
      const DownloadsView(),
    ];

    final tabbar = TabBar(
      indicatorColor: Colors.transparent,
      enableFeedback: false,
      splashBorderRadius: BorderRadius.circular(borderRadius),
      controller: tabController,
      tabs: [
        _buildIconTab(icon: Icons.home_rounded, index: 0),
        _buildIconTab(icon: Icons.subscriptions_rounded, index: 1),
      ],
    );

    final bottomBar = BottomBar(
      borderRadius: BorderRadius.circular(borderRadius),
      barColor: Colors.white,
      body: (_, controller) => TabBarView(
        controller: tabController,
        children: tabs,
      ),
      child: tabbar,
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: bottomBar,
      ),
    );
  }
}
