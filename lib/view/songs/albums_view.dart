import 'package:flutter/material.dart';
import 'package:flutter_audio_player/common_widget/album_cell.dart';
import 'package:flutter_audio_player/viewModel/album_view_model.dart';
import 'package:get/get.dart';

class AlbumsView extends StatefulWidget {
  const AlbumsView({super.key});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  final albumVM = Get.put(AlbumViewModel());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    var cellWidth = (media.width - 40.0 - 20.0) * 0.5;

    return Scaffold(
      body: Obx(
        () => GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              childAspectRatio: cellWidth/(cellWidth + 45),
              mainAxisSpacing: 10,
            ),
            itemCount: albumVM.allList.length,
            itemBuilder: (context, index) {
              var aObj = albumVM.allList[index];
              return AlbumCell(
                aObj: aObj,
                onPressed: () {},
                onPressedMenu: (selectedIndex){},
              );
            }),
      ),
    );
  }
}
