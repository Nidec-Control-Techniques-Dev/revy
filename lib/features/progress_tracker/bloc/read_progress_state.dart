part of 'read_progress_bloc.dart';

class ProgressTrackerState {
  // final List<Map<String, dynamic>>? clientName;
  // final List<Map<String, dynamic>>? businessModel;
  // final List<Map<String, dynamic>>? address;
  // final List<Map<String, dynamic>>? annualSales;
  // final List<Map<String, dynamic>>? telephoneNumber;
  // final List<Map<String, dynamic>>? email;
  // final List<Map<String, dynamic>>? faxNo;
  // final List<Map<String, dynamic>>? status;
  // final List<Map<String, dynamic>>? scheduleDates;
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
  ProgressTrackerState(
      {this.clientName,
      this.companyRef,
      this.category,
      this.businessModel,
      this.address,
      this.annualSales,
      this.telephoneNumber,
      this.email,
      this.faxNo,
      this.status,
      this.scheduleDates
      });

  ProgressTrackerState copyWith({
    List<dynamic>? clientName,
    List<dynamic>? companyRef,
    List<dynamic>?  category,
    List<dynamic>? businessModel,
    List<dynamic>? address,
    List<dynamic>? annualSales,
    List<dynamic>? telephoneNumber,
    List<dynamic>? email,
    List<dynamic>? faxNo,
    List<dynamic>? status,
    List<dynamic>? scheduleDates
    // List<Map<String, dynamic>>? clientName,
    // List<Map<String, dynamic>>? businessModel,
    // List<Map<String, dynamic>>? address,
    // List<Map<String, dynamic>>? annualSales,
    // List<Map<String, dynamic>>? telephoneNumber,
    //  List<Map<String, dynamic>>? email,
    // List<Map<String, dynamic>>? faxNo,
    // List<Map<String, dynamic>>? status,
    // List<Map<String, dynamic>>? scheduleDates,
  }) {
    return ProgressTrackerState(
      clientName: clientName ?? this.clientName,
      companyRef: companyRef ?? this.companyRef,
      category: category ?? this.category,
      businessModel: businessModel ?? this.businessModel,
      address: clientName ?? this.address,
      annualSales: annualSales ?? this.annualSales,
      telephoneNumber: telephoneNumber ?? this.telephoneNumber,
      email: email ?? this.email,
      faxNo: faxNo ?? this.faxNo,
      status: faxNo ?? this.status,
      scheduleDates: scheduleDates ?? this.scheduleDates

      // filterStatus: filterStatus ?? this.filterStatus,
      // startDate: startDate ?? this.startDate,
      // endDate: endDate ?? this.endDate,
    );
  }
}

class DataError extends ProgressTrackerState {
  final String message;

  DataError(this.message);
}
