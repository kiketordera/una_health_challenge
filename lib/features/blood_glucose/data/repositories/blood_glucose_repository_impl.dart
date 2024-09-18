import 'package:una_health_challenge/features/blood_glucose/data/models/blood_glucose_sample_model.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/repositories/blood_glucose_repository.dart';

class BloodGlucoseRepositoryImpl implements BloodGlucoseRepository {
  final BloodGlucoseRepository remoteDataSource;

  BloodGlucoseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BloodGlucoseSampleModel>> getBloodGlucoseSamples() async {
    return await remoteDataSource.getBloodGlucoseSamples();
  }
}
