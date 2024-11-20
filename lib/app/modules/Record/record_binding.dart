import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/provider/appwriteRecord.dart';
import 'package:project_domestic_violence/app/data/repository/recordRepository.dart';
import 'package:project_domestic_violence/app/modules/Record/record_controller.dart';

class RecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordController>(
      () => RecordController(RecordRepository(AppwriteRecord())),
    );
  }
}
