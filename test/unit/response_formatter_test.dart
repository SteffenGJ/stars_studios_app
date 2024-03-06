import 'package:flutter_test/flutter_test.dart';
import 'package:stars_studios/shared/response_formatter.dart';

void main() {
  group("ResponseFormatter", () {
    test(
        "should make YouTube API response for multiple videos compatible with Video class ",
        () {
      final response = ResponseFormatter.formatVideos(videosExampleResponse);
      expect(expectedVideosResponse, response);
    });

    test(
        "should make YouTube API response for single video compatible with Video class",
        () {
      final response =
          ResponseFormatter.formatSingleVideo(singleVideoExampleResponse);
      expect(expectedSingleVideoResponse, response);
    });
  });
}

final videosExampleResponse = {
  "items": [
    {
      "id": {"videoId": "123"},
      "snippet": {
        "title": "The title of this video",
        "description":
            "This is the description of the video. This is here the content of the video is briefly described, as part of the solution ...",
        "thumbnails": {
          "high": {
            "url": "https://exampleurl.com/image.jpg",
          }
        },
      }
    },
    {
      "id": {"videoId": "234"},
      "snippet": {
        "title": "The title of this video",
        "description":
            "This is the description of the video. This is here the content of the video is briefly described, as part of the solution ...",
        "thumbnails": {
          "high": {
            "url": "https://exampleurl.com/image.jpg",
          }
        },
      }
    },
  ]
};
final expectedVideosResponse = [
  {
    "videoId": "123",
    "title": "The title of this video",
    "description":
        "This is the description of the video. This is here the content of the video is briefly described, as part of the solution ...",
    "url": "https://exampleurl.com/image.jpg",
  },
  {
    "videoId": "234",
    "title": "The title of this video",
    "description":
        "This is the description of the video. This is here the content of the video is briefly described, as part of the solution ...",
    "url": "https://exampleurl.com/image.jpg",
  },
];

final singleVideoExampleResponse = {
  "items": [
    {
      "id": "123",
      "snippet": {
        "title": "Title of this video",
        "description":
            "This is the description of the video. This is here the content of the video is briefly described, as part of the solution.",
        "thumbnails": {
          "standard": {
            "url": "https://exampleurl.com/image.jpg",
          },
          "maxres": {
            "url": "https://exampleurl.com/image.jpg",
          }
        },
      }
    }
  ],
};

final expectedSingleVideoResponse = {
  "videoId": "123",
  "title": "Title of this video",
  "description":
      "This is the description of the video. This is here the content of the video is briefly described, as part of the solution ...",
  "url": "https://exampleurl.com/image.jpg",
};
