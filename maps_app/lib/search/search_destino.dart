
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/search_response.dart';
import 'package:maps_app/models/search_results.dart';
import 'package:maps_app/services/trafic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult>{

  @override
  final String searchFieldLabel;
  final TraficService _traficService;
  final LatLng proximidad;
  final List<SearchResult> historial;

  SearchDestination(this.proximidad, this.historial):   
  this.searchFieldLabel="Buscar...",
  this._traficService =  new TraficService()   ;

  @override
  List<Widget> buildActions(BuildContext context) {
    
      return [
        IconButton(
         icon: Icon(Icons.clear),
         onPressed: (){
           this.query="";
         },
       ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      
       return  IconButton(
         icon: Icon(Icons.arrow_back_ios),
         onPressed: (){
           this.close(context, SearchResult(cancelo: true));
         },
       );
      
    }
  
    @override
    Widget buildResults(BuildContext context) {      
       
       return _construirResultadosSugerencias();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      if (this.query.length==0){
     return  ListView(
       children: [
         ListTile(
           leading: Icon(Icons.location_on),
           title: Text("Colocar manualmente"),
           onTap: (){
             
             this.close(context, SearchResult(cancelo: false,manual: true));
           },
         ),
         ...this.historial.map(
            (result) => ListTile(
              leading: Icon(Icons.history),
              title: Text(result.nombreDestino),
              subtitle: Text(result.descripcion),
              onTap: (){
                this.close(context, result);
              },
            )            
           ).toList(),
       ],
      );
      }
      return this._construirResultadosSugerencias();

  }


  Widget _construirResultadosSugerencias(){
    if(this.query.length==0){
      return Container();
    }
    this._traficService.getSugerenciasPorQuery(this.query.trim(), this.proximidad);
    return  StreamBuilder(
      stream: this._traficService.sugerenciasStream,      
      builder: (BuildContext context, AsyncSnapshot<SerachResponse> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        final lugares= snapshot.data.features;

        if(lugares.length==0){
          return ListTile(
            title: Text("No hay resultados con $query"),
          );
        }

        return ListView.separated(
          itemCount: lugares.length,
          separatorBuilder: (_, i) =>Divider(),
          itemBuilder: (BuildContext context, int index) {
            final lugar = lugares[index];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs),
              subtitle: Text(lugar.placeNameEs),
              onTap: (){
                this.close(context, SearchResult( 
                  cancelo: false,
                  manual: false,
                  position: LatLng(lugar.center[1],lugar.center[0]),
                  nombreDestino: lugar.textEs,
                  descripcion: lugar.placeNameEs
                ));
              },
            );
         },
        );
      },
    );

  }



}