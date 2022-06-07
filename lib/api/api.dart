import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rider_app/models/accept_order.dart';
import 'package:flutter_rider_app/models/rider_home.dart';
import 'package:flutter_rider_app/models/rider_waylist.dart';
import 'package:flutter_rider_app/models/today_order_list.dart';
import 'package:flutter_rider_app/screens/home_screen.dart';
import 'package:flutter_rider_app/screens/testing_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  var token;

  // void login(String email, String password) async {
  //   try {
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       Response response = await http.post(
  //           Uri.parse('http://lineapi.myanmaritc.com/api/login'),
  //           headers: {
  //             'Accept': 'application/json',
  //           },
  //           body: {
  //             'email': email,
  //             'password': password,
  //           });
  //       //print(response.body);

  //       if (response.statusCode == 201) {
  //         pageContext(BuildContext context) {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //         }

  //         var data = jsonDecode(response.body.toString());

  //         //pageRoute(data['token']);

  //         //Navigator.push(_save(data['token']),
  //         //MaterialPageRoute(builder: (context) => HomeScreen()));

  //         print(data['token']);

  //         // print('Login Success');

  //         //print(data['user']['email']);
  //         _save(data['token']);
  //         //toHome(context: )
  //         // Navigator.push(
  //         //     context, MaterialPageRoute(builder: (context) => Testing()));

  //         // Navigator.of(_save(data['token'])).pushAndRemoveUntil(
  //         //     MaterialPageRoute(
  //         //       builder: (context) => Testing(),
  //         //     ),
  //         //     (route) => false);
  //       } else {
  //         print('Login Fail');
  //       }
  //     } else {
  //       Text('Invalid');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // pageRoute(String token) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   await pref.setString('token', token);
  // }

  Future acceptOrder(String voucherId, String token) async {
    try {
      if (voucherId.isNotEmpty && token.isNotEmpty) {
        //final prefs = await SharedPreferences.getInstance();

        //final key = 'token';

        //final value = prefs.getString(key) ?? 0;

        // final value = '832|vQiIaWTglPW72yFSS5MEu9NtOmL2O9tig7vE00oN';

        String? url = 'http://testlineapi.myanmaritc.com/api/rider_accept';

        http.Client client = http.Client();

        var response = await client.post(
          Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer " + token,
          },
          body: {
            "voucher_id": voucherId,
            "status_id": "2",
          },
        );

        print(token);
        print(response.statusCode);

        if (response.statusCode == 302) {
          print(response.headers.toString());

          final url = response.headers['location'];

          final ans = await http.get(Uri.parse(url!));

          print(ans.statusCode);

          return ans.statusCode;

          //return );
          //print(result.body);
          // if (result.statusCode == 200) {
          //   //var data = AcceptOrder.fromRawJson(result.body);

          //   //var ans = data.message;

          //   //print(ans);
          //   // var data =
          //   //     AcceptOrder.fromRawJson(jsonEncode(result.body).toString());
          //   // // var data = jsonDecode(result.body);
          //   // print(data);
          //   //var document = parse(result.body);

          //   print(document.getElementById('p'));
          //   print('success status code 200');
          // }
        } else {
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            print(data);
          }
        }

        //print(response.body);
        // print(json.decode('${response.body.toString()}'));
        // var responseJson = jsonDecode(response.statusCode);

        // print(responseJson);

        // int jsonDataString = response.statusCode;

        // print(jsonDataString.toString());

        //print(statusId);
        //print(json.decode(response.body).toString());

        //print(jsonDecode('${response.statusCode}'));
        // if (response.statusCode == 200) {
        //   // var data = jsonDecode(response.body.toString());

        //   // print(data.toString());
        //   //print('');

        //   print('success');

        //   //print(data['user']['email']);
        //   //_save(data['token']);
        // } else {
        //   print('Error');
        // }
      } else {
        Text('Invalid');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<List<Datum>>?> getData(String token) async {
    StreamController _streamController = StreamController();
    final prefs = await SharedPreferences.getInstance();

    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      http.Response response = await http.get(
          Uri.parse('http://testlineapi.myanmaritc.com/api/today_orders'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });

      print(response);

      if (response.statusCode == 200) {
        var result = TodayOrder.fromRawJson(response.body);

        _streamController.add(result);

        print(result.data);

        return result.data;
      }
      //print(result['data'][0][0]['id']);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<RiderHomeData>?> getRiderHomeData(String token) async {
    StreamController _streamController = StreamController();
    final prefs = await SharedPreferences.getInstance();

    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      http.Response response = await http.get(
          Uri.parse('http://testlineapi.myanmaritc.com/api/riderhome'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });

      if (response.statusCode == 200) {
        var result = RiderHome.fromRawJson(response.body);

        _streamController.add(result);

        print(result.data);

        return result.data;
      }
      //print(result['data'][0][0]['id']);
    } catch (e) {
      print(e.toString());
    }
    //return null;
  }

  Future getRiderWayList(String token) async {
    StreamController _streamController = StreamController();
    try {
      if (token.isNotEmpty) {
        http.Response response = await http.get(
            Uri.parse('http://testlineapi.myanmaritc.com/api/riderwaylist'),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ' + token,
            });

        print('Response data' + response.statusCode.toString());

        if (response.statusCode == 200) {
          var ans = json.decode(response.body);

          print(ans['data'][0]['id']);

          // var result = RiderWayListData.fromRawJson(response.body);

          // print('Result $result');

          _streamController.add(ans);

          // print(result);

          // return result;
          return ans;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future arriveShop(String voucherID, String token) async {
    try {
      if (token.isNotEmpty && voucherID.isNotEmpty) {
        String? url =
            'http://testlineapi.myanmaritc.com/api/changeOrderStatusByRider';

        http.Client client = http.Client();

        var response = await client.post(
          Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer " + token,
          },
          body: {
            "voucher_id": voucherID,
            "status_id": "3",
          },
        );
        print(
            'Status code for arrive shop is ' + response.statusCode.toString());

        // Map<String, dynamic> data = jsonDecode(response.body);

        // print(data);

        if (response.statusCode == 301) {
          print(response.headers['location']);

          final data = response.headers['location'];

          final result = await http.get(Uri.parse(data!));

          print(result.statusCode);

          return result.statusCode;
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
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
