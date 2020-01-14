import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plant_variety_index_entry.g.dart';

@JsonSerializable(createToJson: false)
class PlantVarietyIndexEntry extends Equatable {
  final String id;

  @JsonKey(name: 'n')
  final String displayName;

  @JsonKey(name: 'o')
  final String originName;

  @JsonKey(name: 'l', defaultValue: false)
  final bool isLocal;

  PlantVarietyIndexEntry({
    this.id,
    this.displayName,
    this.originName,
    this.isLocal,
  });

  factory PlantVarietyIndexEntry.fromJson(Map<String, dynamic> json) =>
      _$PlantVarietyIndexEntryFromJson(json);

  @override
  List<Object> get props => [id, displayName, originName, isLocal];
}
