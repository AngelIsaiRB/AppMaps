import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionstate> {
  MiUbicacionBloc() : super(MiUbicacionstate());

  @override
  Stream<MiUbicacionstate> mapEventToState(
    MiUbicacionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
