
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TraficService{

  // singleton
  TraficService._privateContructor();

  static final TraficService _instance = TraficService._privateContructor();
  factory TraficService(){
    return _instance;
  }

  final _dio= new Dio();

  Future getCoordsInicioYFin(LatLng inicio, LatLng destino)async {

    print(inicio);
    print(destino);

  }


}