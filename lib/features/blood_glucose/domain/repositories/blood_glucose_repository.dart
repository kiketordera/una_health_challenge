import 'package:una_health_challenge/features/blood_glucose/data/models/blood_glucose_sample_model.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/entities/blodd_glucose_sample.dart';

abstract class BloodGlucoseRepository {
  Future<List<BloodGlucoseSampleModel>> getBloodGlucoseSamplesModels();
  Future<List<BloodGlucoseSample>> getBloodGlucoseSamples();
}
