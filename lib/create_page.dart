import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:running_tracker/models/database/database_instance.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  bool isRunning = false;
  late Timer timer;
  late int lariId;
  List<LocationData?> locations = [];

  Future<LocationData?> _currentLocation() async {
    bool serviceEnable;
    PermissionStatus permissionGranted;

    Location location = Location();

    serviceEnable = await location.serviceEnabled();

    if (!serviceEnable) {
      serviceEnable = await location.requestService();
      if (!serviceEnable) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Your Run'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (isRunning)
                const Text(
                  'Happy Run!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (isRunning) {
                    isRunning = false;
                    Navigator.pop(context);

                    timer.cancel();

                    await databaseInstance.updateLari(lariId, {
                      'selesai': DateTime.now().toString(),
                    });
                  } else {
                    lariId = await databaseInstance
                        .insertLari({'mulai': DateTime.now().toString()});

                    timer = Timer.periodic(const Duration(seconds: 2),
                        (timer) async {
                      LocationData? location = await _currentLocation();

                      locations.add(location);

                      await databaseInstance.insertLariDetail({
                        'lari_id': lariId,
                        'latitude': location?.latitude,
                        'longitude': location?.longitude,
                        'waktu': DateTime.now().toString(),
                      });

                      setState(() {});
                    });

                    isRunning = true;
                  }
                  setState(() {});
                },
                child: isRunning
                    ? const Text(
                        'Stop',
                      )
                    : const Text(
                        'Start',
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) => Center(
                    child: Text(
                        'Latitude : ${locations[index]!.latitude.toString()} | Longitude : ${locations[index]!.longitude.toString()}'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
