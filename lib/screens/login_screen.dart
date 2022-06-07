import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rider_app/api/api.dart';
import 'package:flutter_rider_app/screens/testing_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    //checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString('token');

    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Testing(),
          ),
          (route) => false);
    }
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: Stack(
          children: [
            Positioned(
              top: 50,
              //right: MediaQuery.of(context).size.width / 2,
              left: MediaQuery.of(context).size.width * 0.25,
              child: const Center(
                child: Text(
                  'Line Delivery',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 150,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  //color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 221, 220, 220),
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Enter Your Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              labelText: 'email',
                            ),
                            validator: (String? value) {
                              return (value != null && value.contains('@'))
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password_rounded),
                            hintText: 'Enter Your Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            labelText: 'password',
                          ),
                          validator: (val) =>
                              val!.length < 6 ? 'Password too short.' : null,
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: (() async {
                            var token;

                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              Response response = await http.post(
                                  Uri.parse(
                                      'https://testlineapi.myanmaritc.com/api/login'),
                                  headers: {
                                    'Accept': 'application/json',
                                  },
                                  body: {
                                    'email': emailController.text.toString(),
                                    'password':
                                        passwordController.text.toString(),
                                  });
                              print(response.headers);

                              if (response.statusCode == 201) {
                                var data = jsonDecode(response.body.toString());

                                print(data['token']);

                                print(data);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(token: data['token']),
                                  ),
                                );

                                //pageRoute(data['token']);

                                //Navigator.push(_save(data['token']),
                                //MaterialPageRoute(builder: (context) => HomeScreen()));

                                print(data['token']);

                                // print('Login Success');

                                //print(data['user']['email']);
                                //_save(data['token']);
                                //toHome(context: )
                                // Navigator.push(
                                //     context, MaterialPageRoute(builder: (context) => Testing()));

                                // Navigator.of(_save(data['token'])).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //       builder: (context) => Testing(),
                                //     ),
                                //     (route) => false);
                              } else {
                                print('Login Fail');
                              }
                            } else {
                              Text('Invalid');
                            }

                            // if (emailController.text.isNotEmpty &&
                            //     passwordController.text.isNotEmpty) {
                            //   Navigator.pushReplacement(context,
                            //       MaterialPageRoute(builder: (context) => HomeScreen()));
                            // }
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //       builder: (context) => HomeScreen(),
                            //     ),
                            //     (route) => false);
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: 70,
              left: 0,
              right: -200,
              //bottom: -30,
              child: Container(
                width: 150,
                height: 150,
                child: SvgPicture.asset('assets/two.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
