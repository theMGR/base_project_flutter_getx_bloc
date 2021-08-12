import 'package:project/domain/entities/sample_quotable.dart';

abstract class SampleQuotableRepository {
  Future<SampleQuotable?> getQuotableList({int? page, int? limit});
}