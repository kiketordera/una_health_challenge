import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:una_health_challenge/features/blood_glucose/data/models/blood_glucose_sample_model.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/entities/blodd_glucose_sample.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/repositories/blood_glucose_repository.dart';

class BloodGlucoseRemoteDataSourceImpl implements BloodGlucoseRepository {
  final http.Client client;

  BloodGlucoseRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BloodGlucoseSampleModel>> getBloodGlucoseSamplesModels() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw Exception('No internet connection');
    }

    try {
      final response = await client
          .get(Uri.parse(
              'https://s3-de-central.profitbricks.com/una-health-frontend-tech-challenge/sample.json'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final samples = data['bloodGlucoseSamples'] as List;
        return samples
            .map((json) => BloodGlucoseSampleModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load data with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Future<List<BloodGlucoseSample>> getBloodGlucoseSamples() async {
    final models = await getBloodGlucoseSamplesModels();
    return models.map((model) {
      return BloodGlucoseSample(
        value: model.value,
        timestamp: model.timestamp,
        unit: model.unit,
      );
    }).toList();
  }
}
