import 'package:flutter/material.dart';
import 'package:flutter_audio_player/common/color_extension.dart';

class MainViewTab extends StatefulWidget {
  const MainViewTab({super.key});

  @override
  State<MainViewTab> createState() => _MainViewTabState();
}

class _MainViewTabState extends State<MainViewTab>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);

    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
          Container(child: Center(child: Text("Home")),),
          Container(child: Center(child: Text("Songs")),),
          Container(child: Center(child: Text("Settings")),),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: TColor.bg, boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 5, offset: Offset(0, -3))
        ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            indicatorWeight: 1,
            labelColor: TColor.primary,
            labelStyle: const TextStyle(fontSize: 10),
            unselectedLabelColor: TColor.primaryText28,
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            tabs: [
              Tab(
                  text: "Home",
                  icon: Image.asset(
                      selectTab == 0
                          ? "assets/img/home_tab.png"
                          : "assets/img/home_tab_un.png",
                      width: 20,
                      height: 20)),
              Tab(
                  text: "Songs ",
                  icon: Image.asset(
                      selectTab == 1
                          ? "assets/img/songs_tab.png"
                          : "assets/img/songs_tab_un.png",
                      width: 20,
                      height: 20)),
              Tab(
                  text: "Settings ",
                  icon: Image.asset(
                      selectTab == 2
                          ? "assets/img/setting_tab.png"
                          : "assets/img/setting_tab_un.png",
                      width: 20,
                      height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
