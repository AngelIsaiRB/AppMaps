part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}
class OnMarcarRecorrido extends MapaEvent{}

class OnNuevaUambio extends MapaEvent{
  final LatLng ubicacion;
  OnNuevaUambio(this.ubicacion);
}
