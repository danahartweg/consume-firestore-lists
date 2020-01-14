import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:consume_firestore_lists/screens/plants/list_plant_varieties.dart';
import 'package:consume_firestore_lists/bloc_delegate.dart';
import 'package:consume_firestore_lists/blocs/homestead/bloc.dart';

import 'services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await locatorSetup();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  // create these blocs ahead of time so they can be kept up-to-date
  final homesteadBloc = HomesteadBloc();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomesteadBloc>.value(value: homesteadBloc),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Consume Firestore Lists'),
          ),
          body: ListPlantVarieties(),
        ),
      ),
    ),
  );
}
