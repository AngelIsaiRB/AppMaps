import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    context.bloc<MiUbicacionBloc>().iniciarSegimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.bloc<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionstate>(
        builder: (context, state) {
          return crearMapa(state);
        },
      ),
    );
  }

  Widget crearMapa(MiUbicacionstate state){
    if(state.existeUbicacion){
            return Center(
              child: Text("${state.ubicacion.latitude},${state.ubicacion.longitude}"),
            );
          } 
          else{
            return Center(
            child: CircularProgressIndicator(),
          );
          }
  }
}
