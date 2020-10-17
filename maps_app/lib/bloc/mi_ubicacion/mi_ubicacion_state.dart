part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionstate{

    final bool siguiendo;
    final bool existeUbicacion;
    final LatLng ubicacion;

  MiUbicacionstate({
    this.siguiendo=true,
    this.existeUbicacion=false,
    this.ubicacion
    });

  MiUbicacionstate copyWith({
    bool siguiendo,
    bool existeUbicacion,
    LatLng ubicacion,
  })=>new MiUbicacionstate(
    siguiendo: siguiendo ?? this.siguiendo,
    existeUbicacion: existeUbicacion ?? this.existeUbicacion,
    ubicacion: ubicacion ?? this.ubicacion 
  );

}