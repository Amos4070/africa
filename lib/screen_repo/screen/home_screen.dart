import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/countries_bloc/country_bloc.dart';
import '../country_detail_screen.dart';

class HomeScreen
    extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC4C4C4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Africa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Loading...')
                ],
              ),
            );
          } else if (state is CountryLoaded) {
            return ListView.builder(
              itemCount: state.countries.length,
              itemBuilder: (context, index) {
                final country = state.countries[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                    leading: Image.network(country.flag, width: 50, height: 30, fit: BoxFit.cover),
                    title: Text(country.name),
                    subtitle: Text(country.capital),
                    onTap: () {
                      context.read<CountryBloc>().add(FetchCountryDetails(country.name));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryDetailScreen(country: country),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is CountryError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Press the button to load african countries',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CountryBloc>().add(FetchCountries());
                  },
                  child: const Icon(Icons.refresh),
                )
              ],
            ));
          }
        },
      ),
    );
  }
}
