import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:switch_example/controller/controller.dart';

final GeneralController controller = Get.put(GeneralController());

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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

  Future<void> toggleSwitch(bool value) async {

    saveSwitchState(value);

    controller.switchControl.value == false ?  controller.isikDurumu.value='ON'
                                            :  controller.isikDurumu.value='OFF';

    controller.switchControl.value= !controller.switchControl.value;

  }


  @override
  initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    controller.switchControl.value = await getSwitchState();
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isikDurumu", value);
    return prefs.setBool("isikDurumu", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isikAcikMi = prefs.getBool("isikDurumu") ?? false;

    isikAcikMi==true ? controller.isikDurumu.value="ON"
                    : controller.isikDurumu.value="OFF";

    return isikAcikMi;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text("Switch Uygulaması"),
        ),

        body:
        Obx(()=>Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                controller.switchControl.value ? const Icon(Icons.lightbulb_outline, size: 100, color: Colors.yellow,)
                    : const Icon(Icons.lightbulb_outline, size: 100),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Switch(
                    onChanged: toggleSwitch,
                    value:  controller.switchControl.value ,
                    activeColor: Colors.redAccent,
                    activeTrackColor: Colors.grey[400],
                    inactiveThumbColor: Colors.grey[200],
                    inactiveTrackColor: Colors.grey,
                  ),
                ),

                Text(controller.isikDurumu.value),

              ],
            )
        )),
      ),
    );
  }
}
