import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:consume_firestore_lists/blocs/homestead/homestead_bloc.dart';
import 'package:consume_firestore_lists/repositories/plant_variety_index_repository.dart';

import './bloc.dart';

class PlantVarietyBloc extends Bloc<PlantVarietyEvent, PlantVarietyState> {
  final HomesteadBloc _homesteadBloc;
  final PlantVarietyIndexRepository _plantVarietyIndexRepository;

  StreamSubscription _indexEntriesSubscription;

  PlantVarietyBloc({
    @required HomesteadBloc homesteadBloc,
    @required PlantVarietyIndexRepository plantVarietyIndexRepository,
  })  : assert(homesteadBloc != null),
        assert(plantVarietyIndexRepository != null),
        _homesteadBloc = homesteadBloc,
        _plantVarietyIndexRepository = plantVarietyIndexRepository {
    add(LoadIndexEntries());
  }

  @override
  PlantVarietyState get initialState => Loading();

  @override
  Stream<PlantVarietyState> mapEventToState(
    PlantVarietyEvent event,
  ) async* {
    if (event is LoadIndexEntries) {
      yield* _mapLoadIndexEntriesToState();
    } else if (event is IndexEntriesReceived) {
      yield* _mapIndexEntriesUpdatesToState(event);
    }
  }

  Stream<PlantVarietyState> _mapLoadIndexEntriesToState() async* {
    await _indexEntriesSubscription?.cancel();
    _indexEntriesSubscription =
        _plantVarietyIndexRepository.indexEntries(_homesteadBloc.state).listen(
              (indexEntries) => add(IndexEntriesReceived(indexEntries)),
            );
  }

  Stream<PlantVarietyState> _mapIndexEntriesUpdatesToState(
    IndexEntriesReceived event,
  ) async* {
    if (event.indexEntries.isEmpty) {
      yield Empty();
    } else {
      yield Loaded(event.indexEntries);
    }
  }

  @override
  Future<void> close() async {
    await _indexEntriesSubscription?.cancel();
    return super.close();
  }
}
