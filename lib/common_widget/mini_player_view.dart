import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_player/audio_helpers/page_manager.dart';
import 'package:flutter_audio_player/common_widget/control_buttons.dart';
import 'dart:ui' as ui;
import '../audio_helpers/service_locator.dart';
import '../common/color_extension.dart';

class MiniPlayerView extends StatefulWidget {
  static const MiniPlayerView _instance = MiniPlayerView._internal();

  factory MiniPlayerView() {
    return _instance;
  }

  const MiniPlayerView._internal();

  @override
  State<MiniPlayerView> createState() => _MiniPlayerViewState();
}

class _MiniPlayerViewState extends State<MiniPlayerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return ValueListenableBuilder<AudioProcessingState>(
      valueListenable: pageManager.playbackStatNotifier,
      builder: (context, processingState, _) {
        if (processingState == AudioProcessingState.idle) {
          return const SizedBox();
        }

        return ValueListenableBuilder<MediaItem?>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (context, mediaItem, _) {
            if (mediaItem == null) return const SizedBox();
            return Dismissible(
              key: const Key('mini_player'),
              direction: DismissDirection.down,
              onDismissed: (direction) {
                Feedback.forLongPress(context);
                pageManager.stop();
              },
              child: Dismissible(
                key: Key(mediaItem.id),
                confirmDismiss: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    pageManager.previous();
                  } else {
                    pageManager.next();
                  }
                  return Future.value();
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  elevation: 0,
                  color: Colors.white10,
                  child: SizedBox(
                    height: 76,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder<ProgressBarState>(
                                  valueListenable: pageManager.progressNotifier,
                                  builder: (context, value, _) {
                                    final position = value.current;
                                    final totalDuration = value.total;

                                    return position == null
                                        ? const SizedBox()
                                        : (position.inSeconds.toDouble() <
                                                    0.0 ||
                                                (position.inSeconds.toDouble() >
                                                    totalDuration.inSeconds
                                                        .toDouble()))
                                            ? const SizedBox()
                                            : SliderTheme(
                                                data: SliderThemeData(
                                                    activeTrackColor:
                                                        TColor.focus,
                                                    inactiveTrackColor:
                                                        Colors.transparent,
                                                    trackHeight: 5,
                                                    thumbColor: TColor.focus,
                                                    thumbShape:
                                                        const RoundSliderOverlayShape(
                                                      overlayRadius: 5,
                                                    ),
                                                    overlayColor:
                                                        Colors.transparent,
                                                    overlayShape:
                                                        const RoundSliderOverlayShape(
                                                            overlayRadius: 2)),
                                                child: Center(
                                                  child: Slider(
                                                      inactiveColor:
                                                          Colors.transparent,
                                                      value: position.inSeconds
                                                          .toDouble(),
                                                      max: totalDuration
                                                          .inSeconds
                                                          .toDouble() ,
                                                      onChanged: (newPosition) {
                                                        pageManager.seek(Duration(
                                                            seconds: newPosition
                                                                .round()));
                                                      }),
                                                ));
                                  }),
                              ListTile(
                                dense: false,
                                onTap: () {},
                                title: Text(
                                  mediaItem.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  mediaItem.artist ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Hero(
                                  tag: 'currentArtWork',
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox.square(
                                      dimension: 40,
                                      child: CachedNetworkImage(
                                        imageUrl: mediaItem.toString(),
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                            'assets/img/cover.jpg',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        placeholder: (context, url) {
                                          return Image.asset(
                                            'assets/img/cover.jpg',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: const ControlButtons(
                                  miniPlayer: true,
                                  buttons: ['Play/Pause', 'Next'],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
