import 'package:flutter/material.dart';

//TODO: Implement AboutScreen

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Stars Studios"),
      ),
      body: const Center(
        child: Text("About Screen"),
      ),
      // body: FutureBuilder(
      //   future: NotificationController().getNotifications(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done &&
      //         snapshot.hasData) {
      //       print(snapshot.data![0].title);
      //       return ListView.builder(
      //         itemCount: snapshot.data!.length,
      //         itemBuilder: (context, index) {
      //           return NotificationPreview(notification: snapshot.data![index]);
      //         },
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}

// late Future<List<Map<String, Object>>> futureVideos;

//   Future<List<Map<String, Object>>> _fetchVideos() async {
//     try {
//       final response = await VideoRepository().fetchVideos();
//       return ResponseFormatter.formatVideos(
//           jsonDecode(response.body) as Map<String, dynamic>);
//     } catch (e) {
//       throw "Error";
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     futureVideos =
//         widget.futureVideos != null ? widget.futureVideos!() : _fetchVideos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Learn"),
//       ),
//       body: FutureBuilder(
//           future: futureVideos,
//           builder: ((context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done &&
//                 snapshot.hasData) {
//               return Container(
//                 color: const Color.fromARGB(255, 237, 237, 237),
//                 child: ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: ((context, index) {
//                     final Video video = Video.fromJson(snapshot.data![index]);
//                     return ContentCard(
//                       imageURL: video.url,
//                       title: video.title,
//                       description: video.description,
//                       videoId: video.videoId,
//                     );
//                   }),
//                 ),
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           })),
//     );
//   }
// }