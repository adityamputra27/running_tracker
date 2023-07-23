import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
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
                onPressed: () {},
                child: const Text(
                  'Start',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Latitude : 0.00 | Longitude : 0.00'),
              const Text('Latitude : 0.00 | Longitude : 0.00'),
              const Text('Latitude : 0.00 | Longitude : 0.00'),
            ],
          ),
        ),
      ),
    );
  }
}
