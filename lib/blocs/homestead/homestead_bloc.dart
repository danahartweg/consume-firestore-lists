import 'package:bloc/bloc.dart';

/// This is a contrived implementation of this bloc, simply used to set up this example repository.
class HomesteadBloc extends Bloc<dynamic, String> {
  @override
  String get initialState => 'homesteadId';

  @override
  Stream<String> mapEventToState(_) async* {}
}
