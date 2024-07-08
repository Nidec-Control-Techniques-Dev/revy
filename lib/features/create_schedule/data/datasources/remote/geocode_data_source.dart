import 'dart:convert'; // Make sure this import is at the top of your file
import 'package:dio/dio.dart';
import '../../../../../env/env.dart';

// TODO: Do not hardcode api key

class GeocodingApiDataSource {
  final Dio _dio;

  GeocodingApiDataSource(this._dio);

  Future<Map<String, dynamic>> geocodeAddress(String address) async {
    final response = await _dio.get(
      'https://maps.googleapis.com/maps/api/geocode/json',
      queryParameters: {
        'address': address,
        'key': Env.googleMapsApiKey, // Use the API key from your environment variables
      },
    );

    if (response.statusCode == 200) {
      // Parse the response to get the location
      final results = response.data['results'];
      if (results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        return location;
      } else {
        throw Exception('No results found for the given address');
      }
    } else {
      throw Exception('Failed to geocode address');
    }
  }
}

void main() async {
  final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
  try {
    Map<String, dynamic> location = await dataSource.geocodeAddress("1600 Amphitheatre Parkway, Mountain View, CA");
    print('Coordinates: ${location['lat']}, ${location['lng']}');
  } catch (e) {
    print(e);
  }
}

// void main() async {
//   final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
//   try {
//     Map<String, dynamic> location = await dataSource.geocodeAddress("1600 Amphitheatre Parkway, Mountain View, CA");
//     print('Coordinates: ${location['lat']}, ${location['lng']}');
//   } catch (e) {
//     print(e);
//   }
// }
