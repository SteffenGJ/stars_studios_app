import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  final YoutubePlayerController controller;
  const VideoPlayer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
              player: YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    //???
                  },
              ),
              builder: (context, player) => player
            );
  }
}