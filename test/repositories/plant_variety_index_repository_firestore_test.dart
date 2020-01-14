import 'package:flutter_test/flutter_test.dart';

import 'package:consume_firestore_lists/models/plant_variety_index_entry.dart';
import 'package:consume_firestore_lists/repositories/plant_variety_index_repository_firestore.dart';

import '../helpers/firestore_mock.dart';

void main() {
  group('PlantVarietyIndexRepositoryFirestore', () {
    setUpAll(() {
      setupMockFirestore();
    });

    tearDownAll(() {
      resetMockFirestore();
    });

    group('flattening index entry response', () {
      test('handles index entries from one document', () {
        setupMockFirestoreQueryResponse([
          {
            'indexName': 'index',
            'isFull': false,
            'parentId': 'root',
            'entry1': {'n': 'name1', 'o': 'origin1', 'l': false},
            'entry2': {'n': 'name2', 'o': 'origin2', 'l': false},
            'entry3': {'n': 'name3', 'o': 'origin3', 'l': false},
          },
        ]);

        final repository = PlantVarietyIndexRepositoryFirestore();
        final indexStream = repository.indexEntries('');

        expectLater(
            indexStream,
            emits([
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
              PlantVarietyIndexEntry(
                id: 'entry3',
                displayName: 'name3',
                originName: 'origin3',
                isLocal: false,
              ),
            ]));
      });

      test('handles index entries with an empty second document', () {
        setupMockFirestoreQueryResponse([
          {
            'indexName': 'index',
            'isFull': false,
            'parentId': 'root',
            'entry1': {'n': 'name1', 'o': 'origin1', 'l': false},
            'entry2': {'n': 'name2', 'o': 'origin2', 'l': false},
            'entry3': {'n': 'name3', 'o': 'origin3', 'l': false},
          },
          {
            'indexName': 'index',
            'isFull': false,
            'parentId': 'homestead1',
          },
        ]);

        final repository = PlantVarietyIndexRepositoryFirestore();
        final indexStream = repository.indexEntries('');

        expectLater(
            indexStream,
            emits([
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
              PlantVarietyIndexEntry(
                id: 'entry3',
                displayName: 'name3',
                originName: 'origin3',
                isLocal: false,
              ),
            ]));
      });
    });

    test('handles index entries from multiple documents', () {
      setupMockFirestoreQueryResponse([
        {
          'indexName': 'index',
          'isFull': false,
          'parentId': 'root',
          'entry1': {'n': 'name1', 'o': 'origin1', 'l': false},
          'entry2': {'n': 'name2', 'o': 'origin2', 'l': false},
          'entry3': {'n': 'name3', 'o': 'origin3', 'l': false},
        },
        {
          'indexName': 'index',
          'isFull': false,
          'parentId': 'homestead1',
          'entry4': {'n': 'name4', 'o': 'origin4', 'l': true},
        },
        {
          'indexName': 'index',
          'isFull': false,
          'parentId': 'homestead1',
          'entry5': {'n': 'name5', 'o': 'origin5', 'l': true},
          'entry6': {'n': 'name6', 'o': 'origin6', 'l': true},
        },
      ]);

      final repository = PlantVarietyIndexRepositoryFirestore();
      final indexStream = repository.indexEntries('');

      expectLater(
          indexStream,
          emits([
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
            PlantVarietyIndexEntry(
              id: 'entry3',
              displayName: 'name3',
              originName: 'origin3',
              isLocal: false,
            ),
            PlantVarietyIndexEntry(
              id: 'entry4',
              displayName: 'name4',
              originName: 'origin4',
              isLocal: true,
            ),
            PlantVarietyIndexEntry(
              id: 'entry5',
              displayName: 'name5',
              originName: 'origin5',
              isLocal: true,
            ),
            PlantVarietyIndexEntry(
              id: 'entry6',
              displayName: 'name6',
              originName: 'origin6',
              isLocal: true,
            ),
          ]));
    });
  });
}
