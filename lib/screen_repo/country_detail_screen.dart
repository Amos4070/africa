import 'package:flutter/material.dart';

import '../data/models/country.dart';

//this is the country display screen
class CountryDetailScreen
    extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC4C4C4),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
        centerTitle: true,
        title: Text(
          'Welcome to ${country.name}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(country.flag, width: 100, height: 60, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text('Capital: ${country.capital}'),
            const SizedBox(height: 10),
            Text('Languages: ${country.languages.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
