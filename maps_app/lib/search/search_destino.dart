
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

  SearchDestination(this.proximidad):   
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
         )
       ],
      );
      }
      return this._construirResultadosSugerencias();

  }


  Widget _construirResultadosSugerencias(){
    if(this.query.length==0){
      return Container();
    }
    return  FutureBuilder(
      future: this._traficService.getResultadosPorQuery(this.query.trim(),this.proximidad),      
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
                print (lugar);
              },
            );
         },
        );
      },
    );

  }



}