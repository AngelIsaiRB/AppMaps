part of "widgets.dart";


class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    final mapaBloc        = context.bloc<MapaBloc>();
    // ignore: close_sinks
    final miUbicacionBloc = context.bloc<MiUbicacionBloc>();


    return Container(
      margin: EdgeInsets.only(bottom:10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87,),
          onPressed: (){
            final destno = miUbicacionBloc.state.ubicacion;
            mapaBloc.moverCamara(destno);
          },
        ),
      ),
    );
  }
}