import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchCountries() async {
  final response = await http.get(
    Uri.parse('https://countries.dev/countries?fields=name&sort=name'),
  );

  if (response.statusCode == 200) {
    List<dynamic> countriesJson = json.decode(response.body);
    List<String> countryList = countriesJson
        .map((country) => country['name'] as String)
        .toList();
    return countryList;
  } else {
    throw Exception('No se pudieron cargar los países');
  }
}
