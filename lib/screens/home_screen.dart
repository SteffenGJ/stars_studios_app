import 'package:flutter/material.dart';
import 'package:stars_studios/components/appbar/app_drawer.dart';
import 'package:stars_studios/components/appbar/menu_dropdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: const [MenuDropdown()],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              TemporaryPlaceholderWidget(),
              SizedBox(
                height: 15,
              ),
              TemporaryMultiPlaceholderWidget(),
              TemporaryPlaceholderWidget()
            ],
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class TemporaryMultiPlaceholderWidget extends StatelessWidget {
  const TemporaryMultiPlaceholderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Card(
          color: const Color.fromARGB(255, 245, 244, 244),
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
              child: Container(
                color: Colors.grey[300],
                child: const Center(child: Text("....")),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Card(
          color: const Color.fromARGB(255, 245, 244, 244),
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
              child: Container(
                color: Colors.grey[300],
                child: const Center(child: Text("....")),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class TemporaryPlaceholderWidget extends StatelessWidget {
  const TemporaryPlaceholderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: const Color.fromARGB(255, 245, 244, 244),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
                child: Container(
                  color: Colors.grey[300],
                  child: const Center(child: Text("....")),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
