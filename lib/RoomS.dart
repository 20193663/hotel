import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);

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
  MyItem(
      {this.isExpanded = false,
      required this.header,
      required this.body,
      required this.leading,
      this.sw = false,
        required this.userRating,
      });
}

class _RoomState extends State<Room> {
  final List<MyItem> _items = <MyItem>[
    MyItem(
      header: "Single Room",
      body: "A room for one prison.",
      leading: "images/single.png",
      userRating: 4
    ),
    MyItem(
      header: "Double Room",
      body: "A room for two prison may have one or more beds.",
      leading: "images/double.png",
        userRating: 4
    ),
    MyItem(
      header: "Suite Room",
      body: "A room may include multiple rooms and one livening room.",
      leading: "images/suite.png",
        userRating: 5
    ),
  ];
  // ring bar
  double _userRating = 5.0;

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
                          rating: _userRating,
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
          ElevatedButton(onPressed: () {}, child: Text("Book Now!")),
        ],
      ),
    );
  }
}
