import 'package:flutter/material.dart';
import 'package:stars_studios/components/content/video_player.dart';
import 'package:stars_studios/models/video.dart';
import 'package:stars_studios/repositories/video_repository.dart';
import 'package:stars_studios/shared/response_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import "dart:async";
import "dart:convert";

//TODO: Not happy about this widget. Refactor.

class SingleContentScreen extends StatefulWidget {
  final String title;
  final String videoId;
  final Future<Map<String, Object>> Function(String)? futureVideo;

  const SingleContentScreen(
      {super.key,
      required this.title,
      required this.videoId,
      this.futureVideo});

  @override
  State<SingleContentScreen> createState() => _SingleContentScreenState();
}

class _SingleContentScreenState extends State<SingleContentScreen> {
  late Future<Map<String, dynamic>> futureVideo;
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      print("can't launch url");
    }
  }

  bool isValidImageURL(String url) {
    return url.contains("https://");
  }

  Future<Map<String, Object>> _fetchVideo(String id) async {
    try {
      final response = await VideoRepository().fetchVideo(id);
      return ResponseFormatter.formatSingleVideo(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      throw "Error";
    }
  }

  @override
  void initState() {
    super.initState();
    futureVideo = widget.futureVideo != null
        ? widget.futureVideo!(widget.videoId)
        : _fetchVideo(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: futureVideo,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final Video video = Video.fromJson(snapshot.data!);
            return ListView(
              children: [
                isValidImageURL(video.url)
                    ? Image.network(
                        video.url,
                        fit: BoxFit.fitWidth,
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    video.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(video.description),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isValidImageURL(video.url)
                        ? VideoPlayer(
                            controller: _controller,
                          )
                        : Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => _launchUrl(Uri.parse(video.videoUrl)),
                    child: const Row(
                      children: [
                        Text(
                          "Show on youtube",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
