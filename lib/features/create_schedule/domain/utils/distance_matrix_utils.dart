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



// # Process the response data
// for row in data["rows"]:
//     for element in row["elements"]:
//         distance = element["distance"]["text"]
//         duration = element["duration"]["text"]
//         print(f"Distance: {distance}, Duration: {duration}")

void print2DArray(List<List<int>> array) {
  for (var row in array) {
    for (var value in row) {
      print('$value ');
    }
    print(''); // This prints a new line after each row
  }
}

// void main() async{
//   String response = '''
//   {"destination_addresses":["North Avenue, corner Epifanio de los Santos Ave, Bagong Pag-asa, Quezon City, 1100 Metro Manila, Philippines","M339+HC2, Roxas Ave, Diliman, Quezon City, Metro Manila, Philippines","World Plaza, 30th St, Taguig, Kalakhang Maynila, Philippines","123 Paseo de Roxas, Legazpi Village, Makati, 1229 Metro Manila, Philippines"],"origin_addresses":["Cagayan Valley Road, Banga 1, Plaridel, 3004 Bulacan, Philippines"],"rows":[{"elements":[{"distance":{"text":"36.5 km","value":36482},"duration":{"text":"49 mins","value":2939},"status":"OK"},{"distance":{"text":"40.7 km","value":40694},"duration":{"text":"55 mins","value":3279},"status":"OK"},{"distance":{"text":"52.9 km","value":52917},"duration":{"text":"1 hour 13 mins","value":4389},"status":"OK"},{"distance":{"text":"49.9 km","value":49900},"duration":{"text":"1 hour 5 mins","value":3898},"status":"OK"}]}],"status":"OK"}
//   ''';

//   List<List<int>>matrix = DistanceMatrix.getMatrix(
//     response
//   );
//   print2DArray(matrix);
// }
