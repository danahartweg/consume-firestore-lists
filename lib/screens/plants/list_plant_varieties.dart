import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:consume_firestore_lists/blocs/homestead/bloc.dart';
import 'package:consume_firestore_lists/blocs/plant_variety/bloc.dart';
import 'package:consume_firestore_lists/repositories/plant_variety_index_repository_firestore.dart';

class ListPlantVarieties extends StatelessWidget {
  @override
  build(context) {
    final homesteadBloc = BlocProvider.of<HomesteadBloc>(context);

    return Scaffold(
      body: BlocBuilder<PlantVarietyBloc, PlantVarietyState>(
        bloc: PlantVarietyBloc(
          homesteadBloc: homesteadBloc,
          plantVarietyIndexRepository: PlantVarietyIndexRepositoryFirestore(),
        ),
        builder: (_, state) {
          if (state is Error) {
            return Text(state.error);
          }

          if (state is Empty) {
            return const Text('No plant varieties here.');
          }

          if (state is Loaded) {
            return ListView(
              children: state.indexEntries
                  .map(
                    (indexEntry) => ListTile(
                      key: ValueKey(indexEntry.id),
                      title: Text(indexEntry.displayName),
                    ),
                  )
                  .toList(),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
