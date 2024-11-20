import 'package:project_domestic_violence/app/data/provider/appwriteRecord.dart';
import 'package:project_domestic_violence/app/models/record.dart';

class RecordRepository {
  final AppwriteRecord appWriteRecordProvider;

  RecordRepository(this.appWriteRecordProvider);

  Future<void> createRecord(RecordModel recordModel, List<String> imagePaths) {
    return appWriteRecordProvider.createRecord(recordModel, imagePaths);
  }

  Future<List<Map<String, dynamic>>> fetchRecordsByUserId(String id) {
    return appWriteRecordProvider.fetchRecordsByUserId(id);
  }
}
