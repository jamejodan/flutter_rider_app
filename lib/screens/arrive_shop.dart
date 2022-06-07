import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rider_app/models/today_order_list.dart';
import 'package:http/http.dart' as http;

class ArriveShop extends StatefulWidget {
  ArriveShop({Key? key, required this.data, required this.token})
      : super(key: key);

  List<Datum> data;

  String token;

  @override
  State<ArriveShop> createState() => _ArriveShopState();
}

class _ArriveShopState extends State<ArriveShop> {
  Future<bool> _onWillPoP() async {
    return false;
  }

  String total() {
    int sum = 0;
    for (var item in widget.data) {
      //print(item.price);
      int price = int.parse(item.price) * int.parse(item.quantity);

      sum = sum + price;

      print(sum);
    }
    return sum.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Arrive Shop'),
        //   backgroundColor: Colors.orange,
        //   elevation: 0,
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.orange,
                child: const Center(
                  child: Text(
                    'Arrive Shop',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'စဉ်',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      '‌‌‌ေစျးနှုန်း',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'ပေါင်း',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${widget.data[index].id}',
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Center(
                            child: Text(
                              widget.data[index].name,
                              style: const TextStyle(fontSize: 13.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.data[index].quantity,
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            widget.data[index].price,
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${int.parse(widget.data[index].price) * int.parse(widget.data[index].quantity)}',
                            style: const TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                //color: Colors.lightGreen[50],
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ပစ္စည်းခ'),
                        Text(total()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Deli Fee'),
                        Text(widget.data[0].deliverFee),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('စုစုပေါင်း'),
                        Text(
                            '${int.parse(widget.data[0].deliverFee) + int.parse(total())}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    color: Colors.black,
                    child: Center(
                      child: TextButton(
                        onPressed: () async {
                          if (widget.token.isNotEmpty &&
                              widget.data[0].voucherId.isNotEmpty) {
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
                                "voucher_id": widget.data[0].voucherId,
                                "status_id": "3",
                              },
                            );
                            print('Status code for arrive shop is ' +
                                response.statusCode.toString());

                            // Map<String, dynamic> data = jsonDecode(response.body);

                            // print(data);

                            if (response.statusCode == 301) {
                              print(response.headers['location']);

                              final data = response.headers['location'];

                              final result = await http.get(Uri.parse(data!));

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
                                        child: const Text('Cancelled Order'),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text('Confirm Order'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: const Text(
                          'Arrived Shop',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
