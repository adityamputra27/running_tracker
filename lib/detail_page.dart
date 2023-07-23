import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MapLatLng location = new MapLatLng(-6.809187923753865, 107.14968732222341);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Route Your Run'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300,
              child: SfMaps(
                layers: [
                  MapTileLayer(
                    initialZoomLevel: 15,
                    initialFocalLatLng: location,
                    initialMarkersCount: 1,
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    markerBuilder: (BuildContext content, int index) {
                      return MapMarker(
                        latitude: location.latitude,
                        longitude: location.longitude,
                        child: const Icon(Icons.location_on,
                            color: Colors.pinkAccent),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
