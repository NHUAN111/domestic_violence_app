import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/repository/recordRepository.dart';
import 'package:project_domestic_violence/app/models/record.dart';

class RecordController extends GetxController {
  final RecordRepository recordRepository;

  RecordController(this.recordRepository);

  var posts = <Map<String, dynamic>>[].obs;

  Future<void> createRecord(
      RecordModel recordModel, List<String> imagePaths) async {
    try {
      await recordRepository.createRecord(recordModel, imagePaths);
      print("recordModel post created successfully!");
    } catch (e) {
      print("Error creating recordModel : $e");
    }

    Future<List<Map<String, dynamic>>> fetchRecordsByUserId(String id) async {
      return await recordRepository.fetchRecordsByUserId(id);
    }
  }
}
