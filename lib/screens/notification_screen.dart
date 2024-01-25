import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  const NotificationScreen({super.key, required this.title, required this.imageUrl, required this.description,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall,),
                const Align(alignment: Alignment.centerRight, child: Text("06.01.2024", style: TextStyle(color: Colors.grey),)),
                const SizedBox(height: 20,),
                 Image.network(imageUrl, fit: BoxFit.cover,),
                const SizedBox(height: 20,),
                Text(description),
                const SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}