part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}
class OnMarcarRecorrido extends MapaEvent{}
class OnSeguirUbicacion extends MapaEvent{}

class OnCrearRutaIniciodestino extends MapaEvent{

  final List<LatLng> rutaCoordenadas;
  final double distancia;
  final double duracion;
  final String nombreDestino;

  OnCrearRutaIniciodestino(this.rutaCoordenadas, this.distancia, this.duracion, this.nombreDestino);


}

class OnNuevaUambio extends MapaEvent{
  final LatLng ubicacion;
  OnNuevaUambio(this.ubicacion);
}

class OnMoviomapa extends MapaEvent{
  final LatLng centroMapa;
  OnMoviomapa(this.centroMapa);  
}