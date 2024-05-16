// TODO: [2] Refactor this. This script is too long and has too many repeated code.
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:revy/env/env.dart';
import 'package:supabase/supabase.dart';

// Global variables.
late final SupabaseClient supabase;
late final AuthResponse authResponse;
final DateTime cEmployeeCountDate = DateTime(2001, 12, 9);
final DateTime cAnnualSalesDate = DateTime(2001, 12, 9);

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
  print('[ SESSION ]');
  print('${authResponse.session}\n');
  print('[ USER ]');
  print('${authResponse.user}\n');

  const filePaths = [
    './raw_data/China - Masterfile.csv',
    './raw_data/Philippines - Masterfile.csv',
    './raw_data/Vietnam - Masterfile.csv',
  ];

  for (int i = 0; i < filePaths.length; i++) {
    print(filePaths[i]);
    await uploadDataToDatabase(filePaths[i]);
    print(
      '=====================================================================\n',
    );
  }

  print('[ END OF SCRIPT ]\n');
  stopwatch.stop();
  print('Execution time: ${stopwatch.elapsed}\n');

  exit(0);
}

Future<void> uploadDataToDatabase(String filePath) async {
  // * Read the csv file.
  print('[ READING THE CSV FILE... ]\n');
  final file = File(filePath);
  final List<String> lines = file.readAsLinesSync();

  // Get the headers from the csv file.
  List<String> columnNames = getColumnNames(lines[0]);
  print(columnNames);
  print(columnNames.length);

  // Extract the features from the csv file (per row).
  List<List<Object?>> data = [];
  for (int i = 1; i < lines.length; i++) {
    data.add(extractFeatures(lines[i]));
  }

  // Traverse the data (list of client companies).
  final int companyIndex = columnNameToCompanyClientRowIndex('Company Name');
  final int countryIndex = columnNameToCompanyClientRowIndex('Country');
  final int stateIndex = columnNameToCompanyClientRowIndex('State');
  final int businessModelIndex =
      columnNameToCompanyClientRowIndex('Business Model');
  final int categoryIndex = columnNameToCompanyClientRowIndex('Category');
  final int subcategoryIndex = columnNameToCompanyClientRowIndex('Subcategory');
  final int addressIndex = columnNameToCompanyClientRowIndex('Address');
  final int latitudeIndex = columnNameToCompanyClientRowIndex('Latitude');
  final int longitudeIndex = columnNameToCompanyClientRowIndex('Longitude');
  final int contactNumbersIndex =
      columnNameToCompanyClientRowIndex('Contact No.');
  final int companyEmailsIndex = columnNameToCompanyClientRowIndex('Email');
  final int companyFaxNumbersIndex =
      columnNameToCompanyClientRowIndex('Fax No.');
  final int companyWebsitesIndex = columnNameToCompanyClientRowIndex('Website');
  final int companyEmployeeCountIndex =
      columnNameToCompanyClientRowIndex('Employees');
  final int companyAnnualSalesIndex =
      columnNameToCompanyClientRowIndex('Annual Sales');

  for (int i = 0; i < data.length; i++) {
    List<Object?> companyClient = data[i];
    print('[ ${i + 1} ] --------------------------------------------------');
    print(companyClient.length);

    // Company.
    print('[ UPLOADING COMPANY... ]');
    String companyName =
        removeDoubleQuotes(companyClient[companyIndex] as String);
    late final String companyUUID;

    if (await doesCompanyExist(companyName)) {
      print('Company ($companyName) already exists.\n');
      companyUUID = await getCompanyUUID(companyName);
    } else {
      // Upload the company.
      companyUUID = await uploadCompany(companyName);
      print('Company ($companyName) uploaded.\n');
    }

    // * Country.
    print('[ UPLOADING COUNTRY... ]');
    String countryName =
        removeDoubleQuotes(companyClient[countryIndex] as String);
    late final String countryUUID;

    if (await doesCountryExist(countryName)) {
      print('Country ($countryName) already exists.\n');
      countryUUID = await getCountryUUID(countryName);
    } else {
      // Upload the country.
      countryUUID = await uploadCountry(countryName);
      print('Country ($countryName) uploaded.\n');
    }

    // * State.
    print('[ UPLOADING STATE... ]');
    String stateName = removeDoubleQuotes(companyClient[stateIndex] as String);
    late final String stateUUID;

    if (await doesStateExist(stateName)) {
      print('State ($stateName) already exists.\n');
      stateUUID = await getStateUUID(stateName);
    } else {
      // Upload the state.
      stateUUID = await uploadState(stateName, countryUUID);
      print('State ($stateName) uploaded.\n');
    }

    // * Business Model.
    print('[ UPLOADING BUSINESS MODEL... ]');
    String businessModel =
        removeDoubleQuotes(companyClient[businessModelIndex] as String);
    List<String> businessModelList = businessModel
        .split(',')
        .map((businessModel) => businessModel.trim())
        .toList();
    List<String> businessModelUUIDs = [];

    for (int i = 0; i < businessModelList.length; i++) {
      String businessModel = businessModelList[i];
      late final String businessModelUUID;

      if (await doesBusinessModelExist(businessModel)) {
        print('Business Model ($businessModel) already exists.');
        businessModelUUID = await getBusinessModelUUID(businessModel);
      } else {
        // Upload the business model.
        businessModelUUID = await uploadBusinessModel(businessModel);
        print('Business Model ($businessModel) uploaded.');
      }

      businessModelUUIDs.add(businessModelUUID);
    }
    print('');

    // * Category.
    print(' [ UPLOADING CATEGORY... ]');
    String categoryName =
        removeDoubleQuotes(companyClient[categoryIndex] as String);
    List<String> categoryList =
        categoryName.split(',').map((category) => category.trim()).toList();
    List<String> categoryUUIDs = [];

    for (int i = 0; i < categoryList.length; i++) {
      String category = categoryList[i];
      late final String categoryUUID;

      if (await doesCategoryNameExist(category)) {
        print('Category ($category) already exists.');
        categoryUUID = await getCategoryUUID(category);
      } else {
        // Upload the category.
        categoryUUID = await uploadCategory(category);
        print('Category ($category) uploaded.');
      }

      categoryUUIDs.add(categoryUUID);
    }
    print('');

    // * Subcategory.
    print('[ UPLOADING SUBCATEGORY... ]');
    String subcategoryName =
        removeDoubleQuotes(companyClient[subcategoryIndex] as String);
    List<String> subcategoryList = subcategoryName
        .split(',')
        .map((subcategory) => subcategory.trim())
        .toList();
    List<String> subcategoryUUIDs = [];

    for (int i = 0; i < subcategoryList.length; i++) {
      String subcategory = subcategoryList[i];
      late final String subcategoryUUID;

      if (await doesSubcategoryNameExist(subcategory)) {
        print('Subcategory ($subcategory) already exists.');
        subcategoryUUID = await getSubcategoryUUID(subcategory);
      } else {
        // Upload the subcategory.
        subcategoryUUID = await uploadSubcategory(subcategory);
        print('Subcategory ($subcategory) uploaded.');
      }

      subcategoryUUIDs.add(subcategoryUUID);
    }
    print('');

    // * Company Address
    print('[ UPLOADING COMPANY ADDRESS... ]');
    String fullTextAddress =
        removeDoubleQuotes(companyClient[addressIndex] as String);
    double latitude = double.parse(companyClient[latitudeIndex] as String);
    double longitude = double.parse(companyClient[longitudeIndex] as String);
    late final String companyAddressUUID;

    if (await doesCompanyAddressExist(fullTextAddress)) {
      print('Company Address ($fullTextAddress) already exists.\n');
      companyAddressUUID = await getCompanyAddressUUID(fullTextAddress);
    } else {
      // Upload the company address.
      companyAddressUUID = await uploadCompanyAddress(
        companyUUID: companyUUID,
        countryUUID: countryUUID,
        stateUUID: stateUUID,
        fullTextAddress: fullTextAddress,
        latitude: latitude,
        longitude: longitude,
      );
      print('Company Address ($fullTextAddress) uploaded.\n');
    }

    // * Company Contact Number
    print('[ UPLOADING COMPANY CONTACT NUMBER... ]');
    String? contactNumbers = companyClient[contactNumbersIndex] as String?;
    if (contactNumbers == null) {
      print('No contact number found.\n');
    } else {
      contactNumbers = removeDoubleQuotes(contactNumbers);
      List<String> contactNumbersList = contactNumbers
          .split(', ')
          .map((contactNumber) => contactNumber.trim())
          .toList();
      List<String> contactNumberUUIDs = [];

      for (int i = 0; i < contactNumbersList.length; i++) {
        String contactNumber = contactNumbersList[i];
        late final String contactNumberUUID;

        if (await doesContactNumberExist(contactNumber)) {
          print('Contact Number ($contactNumber) already exists.');
          contactNumberUUID = await getContactNumberUUID(contactNumber);
        } else {
          // Upload the contact number.
          contactNumberUUID = await uploadContactNumber(
            contactNumber: contactNumber,
            companyUUID: companyUUID,
          );
          print('Contact Number ($contactNumber) uploaded.');
        }

        contactNumberUUIDs.add(contactNumberUUID);
      }
      print('');
    }

    // * Company Email
    print('[ UPLOADING COMPANY EMAIL... ]');
    String? companyEmails = companyClient[companyEmailsIndex] as String?;
    if (companyEmails == null) {
      print('No company email found.\n');
    } else {
      companyEmails = removeDoubleQuotes(companyEmails);
      List<String> companyEmailsList = companyEmails
          .split(', ')
          .map((companyEmail) => companyEmail.trim())
          .toList();
      List<String> companyEmailUUIDs = [];

      for (int i = 0; i < companyEmailsList.length; i++) {
        String companyEmail = companyEmailsList[i];
        late final String companyEmailUUID;

        if (await doesCompanyEmailExist(companyEmail)) {
          print('Company Email ($companyEmail) already exists.');
          companyEmailUUID = await getCompanyEmailUUID(companyEmail);
        } else {
          // Upload the company email.
          companyEmailUUID = await uploadCompanyEmail(
            companyUUID: companyUUID,
            email: companyEmail,
          );
          print('Company Email ($companyEmail) uploaded.');
        }

        companyEmailUUIDs.add(companyEmailUUID);
      }
      print('');
    }

    // * Company Fax Number
    print('[ UPLOADING COMPANY FAX NUMBER... ]');
    String? companyFaxNumbers =
        companyClient[companyFaxNumbersIndex] as String?;
    if (companyFaxNumbers == null) {
      print('No company fax number found.\n');
    } else {
      companyFaxNumbers = removeDoubleQuotes(companyFaxNumbers);
      List<String> companyFaxNumbersList = companyFaxNumbers
          .split(', ')
          .map((companyFaxNumber) => companyFaxNumber.trim())
          .toList();
      List<String> companyFaxNumberUUIDs = [];

      for (int i = 0; i < companyFaxNumbersList.length; i++) {
        String companyFaxNumber = companyFaxNumbersList[i];
        late final String companyFaxNumberUUID;

        if (await doesCompanyFaxNumberExist(companyFaxNumber)) {
          print('Company Fax Number ($companyFaxNumber) already exists.');
          companyFaxNumberUUID =
              await getCompanyFaxNumberUUID(companyFaxNumber);
        } else {
          // Upload the company fax number.
          companyFaxNumberUUID = await uploadCompanyFaxNumber(
            companyUUID: companyUUID,
            faxNumber: companyFaxNumber,
          );
          print('Company Fax Number ($companyFaxNumber) uploaded.');
        }

        companyFaxNumberUUIDs.add(companyFaxNumberUUID);
      }
      print('');
    }

    // * Company Website
    print('[ UPLOADING COMPANY WEBSITE... ]');
    String? companyWebsites = companyClient[companyWebsitesIndex] as String?;
    if (companyWebsites == null) {
      print('No company website found.\n');
    } else {
      companyWebsites = removeDoubleQuotes(companyWebsites);
      List<String> companyWebsitesList = companyWebsites
          .split(', ')
          .map((companyWebsite) => companyWebsite.trim())
          .toList();
      List<String> companyWebsiteUUIDs = [];

      for (int i = 0; i < companyWebsitesList.length; i++) {
        String companyWebsite = companyWebsitesList[i];
        late final String companyWebsiteUUID;

        if (await doesCompanyWebsiteExist(companyWebsite)) {
          print('Company Website ($companyWebsite) already exists.');
          companyWebsiteUUID = await getCompanyWebsiteUUID(companyWebsite);
        } else {
          // Upload the company website.
          companyWebsiteUUID = await uploadCompanyWebsite(
            companyUUID: companyUUID,
            url: companyWebsite,
          );
          print('Company Website ($companyWebsite) uploaded.');
        }

        companyWebsiteUUIDs.add(companyWebsiteUUID);
      }
      print('');
    }

    // * Company Employee Count
    print('[ UPLOADING COMPANY EMPLOYEE COUNT... ]');
    String? rawCompanyEmployeeCount =
        companyClient[companyEmployeeCountIndex] as String?;

    if (rawCompanyEmployeeCount == null) {
      print('No company employee count found.\n');
    } else {
      late final String companyEmployeeCountUUID;
      final int companyEmployeeCount = stringIntToInt(rawCompanyEmployeeCount);

      if (await doesCompanyEmployeeCountExist(
          companyUUID: companyUUID,
          count: companyEmployeeCount,
          countDate: cEmployeeCountDate)) {
        print(
            'Company Employee Count ($companyEmployeeCount) already exists.\n');
        companyEmployeeCountUUID = await getCompanyEmployeeCountUUID(
          companyUUID: companyUUID,
          count: companyEmployeeCount,
          countDate: cEmployeeCountDate,
        );
      } else {
        // Upload the company employee count.
        companyEmployeeCountUUID = await uploadCompanyEmployeeCount(
          companyUUID: companyUUID,
          count: companyEmployeeCount,
          countDate: cEmployeeCountDate,
        );
        print('Company Employee Count ($companyEmployeeCount) uploaded.\n');
      }
    }

    // * Company Annual Sales
    print('[ UPLOADING COMPANY ANNUAL SALES... ]');
    String? rawCompanyAnnualSales =
        companyClient[companyAnnualSalesIndex] as String?;

    if (rawCompanyAnnualSales == null) {
      print('No company annual sales found.\n');
    } else {
      late final String companyAnnualSalesUUID;
      final double companyAnnualSales =
          stringDoubleToDouble(rawCompanyAnnualSales);

      if (await doesCompanyAnnualSalesExist(
          companyUUID: companyUUID,
          annualSales: companyAnnualSales,
          annualSalesDate: cAnnualSalesDate)) {
        print('Company Annual Sales ($companyAnnualSales) already exists.\n');
        companyAnnualSalesUUID = await getCompanyAnnualSalesUUID(
          companyUUID: companyUUID,
          annualSales: companyAnnualSales,
          multiplier: 1,
          annualSalesDate: cAnnualSalesDate,
        );
      } else {
        // Upload the company annual sales.
        companyAnnualSalesUUID = await uploadCompanyAnnualSales(
          companyUUID: companyUUID,
          annualSales: companyAnnualSales,
          annualSalesDate: cAnnualSalesDate,
        );
        print('Company Annual Sales ($companyAnnualSales) uploaded.\n');
      }
    }

    // * Company Client
    print('[ UPLOADING COMPANY CLIENT... ]');
    late final String companyClientUUID;

    if (await doesCompanyClientExist(
      companyUUID: companyUUID,
      businessModelUUIDs: businessModelUUIDs,
      categoryUUIDs: categoryUUIDs,
      subcategoryUUIDs: subcategoryUUIDs,
    )) {
      print('Company Client already exists.\n');
      companyClientUUID = await getCompanyClientUUID(
        companyUUID: companyUUID,
        businessModelUUIDs: businessModelUUIDs,
        categoryUUIDs: categoryUUIDs,
        subcategoryUUIDs: subcategoryUUIDs,
      );
    } else {
      // Upload the company client.
      companyClientUUID = await uploadCompanyClient(
        companyUUID: companyUUID,
        businessModelUUIDs: businessModelUUIDs,
        categoryUUIDs: categoryUUIDs,
        subcategoryUUIDs: subcategoryUUIDs,
      );
      print('Company Client uploaded.\n');
    }
  }
}

