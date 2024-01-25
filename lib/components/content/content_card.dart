import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stars_studios/screens/single_content_screen.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageURL;
  final String videoId = "x9l6yw1PFbs";
  final String youtubeURL = "https://www.youtube.com/watch?v=x9l6yw1PFbs";

  const ContentCard({super.key, required this.title, required this.description, required this.imageURL});

  void _onPressed() {
    Get.to(() => SingleContentScreen(
      videoId: videoId, 
      title: title, 
      description: description, 
      imageURL: imageURL, 
      youtubeURL: youtubeURL,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Card(
        surfaceTintColor: Colors.white,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge,),
                const Expanded(child: SizedBox(),),
                IconButton(
                  icon: const Icon(Icons.arrow_forward), 
                  onPressed: _onPressed,
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Image.network(imageURL, fit: BoxFit.fitWidth,),
              )
            ),
            SizedBox(height: 50, child: Text(description, overflow: TextOverflow.fade,)),
            ]),
      )
      ),
    );
  }
}