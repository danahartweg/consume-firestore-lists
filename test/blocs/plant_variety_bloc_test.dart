import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:consume_firestore_lists/blocs/homestead/bloc.dart';
import 'package:consume_firestore_lists/blocs/plant_variety/bloc.dart';
import 'package:consume_firestore_lists/models/plant_variety_index_entry.dart';
import 'package:consume_firestore_lists/repositories/plant_variety_index_repository_firestore.dart';
import 'package:consume_firestore_lists/repositories/plant_variety_index_repository.dart';

class MockHomesteadBloc extends Mock implements HomesteadBloc {}

class MockPlantVarietyIndexRepositoryFirestore extends Mock
    implements PlantVarietyIndexRepositoryFirestore {}

const _homesteadId = '123';

void main() {
  group('PlantVarietyBloc', () {
    PlantVarietyIndexRepository mockPlantVarietyIndexRepository;
    PlantVarietyBloc plantVarietyBloc;

    setUp(() {
      final HomesteadBloc mockHomesteadBloc = MockHomesteadBloc();
      when(mockHomesteadBloc.state).thenReturn(_homesteadId);

      mockPlantVarietyIndexRepository =
          MockPlantVarietyIndexRepositoryFirestore();
      plantVarietyBloc = PlantVarietyBloc(
        homesteadBloc: mockHomesteadBloc,
        plantVarietyIndexRepository: mockPlantVarietyIndexRepository,
      );
    });

    test('has an appropriate initial state', () {
      expect(plantVarietyBloc.initialState, Loading());
    });

    test('initially requests index entries', () async {
      await expectLater(plantVarietyBloc, emits(Loading()));
      verify(mockPlantVarietyIndexRepository.indexEntries(_homesteadId));
    });

    test('handles an empty index entry list', () {
      final expectedState = [
        Loading(),
        Empty(),
      ];

      when(mockPlantVarietyIndexRepository.indexEntries(any))
          .thenAnswer((_) => Stream.value([]));
      expectLater(plantVarietyBloc, emitsInOrder(expectedState));
    });

    test('handles index entry list with data', () {
      final indexEntries = [
        PlantVarietyIndexEntry(
          id: 'entry1',
          displayName: 'name1',
          originName: 'origin1',
          isLocal: false,
        ),
        PlantVarietyIndexEntry(
          id: 'entry2',
          displayName: 'name2',
          originName: 'origin2',
          isLocal: false,
        ),
      ];

      final expectedState = [
        Loading(),
        Loaded(indexEntries),
      ];

      when(mockPlantVarietyIndexRepository.indexEntries(any))
          .thenAnswer((_) => Stream.value(indexEntries));
      expectLater(plantVarietyBloc, emitsInOrder(expectedState));
    });

    test('closes the index entries subscription', () {
      final stream = Stream.value([]);
      final onDoneCallback = expectAsync0(() {});
      stream.listen((_) {}, onDone: onDoneCallback);

      when(mockPlantVarietyIndexRepository.indexEntries(any))
          .thenAnswer((_) => stream);

      plantVarietyBloc.close();
    });
  });
}
