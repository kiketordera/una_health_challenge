import 'package:una_health_challenge/features/blood_glucose/data/models/blood_glucose_sample_model.dart';

abstract class BloodGlucoseRepository {
  Future<List<BloodGlucoseSampleModel>> getBloodGlucoseSamples();
}
