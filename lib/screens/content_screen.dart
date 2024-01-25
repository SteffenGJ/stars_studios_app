import 'package:flutter/material.dart';
import 'package:stars_studios/components/content/content_card.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 237, 237, 237),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder:(context, index) {
            return const ContentCard(
              imageURL: "https://wallpapercave.com/dwp2x/wp3255731.jpg", 
              title: "The title of this video", 
              description: "The description of this video. It can be a text with a length like this or even more or less if you wish so. Sfs kds fl askd fakjekrf aj f ej fak fjr hrejhfbaj ehrja eiubfds arfibai ehaihfabkiehr ah erh a freia iher aierhia h",
            );
          },
        ),
      ),
    );
  }
}