import 'dart:convert';
//import 'dart:html';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<TrackList>> getdata()async{
    List<TrackList> list;
     var res = await http.get(Uri.encodeFull("https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7"),
     headers: {"Accept":"application/json"});
     print("ram hey ram");
    print(res.headers);
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
      var rest = data["message"]["body"] ["track_list"] as List;
      print(rest);
      list = rest.map<TrackList>((json) => TrackList.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    //var data = json.decode(res.body);
    return list;
      //data["track"] as List;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text("not has data"),
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text("has error"),
            );
          }else if(snapshot.hasData){
            print(snapshot.hasData);
            return HomeTile();
          }
          return CircularProgressIndicator();
        },

      ),
    );
  }
}

class TrackList{
   Track track;

   TrackList({
     this.track,
});

   factory TrackList.fromJson(Map<String, dynamic> json){
     return TrackList(
       track: Track.fromJson(json["track"]) ,

     );
   }
}

class Track{
  String track_id;
  String track_name;
  String track_rating;

  Track(
      {this.track_id,
        this.track_name,
        this.track_rating,
  });

  factory Track.fromJson(Map<String, dynamic> json){
    return Track(
        track_id: json["track_id"] as String,
        track_name: json["track_name"] as String,
        track_rating: json["track_rating"] as String,
    );
  }

}

class HomeTile extends StatefulWidget {
  @override
  _HomeTileState createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
