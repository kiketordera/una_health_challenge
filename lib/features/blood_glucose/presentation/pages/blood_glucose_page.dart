import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:una_health_challenge/features/blood_glucose/data/datasources/api.dart';
import 'package:una_health_challenge/features/blood_glucose/data/repositories/blood_glucose_repository_impl.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/entities/blodd_glucose_sample.dart';
import 'package:una_health_challenge/features/blood_glucose/domain/usecases/get_blood_glucose_samples.dart';
import 'package:una_health_challenge/features/blood_glucose/presentation/widgets/blood_glucose_chart.dart';

import 'package:http/http.dart' as http;
import 'package:una_health_challenge/features/blood_glucose/presentation/widgets/statistics_section.dart';

class BloodGlucosePage extends StatefulWidget {
  const BloodGlucosePage({super.key});

  @override
  BloodGlucosePageState createState() => BloodGlucosePageState();
}

class BloodGlucosePageState extends State<BloodGlucosePage> {
  DateTime? _startDate;
  DateTime? _endDate;
  List<BloodGlucoseSample> _allSamples = [];
  List<BloodGlucoseSample> _filteredSamples = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSamples();
  }

  Future<void> _fetchSamples() async {
    final repository = BloodGlucoseRepositoryImpl(
      remoteDataSource: BloodGlucoseRemoteDataSourceImpl(client: http.Client()),
    );
    final getSamples = GetBloodGlucoseSamples(repository);
    final samples = await getSamples();
    setState(() {
      _allSamples = samples;
      _filteredSamples = samples;
      _isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = DateTime(picked.year, picked.month, picked.day, 0, 0, 0);
        } else {
          _endDate =
              DateTime(picked.year, picked.month, picked.day, 23, 59, 59, 999);
        }
        _applyFilters();
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredSamples = _allSamples.where((sample) {
        final timestamp = sample.timestamp;
        if (_startDate != null && timestamp.isBefore(_startDate!)) return false;
        if (_endDate != null && timestamp.isAfter(_endDate!)) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Glucose Levels'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Date'),
                          const SizedBox(height: 8.0),
                          OutlinedButton(
                            onPressed: () => _selectDate(context, true),
                            child: Text(_startDate == null
                                ? 'Select Start Date'
                                : dateFormat.format(_startDate!)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('End Date'),
                          const SizedBox(height: 8.0),
                          OutlinedButton(
                            onPressed: () => _selectDate(context, false),
                            child: Text(_endDate == null
                                ? 'Select End Date'
                                : dateFormat.format(_endDate!)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  BloodGlucoseChart(samples: _filteredSamples),
                  const SizedBox(height: 16.0),
                  StatisticsSection(samples: _filteredSamples),
                ],
              ),
            ),
    );
  }
}
