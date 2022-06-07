// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rider_app/api/api.dart';
import 'package:flutter_rider_app/models/rider_home.dart';
import 'package:flutter_rider_app/models/today_order_list.dart';
import 'package:flutter_rider_app/screens/arrive_shop.dart';
import 'package:flutter_rider_app/screens/bluetooth_devices/search_bluetooth_page.dart';
import 'package:flutter_rider_app/screens/login_screen.dart';
import 'package:flutter_rider_app/screens/rider_home.dart';
import 'package:flutter_rider_app/screens/rider_waylist.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:flutter_rider_app/screens/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    this.token,
  }) : super(key: key);

  var token;

  var loginData;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      setState(() {
        HomeScreen(
          token: widget.token,
        );
      });
    });

    //print(API().getData());
    //print(API().getRiderHomeData(widget.token));

    //print(API().arriveShop(
    //'202205200717441627', '566|f9XRxNLCcmrw68FP9bflfwU564twLhNWNDIf3hEj'));

    //print(API().acceptOrder('2', '202205200717441627'));

    //print(todayOrderData);
    //getToken();
    //print(API().getData(widget.token));

    //print(orderList?.length ?? 0);
    //print(data);
    //HomeScreen();

    super.initState();
  }

  void getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getString('token') == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false);
    }
  }

  //var data = API().getData(widget.token);

  List<List<Datum>>? orderList;

  @override
  void dispose() {
    //cancel the timer
    if (_timer!.isActive) _timer?.cancel();

    super.dispose();
  }

  final PageController controller = PageController(initialPage: 0);

  //int i = 0;

  //Future<List<OrderList>?> todayOrderData = API().getData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.orange,
            title: const Text('Line Rider Order'),
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ignore: sized_box_for_whitespace
                      Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        width: 70,
                        height: 70,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          //backgroundImage: AssetImage('assets/deliveryboy.png'),
                          radius: 100,
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              'assets/deliveryboy.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello ',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(''
                                // '${widget.loginData['user']['email']}',
                                // style: TextStyle(
                                //     color: Colors.white70, fontSize: 13),
                                ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.linear_scale_sharp,
                    size: 20,
                    //color: Colors.black,
                  ),
                  title: const Text(
                    'Rider WayLists',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RiderWayLists(
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.bluetooth_searching_outlined,
                    size: 20,
                  ),
                  title: const Text(
                    'Search Bluetooth Devices',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BluetoothPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: StreamBuilder<List<List<Datum>>?>(
            stream: API().getData(widget.token).asStream(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No Order Yet',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          //color: Colors.black45,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 247, 232, 185),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Refresh',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(
                                  Icons.refresh,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        //color: Colors.deepPurple[100],
                        child: Stack(
                          children: [
                            PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              controller: controller,
                              itemBuilder: (context, index) {
                                String total() {
                                  int sum = 0;
                                  for (var item in snapshot.data![index]) {
                                    //print(item.price);
                                    int price = int.parse(item.price) *
                                        int.parse(item.quantity);

                                    sum = sum + price;

                                    print(sum);
                                  }
                                  return sum.toString();
                                }

                                return RefreshIndicator(
                                  onRefresh: () {
                                    setState(() {
                                      API().getData(widget.token);
                                    });
                                    return API().getData(widget.token);
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          //color: Colors.amber[100],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'စဉ်',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 8,
                                                  child: Center(
                                                    child: Text(
                                                      'အမျိုးအမည်',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'ဦး‌ရေ',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    '‌‌‌ေစျးနှုန်း',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'ပေါင်း',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data![index].length,
                                          itemBuilder: (context, position) {
                                            var totalPrice = int.parse(snapshot
                                                    .data![index][position]
                                                    .quantity) *
                                                int.parse(snapshot
                                                    .data![index][position]
                                                    .price);

                                            return ExpansionTile(
                                              iconColor: Colors.black,
                                              collapsedIconColor:
                                                  Colors.orange[100],
                                              collapsedTextColor:
                                                  Colors.orange[100],
                                              initiallyExpanded: true,
                                              title: Text(
                                                snapshot.data![index][position]
                                                    .shopName,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  height: 70,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          '${position + 1}',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 8,
                                                        child: Center(
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                    [position]
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Center(
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                    [position]
                                                                .quantity,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Center(
                                                          child: Text(
                                                            snapshot
                                                                .data![index]
                                                                    [position]
                                                                .price,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Center(
                                                          child: Text(
                                                            '$totalPrice',
                                                            style: TextStyle(
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
                                        flex: 3,
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          //color: Colors.lightGreen[50],
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('ပစ္စည်းခ'),
                                                  Text(total()),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Deli Fee'),
                                                  Text(snapshot.data![index][0]
                                                      .deliverFee),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('စုစုပေါင်း'),
                                                  Text(
                                                      '${int.parse(snapshot.data![index][0].deliverFee) + int.parse(total())}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          'Are u sure to reject order'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            String? url =
                                                                'http://testlineapi.myanmaritc.com/api/changeOrderStatusByRider';

                                                            http.Client client =
                                                                http.Client();

                                                            var response =
                                                                await client
                                                                    .post(
                                                              Uri.parse(url),
                                                              headers: {
                                                                "Accept":
                                                                    "application/json",
                                                                "Content-Type":
                                                                    "application/x-www-form-urlencoded",
                                                                "Authorization":
                                                                    "Bearer " +
                                                                        widget
                                                                            .token,
                                                              },
                                                              body: {
                                                                "voucher_id":
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                            [0]
                                                                        .voucherId,
                                                                "status_id":
                                                                    "9",
                                                              },
                                                            );
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomeScreen(
                                                                  token: widget
                                                                      .token,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Text('Ok!'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  color: Colors.black45,
                                                  child: Center(
                                                    child: Text(
                                                      'Reject Order',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          'Are u sure to accept order'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              API().acceptOrder(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                          [0]
                                                                      .voucherId,
                                                                  widget.token);
                                                            });

                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RiderHomePage(
                                                                  token: widget
                                                                      .token,
                                                                  voucherID: snapshot
                                                                      .data![
                                                                          index]
                                                                          [0]
                                                                      .voucherId,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Text('Ok!'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  //height: 50,
                                                  color: Colors.black,
                                                  child: Center(
                                                    child: Text(
                                                      'Accept Order',
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 70),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SmoothPageIndicator(
                                  controller: controller,
                                  count: snapshot.data!.length,
                                  effect: JumpingDotEffect(
                                    activeDotColor:
                                        Color.fromARGB(255, 251, 191, 113),
                                    dotColor:
                                        Color.fromARGB(255, 218, 215, 215),
                                    dotHeight: 9,
                                    dotWidth: 9,
                                    jumpScale: 1,
                                    verticalOffset: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container(
                child: Center(
                  child: Text('No Order Yet'),
                ),
              );
            },
          )),
    );
  }
}
