import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:maps_app/themes/uber_map_them.dart';
part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super( new MapaState());

  //controlador del mapa
  GoogleMapController _mapcontroller;

  //polylines
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId("mi_ruta"),
    width: 4,
    color: Colors.black87

    );

  void initMapa(GoogleMapController controller){
    if(!state.mapaListo){
      this._mapcontroller=controller;
      this._mapcontroller.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
  }
  void moverCamara(LatLng destino){

    final camaraUpdate = CameraUpdate.newLatLng(destino);
    this._mapcontroller?.animateCamera(camaraUpdate);

  }

  @override
  Stream<MapaState> mapEventToState( MapaEvent event,) async* {
   
    if(event is OnMapaListo){
      yield state.copyWith(mapaListo: true);
    }
    else if(event is OnNuevaUambio){
      List<LatLng> points= [...this._miRuta.points, event.ubicacion];
      this._miRuta= this._miRuta.copyWith(pointsParam:points );
      final currentPolylines = state.polylines;
      currentPolylines["mi_ruta"]= this._miRuta;
      yield state.copyWith(polylines: currentPolylines);
    }
    else if(event is OnMarcarRecorrido){
      if(!state.dibujarRecorrido){
        this._miRuta=this._miRuta.copyWith(colorParam: Colors.black87);
      }
      else{
        this._miRuta=this._miRuta.copyWith(colorParam: Colors.transparent);
      }
      final currentPolylines = state.polylines;
      currentPolylines["mi_ruta"]= this._miRuta;
      yield state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido,
        polylines: currentPolylines);
    }

  }
}
