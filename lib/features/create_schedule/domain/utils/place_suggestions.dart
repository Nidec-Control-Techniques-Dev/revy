import 'dart:convert';

class PlaceSuggestions {
 // Method to parse the JSON response and extract the main texts
 static List<String> getMainTexts(String jsonResponse) {
    // Parse the JSON response
    Map<String, dynamic> responseMap = jsonDecode(jsonResponse);

    // Extract the list of suggestions
    List<dynamic> suggestions = responseMap['suggestions'];

    // Initialize an empty list to hold the main texts
    List<String> mainTexts = [];

    // Iterate over each suggestion and extract the main text
    for (var suggestion in suggestions) {
      String mainText = suggestion['placePrediction']['text']['text'];
      mainTexts.add(mainText);
    }

    // Return the list of main texts
    return mainTexts;
 }
}
