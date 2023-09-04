import 'package:flutter/material.dart';
import 'package:flutter_audio_player/common_widget/my_playlist_cell.dart';
import 'package:flutter_audio_player/common_widget/view_all_section.dart';
import 'package:flutter_audio_player/viewModel/playlists_view_model.dart';
import 'package:get/get.dart';

class PlaylistsView extends StatefulWidget {
  const PlaylistsView({super.key});

  @override
  State<PlaylistsView> createState() => _PlaylistsViewState();
}

class _PlaylistsViewState extends State<PlaylistsView> {
  final plVM = Get.put(PlaylistsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewAllSection(title: "My Playlists", onPressed: () {}),
            SizedBox(
              height: 150,
              child: Obx(() => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: plVM.myPlaylistArr.length,
                    itemBuilder: (BuildContext context, int index) {
                      var pObj = plVM.myPlaylistArr[index];

                      return MyPlaylistCell(onPressed: () {}, pObj: pObj);
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
