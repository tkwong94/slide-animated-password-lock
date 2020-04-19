import 'package:flutter/material.dart';
import 'package:slide_animated_password_lock/slide_animated_password_lock.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; 


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _password = '111';
  String _hashedPassword;
  final TextEditingController _textFieldController =
      new TextEditingController();
  String _msg = "Please unlock";

  @override
  void initState() {
    super.initState();
    List<int> bytes = utf8.encode(_password); 
    _hashedPassword = md5.convert(bytes).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        SlideAnimatedPasswordLock(
          hashedPassword: _hashedPassword,
          hashMethod: HashMethod.MD5,
          controller: _textFieldController,
          color: Theme.of(context).primaryColor,
          placeholder: "HELLO WORLD",
          onUnlock: (_unlocked){
            if (_unlocked){
              setState(()=>_msg = "Unlocked!");
            }else{
              setState(()=>_msg = "Please unlock!");
            }
          },
        ),
        Text(_msg)
      ])),
    );
  }
}
