import 'package:equatable/equatable.dart';

import 'package:consume_firestore_lists/models/plant_variety_index_entry.dart';

abstract class PlantVarietyState extends Equatable {
  const PlantVarietyState();

  @override
  List<Object> get props => [];
}

class Loading extends PlantVarietyState {}

class Empty extends PlantVarietyState {}

class Loaded extends PlantVarietyState {
  final List<PlantVarietyIndexEntry> indexEntries;

  Loaded(this.indexEntries);

  @override
  List<Object> get props => [indexEntries];
}

class Error extends PlantVarietyState {
  final String error;

  Error(this.error);

  @override
  List<Object> get props => [error];
}
