import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:running_tracker/create_page.dart';
import 'package:running_tracker/detail_page.dart';
import 'package:running_tracker/models/database/database_instance.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  @override
  void initState() {
    databaseInstance.database();

    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance.database();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Tracker'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future: databaseInstance.getAllLari(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              lariId: snapshot.data![index].id,
                                            )))
                                    .then(
                                  (value) {
                                    setState(() {});
                                  },
                                );
                              },
                              leading: const Icon(Icons.map),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mulai : ${DateFormat('dd-MM-yyyy H:mm:ss').format(DateTime.parse(snapshot.data![index].mulai))}',
                                  ),
                                  Text(
                                    'Selesai : ${DateFormat('dd-MM-yyyy H:mm:ss').format(DateTime.parse(snapshot.data![index].selesai))}',
                                  ),
                                  Text(
                                    'Durasi : ${DateTime.parse(snapshot.data![index].selesai).difference(DateTime.parse(snapshot.data![index].mulai)).inSeconds.toString()} detik',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const CreatePage()))
              .then(
            (value) {
              setState(() {});
            },
          );
        },
        child: const Icon(
          Icons.navigation,
        ),
      ),
    );
  }
}
