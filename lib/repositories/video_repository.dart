import 'package:http/http.dart' as http;
import 'package:stars_studios/firebase_options.dart';

//TODO: Not sure how this should be approached. Doesn't seem like a repository implementation. But should it even, since I am only getting data?

class VideoRepository {
  final String apiKey = DefaultFirebaseOptions.currentPlatform.apiKey;

  Future<http.Response> fetchVideos() async {
    return await http.get(Uri.parse(
        "https://youtube.googleapis.com/youtube/v3/search?part=id%2C%20snippet&channelId=UCCfqyGl3nq_V0bo64CjZh8g&order=date&key=$apiKey"));
  }

  Future<http.Response> fetchVideo(String videoId) async {
    return await http.get(Uri.parse(
        "https://youtube.googleapis.com/youtube/v3/videos?part=id%2C%20snippet&id=$videoId&key=$apiKey"));
  }
}
