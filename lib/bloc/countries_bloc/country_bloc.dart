import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart'
    as http;

import '../../data/models/country.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<
    CountryEvent,
    CountryState> {
  CountryBloc() : super(CountryInitial()) {
    on<FetchCountries>(_onFetchCountries);
    on<FetchCountryDetails>(_onFetchCountryDetails);
  }

  Future<void> _onFetchCountries(FetchCountries event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    try {
      final response = await http.get(Uri.parse('https://restcountries.com/v3.1/region/africa?status=true&fields=name,languages,capital,flags'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Country> countries = data.map((json) => Country.fromJson(json)).toList();
        emit(CountryLoaded(countries));
      } else {
        emit(CountryError('Failed to load countries'));
      }
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }

  Future<void> _onFetchCountryDetails(FetchCountryDetails event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    try {
      final response = await http.get(Uri.parse('https://restcountries.com/v3.1/name/${event.countryName}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final Country country = Country.fromJson(data[0]);
        emit(CountryDetailLoaded(country));
      } else {
        emit(const CountryError('Failed to load country details'));
      }
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }
}
