import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http_app/Country%20page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map mapResponse;
  List countryData;

  Future fetchdata() async {
    http.Response response;
    response = await http.get(Uri.parse("https://corona.lmao.ninja/v2/all"));
    setState(() {
      if (response.statusCode == 200) {
        mapResponse = json.decode(response.body);
      }
    });
  }
//TODO:COUNTRY
  Future fetchCountry() async {
    http.Response response;
    response = await http.get(Uri.parse("https://corona.lmao.ninja/v2/countries?sort=cases"));
    setState(() {
      if (response.statusCode == 200) {
        countryData = json.decode(response.body);
      }
    });
  }

  @override
  void initState() {
    fetchdata();
    fetchCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff202C3B),
        title: Text(
          "COVID-19 TRACKER",
          style: TextStyle(
            //fontWeight:FontWeight.bold,
            fontFamily: "Patua",
            letterSpacing: 1,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        //centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        backgroundColor:Colors.black,
        color:Colors.blue.shade900,
        onRefresh: fetchdata,
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                    color: Color(0xffFF7F50),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "\“ We are in this together !\ ” ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Patua",
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                  width: 133,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Worldwide",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Patua",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:18),
                      child: Container(
                        width:108,
                        height:36,
                        decoration:BoxDecoration(
                          color:Colors.black,
                          borderRadius:BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return CountryPage();
                            })
                            );
                          },
                          child: Center(
                            child: Text(
                              "Regional",
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Patua",
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                  width: 133,
                ),
                Column(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children:[
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding:EdgeInsets.all(10),
                          height: 100,
                          width: 160,
                          color: Color(0xffF08080),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "CONFIRMED",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff850C00),
                                    fontFamily: "Patua"),
                              ),
                              mapResponse == null
                                  ? Text("Loading..")
                                  : Text(
                                mapResponse["cases"].toString(),
                                style:
                                TextStyle(fontSize: 17, color: Color(0xff850C00),fontWeight:FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:EdgeInsets.all(7),
                          height: 100,
                          width: 160,
                          color: Color(0xff6599F0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ACTIVE",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff002D70),
                                    fontFamily: "Patua"),
                              ),
                              mapResponse == null
                                  ? Text("Loading..")
                                  : Text(
                                mapResponse["active"].toString(),
                                style:
                                TextStyle(fontSize: 17, color: Color(0xff002D70),fontWeight:FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(

                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding:EdgeInsets.all(10),
                          height: 100,
                          width: 160,
                          color: Color(0xff22DA75),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "RECOVERED",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff002D70),
                                    fontFamily: "Patua"),
                              ),
                              mapResponse == null
                                  ? Text("Loading..")
                                  : Text(
                                mapResponse["recovered"].toString(),
                                style:
                                TextStyle(fontSize: 17, color: Color(0xff002D70),fontWeight:FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:EdgeInsets.all(7),
                          height: 100,
                          width: 160,
                          color: Color(0xff606060),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "DEATHS",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontFamily: "Patua"),
                              ),
                              mapResponse == null
                                  ? Text("Loading..")
                                  : Text(
                                mapResponse["deaths"].toString(),
                                style:
                                TextStyle(fontSize: 17, color: Colors.white,fontWeight:FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
             height:10,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Most Affected Countries",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Patua",
                ),
              ),
            ),
           SingleChildScrollView(
             child:Container(
               child:ListView.builder(
                  physics:NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemCount:6,
                   itemBuilder: (context,index){
                 return Container(
                   width:86,
                   height:52,
                   margin:EdgeInsets.symmetric(horizontal:20,vertical:10),
                   child: Center(
                     child: Row(
                       children: [
                        Image.network(countryData[index]['countryInfo']['flag']),
                         SizedBox(width:10),
                         Text(countryData[index]['country'],style:TextStyle(fontFamily:"Patua",fontWeight:FontWeight.bold,fontSize:25),),
                         SizedBox(width:12),
                         Text('Deaths:'+countryData[index]['deaths'].toString(),style:TextStyle(color:Color(0xffF40000),fontWeight:FontWeight.w500,fontFamily:"Patua",fontSize:16),),
                       ],
                     ),
                   ),
                 );
               }
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}