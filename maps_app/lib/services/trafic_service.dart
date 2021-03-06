
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/helpers/debouncer.dart';
import 'package:maps_app/models/reverse_query_response.dart';
import 'package:maps_app/models/search_response.dart';
import 'package:maps_app/models/trafic_response.dart';

class TraficService{

  // singleton
  TraficService._privateContructor();

  static final TraficService _instance = TraficService._privateContructor();
  factory TraficService(){
    return _instance;
  }

  final _dio= new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500 ));
  // ignore: close_sinks
  final StreamController<SerachResponse> _sugerencriasStreamController =  new StreamController<SerachResponse>.broadcast();
  Stream<SerachResponse> get sugerenciasStream => this._sugerencriasStreamController.stream;


  final String baseUrlDir = "https://api.mapbox.com/directions/v5";
  final String baseUrlGeo = "https://api.mapbox.com/geocoding/v5";
  final String _apiKey = "pk.eyJ1IjoiYW5nZWxpc2FpIiwiYSI6ImNrZ2luaTFiZDA1NmIydnFvODg3OGV6ZzIifQ.rlbIF_aWQLlSF0DMn88D6A";


  Future<DrivingResponse> getCoordsInicioYFin(LatLng inicio, LatLng destino)async {
    final coordString= "${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}";
    final url="${this.baseUrlDir}/mapbox/driving/$coordString";
    final respuesta = await this._dio.get(url,queryParameters:{
      "alternatives":"true",
      "geometries":"polyline6",
      "steps":"false",
      "access_token":"${this._apiKey}",
      "language":"es"
    } );

    final data = DrivingResponse.fromJson(respuesta.data);
    return data;

  }

  Future<SerachResponse> getResultadosPorQuery (String busqueda, LatLng proximidad)async {

    final url= "${this.baseUrlGeo}/mapbox.places/$busqueda.json";
    try {
      final resp = await this._dio.get(url,
    queryParameters: {
      "access_token":this._apiKey,      
      "autocomplete":"true",
      "proximity"   :"${proximidad.longitude},${proximidad.latitude}",
      "language"    :"es",
      });
    final searchResponse =serachResponseFromJson(resp.data);
    return searchResponse;
    } catch (e) {
      return SerachResponse(features: []);
    }
  }
  

void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

  debouncer.value = '';
  debouncer.onValue = ( value ) async {
    final resultados = await this.getResultadosPorQuery(value, proximidad);
    this._sugerencriasStreamController.add(resultados);
  };

  final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
    debouncer.value = busqueda;
  });

  Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 

}

Future<ReverseQueryResponse> getCoordenadasInfo(LatLng destinoCoords)async{

  final url = "${this.baseUrlGeo}/mapbox.places/${destinoCoords.longitude},${destinoCoords.latitude}.json";

  final resp = await this._dio.get(url,queryParameters:{
    "access_token":this._apiKey,              
    "language"    :"es",
  });
   final data = reverseQueryResponseFromJson(resp.data);
  return data;

}

}