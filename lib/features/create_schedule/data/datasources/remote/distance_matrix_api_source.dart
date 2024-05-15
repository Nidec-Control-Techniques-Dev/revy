import 'dart:convert'; // Make sure this import is at the top of your file
import 'dart:io';
import 'package:dio/dio.dart';
import '../../test_data/hardcoded_locations.dart';
import '../../../../../env/env.dart';

class DistanceMatrixDataSource {
 final Dio _dio;
 final String units = 'metric';

 DistanceMatrixDataSource(this._dio);
  

 Future<String> fetchDistMatrix(
    String destinationConcatenated,
    String originConcatenated,
  ) async {
    final response = await _dio.get(
      'https://maps.googleapis.com/maps/api/distancematrix/json',
      queryParameters: {
        'origins': originConcatenated,
        'destinations': destinationConcatenated,
        'units': units,
        'key': Env.googleMapsApiKey
        // Add other necessary parameters here
      },
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

// void main() async{
//   List<String> originList = [startingLocation];
//   List<String> destinationList = [ptA, ptB, ptC, ptD];
//   print("origins: $originList");
//   print("destinations: $destinationList");
//   final DistanceMatrixDataSource dataSource = DistanceMatrixDataSource(Dio());
//   String jsonResponse = await dataSource.fetchDistMatrix(
//     destinationList.join('|'),
//      originList.join('|')
//   );
//   print(jsonResponse);
//   await writeJsonToFile(jsonResponse);
// }

// Future<void> writeJsonToFile(String jsonData) async {
//   final file = File('output.json');  // Specify the path where you want to save the file
//   await file.writeAsString(jsonData);
//   print('JSON data written to output.json'); 
// }