import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/GUI/map.dart';
import 'package:map_app/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';



void main() async {
  // GoogleMap.init('AIzaSyB_0G3E7An9i_2y5B14He3dOIfXb_AapcQ');
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setEnabledSystemUIOverlays(
    SystemUiOverlay.values,

  );

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color.fromARGB(250, 25, 112, 147),
        //     systemNavigationBarColor:Colors.transparent,
      ));

  runApp(
    ChangeNotifierProvider<DataProvider>(
      create: (_) => DataProvider(),
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SpringyUniverse',
          theme: ThemeData(
            fontFamily: 'Ubuntu',
            textTheme: TextTheme(
              body2: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              body1: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(250, 25, 112, 147),
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
          home: Container(
              alignment: Alignment.center,
              child: Container(
                child: SplashScreen(
                    seconds: 2,
                    backgroundColor: Colors.white,
                    loaderColor: Color.fromARGB(250, 25, 112, 147),
                    image: Image.asset(
                      'img/GoogleMaps.png',
                      fit: BoxFit.fill,
                    ),
                    photoSize: 100,
                    loadingText: Text(
                      'Loading...',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Color.fromARGB(250, 25, 112, 147),
                      ),
                    ),
                    navigateAfterSeconds: MapProvider()
                ),
              ))),
    ),
  );
}
