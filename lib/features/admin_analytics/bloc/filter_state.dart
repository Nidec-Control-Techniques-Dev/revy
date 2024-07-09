part of 'filter_bloc.dart';

class FilterState {
  final String selectedFilter1;
  final String selectedFilter2;
  final String tempSelectedFilter1;
  final String tempSelectedFilter2;
  final String displayText;
  final String businessModel;
  final String subcategory;
  final String address;
  final String visitStatus;
  final double annualSales;
  final int total;
  final int visitedCount;
  final int notVisitedCount;
  final int ongoingCount;
  final Map<String, double> dataMap;

  FilterState({
    required this.selectedFilter1,
    required this.selectedFilter2,
    required this.tempSelectedFilter1,
    required this.tempSelectedFilter2,
    required this.displayText,
    required this.businessModel,
    required this.subcategory,
    required this.address,
    required this.visitStatus,
    required this.annualSales,
    required this.total,
    required this.visitedCount,
    required this.notVisitedCount,
    required this.ongoingCount,
    required this.dataMap,
  });

  FilterState copyWith({
    String? selectedFilter1,
    String? selectedFilter2,
    String? tempSelectedFilter1,
    String? tempSelectedFilter2,
    String? displayText,
    String? businessModel,
    String? subcategory,
    String? address,
    String? visitStatus,
    double? annualSales,
    int? total,
    int? visitedCount,
    int? notVisitedCount,
    int? ongoingCount,
    Map<String, double>? dataMap,
  }) {
    return FilterState(
      selectedFilter1: selectedFilter1 ?? this.selectedFilter1,
      selectedFilter2: selectedFilter2 ?? this.selectedFilter2,
      tempSelectedFilter1: tempSelectedFilter1 ?? this.tempSelectedFilter1,
      tempSelectedFilter2: tempSelectedFilter2 ?? this.tempSelectedFilter2,
      displayText: displayText ?? this.displayText,
      businessModel: businessModel ?? this.businessModel,
      subcategory: subcategory ?? this.subcategory,
      address: address ?? this.address,
      visitStatus: visitStatus ?? this.visitStatus,
      annualSales: annualSales ?? this.annualSales,
      total: total ?? this.total,
      visitedCount: visitedCount ?? this.visitedCount,
      notVisitedCount: notVisitedCount ?? this.notVisitedCount,
      ongoingCount: ongoingCount ?? this.ongoingCount,
      dataMap: dataMap ?? this.dataMap,
    );
  }
}
