import 'package:flutter/material.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  bool connected = false;
  List availableBluetoothDevices = [];

  Future<void> getBluetooth() async {
    final List? bluetooths = await BluetoothThermalPrinter.getBluetooths;
    print("Print $bluetooths");
    setState(() {
      availableBluetoothDevices = bluetooths!;
    });
  }

  Future<void> setConnect(String mac) async {
    final String? result = await BluetoothThermalPrinter.connect(mac);
    print("state conneected $result");
    if (result == "true") {
      setState(() {
        connected = true;
      });
    }
  }

  @override
  void initState() {
    //getBluetooth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: const Text('Bluetooth Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text("Search Paired Bluetooth"),

          Expanded(
            flex: 8,
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: availableBluetoothDevices.isNotEmpty
                    ? availableBluetoothDevices.length
                    : 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    selectedColor: Colors.green,
                    leading: const Icon(Icons.print_rounded,
                        size: 30, color: Colors.black),
                    onTap: () {
                      setState(() {});
                      String select = availableBluetoothDevices[index];
                      List list = select.split("#");
                      //String name = list[0];
                      String mac = list[1];
                      setConnect(mac);
                    },
                    title: Text('${availableBluetoothDevices[index]}'),
                    subtitle: const Text("Click to connect"),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: TextButton(
                onPressed: () {
                  getBluetooth();
                },
                child: const Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          // TextButton(
          //   onPressed: connected ? this.printGraphics : null,
          //   child: Text("Print"),
          // ),
          // TextButton(
          //   onPressed: connected ? this.printTicket : null,
          //   child: Text("Print Ticket"),
          // ),
        ],
      ),
    );
  }
}
