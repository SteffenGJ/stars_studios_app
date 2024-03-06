//A class for formatting responses from API calls

class ResponseFormatter {
  static List<Map<String, Object>> formatVideos(Map<String, dynamic> data) {
    final List<Map<String, Object>> formattedData = [];
    final List<dynamic> items = data["items"];
    for (final item in items) {
      final Map<String, dynamic> snippet = item["snippet"];
      final Map<String, dynamic> thumbnails = snippet["thumbnails"];
      final Map<String, dynamic> highThumbnail = thumbnails["high"];
      final Map<String, dynamic> id = item["id"];
      final String videoId = id["videoId"];
      final String title = snippet["title"];
      final String description = snippet["description"];
      final String url = highThumbnail["url"];
      final Map<String, Object> formattedItem = {
        "videoId": videoId,
        "title": title,
        "description": description,
        "url": url,
      };
      formattedData.add(formattedItem);
    }
    return formattedData;
  }

  static Map<String, Object> formatSingleVideo(Map<String, dynamic> data) {
    final List<dynamic> items = data["items"];
    final Map<String, dynamic> item = items[0];
    final Map<String, dynamic> snippet = item["snippet"];
    final Map<String, dynamic> thumbnails = snippet["thumbnails"];
    final Map<String, dynamic> standardThumbnail = thumbnails["standard"];
    final String id = item["id"];
    final String title = snippet["title"];
    final String description = snippet["description"];
    final String url = standardThumbnail["url"];
    final Map<String, Object> formattedItem = {
      "videoId": id,
      "title": title,
      "description": description,
      "url": url,
    };
    return formattedItem;
  }
}
