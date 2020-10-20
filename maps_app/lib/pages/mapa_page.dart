import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/bloc/mapa/mapa_bloc.dart';
import 'package:maps_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:maps_app/widgets/widgets.dart';

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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta()
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionstate state){    
    if(state.existeUbicacion){        
        // ignore: close_sinks
        final mapaBloc = BlocProvider.of<MapaBloc>(context);
        mapaBloc.add(OnNuevaUambio(state.ubicacion));
        final camaraPosition = new CameraPosition(
        target: state.ubicacion,
        zoom: 16
        );
            return GoogleMap(
              initialCameraPosition: camaraPosition,              
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: mapaBloc.initMapa,
              /* la llamada de arriba es resumida de 
              onMapCreated: (GoogleMapController controller){
                mapaBloc.initMapa(controller);
              },
               */
              polylines: mapaBloc.state.polylines.values.toSet(),
            );
          } 
          else{
            return Center(
            child: CircularProgressIndicator(),
          );
          }
  }
}
