import 'dart:ui';
import 'package:google_maps_webservice/places.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

void main() => runApp(MyApp());
const kGoogleApiKey = "AIzaSyAqKjL3o1J_Hn45ieKwEo9g8XLmj9CqhSc";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home() ,
    );
  }
}

class Home extends StatefulWidget {

  
  @override
  _HomeState createState() => _HomeState();
}

//google maps stuffs
  GoogleMapController mapController;
  String searchAddr;
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
          LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }

//fin google maps stuffs
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void _openDrawer(BuildContext context) {
  _scaffoldKey.currentState.openDrawer();
}

void _closeDrawer(BuildContext context) {
  Navigator.of(context).pop();
}


class _HomeState extends State<Home> {
//variables
bool _visible=true;
bool _invisible=false;
Color c1 = const Color.fromRGBO(0, 0, 60, 0.8);
Color c2 = const Color(0xFF3B466B);
Color myWhite = const Color(0xFFFFFFFF);
//fin variables
  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }
 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
 
    return SafeArea(
      child:Scaffold(
        extendBody: true,
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
     
      key: _scaffoldKey,
      
      drawer: /*BackdropFilter(
        filter: ImageFiltered(
          imageFilter:ImageFilter. ,
        child:*/
              Opacity(
          opacity: 0.5,
        
        child:
       SizedBox(
        width: size.width,
        child: 

        Drawer( 
         child:
            Container(
               //color: c2,
               //color:Color.fromRGBO(188,180, 200, 0),
               child:Stack(
                 //mainAxisAlignment: MainAxisAlignment.center,
               
                 children: <Widget>[
                Positioned(
                left: MediaQuery.of(context).size.width*0.02,
                top: MediaQuery.of(context).size.height*0.03,
                 child:  MaterialButton(
                          onPressed:() {_closeDrawer(context);
                                  setState(() {
                            _visible = true;
                              });
                          },

                          child:Icon(Icons.arrow_back_ios,color: Color(0xFF5B5050),),
                ),
                ),
                Center(
               child:   Container(
                  height: size.height*0.6,
                  width: size.width*0.65,    
                   margin: EdgeInsets.symmetric(vertical:5)   ,
                 decoration: BoxDecoration(
                 borderRadius:BorderRadius.circular(20), 
                 color:Color.fromRGBO(59, 70, 150, 1),
                 ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Container(
                         height: size.width*0.25,
                         width: size.width*0.4,
                         child:
                     Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                         height: size.width*0.15,
                         width:size.width*0.15, 
                        
                          child:

                        CircleAvatar(backgroundColor: myWhite,
                        
                        child:

                       Icon(Icons.person_outline,size:40,color: Color(0xFF707070),),
                        ),
                     ),
                      
                      Expanded(child:
                           Text('Utilisateur1',
                           textDirection: TextDirection.rtl ,
                           textAlign: TextAlign.center,strutStyle: StrutStyle(),
                         style: TextStyle(fontFamily:'Montserrat',fontSize: 18,
                         
                         color: myWhite),
                      
                        ),
                   
                      ),
                       
                        ],
                  ),
                       ),
                       Center(
                         child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                         // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:<Widget>[
                
                       ListTile(
                         contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         onTap: null,
                         leading: Icon(
                         Icons.playlist_add_check,
                         color: myWhite,
                        ),
                         title: Text("Compte",
                         //strutStyle: ,
                         style: TextStyle(fontFamily:'Montserrat',
                         color: myWhite,fontSize: 15),
                         ),
                       ),
              
                       ListTile(
                         
                         contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         leading: Icon(
                           Icons.star,
                         color: myWhite
                        ),
                         title: Text("Favoris",
                         style: TextStyle(fontFamily:'Montserrat',color: myWhite,fontSize: 15

                         ),
                       ),
                       ),
                       
                
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         leading: Icon(
                           Icons.group,
                        color: myWhite,
                        ),
                         title:Text("Liste d'amis",textAlign: TextAlign.left,overflow: TextOverflow.visible,
                         style: TextStyle(fontFamily:'Montserrat',color: myWhite,fontSize: 15),
                         //strutStyle: ,
                         
                         ),
                         
                         
                                                ),
                  
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         leading: Icon(
                           Icons.build,
                        color: myWhite,
                        ),
                         title: Text("Aide",
                         style: TextStyle(fontFamily:'Montserrat',color: myWhite,fontSize: 15,

                         ),
                         
                       ),
                          ),
                       
                     ],
                        ),
                       ),
                     ],
                       
                  ),
                  
                  
             ),
            
             ),
             Positioned(
               left: MediaQuery.of(context).size.width*0.45,
               
               bottom: MediaQuery.of(context).size.height*0.1,
               child:
                  Container
                  (
                   height: 40,
                   width: 40,
                   child:
                   FloatingActionButton
                   (
                      onPressed: () {},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Color(0xFFFFFFFF),
                      child:Transform(transform: Matrix4.rotationX(170),
                         child: Icon(    Icons.directions_run,color: c2, size:32.0),
       
                        ),
                    ),
                  ),
             ),
                 ],
               ),
            ),
        ),
        ),
        ),
      //),
 

      //Drawerr(),
        bottomNavigationBar:  bottomNavBar,
         
      floatingActionButton:  flaotButton ,
      //bottomNavigationBar:
       
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
       body:Container(
         child:

      Stack(
        children:<Widget>[
 
          GoogleMap(
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            mapToolbarEnabled: true,
            
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(36.7525000, 3.0419700),
                zoom: 11.0,
              ),
            ),
          
      
           
                  
  /*  SearchMapPlaceWidget(
    apiKey: "AIzaSyAiQH89tYyL7OIeip-9GoymqBNqWy-DJW8",
    // The language of the autocompletion
    language: 'fr',
    // The position used to give better recomendations. In this case we are using the user position
    location: LatLng(36.7525000, 3.0419700),
    radius: 30000000,
    onSelected: (Place place) async {
        final geolocation = await place.geolocation;

        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
       // final GoogleMapController controller = await mapController.animateCamera(cameraUpdate);
        mapController.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
        mapController.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
    },
),*/
          /* Positioned(
              left:size.width*0.05,
              top:size.height*0.04,
              child:
           AnimatedOpacity(
             
          opacity: _visible ? 1.0 : 0.0 ,
          duration: Duration(milliseconds: 500),
             child:
          
              
              Container(
                height: 50.0,
                width: size.width*0.9,
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0), color: Colors.white),
               
                  child:TextField(
                onChanged:(val) async {
            // show input autocomplete with selected mode
            // then get the Prediction selected
            Prediction p = await PlacesAutocomplete.show(
                context: context, apiKey: kGoogleApiKey);
            displayPrediction(p);
          }, 
                 decoration: InputDecoration(
                     
                      hintText: 'Recherche',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left:15.0, top: 15.0),
                      //prefixIcon: IconButton(icon:Icon(Icons.menu), onPressed: null),
                      prefixIcon: Container(child:
                      MaterialButton(
                    minWidth: 40,
                    onPressed: () {_openDrawer(context);

                                        setState(() {
                            _visible = !_visible;
          });
                    },
                    child: Icon(Icons.menu,color: Color(0xFF3B466B),),),
                      ),
                      suffixIcon: 
                      IconButton(
                          icon: Icon(Icons.search,color: Color(0xFF3B466B),),
                          onPressed: searchandNavigate,
                          iconSize: 30.0)),
                  

                      
                 /* onChanged: (val) {
                    setState(() {
                      searchAddr = val;
                    });
                  },*/
                ),
                
              ),
            
           ),
            ),*/


          Positioned(
              left:size.width*0.075,
              top:size.height*0.04,
              child:
           AnimatedOpacity(
             
          opacity: _visible ? 1.0 : 0.0 ,
          duration: Duration(milliseconds: 500),
             child:
          
              
              Container(
                height: size.height*0.07,
                width: size.width*0.85,
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0), color: Colors.white),
                    child:
                  Stack(
                  //alignment: Alignment.center,
                   children: <Widget>[
                     Positioned(
                       left:0,
                      // top:size.height*0.07*0.5,
                       child:
                      IconButton(
                      icon:Icon(Icons.menu,color: Color(0xFF3B466B),),
                    onPressed: () {_openDrawer(context);

                                        setState(() {
                            _visible = !_visible;
                      });
                    },
                          iconSize: 30.0),
                     ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:size.width*0.3,vertical:0.001),
                       //left:40,
                       //top:size.height*0.07*0.5,
                       child:
                   TextField(            
                     style: TextStyle(fontFamily:'Montserrat',
                         color: myWhite,fontSize: 18),
                   decoration: InputDecoration(
                     
                      hintText: 'Recherche',
                      border: InputBorder.none,
                      
                      contentPadding: EdgeInsets.only(left:15.0),
                 ),
                   ),
                      ),
                      Positioned(
                       right:0,
                      // top:size.height*0.5,
                       child:
                      IconButton(
                          icon: Icon(Icons.search,color: Color(0xFF3B466B),),
                          onPressed:searchandNavigate,
                          iconSize: 30.0),
                      ),
              
      
    
  ],
),
              ),
           ),
          ),
      
            

    ],

    ),
       ),
    ),
    
    );
  }




 

  Widget get flaotButton{

  return 
    AnimatedOpacity(
             
          opacity: _visible ? 1.0 : 0.0 ,
          duration: Duration(milliseconds: 500),
          child:
  FloatingActionButton(
    
        backgroundColor: Color(0xFF389490),
        child: Icon(
          Icons.group_add,
          size:32.0),
        onPressed: () {},
       ),
      );
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked;
  }
 Widget get bottomNavBar{
   return 

           AnimatedOpacity(
             
          opacity: _visible ? 1.0 : 0.0 ,
          duration: Duration(milliseconds: 500),
          child:
   ClipRRect(
    
     borderRadius: BorderRadius.only(
         topRight : Radius.circular(40),
         topLeft: Radius.circular(40),),
         
      child:
       BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xFF3B466B),
        notchMargin: 10,
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
         
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.group,
                          size: 32.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
            
          
              // Right Tab bar icons

            
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size:32.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),

            
            ],
          ),
        ),
      ),
   ),
           
       );

          
 }  
}

