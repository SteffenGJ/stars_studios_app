import 'package:flutter/material.dart';
import 'package:stars_studios/components/content/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleContentScreen extends StatefulWidget {
  final String youtubeURL;
  final String title;
  final String description;
  final String imageURL;
  final String videoId;

  const SingleContentScreen({
    super.key, 
    required this.youtubeURL, 
    required this.title, 
    required this.description, 
    required this.imageURL, 
    required this.videoId
  });

  @override
  State<SingleContentScreen> createState() => _SingleContentScreenState();
}

class _SingleContentScreenState extends State<SingleContentScreen> {
  late final Uri _url = Uri.parse(widget.youtubeURL);
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      //print("can't launch url");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Image.network(widget.imageURL, fit: BoxFit.fitWidth,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.title, style: Theme.of(context).textTheme.titleLarge,),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VideoPlayer(controller: _controller,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), 
              child: TextButton(
                onPressed: _launchUrl,
                child: const Row(
                  children: [
                    Text("Show on youtube", style: TextStyle(color: Colors.blue),),
                    Icon(Icons.arrow_forward, color: Colors.blue,)
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}