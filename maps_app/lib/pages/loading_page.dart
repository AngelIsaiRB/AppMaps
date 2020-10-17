import 'package:flutter/material.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/acceso_gps_page.dart';
import 'package:maps_app/pages/mapa_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGPSLoaction(context),        
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        );
        },
      ),
      
    );
  }

  Future checkGPSLoaction(BuildContext context)async {
    //TODO: permiso gps 
    //TODO: gps activo 
    Future.delayed(Duration(milliseconds: 100)/*,()=>
    Navigator.pushReplacement(context,navegarMapaFadeIn(context, AccesoGpsPage()) )*/);
    print ("holamundo");
    
    //Navigator.pushReplacement(context,navegarMapaFadeIn(context, MapaPage()) );
  
  }
}