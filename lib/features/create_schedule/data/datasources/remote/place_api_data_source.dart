import 'dart:convert'; // Make sure this import is at the top of your file
import 'package:dio/dio.dart';
import '../../../../../env/env.dart';

class PlaceApiDataSource {
 final Dio _dio;

 PlaceApiDataSource(this._dio);

 Future<String> fetchPlaceSuggestions(String query) async {
    final response = await _dio.post(
      'https://places.googleapis.com/v1/places:autocomplete',
      data: {
        'input': query,
        // Add other necessary parameters here
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': Env.googleMapsApiKey, // Use the API key from your environment variables
        },
      ),
    );

    if (response.statusCode == 200) {
      // Serialize the Map<String, dynamic> to a JSON string
      String jsonResponse = jsonEncode(response.data);
      return jsonResponse;
    } else {
      throw Exception('Failed to load place suggestions');
    }
 }
}

void main() async{
  final PlaceApiDataSource dataSource = PlaceApiDataSource(Dio());
  String jsonResponse = await dataSource.fetchPlaceSuggestions("Walter Mart Plaridel");
  // print(jsonResponse);
}