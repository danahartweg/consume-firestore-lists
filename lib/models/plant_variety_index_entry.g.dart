// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_variety_index_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantVarietyIndexEntry _$PlantVarietyIndexEntryFromJson(
    Map<String, dynamic> json) {
  return PlantVarietyIndexEntry(
    id: json['id'] as String,
    displayName: json['n'] as String,
    originName: json['o'] as String,
    isLocal: json['l'] as bool ?? false,
  );
}
