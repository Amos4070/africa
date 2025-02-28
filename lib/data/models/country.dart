import 'package:equatable/equatable.dart';

class Country
    extends Equatable {
  final String name;
  final String capital;
  final String flag;
  final List<String> languages;

  const Country({
    required this.name,
    required this.capital,
    required this.flag,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      capital: json['capital'] != null ? json['capital'][0] : 'N/A',
      flag: json['flags']['png'],
      languages: json['languages'] != null ? (json['languages'] as Map<String, dynamic>).values.cast<String>().toList() : [],
    );
  }

  @override
  List<Object?> get props => [
        name,
        capital,
        flag,
        languages
      ];
}
