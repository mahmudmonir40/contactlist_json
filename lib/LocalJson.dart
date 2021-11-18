import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalJsonData extends StatefulWidget {
  const LocalJsonData({Key? key}) : super(key: key);

  @override
  _LocalJsonDataState createState() => _LocalJsonDataState();
}

class _LocalJsonDataState extends State<LocalJsonData> {

  late List readyList;

  late List unfilterData;



  Future<String> loadjsonData () async{

    var jsonText = await rootBundle.loadString('assets/JsonData.Json');
    setState(() {
      readyList = jsonDecode(jsonText);
    });


    this.unfilterData = readyList;


     return 'succesfully get data';


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.loadjsonData();
  }

  searchBar(str) {

var stringExist = str.length >0 ? true: false;

if(stringExist) {

var filterData = [];

for(int i =0; i<unfilterData.length; i++){

  String name = unfilterData [i]["name"].toUpperCase();

  if(name.contains(str.toUpperCase())){

    filterData.add(unfilterData[i]);

  }
setState(() {

  this.readyList = filterData;

});


}

}else{

  setState(() {

    this.readyList = this.unfilterData;


  });

}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Contact List",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.teal),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
      TextField(
    decoration: InputDecoration(

      hintText: 'Search Contacts',
      icon: Icon(Icons.search),

    ),
        onChanged: (String str){

      this.searchBar(str);

      print(str);

        },


      ),


          Expanded(child: ListView.builder(itemCount: readyList.length,
          itemBuilder: (BuildContext context,int index){
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Text(readyList[index]["name"][0]),
                    
                  ),
                  title: Text(readyList[index]["name"]),
                  subtitle: Text(readyList[index]["phone"]),
                )
                
                
              ],
              
            );
            
            
          }
          
          ))
        ],
      ),

    );
  }
}
