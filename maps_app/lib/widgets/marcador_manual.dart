part of "widgets.dart";


class MarcadorManual  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {        
        if(state.seleccionManual){
         
          return _BuildMarcadorManual();
        }
        return Container();
      },
    );


  }
}


class _BuildMarcadorManual extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        //Boton regresar
        Positioned(
          top: 70,
          left: 20,
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black87,),
              onPressed: (){
                context.bloc<BusquedaBloc>().add(OnDescativarMarcadorManual());
              },
            ),
          ),
        ),
        // pin del marcador
        Center(
          child: Transform.translate(
            offset: Offset(0,-15),
            child: Icon(Icons.location_on,size: 50,color: Colors.red)
            ),
        ),
        //boton de confirmar 
        Positioned(
          bottom: 70,
          left: 40,
          child: MaterialButton(
            child: Text("Confirmar destino",style: TextStyle(color: Colors.white),),
            color: Colors.black,
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            minWidth: width-120,
            onPressed: (){
              
            },
          ),
        )
      ],
    );    
  }
}