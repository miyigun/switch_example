import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Switch Örneği',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Switch Örneği'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool switchControl = false;

  var isikDurumu = 'OFF';

  Future<void> toggleSwitch(bool value) async {

    if(switchControl == false)
    {
      setState(() {
        saveSwitchState(value);
        switchControl = true;
        isikDurumu = 'ON';
      });
    }
    else
    {
      setState(() {
        saveSwitchState(value);
        switchControl = false;
        isikDurumu = 'OFF';
      });
    }
  }


  @override
  initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    switchControl = await getSwitchState();
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    return prefs.setBool("switchState", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState") ?? false;
    return isSwitchedFT;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Switch Uygulaması"),
        ),

        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                switchControl? Icon(Icons.lightbulb_outline, size: 100, color: Colors.yellow,)
                              : Icon(Icons.lightbulb_outline, size: 100),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Switch(
                    onChanged: toggleSwitch,
                    value: switchControl,
                    activeColor: Colors.redAccent,
                    activeTrackColor: Colors.grey[400],
                    inactiveThumbColor: Colors.grey[200],
                    inactiveTrackColor: Colors.grey,
                  ),
                ),

                Text("$isikDurumu"),

              ],
            )
        ),
      ),
    );
  }
}
