import 'package:consume_firestore_lists/models/plant_variety_index_entry.dart';

abstract class PlantVarietyIndexRepository {
  Stream<List<PlantVarietyIndexEntry>> indexEntries(String homesteadId);
}
