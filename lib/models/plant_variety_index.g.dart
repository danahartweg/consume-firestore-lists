// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_variety_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantVarietyIndex _$PlantVarietyIndexFromJson(Map json) {
  return PlantVarietyIndex(
    indexEntries: (json['indexEntries'] as List)
            ?.map((e) => e == null
                ? null
                : PlantVarietyIndexEntry.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList() ??
        [],
    indexName: json['indexName'] as String,
    isFull: json['isFull'] as bool,
    parentId: json['parentId'] as String,
  );
}
