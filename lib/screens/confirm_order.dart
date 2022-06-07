import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rider_app/api/api.dart';
import 'package:flutter_rider_app/models/rider_home.dart';
import 'package:flutter_rider_app/models/today_order_list.dart';
import 'package:flutter_rider_app/screens/confirm_order.dart';
import 'package:flutter_rider_app/screens/picked_up_order.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Confirmpage extends StatefulWidget {
  Confirmpage({Key? key, required this.token, required this.voucherID})
      : super(key: key);

  final String token;

  final String voucherID;

  @override
  State<Confirmpage> createState() => _ConfirmpageState();
}

class _ConfirmpageState extends State<Confirmpage> {
  Future<List<RiderHomeData>>? riderHomeData;

  @override
  void initState() {
    //print(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.orange,
                  child: const Center(
                    child: Text(
                      'Line Delivery',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(top: 30, left: 15.0),
                  child: Text('Step 3: Confirm Order'),
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
                          flex: 8,
                          child: Center(
                            child: Text(
                              'အမျိုးအမည်',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ဦး‌ရေ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '‌‌‌ေစျးနှုန်း',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'ပေါင်း',
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
                child: StreamBuilder<List<RiderHomeData>?>(
                  stream: API().getRiderHomeData(widget.token).asStream(),
                  builder: (context, snapshot) {
                    String total() {
                      int sum = 0;
                      for (var item in snapshot.data!) {
                        //print(item.price);
                        int price =
                            int.parse(item.price) * int.parse(item.quantity);

                        sum = sum + price;

                        print(sum);
                      }
                      return sum.toString();
                    }

                    String deliveryFee() {
                      String fee = '';

                      for (int i = 0; i < snapshot.data!.length; i++) {
                        fee = snapshot.data![i].deliverFee;
                      }

                      return fee;
                    }

                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Text(snapshot.data![index].shopName),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 70,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              snapshot.data![index].id,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Center(
                                              child: Text(
                                                snapshot.data![index].name,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                snapshot.data![index].quantity,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: Text(
                                                snapshot.data![index].price,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Center(
                                              child: Text(
                                                '${int.parse(snapshot.data![index].quantity) * int.parse(snapshot.data![index].price)}',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              //color: Colors.lightGreen[50],
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ပစ္စည်းခ'),
                                      Text(total()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Deli Fee'),
                                      Text(deliveryFee()),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('စုစုပေါင်း'),
                                      Text(
                                          '${int.parse(deliveryFee()) + int.parse(total())}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text('Something Wrong');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey[300],
                              child: Center(
                                child: Text('Cancel Order'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                if (widget.token.isNotEmpty &&
                                    widget.voucherID.isNotEmpty) {
                                  String? url =
                                      'http://testlineapi.myanmaritc.com/api/changeOrderStatusByRider';

                                  http.Client client = http.Client();

                                  var response = await client.post(
                                    Uri.parse(url),
                                    headers: {
                                      "Accept": "application/json",
                                      "Content-Type":
                                          "application/x-www-form-urlencoded",
                                      "Authorization": "Bearer " + widget.token,
                                    },
                                    body: {
                                      "voucher_id": widget.voucherID,
                                      "status_id": "4",
                                    },
                                  );
                                  print('Status code for arrive shop is ' +
                                      response.statusCode.toString());

                                  // Map<String, dynamic> data = jsonDecode(response.body);

                                  // print(data);

                                  if (response.statusCode == 301) {
                                    print(response.headers['location']);

                                    final data = response.headers['location'];

                                    final result =
                                        await http.get(Uri.parse(data!));

                                    print(result.statusCode);

                                    return result.statusCode as Future<void>;
                                    // if (response.headers.containsKey('location')) {
                                    //   final url = response.headers['location'];
                                    //   final result = await http.get(Uri.parse(url!));

                                    //   print(result.statusCode);

                                    //print('status code is 301');
                                    // }
                                  } else {
                                    if (response.statusCode == 200) {
                                      print('success');
                                      var data = jsonDecode(response.body);

                                      print(data.toString());

                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            data['message'],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text('cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PickUpOrderPage(
                                                            token: widget.token,
                                                            voucherID: widget
                                                                .voucherID),
                                                  ),
                                                );
                                              },
                                              child: const Text('ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              child: Container(
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    'Confirm Order',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
