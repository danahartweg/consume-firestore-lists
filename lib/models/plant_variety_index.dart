import 'package:json_annotation/json_annotation.dart';

import 'plant_variety_index_entry.dart';

part 'plant_variety_index.g.dart';

@JsonSerializable(anyMap: true, createToJson: false)
class PlantVarietyIndex {
  @JsonKey(defaultValue: [])
  final List<PlantVarietyIndexEntry> indexEntries;

  final String indexName;
  final bool isFull;
  final String parentId;

  PlantVarietyIndex({
    this.indexEntries,
    this.indexName,
    this.isFull,
    this.parentId,
  });

  factory PlantVarietyIndex.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> indexEntries = Map.from(json);
    indexEntries.remove('indexName');
    indexEntries.remove('isFull');
    indexEntries.remove('parentId');

    // the keys we transferred into this map will automatically
    // be removed during serialization
    json['indexEntries'] =
        indexEntries.entries.map((e) => {...e.value, 'id': e.key}).toList();

    return _$PlantVarietyIndexFromJson(json);
  }
}
