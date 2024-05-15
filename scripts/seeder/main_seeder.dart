// ignore_for_file: avoid_print

import 'dart:io';

import 'package:revy/env/env.dart';
import 'package:supabase/supabase.dart';

// Global variables.
late final SupabaseClient supabase;
late final AuthResponse authResponse;

Future<void> main() async {
  final stopwatch = Stopwatch()..start();
  print('[ START OF SCRIPT ]\n');

  // * Initialize Supabase client.
  print('[ INITIALIZING THE SUPABASE CLIENT... ]\n');
  supabase = SupabaseClient(
    Env.publicSupabaseUrl,
    Env.publicSupabaseAnonKey,
  );

  // * Authenticate the Supabase client (using the super user).
  print('[ AUTHENTICATING THE SUPABASE CLIENT... ]');
  authResponse = await supabase.auth.signInWithPassword(
    email: 'nidec.ct.dev@gmail.com',
    password: 'Qwerty1234',
  );
  print('Session: ${authResponse.session}\n');
  print('User: ${authResponse.user}\n');

  // * Read the csv file.
  print('[ READING THE CSV FILE... ]\n');
  final file = File('./raw_data/Copy of Philippines - Masterfile.csv');
  final List<String> lines = file.readAsLinesSync();

  // Get the headers from the csv file.
  List<String> columnNames = getColumnNames(lines[0]);

  // Extract the features from the csv file (per row).
  List<List<Object?>> data = [];
  for (int i = 1; i < lines.length; i++) {
    data.add(extractFeatures(lines[i]));
  }

  // Traverse the data (list of client companies).
  final countryIndex = columnNameToCompanyClientRowIndex('Country');
  final stateIndex = columnNameToCompanyClientRowIndex('State');

  for (int i = 0; i < 3; i++) {
    List<Object?> companyClient = data[i];
    print('[ ${i + 1} ]');

    // * Country.
    print('[ UPLOADING COUNTRY... ]');
    String countryName = companyClient[countryIndex] as String;

    if (await doesCountryExist(countryName)) {
      print('Country already exists.\n');
    } else {
      // Upload the country.
      await uploadCountry(countryName);
    }

    // * State.
    print('[ UPLOADING STATE... ]');
    String stateName = companyClient[stateIndex] as String;

    if (await doesStateExist(stateName)) {
      print('State already exists.\n');
    } else {
      // Upload the state.
    }
  }

  print('Upload Marxity');
  await uploadState('Marxity');

  print('[ END OF SCRIPT ]\n');
  stopwatch.stop();
  print('Execution time: ${stopwatch.elapsed}\n');

  exit(0);
}

Future<void> uploadState(String stateName) async {
  await supabase.from('states').insert({
    'name': stateName,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  });
}

Future<bool> doesStateExist(String stateName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('states').select('name').eq('name', stateName);

  return response.isNotEmpty;
}

Future<void> uploadCountry(String countryName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('countries').insert({
    'name': countryName,
    'un_code': getCountryUNCode(countryName),
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select();

  print(response);
}

Future<bool> doesCountryExist(String countryName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('countries').select('name').eq('name', countryName);

  return response.isNotEmpty;
}

List<Object?> extractFeatures(String row) {
  // Set to 'true' if the current character is inside a double quote.
  bool doubleQuoteFlag = false;
  List<Object?> features = [];
  int prevCommaIndex = 0;

  for (int i = 0; i < row.length; i++) {
    if (row[i] == '"') {
      doubleQuoteFlag = !doubleQuoteFlag;
    }

    if (row[i] == ',') {
      if (doubleQuoteFlag) {
        continue;
      }

      String substring = row.substring(prevCommaIndex, i);
      if (substring == '') {
        features.add(null);
      } else {
        features.add(substring);
      }

      prevCommaIndex = i + 1;
    }
  }

  return features;
}

/// The parameter [columnHeaderRow] should be the first row of the csv file or the
/// actual column header row.
///
/// Note: Just to be explicit that the return type should be [List<String>] and
/// not [List<Object?>] when getting the column names.
List<String> getColumnNames(String columnHeaderRow) {
  List<Object?> rawColumnNames = extractFeatures(columnHeaderRow);
  List<String> columnNames = [];

  for (int i = 0; i < rawColumnNames.length; i++) {
    columnNames.add(rawColumnNames[i] as String);
  }

  return columnNames;
}

/// Reference: https://unece.org/trade/cefact/unlocode-code-list-country-and-territory
String getCountryUNCode(String countryName) {
  // TODO: Add more countries.
  switch (countryName) {
    case 'China':
      return 'CN';
    case 'Philippines':
      return 'PH';
    case 'Vietnam':
      return 'VN';
    case 'Utopia':
      return 'UT';
    default:
      throw Exception('Country not found.');
  }
}

int columnNameToCompanyClientRowIndex(String columnName) {
  switch (columnName) {
    case 'Business Model':
      return 0;
    case 'Category':
      return 1;
    case 'Subcategory':
      return 2;
    case 'Company Name':
      return 3;
    case 'Address':
      return 4;
    case 'Latitude':
      return 5;
    case 'Longitude':
      return 6;
    case 'State':
      return 7;
    case 'Country':
      return 8;
    case 'Contact No.':
      return 9;
    case 'Fax No.':
      return 10;
    case 'Website':
      return 11;
    case 'Email':
      return 12;
    case 'Annual Sales':
      return 13;
    case 'Annual Sale':
      return 14;
    case 'Employees':
      return 15;
    default:
      throw Exception('Column name not found.');
  }
}
