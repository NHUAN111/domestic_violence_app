import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:project_domestic_violence/app/data/provider/config.dart';
import 'package:project_domestic_violence/app/models/realtime.dart';

Client client = Client()
    .setEndpoint(Config.endpoint)
    .setProject(Config.projectId)
    .setSelfSigned(status: true);

Account account = Account(client);
Databases database = Databases(client);
Storage storage = Storage(client);
Realtime realtime = Realtime(client);

Stream<RealtimeModel> subscribeToRealtime() {
  return realtime
      .subscribe([
        'databases.${Config.databaseId}.collections.${Config.realtimeCollectionId}.documents'
      ])
      .stream
      .map((event) {
        final payload = event.payload;
        print(" test ${payload}");
        return RealtimeModel.fromJson(payload);
      });
}

Future<RealtimeModel> initialFunction() async {
  try {
    Document document = await database.getDocument(
      databaseId: Config.databaseId,
      collectionId: Config.realtimeCollectionId,
      documentId:
          '671fbcae00253de94438', // Replace with the specific document ID you want to fetch
    );

    return RealtimeModel.fromJson(document.data);
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching initial data: $e');
    }
    // Return a default or empty model if there's an error
    return RealtimeModel(text1: 'Error', text2: 'Error');
  }
}
