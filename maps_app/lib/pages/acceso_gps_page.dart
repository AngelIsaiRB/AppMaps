import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesoGpsPage extends StatefulWidget {
  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage> with WidgetsBindingObserver { // estar pendiente de los cambios on resume pause inactive

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); // para observar el estado de la app
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); //observar estado de la app remuse,pause inactive
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    //observar estado de la app remuse,pause inactive
    if (state == AppLifecycleState.resumed){
      if( await Permission.location.isGranted){
        Navigator.pushReplacementNamed(context, "loading");
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Es necesario el GPs para usar esta Aplicacion"),
            MaterialButton(
              child: Text("solicitar acceso",style:TextStyle(color: Colors.white),),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              onPressed: ()async {
                final status = await Permission.location.request(); // permision handler
                this.accesoGPs (status);
              },

            ),
          ],
        ),
      ),
    );
  }

  void accesoGPs(PermissionStatus status){ // permision handler
    switch(status){

      
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, "mapa");
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:        
      case PermissionStatus.restricted:        
      case PermissionStatus.permanentlyDenied:
        openAppSettings(); // permision _handler
        break;
    }
  } 
}