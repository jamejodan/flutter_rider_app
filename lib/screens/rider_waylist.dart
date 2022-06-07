// ignore_for_file: prefer_const_constructors

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rider_app/api/api.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class RiderWayLists extends StatefulWidget {
  const RiderWayLists({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<RiderWayLists> createState() => _RiderWayListsState();
}

class _RiderWayListsState extends State<RiderWayLists> {
  //bool _connected = false;
  @override
  void initState() {
    //print(API().getRiderWayList(widget.token));

    //initPlatformState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          title: Text('Your Ways'),
        ),
        body: StreamBuilder<dynamic>(
          stream: API().getRiderWayList(widget.token).asStream(),
          builder: (context, snapshot) {
            Future<List<int>> getItem() async {
              List<int> bytes = [];
              CapabilityProfile profile = await CapabilityProfile.load();
              final generator = Generator(PaperSize.mm80, profile);

              bytes += generator.text("SanThit Shop",
                  styles: PosStyles(
                    align: PosAlign.center,
                    height: PosTextSize.size2,
                    width: PosTextSize.size2,
                  ),
                  linesAfter: 1);

              bytes += generator.row([
                PosColumn(
                    text: 'No',
                    width: 1,
                    styles: PosStyles(
                        align: PosAlign.left,
                        bold: true,
                        width: PosTextSize.size1,
                        height: PosTextSize.size1)),
                PosColumn(
                    text: 'Date',
                    width: 3,
                    styles: PosStyles(align: PosAlign.left, bold: true)),
                PosColumn(
                    text: 'Name',
                    width: 4,
                    styles: PosStyles(align: PosAlign.left, bold: true)),
                PosColumn(
                    text: 'City',
                    width: 2,
                    styles: PosStyles(align: PosAlign.center, bold: true)),
                PosColumn(
                    text: 'price',
                    width: 2,
                    styles: PosStyles(align: PosAlign.right, bold: true)),
              ]);

              bytes += generator.hr();

              SizedBox(
                height: 6,
              );

              String totalPrice() {
                int sum = 0;

                for (int i = 0; i < snapshot.data['data'].length; i++) {
                  sum = sum +
                      int.parse(
                          snapshot.data['data'][i]['attribute']['deli_fee']);
                }

                return sum.toString();
              }

              // for (Future<dynamic> item in snapshot.data) {
              //   // for (int i = 0; i < snapshot.data.length; i++) {
              //   //   print(item['data'][i]['id']);
              //   // }
              //   print(item);
              // }
              for (int i = 0; i < snapshot.data['data'].length; i++) {
                print(snapshot.data['data'][i]['id']);

                bytes += generator.row([
                  PosColumn(text: '${i + 1}', width: 1),
                  PosColumn(
                      text:
                          '${snapshot.data['data'][i]['attribute']['delivered_date']}',
                      width: 3,
                      styles: PosStyles(
                        align: PosAlign.left,
                      )),
                  PosColumn(
                      text:
                          '${snapshot.data['data'][i]['attribute']['customer']['name']}',
                      width: 4,
                      styles: PosStyles(
                        align: PosAlign.left,
                      )),
                  PosColumn(
                      text:
                          '${snapshot.data['data'][i]['attribute']['township']['id']}',
                      width: 2,
                      styles: PosStyles(align: PosAlign.center)),
                  PosColumn(
                      text:
                          '${snapshot.data['data'][i]['attribute']['township']['delivery_fee']}',
                      width: 2,
                      styles: PosStyles(align: PosAlign.right)),
                ]);

                bytes += generator.hr();

                bytes += generator.row([
                  PosColumn(
                      text: 'TOTAL',
                      width: 6,
                      styles: PosStyles(
                        align: PosAlign.left,
                        height: PosTextSize.size4,
                        width: PosTextSize.size4,
                      )),
                  PosColumn(
                      text: totalPrice(),
                      width: 6,
                      styles: PosStyles(
                        align: PosAlign.right,
                        height: PosTextSize.size4,
                        width: PosTextSize.size4,
                      )),
                ]);

                bytes += generator.hr(ch: '=', linesAfter: 1);

                // ticket.feed(2);
                bytes += generator.text('Thank you!',
                    styles: PosStyles(align: PosAlign.center, bold: true));

                bytes += generator.qrcode(
                    '${snapshot.data['data'][i]['attribute']['voucher_id']}');

                bytes += generator.cut();
              }
              print(snapshot.data['data'].length.toString());

              return bytes;
            }

            Future<void> printTicket() async {
              String? isConnected =
                  await BluetoothThermalPrinter.connectionStatus;
              if (isConnected == "true") {
                List<int> bytes = await getItem();
                final result = await BluetoothThermalPrinter.writeBytes(bytes);
                print("Print $result");
              } else {
                //Hadnle Not Connected Senario
              }
            }
            // String total() {
            //   int sum = 0;
            //   for (var item in snapshot.data) {
            //     print(item['id']);
            //     //print(item.price);
            //     // int delifee = int.parse(item['data']['']);

            //     // sum = sum + delifee;

            //     // print(sum);
            //   }
            //   return sum.toString();
            //
            //print(snapshot.data);
            if (snapshot.hasData) {
              //print(snapshot.data['data'].length);

              String total() {
                int sum = 0;

                for (int i = 0; i < snapshot.data['data'].length; i++) {
                  sum = sum +
                      int.parse(
                          snapshot.data['data'][i]['attribute']['deli_fee']);
                }

                return sum.toString();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('စုစုပေါင်း'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('${total()} k'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('/'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('${snapshot.data['data'].length}'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('way (s)'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.amber[100],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'စဉ်',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  'နေ့စွဲ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'အမည်',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'မြို့နယ်',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'တန်ဖိုး',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: ListView.builder(
                        itemCount: snapshot.data['data'].length as int,
                        itemBuilder: (context, index) {
                          // return ExpansionTile(
                          //     title: Text(snapshot.data['data'][index]
                          //         ['attribute']['delivered_date']));
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Center(
                                    child: Text(
                                      snapshot.data['data'][index]['attribute']
                                          ['delivered_date'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    snapshot.data['data'][index]['attribute']
                                        ['customer']['name'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    snapshot.data['data'][index]['attribute']
                                        ['township']['name'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    snapshot.data['data'][index]['attribute']
                                        ['township']['delivery_fee'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        printTicket();
                      },
                      child: Container(
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                            'Print',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
              // return Expanded(
              //   child: ListView.builder(
              //     itemCount: snapshot.data,
              //     itemBuilder: (context, index) {
              //     return ListTile(title: Text(snapshot.data![index][]),);
              //   }),
              //);
            }
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            return const Center(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
