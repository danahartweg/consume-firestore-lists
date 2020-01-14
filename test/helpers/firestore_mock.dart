import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'package:consume_firestore_lists/services/service_locator.dart';

class MockFirestore extends Mock implements Firestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuery extends Mock implements Query {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {
  MockDocumentSnapshot([this.data]);

  @override
  final Map<String, dynamic> data;
}

class MockQuerySnapshot extends Mock implements QuerySnapshot {
  MockQuerySnapshot([this.documents]);

  @override
  final List<DocumentSnapshot> documents;
}

final Firestore mockFirestore = MockFirestore();
final CollectionReference mockCollection = MockCollectionReference();
final Query mockQuery = MockQuery();
final DocumentReference mockDocument = MockDocumentReference();

void resetMockFirestore() {
  reset(mockFirestore);
  reset(mockCollection);
  reset(mockQuery);
  reset(mockDocument);
}

void setupMockFirestore() {
  when(mockFirestore.collection(any)).thenReturn(mockCollection);
  when(mockCollection.where(
    any,
    isEqualTo: anyNamed('isEqualTo'),
    whereIn: anyNamed('whereIn'),
  )).thenReturn(mockQuery);
  when(mockQuery.where(
    any,
    isEqualTo: anyNamed('isEqualTo'),
    whereIn: anyNamed('whereIn'),
  )).thenReturn(mockQuery);
  when(mockCollection.document(any)).thenReturn(mockDocument);
  when(mockDocument.collection(any)).thenReturn(mockCollection);

  locator.allowReassignment = true;
  locator.registerSingleton<Firestore>(mockFirestore);
}

void setupMockFirestoreDocumentSnapshotResponse(
    String documentId, Map<String, dynamic> data) {
  final document = MockDocumentSnapshot(data);

  when(mockDocument.snapshots())
      .thenAnswer((_) => Stream.fromIterable([document]));
  when(document.documentID).thenReturn(documentId);
}

void setupMockFirestoreDocumentGetResponse(
    String documentId, Map<String, dynamic> data) {
  final document = MockDocumentSnapshot(data);

  when(mockDocument.get()).thenAnswer((_) => Future.value(document));
  when(document.documentID).thenReturn(documentId);
}

void setupMockFirestoreQueryResponse(List<Map<String, dynamic>> documents) {
  final documentSnapshots =
      documents.map((document) => MockDocumentSnapshot(document)).toList();
  final query = MockQuerySnapshot(documentSnapshots);

  when(mockQuery.snapshots()).thenAnswer((_) => Stream.fromIterable([query]));
}

void setupMockFirestoreDocumentAddResponse(String documentId) {
  when(mockCollection.add(any)).thenAnswer((_) => Future.value(mockDocument));
  when(mockDocument.documentID).thenReturn(documentId);
}
