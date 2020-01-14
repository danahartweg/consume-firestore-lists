import 'package:equatable/equatable.dart';

import 'package:consume_firestore_lists/models/plant_variety_index_entry.dart';

abstract class PlantVarietyEvent extends Equatable {
  const PlantVarietyEvent();

  @override
  List<Object> get props => [];
}

class LoadIndexEntries extends PlantVarietyEvent {}

class IndexEntriesReceived extends PlantVarietyEvent {
  final List<PlantVarietyIndexEntry> indexEntries;

  const IndexEntriesReceived(this.indexEntries);

  @override
  List<Object> get props => [indexEntries];
}
