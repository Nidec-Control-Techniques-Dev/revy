import 'dart:convert';

class DistanceMatrix {
 // Method to parse the JSON response and extract the main texts
 static List<List<int>> getMatrix(String jsonResponse) {
    // Parse the JSON response
    Map<String, dynamic> responseMap = jsonDecode(jsonResponse);

    List<dynamic> rows= responseMap['rows'];

    List<List<int>> matrix = [];

    for (var row in rows) {

      List<int> rowElements = [];

      for (var element in row['elements']){
        int duration = element["duration"]["value"];
        rowElements.add(duration);
      }

      matrix.add(rowElements);
    }

    // Return the list of main texts
    return matrix;
 }
}

void print2DArray(List<List<int>> array) {
  for (var row in array) {
    for (var value in row) {
      print('$value ');
    }
    print(''); // This prints a new line after each row
  }
}