Future<String> getCompanyClientUUID({
  required String companyUUID,
  required List<String> businessModelUUIDs,
  required List<String> categoryUUIDs,
  required List<String> subcategoryUUIDs,
}) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_clients')
      .select(
        'uuid, company_ref, business_model_refs, category_refs, subcategory_refs',
      )
      .eq('company_ref', companyUUID)
      .eq('business_model_refs', businessModelUUIDs)
      .eq('category_refs', categoryUUIDs)
      .eq('subcategory_refs', subcategoryUUIDs);

  if (response.isEmpty) {
    throw Exception('Company Client not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple company clients found with the same details.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompanyClient({
  required String companyUUID,
  required List<String> businessModelUUIDs,
  required List<String> categoryUUIDs,
  required List<String> subcategoryUUIDs,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_clients').insert({
    'company_ref': companyUUID,
    'business_model_refs': businessModelUUIDs,
    'category_refs': categoryUUIDs,
    'subcategory_refs': subcategoryUUIDs,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCompanyClientExist({
  required String companyUUID,
  required List<String> businessModelUUIDs,
  required List<String> categoryUUIDs,
  required List<String> subcategoryUUIDs,
}) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_clients')
      .select(
        'company_ref, business_model_refs, category_refs, subcategory_refs',
      )
      .eq('company_ref', companyUUID)
      .eq('business_model_refs', businessModelUUIDs)
      .eq('category_refs', categoryUUIDs)
      .eq('subcategory_refs', subcategoryUUIDs);

  if (response.length > 1) {
    throw Exception('Multiple company clients found with the same details.');
  }

  return response.isNotEmpty;
}

Future<String> getCompanyAnnualSalesUUID({
  required String companyUUID,
  required double annualSales,
  required int multiplier,
  required DateTime annualSalesDate,
}) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_annual_sales')
      .select('uuid, company_ref, annual_sales, multiplier, annual_sales_date')
      .eq('company_ref', companyUUID)
      .eq('annual_sales', annualSales)
      .eq('multiplier', multiplier)
      .eq('annual_sales_date', annualSalesDate.toIso8601String());

  if (response.isEmpty) {
    throw Exception('Company Annual Sales not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple annual sales found with the same amount.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompanyAnnualSales({
  required String companyUUID,
  required double annualSales,
  int multiplier = 1,
  required DateTime annualSalesDate,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_annual_sales').insert({
    'company_ref': companyUUID,
    'annual_sales': annualSales,
    'multiplier': multiplier,
    'annual_sales_date': annualSalesDate.toIso8601String(),
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCompanyAnnualSalesExist({
  required String companyUUID,
  required double annualSales,
  int multiplier = 1,
  required DateTime annualSalesDate,
}) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_annual_sales')
      .select('company_ref, annual_sales, multiplier, annual_sales_date')
      .eq('company_ref', companyUUID)
      .eq('annual_sales', annualSales)
      .eq('multiplier', multiplier)
      .eq('annual_sales_date', annualSalesDate.toIso8601String());

  if (response.length > 1) {
    throw Exception('Multiple annual sales found with the same amount.');
  }

  return response.isNotEmpty;
}

Future<String> getCompanyEmployeeCountUUID({
  required String companyUUID,
  required int count,
  required DateTime countDate,
}) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_employee_counts')
      .select('uuid, company_ref, count, count_date')
      .eq('company_ref', companyUUID)
      .eq('count', count)
      .eq('count_date', countDate.toIso8601String());

  if (response.isEmpty) {
    throw Exception('Company Employee Count not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple employee counts found with the same count.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompanyEmployeeCount({
  required String companyUUID,
  required int count,
  required DateTime countDate,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_employee_counts').insert({
    'company_ref': companyUUID,
    'count': count,
    'count_date': countDate.toIso8601String(),
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCompanyEmployeeCountExist({
  required String companyUUID,
  required int count,
  required DateTime countDate,
}) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_employee_counts')
      .select('company_ref, count, count_date')
      .eq('company_ref', companyUUID)
      .eq('count', count)
      .eq('count_date', countDate.toIso8601String());

  if (response.length > 1) {
    throw Exception('Multiple employee counts found with the same count.');
  }

  return response.isNotEmpty;
}

Future<String> getCompanyWebsiteUUID(String url) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_websites')
      .select('uuid, url')
      .eq('url', url);

  if (response.isEmpty) {
    throw Exception('Company Website not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple websites found with the same website.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompanyWebsite({
  required String companyUUID,
  required String url,
  bool? isVerified = false,
  DateTime? verifiedAt,
  String? verifiedByUUID,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_websites').insert({
    'company_ref': companyUUID,
    'url': url,
    'is_verified': isVerified,
    'verified_at': verifiedAt?.toIso8601String(),
    'verified_by_ref': verifiedByUUID,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCompanyWebsiteExist(String url) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_websites').select('url').eq('url', url);

  if (response.length > 1) {
    throw Exception('Multiple websites found with the same website.');
  }

  return response.isNotEmpty;
}

Future<String> getCompanyFaxNumberUUID(String faxNumber) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_fax_numbers')
      .select('uuid, number')
      .eq('number', faxNumber);

  if (response.isEmpty) {
    throw Exception('Company Fax Number not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple fax numbers found with the same number.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompanyFaxNumber({
  required String companyUUID,
  required String faxNumber,
  bool? isVerified = false,
  DateTime? verifiedAt,
  String? verifiedByUUID,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_fax_numbers').insert({
    'company_ref': companyUUID,
    'number': faxNumber,
    'is_verified': isVerified,
    'verified_at': verifiedAt?.toIso8601String(),
    'verified_by_ref': verifiedByUUID,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCompanyFaxNumberExist(String faxNumber) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_fax_numbers')
      .select('number')
      .eq('number', faxNumber);

  if (response.length > 1) {
    throw Exception('Multiple fax numbers found with the same number.');
  }

  return response.isNotEmpty;
}

Future<String> getCompanyEmailUUID(String email) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_emails')
      .select('uuid, email')
      .eq('email', email);

  if (response.isEmpty) {
    throw Exception('Company Email not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple emails found with the same email.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompanyEmail({
  required String companyUUID,
  required String email,
  bool? isVerified = false,
  DateTime? verifiedAt,
  String? verifiedByUUID,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_emails').insert({
    'company_ref': companyUUID,
    'email': email,
    'is_verified': isVerified,
    'verified_at': verifiedAt?.toIso8601String(),
    'verified_by_ref': verifiedByUUID,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCompanyEmailExist(String email) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_emails').select('email').eq('email', email);

  if (response.length > 1) {
    throw Exception('Multiple emails found with the same email.');
  }

  return response.isNotEmpty;
}

Future<String> getContactNumberUUID(String contactNumber) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_contact_numbers')
      .select('uuid, number')
      .eq('number', contactNumber);

  if (response.isEmpty) {
    throw Exception('Contact Number not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple contact numbers found with the same number.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadContactNumber({
  required String contactNumber,
  required String companyUUID,
  bool? isVerified = false,
  DateTime? verifiedAt,
  String? verifiedByUUID,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_contact_numbers').insert({
    'company_ref': companyUUID,
    'number': contactNumber,
    'is_verified': isVerified,
    'verified_at': verifiedAt?.toIso8601String(),
    'verified_by_ref': verifiedByUUID,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesContactNumberExist(String contactNumber) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_contact_numbers')
      .select('number')
      .eq('number', contactNumber);

  if (response.length > 1) {
    throw Exception('Multiple contact numbers found with the same number.');
  }

  return response.isNotEmpty;
}

// TODO: [2] Add more identifiers other than the full text address. It is possible that
// two totally different companies have the same address.
Future<String> getCompanyAddressUUID(String fullTextAddress) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_addresses')
      .select('uuid, full_text')
      .eq('full_text', fullTextAddress);

  if (response.isEmpty) {
    throw Exception('Company Address not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple company addresses found with the same address.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompanyAddress({
  required String companyUUID,
  required String countryUUID,
  required String stateUUID,
  required String fullTextAddress,
  required double latitude,
  required double longitude,
}) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('company_addresses').insert({
    'company_ref': companyUUID,
    'country_ref': countryUUID,
    'state_ref': stateUUID,
    'full_text': fullTextAddress,
    'latitude': latitude,
    'longitude': longitude,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCompanyAddressExist(String fullTextAddress) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('company_addresses')
      .select('full_text')
      .eq('full_text', fullTextAddress);

  if (response.length > 1) {
    throw Exception('Multiple company addresses found with the same address.');
  }

  return response.isNotEmpty;
}

// TODO: [p2] Add more identifiers other than the company name. It is possible that
// two totally different companies have the same name.
Future<String> getCompanyUUID(String companyName) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('companies')
      .select('uuid, name')
      .eq('name', companyName);

  if (response.isEmpty) {
    throw Exception('Company not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple companies found with the same name.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCompany(String companyName,
    [String? companyDescription]) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('companies').insert({
    'name': companyName,
    'description': companyDescription,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

// TODO: [p2] Add more identifiers other than the company name. It is possible that
// two totally different companies have the same name.
Future<bool> doesCompanyExist(String companyName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('companies').select('name').eq('name', companyName);

  if (response.length > 1) {
    throw Exception('Multiple companies found with the same name.');
  }

  return response.isNotEmpty;
}

Future<String> getSubcategoryUUID(String subcategoryName) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('subcategories')
      .select('uuid, name')
      .eq('name', subcategoryName);

  if (response.isEmpty) {
    throw Exception('Subcategory not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple subcategories found with the same name.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadSubcategory(String subcategoryName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('subcategories').insert({
    'name': subcategoryName,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesSubcategoryNameExist(String subcategoryName) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('subcategories')
      .select('name')
      .eq('name', subcategoryName);

  if (response.length > 1) {
    throw Exception('Multiple subcategories found with the same name.');
  }

  return response.isNotEmpty;
}

Future<String> getCategoryUUID(String categoryName) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('categories')
      .select('uuid, name')
      .eq('name', categoryName);

  if (response.isEmpty) {
    throw Exception('Category not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple categories found with the same name.');
  }

  return response[0]['uuid'] as String;
}

Future<String> uploadCategory(String categoryName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('categories').insert({
    'name': categoryName,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCategoryNameExist(String categoryName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('categories').select('name').eq('name', categoryName);

  if (response.length > 1) {
    throw Exception('Multiple categories found with the same name.');
  }

  return response.isNotEmpty;
}

Future<String> getBusinessModelUUID(String businessModelName) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('business_models')
      .select('uuid, name')
      .eq('name', businessModelName);

  if (response.isEmpty) {
    throw Exception('Business Model not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple business models found with the same name.');
  }

  return response[0]['uuid'] as String;
}

/// Returns the generated UUID.
Future<String> uploadBusinessModel(String businessModelName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('business_models').insert({
    'name': businessModelName,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesBusinessModelExist(String businessModelName) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('business_models')
      .select('name')
      .eq('name', businessModelName);

  if (response.length > 1) {
    throw Exception('Multiple business models found with the same name.');
  }

  return response.isNotEmpty;
}

Future<String> getStateUUID(String stateName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('states').select('uuid, name').eq('name', stateName);

  if (response.isEmpty) {
    throw Exception('State not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple states found with the same name.');
  }

  return response[0]['uuid'] as String;
}

/// Returns the generated UUID.
Future<String> uploadState(String stateName, String countryUUID) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('states').insert({
    'name': stateName,
    'country_ref': countryUUID,
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesStateExist(String stateName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('states').select('name').eq('name', stateName);

  if (response.length > 1) {
    throw Exception('Multiple states found with the same name.');
  }

  return response.isNotEmpty;
}

Future<String> getCountryUUID(String countryName) async {
  final List<Map<String, dynamic>> response = await supabase
      .from('countries')
      .select('uuid, name')
      .eq('name', countryName);

  if (response.isEmpty) {
    throw Exception('Country not found.');
  }

  if (response.length > 1) {
    throw Exception('Multiple countries found with the same name.');
  }

  return response[0]['uuid'] as String;
}

/// Returns the generated UUID.
Future<String> uploadCountry(String countryName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('countries').insert({
    'name': countryName,
    'un_code': getCountryUNCode(countryName),
    'added_at': DateTime.now().toIso8601String(),
    'added_by_ref': authResponse.user?.id,
    'updated_at': DateTime.now().toIso8601String(),
    'updated_by_ref': authResponse.user?.id,
  }).select('uuid');

  return response[0]['uuid'] as String;
}

Future<bool> doesCountryExist(String countryName) async {
  final List<Map<String, dynamic>> response =
      await supabase.from('countries').select('name').eq('name', countryName);

  if (response.length > 1) {
    throw Exception('Multiple countries found with the same name.');
  }

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

  // Add the last feature.
  features.add(row.substring(prevCommaIndex, row.length));

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

String removeDoubleQuotes(String text) {
  if (text[0] == '"' && text[text.length - 1] == '"') {
    return text.substring(1, text.length - 1);
  }

  return text;
}

int stringIntToInt(String stringInt) {
  return int.parse(removeDoubleQuotes(stringInt.replaceAll(',', '')));
}

double stringDoubleToDouble(String stringDouble) {
  return double.parse(removeDoubleQuotes(stringDouble.replaceAll(',', '')));
}
