import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng; 
import 'package:geolocator/geolocator.dart' as Geolocator;

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionstate> {
  MiUbicacionBloc() : super(MiUbicacionstate());

  // ignore: cancel_subscriptions
  StreamSubscription<Geolocator.Position> _positionSubscription;
  
  void iniciarSegimiento(){
    
     this._positionSubscription =  Geolocator.getPositionStream(
      desiredAccuracy:  Geolocator.LocationAccuracy.high,
      distanceFilter: 10
    ).listen((Geolocator.Position position) {
      print(position);
     });
  }

  void cancelarSeguimiento(){
    this._positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionstate> mapEventToState(
    MiUbicacionEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