/*class Drawerr extends StatelessWidget {
  Color c1 = const Color.fromRGBO(0, 0, 60, 0.8);
Color c2 = const Color(0xFF3B466B);
Color myWhite = const Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
       Size size = MediaQuery.of(context).size;
    double containerWidth=size.width*0.65;
    return     
   
            SizedBox(
        width: size.width,
        child: 
        Opacity(opacity: 0.63,
        
        child:
        Drawer( 
         child:
            Container(
               //color: c2,
               color:Color.fromRGBO(180,188, 200, 0.63),
               child:Stack(
                 //mainAxisAlignment: MainAxisAlignment.center,
               
                 children: <Widget>[
                Positioned(
                left: MediaQuery.of(context).size.width*0.04,
                top: MediaQuery.of(context).size.height*0.06,
                 child:  MaterialButton(
                          onPressed:() {_closeDrawer(context);
                            
                          },

                          child:Icon(Icons.arrow_back_ios,color: Color(0xFF5B5050),),
                ),
                ),
                Center(
               child:   Container(
                  height: size.height*0.6,
                  width: size.width*0.65,    
                   margin: EdgeInsets.symmetric(vertical:5)   ,
                 decoration: BoxDecoration(
                 borderRadius:BorderRadius.circular(20), 
                 color:Color.fromRGBO(59, 70, 107, 1),
                 ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Container(
                         height: 120,
                         width: 70,
                         child:
                     Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        
                      Container(
                        height: 70,
                        width: 70,
                        child:CircleAvatar(backgroundColor: myWhite,
                        
                        child:

                       Icon(Icons.person_outline,size:40,color: Color(0xFF707070),),
                        ),
                        
                      ),
                      Expanded(child:
                        //Container(
                         // child:
                           Text('Utilisateur1',
                           textDirection: TextDirection.rtl ,
                           textScaleFactor: 1.2,textAlign: TextAlign.center,strutStyle: StrutStyle(),
                         style: TextStyle(fontFamily:'Montserrat',
                         color: myWhite),
                      
                        ),
                   //  ),
                      ),
                    
                        ],
                     ),
                 // ),
                       ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                         // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:<Widget>[
                
                       ListTile(
                         contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         onTap: null,
                         leading: Icon(
                         Icons.playlist_add_check,
                         color: myWhite,
                        ),
                         title: Text("Compte",textScaleFactor: 1.10,
                         //strutStyle: ,
                         style: TextStyle(fontFamily:'Montserrat',
                         color: myWhite),
                         ),
                       ),
              
                       ListTile(
                         
                         contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         leading: Icon(
                           Icons.star,
                         color: myWhite
                        ),
                         title: Text("Favoris",textScaleFactor: 1.10,
                         style: TextStyle(fontFamily:'Montserrat',color: myWhite),

                         ),
                       ),
                       
                
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         leading: Icon(
                           Icons.group,
                        color: myWhite,
                        ),
                         title:Text("Amis",textScaleFactor: 1.10,textAlign: TextAlign.left,overflow: TextOverflow.visible,
                         style: TextStyle(fontFamily:'Montserrat',color: myWhite),
                         //strutStyle: ,
                         
                         ),
                         
                         
                                                ),
                  
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 60.0,vertical: 0,),
                         leading: Icon(
                           Icons.build,
                        color: myWhite,
                        ),
                         title: Text("Aide",textScaleFactor: 1.10,
                         style: TextStyle(fontFamily:'Montserrat',color: myWhite),

                         ),
                         
                       ),
                       
                     ],
                        ),
                         
                     ],
                  ),
                  
             ),
            
             ),
             Positioned(
               left: MediaQuery.of(context).size.width*0.45,
               
               bottom: MediaQuery.of(context).size.height*0.1,
               child:
                  Container
                  (
                   height: 40,
                   width: 40,
                   child:
                   FloatingActionButton
                   (
                      onPressed: () {},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Color(0xFFFFFFFF),
                      child:Transform(transform: Matrix4.rotationX(170),
                         child: Icon(    Icons.directions_run,color: c2, size:32.0),
       
                        ),
                    ),
                  ),
             ),
                 ],
               ),
            ),
        ),
        ),
        );
 }

}*/
