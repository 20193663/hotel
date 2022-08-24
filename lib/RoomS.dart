import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_database/firebase_database.dart';

class Room extends StatefulWidget {
  DateTime checkin,checkout;
  String extra,view;
  double Sadult;
  double Schildren;
   Room({Key? key ,required this.checkin,required this.checkout,required this.Sadult,required this.Schildren,required this.extra,required this.view,}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class MyItem {
  bool isExpanded;
  final String header;
  final String body;
  final String leading;
  double userRating;
  bool sw;
  MyItem({
    this.isExpanded = false,
    required this.header,
    required this.body,
    required this.leading,
    this.sw = false,
    required this.userRating,
  });
}

class _RoomState extends State<Room> {
  String roomType="";
  final List<MyItem> _items = <MyItem>[
    MyItem(
        header: "Single Room",
        body: "A room for one prison.",
        leading: "images/single.png",
        userRating: 4),
    MyItem(
        header: "Double Room",
        body: "A room for two prison may have one or more beds.",
        leading: "images/double.png",
        userRating: 4),
    MyItem(
        header: "Suite Room",
        body: "A room may include multiple rooms and one livening room.",
        leading: "images/suite.png",
        userRating: 5),
  ];
  // ring bar
  //AlertDialog
  void shoeAlertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Are you sure"),
      content: Text(" Confirm or Discared"),
      actions: [
        ElevatedButton(
          onPressed:() {
            senddata();
            Navigator.pushNamed(context, "home");
          },
          child: Text("Confirm"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Discared"),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
  final DatabaseReference _databaseReference= FirebaseDatabase.instance.ref().child("MY_services");

  senddata(){
    _databaseReference.push().set({
      "hotel":"${widget.checkin}",
      "checkout":"${widget.checkout}",
      "extra":"${widget.extra}",
      "view":"${widget.view}",
      "adult":"${widget.Sadult}",
      "children":"${widget.Schildren}",
      "type":"${roomType}",
    });
    print("send data is successes");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Royal Hotels",
          style: TextStyle(
            fontFamily: "DancingScript",
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
        children: <Widget>[
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !_items[index].isExpanded;
              });
            },
            children: _items.map<ExpansionPanel>(
              (MyItem item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(item.header),
                          SizedBox(
                            width: 30,
                          ),
                          Switch(
                            value: item.sw,
                            onChanged: (value) {
                              setState(() {
                                item.sw = value;
                              });
                            },
                            activeColor: Colors.cyan,
                          ),
                        ],
                      ),
                      leading: Image(
                        image: AssetImage(item.leading),
                        width: 80,
                        height: 100,
                      ),
                    );
                  },
                  body: ListTile(
                    title: Row(
                      children: [
                        RatingBarIndicator(
                          rating: item.userRating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 10.0,
                          unratedColor: Colors.amber.withAlpha(50),
                          direction: Axis.horizontal,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(item.body),
                        )
                      ],
                    ),
                  ),
                  isExpanded: item.isExpanded,
                );
              },
            ).toList(),
          ),
          ElevatedButton(
            onPressed: () => shoeAlertDialog(context),
            child: Text("Book Now!"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.cyan)),
          ),
        ],
      ),
    );
  }
}
