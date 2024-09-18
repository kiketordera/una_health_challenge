import 'package:una_health_challenge/features/blood_glucose/data/models/blood_glucose_sample_model.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/entities/blodd_glucose_sample.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/repositories/blood_glucose_repository.dart';

class BloodGlucoseRepositoryImpl implements BloodGlucoseRepository {
  final BloodGlucoseRepository remoteDataSource;

  BloodGlucoseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BloodGlucoseSampleModel>> getBloodGlucoseSamplesModels() async {
    return await remoteDataSource.getBloodGlucoseSamplesModels();
  }

  @override
  Future<List<BloodGlucoseSample>> getBloodGlucoseSamples() async {
    final List<BloodGlucoseSampleModel> models =
        await getBloodGlucoseSamplesModels();

    final List<BloodGlucoseSample> entities = models.map((model) {
      return BloodGlucoseSample(
        value: model.value,
        timestamp: model.timestamp,
        unit: model.unit,
      );
    }).toList();

    return entities;
  }
}
