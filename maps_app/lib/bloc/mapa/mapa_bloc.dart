import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:maps_app/helpers/helpers.dart';
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

    Polyline _miRutaDestino = new Polyline(
    polylineId: PolylineId("mi_ruta_destino"),
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
     yield* this._onNuevaUbicacion(event);
    }
    else if(event is OnMarcarRecorrido){
      yield* this._onMarcarRecorrido(event);
    }
    else if(event is OnSeguirUbicacion){
     yield* this._onSeguirUbicacion(event);
    }
    else if(event is OnMoviomapa){
      
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    }
    else if(event is OnCrearRutaIniciodestino){     
      yield* this._onCrearRutaInicioDestino(event); 
    }

  }


  Stream<MapaState> _onNuevaUbicacion(OnNuevaUambio event )async*{

      if(state.seguirUbicacion){
        this.moverCamara(event.ubicacion);
      }
      final  List<LatLng> points= [...this._miRuta.points, event.ubicacion];
      this._miRuta= this._miRuta.copyWith(pointsParam:points );
      final currentPolylines = state.polylines;
      currentPolylines["mi_ruta"]= this._miRuta;
      yield state.copyWith(polylines: currentPolylines);
  }

Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event)async*{
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

Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event)async*{
 if(!state.seguirUbicacion){
        this.moverCamara(this._miRuta.points[this._miRuta.points.length-1]);
      }
      yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);
}

Stream<MapaState> _onCrearRutaInicioDestino(OnCrearRutaIniciodestino event )async*{
  
  this._miRutaDestino = this._miRutaDestino.copyWith(
    pointsParam: event.rutaCoordenadas
  );

  final currentPolylines = state.polylines;
  currentPolylines["mi_ruta_destino"]=this._miRutaDestino;

  //icono inicio 

  /*obtener imagen desde asset*/ 
  // final icon =await  getAssetImageMarker();

  // desde widget a imagen 
  final icon =await  getMarkerInicioIcon(event.duracion.toInt());
  final iconDestino = await getMarkerDestinoIcon(event.distancia, event.nombreDestino);

  /* obtener imagen desde internet network */
  // final iconDestino =await  getNetworkInmageMarker();

  // marcadores
  
  final markerinicio = new Marker(
    anchor: Offset(0.0, 1.0),
    markerId: MarkerId("inicio"),
    icon: icon,
    position: event.rutaCoordenadas[0],
    infoWindow: InfoWindow(
      title: "Mi ubicacion",
      snippet: "Duracion de recorrido ${(event.duracion/60).floor()} minutos",
      
    )

  );
  final markerFin= new Marker(
    anchor: Offset(0.0, 1.0),
    markerId: MarkerId("fin"),
    position: event.rutaCoordenadas[event.rutaCoordenadas.length-1],
    icon: iconDestino,
    infoWindow: InfoWindow(
      title: "${event.nombreDestino}",
      snippet: "Destino a ${(event.distancia/1000).floor()} Km",
    )  
  );
  
  final newMarkees = {...state.markers};
  newMarkees["inicio"]= markerinicio;
  newMarkees["fin"] = markerFin;

  Future.delayed(Duration(milliseconds: 200)).then(
    (value){      
    //  _mapcontroller.showMarkerInfoWindow(MarkerId("fin")); 
    });

  yield state.copyWith(
    polylines: currentPolylines, 
    markers: newMarkees,
  );

}

}
