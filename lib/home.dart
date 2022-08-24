import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hotel/RoomS.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  DateTime _CheckIN = DateTime.now();
  Future<Null> SelectCheckIN(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _CheckIN,
      firstDate: DateTime(1960),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _CheckIN) {
      setState(() {
        _CheckIN = picked;
        print(_CheckIN.toString());
      });
    }
  }

  DateTime _CheckOut = DateTime.now();
  Future<Null> SelectCheckOut(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _CheckOut,
      firstDate: DateTime(1960),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _CheckOut) {
      setState(() {
        _CheckOut = picked;
        print(_CheckOut.toString());
      });
    }
  }

  //slider
  double _Sadult = 0.0;
  double _Schildren = 0.0;

  String _extra="";
  String _view="";
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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true, //to add any filed
              children: <Widget>[
                Image(
                  image: AssetImage("images/home.png"),
                  height: 250,
                  width: 250,
                ),
                Row(
                  children: [
                    Text(
                      "Select your CheckIN:",
                      style: TextStyle(color: Colors.cyan),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        SelectCheckIN(context);
                      },
                      icon: Icon(Icons.date_range),
                    ),
                    Text(('${_CheckIN.year}-${_CheckIN.month}-${_CheckIN.day}')
                        .toString()),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Select your CheckOut:",
                      style: TextStyle(color: Colors.cyan),
                    ),
                    SizedBox(
                      width: 23,
                    ),
                    IconButton(
                      onPressed: () {
                        SelectCheckOut(context);
                      },
                      icon: Icon(Icons.date_range),
                    ),
                    Text(
                        ('${_CheckOut.year}-${_CheckOut.month}-${_CheckOut.day}')
                            .toString()),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "select your adult:",
                      style: TextStyle(color: Colors.cyan),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Slider(
                      value: _Sadult,
                      onChanged: (value) {
                        setState(() => _Sadult = value);
                      },
                      divisions: 5,
                      label: _Sadult.toInt().toString(),
                      max: 5,
                      min: 0,
                    ),
                    Text(_Sadult.toInt().toString()),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "select your children:",
                      style: TextStyle(color: Colors.cyan),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Slider(
                      value: _Schildren,
                      onChanged: (value) {
                        setState(() => _Schildren = value);
                      },
                      divisions: 5,
                      label: _Schildren.toInt().toString(),
                      max: 5,
                      min: 0,
                    ),
                    Text(_Schildren.toInt().toString()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Extras",
                      style: TextStyle(color: Colors.cyan),
                    ),
                    CheckboxGroup(
                      labels: <String>["brackfast (50EGP/Day)", "Wifi (50EGP/Day)", "parking (100EGP/Day)"],
                      onSelected: (List<String> checked) =>
                          _extra=checked.toString(),
                    ),
                    Text("View",
                      style: TextStyle(color: Colors.cyan),
                    ),
                    RadioButtonGroup(
                      labels: <String>["Garden view", "Sea view"],
                      onSelected: (String selected) => _view=selected,
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Room(checkin: _CheckIN,checkout: _CheckOut,Sadult: _Sadult,Schildren: _Schildren,extra: _extra,view: _view),)),
                    child: Text("check room and rates"),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(50, 20)),
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
