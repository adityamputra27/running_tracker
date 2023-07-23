import 'package:flutter/material.dart';
import 'package:running_tracker/create_page.dart';
import 'package:running_tracker/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Tracker'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DetailPage()));
                },
                leading: const Icon(Icons.map),
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mulai : 2023-07-23 19:00:00',
                    ),
                    Text(
                      'Selesai : 2023-07-23 21:00:00',
                    ),
                    Text(
                      'Durasi : 2 jam 0 menit',
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DetailPage()));
                },
                leading: const Icon(Icons.map),
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mulai : 2023-07-23 19:00:00',
                    ),
                    Text(
                      'Selesai : 2023-07-23 21:00:00',
                    ),
                    Text(
                      'Durasi : 2 jam 0 menit',
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DetailPage()));
                },
                leading: const Icon(Icons.map),
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mulai : 2023-07-23 19:00:00',
                    ),
                    Text(
                      'Selesai : 2023-07-23 21:00:00',
                    ),
                    Text(
                      'Durasi : 2 jam 0 menit',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreatePage()));
        },
        child: const Icon(
          Icons.navigation,
        ),
      ),
    );
  }
}
