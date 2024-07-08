part of 'read_progress_bloc.dart';

class ProgressTrackerState {
  final List<Map<String, dynamic>>? clientName;
  final List<Map<String, dynamic>>? businessModel;
  final List<Map<String, dynamic>>? address;
  final List<Map<String, dynamic>>? annualSales;
  final List<Map<String, dynamic>>? telephoneNumber;
  final List<Map<String, dynamic>>? email;
  final List<Map<String, dynamic>>? faxNo;
  final List<Map<String, dynamic>>? status;
  ProgressTrackerState(
      {this.clientName,
      this.businessModel,
      this.address,
      this.annualSales,
      this.telephoneNumber,
      this.email,
      this.faxNo,
      this.status});

  ProgressTrackerState copyWith({
    List<Map<String, dynamic>>? clientName,
    List<Map<String, dynamic>>? businessModel,
    List<Map<String, dynamic>>? address,
    List<Map<String, dynamic>>? annualSales,
    List<Map<String, dynamic>>? telephoneNumber,
    List<Map<String, dynamic>>? email,
    List<Map<String, dynamic>>? faxNo,
    List<Map<String, dynamic>>? status,
  }) {
    return ProgressTrackerState(
      clientName: clientName ?? this.clientName,
      businessModel: businessModel ?? this.businessModel,
      address: clientName ?? this.address,
      annualSales: annualSales ?? this.annualSales,
      telephoneNumber: telephoneNumber ?? this.telephoneNumber,
      email: email ?? this.email,
      faxNo: faxNo ?? this.faxNo,
      status: faxNo ?? this.status,

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
