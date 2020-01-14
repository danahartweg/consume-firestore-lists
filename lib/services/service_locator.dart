import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

export 'package:cloud_firestore/cloud_firestore.dart' show Firestore;

GetIt locator = GetIt();

Future<void> locatorSetup() async {
  locator.registerLazySingleton<Firestore>(() => Firestore.instance);
}
