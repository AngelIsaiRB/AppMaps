import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;

import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/acceso_gps_page.dart';
import 'package:maps_app/pages/mapa_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>  with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    print(state);
    if (state == AppLifecycleState.resumed){
      if( await Geolocator.isLocationServiceEnabled()){
        Navigator.pushReplacementNamed(context, "mapa");
      }
    }
    
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGPSLoaction(context),        
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return Center(
              child: Text(snapshot.data),
            );            
          }
          else{
              return CircularProgressIndicator();
            }
        },
      ),
      
    );
  }

  Future checkGPSLoaction(BuildContext context)async {
    // permiso gps 
    final permisoGps = await Permission.location.isGranted;
    // gps activo 
    final gpsActive = await Geolocator.isLocationServiceEnabled();
    
    if(permisoGps && gpsActive){
      Navigator.pushReplacement(context,navegarMapaFadeIn(context, MapaPage()) );
      return "";
    }
    else if(!permisoGps){
      Navigator.pushReplacement(context,navegarMapaFadeIn(context, AccesoGpsPage()) );
      return "active el permiso de localizacion";
    }
    else if(!gpsActive){
      
      return "active el Gps";
    }

    


    //Navigator.pushReplacement(context,navegarMapaFadeIn(context, MapaPage()) );
  
  }
}