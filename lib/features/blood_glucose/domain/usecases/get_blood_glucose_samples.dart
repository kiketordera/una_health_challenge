import 'package:una_health_challenge/features/blood_glucose/domain/entities/blodd_glucose_sample.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/repositories/blood_glucose_repository.dart';

class GetBloodGlucoseSamples {
  final BloodGlucoseRepository repository;

  GetBloodGlucoseSamples(this.repository);

  Future<List<BloodGlucoseSample>> call() async {
    return await repository.getBloodGlucoseSamples();
  }
}
