part of "widgets.dart";

class SerchBar extends StatelessWidget {
  
@override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return Container();
        }
        else{
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSerchbar(context)
            );
        }
      },
    );
  }
  
  Widget buildSerchbar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,                
        child: GestureDetector(
          onTap: ()async {            

            final proximidad = context.bloc<MiUbicacionBloc>().state.ubicacion;
           final SearchResult resultado = await  showSearch(
             context: context, 
             delegate: SearchDestination(proximidad)
             );
              this.retornoBusqueda(context, resultado);

            },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,  vertical: 13),
            width: double.infinity,          
            child: Text("donde queires ir?", style: TextStyle(color: Colors.black87),),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color:Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5),
                )
              ]

            ),
          ),
        ),
      ),
    );
  }

  Future retornoBusqueda(BuildContext context,SearchResult result)async{
    if(result.cancelo){
      
      return;
    }
    if(result.manual){
      context.bloc<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }
    calculandoAlerta(context);
    //calcular ruta en base al resultado
    final traficService = new TraficService();
    // ignore: close_sinks
    final mapabloc = context.bloc<MapaBloc>();
    final inicio = context.bloc<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;
    final drivingResponse = await traficService.getCoordsInicioYFin(inicio, destino);

    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;    
    final distance = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(
      encodedString: geometry,
      precision: 6
    );
     final List<LatLng> rutaCoordenadas = points.decodedCoords.map(
       (e) => LatLng(e[0],e[1])
       ).toList();
    mapabloc.add(OnCrearRutaIniciodestino(rutaCoordenadas, distance, duration));
    Navigator.of(context).pop();
  }

  
}