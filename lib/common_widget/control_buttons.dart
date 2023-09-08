import 'package:flutter/material.dart';
import 'package:flutter_audio_player/audio_helpers/page_manager.dart';
import 'package:flutter_audio_player/audio_helpers/service_locator.dart';
import 'package:flutter_audio_player/common/color_extension.dart';

class ControlButtons extends StatelessWidget {
  final bool shuffle;
  final bool miniPlayer;
  final List buttons;

  const ControlButtons(
      {super.key,
      this.shuffle = false,
      this.miniPlayer = false,
      this.buttons = const ['Previous', 'Play/Pause', 'Next']});

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    final mediaItem = pageManager.currentSongNotifier.value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buttons.map((e) {
        switch (e) {
          case "Previous":
            return ValueListenableBuilder<bool>(
                valueListenable: pageManager.isFirstSongNotifier,
                builder: (context, isFirst, _) {
                  return IconButton(
                    onPressed: isFirst ? null : pageManager.previous,
                    icon: Image.asset('assets/img/previous_song.png',
                        width: miniPlayer ? 20 : 50,
                        height: miniPlayer ? 20 : 50),
                  );
                });
          case "Play/Pause":
            return SizedBox(
              width: miniPlayer ? 40 : 70,
              height: miniPlayer ? 40 : 70,
              child: ValueListenableBuilder<ButtonState>(
                valueListenable: pageManager.playButtonNotifier,
                builder: (context, value, _) {
                  return Stack(
                    children: [
                      if (value == ButtonState.loading)
                        Center(
                          child: SizedBox(
                            width: miniPlayer ? 40 : 70,
                            height: miniPlayer ? 40 : 70,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  TColor.primaryText),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            );
          case "Next":
            return ValueListenableBuilder<bool>(
                valueListenable: pageManager.isFirstSongNotifier,
                builder: (context, isLast, _) {
                  return IconButton(
                    onPressed: isLast ? null : pageManager.next,
                    icon: Image.asset('assets/img/next_song.png',
                        width: miniPlayer ? 20 : 50,
                        height: miniPlayer ? 20 : 50),
                  );
                });
          default:
            return Container();
        }
      }).toList(),
    );
  }
}
