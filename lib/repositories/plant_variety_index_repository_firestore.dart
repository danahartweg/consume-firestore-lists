import 'package:consume_firestore_lists/models/plant_variety_index.dart';
import 'package:consume_firestore_lists/models/plant_variety_index_entry.dart';
import 'package:consume_firestore_lists/repositories/plant_variety_index_repository.dart';
import 'package:consume_firestore_lists/services/service_locator.dart';

class PlantVarietyIndexRepositoryFirestore
    implements PlantVarietyIndexRepository {
  final plantVarietyIndexQuery = locator<Firestore>()
      .collection('indices')
      .where('indexName', isEqualTo: 'plant-varieties');

  @override
  Stream<List<PlantVarietyIndexEntry>> indexEntries(String homesteadId) {
    return plantVarietyIndexQuery
        .where(
          'parentId',
          whereIn: [
            'root',
            homesteadId,
          ],
        )
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) =>
                PlantVarietyIndex.fromJson(document.data).indexEntries)
            .expand((e) => e)
            .toList());
  }
}
