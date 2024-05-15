import '../entities/company_entity.dart';

abstract class CompanyRepository {
  Future<List<List<int>>> getDistanceMatrix();
}