
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/trafic_response.dart';

class TraficService{

  // singleton
  TraficService._privateContructor();

  static final TraficService _instance = TraficService._privateContructor();
  factory TraficService(){
    return _instance;
  }

  final _dio= new Dio();
  final String baseUrl = "https://api.mapbox.com/directions/v5";
  final String _apiKey = "pk.eyJ1IjoiYW5nZWxpc2FpIiwiYSI6ImNrZ2luaTFiZDA1NmIydnFvODg3OGV6ZzIifQ.rlbIF_aWQLlSF0DMn88D6A";


  Future<DrivingResponse> getCoordsInicioYFin(LatLng inicio, LatLng destino)async {
    final coordString= "${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}";
    final url="${this.baseUrl}/mapbox/driving/$coordString";
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


}