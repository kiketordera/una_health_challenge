import 'package:una_health_challenge/features/blood_glucose/data/models/blood_glucose_sample_model.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/repositories/blood_glucose_repository.dart';

class GetBloodGlucoseSamples {
  final BloodGlucoseRepository repository;

  GetBloodGlucoseSamples(this.repository);

  Future<List<BloodGlucoseSampleModel>> call() async {
    return await repository.getBloodGlucoseSamples();
  }
}
