import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:maps_app/bloc/mapa/mapa_bloc.dart';
import 'package:maps_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:maps_app/pages/acceso_gps_page.dart';
import 'package:maps_app/pages/loading_page.dart';
import 'package:maps_app/pages/mapa_page.dart';

//
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>MiUbicacionBloc()),
        BlocProvider(create: (context)              => MapaBloc()),
        BlocProvider(create: (_)                    => BusquedaBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps app',
        home: LoadingPage(),      
        routes: {
           "mapa":   (_) => MapaPage(),
           "loading": (_) => LoadingPage(),
           "acceso_gps": (_) => AccesoGpsPage(),           
        }
      ),
    );
  }
}