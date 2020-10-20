part of "widgets.dart";


class BtnSeguirUbicacion extends StatelessWidget {
  const BtnSeguirUbicacion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    final mapaBloc        = context.bloc<MapaBloc>();
    // ignore: close_sinks
   


    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) =>this.crearBoton(mapaBloc)
    );
  }

  Widget crearBoton(MapaBloc mapaBloc){
    return Container(
      margin: EdgeInsets.only(bottom:10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            mapaBloc.state.seguirUbicacion
            ? Icons.accessibility_new
            : Icons.directions_run,
            color: Colors.black87,),
          onPressed: (){
            mapaBloc.add(OnSeguirUbicacion());
          },
        ),
      ),
    );
  }
}