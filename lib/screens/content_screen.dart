import 'package:flutter/material.dart';
import 'package:stars_studios/components/content/content_card.dart';
import 'package:stars_studios/models/video.dart';
import 'package:stars_studios/repositories/video_repository.dart';
import "dart:async";
import "dart:convert";
import 'package:stars_studios/shared/response_formatter.dart';

//TODO: Not happy about this widget. Refactor.
//The Repository shouldn't be used like that.
//Maybe, the ResponseFormatter logic could be moved into fetchVideos, since it is only used there? Then it won't have to be used here.

class ContentScreen extends StatefulWidget {
  final Future<List<Map<String, Object>>> Function()? futureVideos;

  const ContentScreen({super.key, this.futureVideos});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late Future<List<Map<String, Object>>> futureVideos;

  Future<List<Map<String, Object>>> _fetchVideos() async {
    try {
      final response = await VideoRepository().fetchVideos();
      return ResponseFormatter.formatVideos(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      throw "Error";
    }
  }

  @override
  void initState() {
    super.initState();
    futureVideos =
        widget.futureVideos != null ? widget.futureVideos!() : _fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn"),
      ),
      body: FutureBuilder(
          future: futureVideos,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Container(
                color: const Color.fromARGB(255, 237, 237, 237),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    final Video video = Video.fromJson(snapshot.data![index]);
                    return ContentCard(
                      imageURL: video.url,
                      title: video.title,
                      description: video.description,
                      videoId: video.videoId,
                    );
                  }),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
  }
}
