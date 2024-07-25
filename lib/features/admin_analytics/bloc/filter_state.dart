part of 'filter_bloc.dart';

class FilterState {
  final List<dynamic>? clientName;
  final List<dynamic>? companyRef;
  final List<dynamic>?  category;
  final List<dynamic>?  businessModel;
  final List<dynamic>? address;
  final List<dynamic>? annualSales;
  final List<dynamic>? telephoneNumber;
  final List<dynamic>? email;
  final List<dynamic>? faxNo;
  final List<dynamic>? status;
  final List<dynamic>? scheduleDates;
  // 
  final String salesPersonRef;
  final String selectedFilter1;
  final String selectedFilter2;
  final String tempSelectedFilter1;
  final String tempSelectedFilter2;
  final String displayText;
  // final String businessModel;
  // final String subcategory;
  // final String address;
  // final String visitStatus;
  // final double annualSales;
  final int total;
  final int visitedCount;
  final int notVisitedCount;
  final int ongoingCount;
  final Map<String, double> dataMap;

  FilterState({
    required this.clientName,
    required this.companyRef,
    required this.category,
    required this.businessModel,
    required this.address,
    required this.annualSales,
    required this.telephoneNumber,
    required this.email,
    required this.faxNo,
    required this.status,
    required this.scheduleDates,
    // 
    required this.salesPersonRef,
    required this.selectedFilter1,
    required this.selectedFilter2,
    required this.tempSelectedFilter1,
    required this.tempSelectedFilter2,
    required this.displayText,
    // required this.businessModel,
    // required this.subcategory,
    // required this.address,
    // required this.visitStatus,
    // required this.annualSales,
    required this.total,
    required this.visitedCount,
    required this.notVisitedCount,
    required this.ongoingCount,
    required this.dataMap,
  });

  FilterState copyWith({
    List<dynamic>? clientName,
    List<dynamic>? companyRef,
    List<dynamic>?  category,
    List<dynamic>?  businessModel,
    List<dynamic>? address,
    List<dynamic>? annualSales,
    List<dynamic>? telephoneNumber,
    List<dynamic>? email,
    List<dynamic>? faxNo,
    List<dynamic>? status,
    List<dynamic>? scheduleDates,
    // 
    String? salesPersonRef,
    String? selectedFilter1,
    String? selectedFilter2,
    String? tempSelectedFilter1,
    String? tempSelectedFilter2,
    String? displayText,
    // String? businessModel,
    // String? subcategory,
    // String? address,
    // String? visitStatus,
    // double? annualSales,
    int? total,
    int? visitedCount,
    int? notVisitedCount,
    int? ongoingCount,
    Map<String, double>? dataMap,
  }) {
    return FilterState(
      clientName: clientName,
      companyRef: companyRef,
      category: category,
      businessModel: businessModel,
      address: address,
      annualSales: annualSales,
      telephoneNumber: telephoneNumber,
      email: email,
      faxNo: faxNo,
      status: status,
      scheduleDates: scheduleDates,
      // 
      salesPersonRef: salesPersonRef ?? this.salesPersonRef,
      selectedFilter1: selectedFilter1 ?? this.selectedFilter1,
      selectedFilter2: selectedFilter2 ?? this.selectedFilter2,
      tempSelectedFilter1: tempSelectedFilter1 ?? this.tempSelectedFilter1,
      tempSelectedFilter2: tempSelectedFilter2 ?? this.tempSelectedFilter2,
      displayText: displayText ?? this.displayText,
      // businessModel: businessModel ?? this.businessModel,
      // subcategory: subcategory ?? this.subcategory,
      // address: address ?? this.address,
      // visitStatus: visitStatus ?? this.visitStatus,
      // annualSales: annualSales ?? this.annualSales,
      total: total ?? this.total,
      visitedCount: visitedCount ?? this.visitedCount,
      notVisitedCount: notVisitedCount ?? this.notVisitedCount,
      ongoingCount: ongoingCount ?? this.ongoingCount,
      dataMap: dataMap ?? this.dataMap,
    );
  }
}
