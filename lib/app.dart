import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:youtube_downloader/views/downloads.dart';
import 'package:youtube_downloader/views/home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BottomBar(
          borderRadius: BorderRadius.circular(32),
          barColor: Colors.white,
          body: (context, controller) => TabBarView(
            controller: tabController,
            children: [HomeView(), DownloadsView()],
          ),
          child: TabBar(
            indicatorColor: Colors.transparent,
            enableFeedback: false,
            splashBorderRadius: BorderRadius.circular(32),
            controller: tabController,
            tabs: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 40,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: currentPage == 0 ? Colors.red : Colors.transparent,
                  shape: StadiumBorder(),
                ),
                child: Center(
                    child: Icon(
                  Icons.home_rounded,
                  color: Colors.blue,
                )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 40,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: currentPage == 1 ? Colors.green : Colors.transparent,
                  shape: StadiumBorder(),
                ),
                child: Center(
                    child: Icon(
                  Icons.subscriptions_rounded,
                  color: Colors.blue,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
