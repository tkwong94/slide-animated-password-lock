library slide_animated_password_lock;

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; 

enum HashMethod {
  PlainText,
  SHA1,
  SHA224,
  SHA256,
  SHA384,
  SHA512,
  MD5,
  HMACMD5,
  HMACSHA1,
  HMACSHA256
}

class SlideAnimatedPasswordLock extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<bool> onUnlock;
  final Color color;
  final double width;
  final double height;
  final String placeholder;
  final String hashedPassword;
  final HashMethod hashMethod;
  final String hashKey;

  double slideSpace = 50;

  SlideAnimatedPasswordLock(
      {@required this.hashedPassword,
      @required this.hashMethod,
      this.hashKey,
      @required this.controller,
      @required this.onUnlock,
      @required this.color,
      this.width = 250,
      this.height = 40,
      this.placeholder = ''}) {
    print(this.width);
    assert(hashedPassword != null && hashedPassword.length > 0);
    assert(hashMethod != null);
    if (hashMethod == HashMethod.HMACMD5 ||
        hashMethod == HashMethod.HMACSHA1 ||
        hashMethod == HashMethod.HMACSHA256) {
      assert(hashKey != null && hashKey.length > 0);
    }
    assert(controller != null);
    assert(onUnlock != null);
    assert(color != null);
    assert(width != null && width > slideSpace);
    assert(height != null && height > 2);
    assert(placeholder != null);
  }

  @override
  _SlideAnimatedPasswordLockState createState() =>
      _SlideAnimatedPasswordLockState();
}

class _SlideAnimatedPasswordLockState extends State<SlideAnimatedPasswordLock> {
  double inputFieldLeftVal = 0;

  String hashInput(_val) {
    List<int> bytes = utf8.encode(_val); // data being hashed
    Digest digest;

    switch (widget.hashMethod) {
      case HashMethod.PlainText:
        return _val;

      case HashMethod.SHA1:
        digest = sha1.convert(bytes);
        break;
      case HashMethod.SHA224:
        digest = sha224.convert(bytes);
        break;
      case HashMethod.SHA256:
        digest = sha256.convert(bytes);
        break;
      case HashMethod.SHA384:
        digest = sha384.convert(bytes);
        break;
      case HashMethod.SHA512:
        digest = sha512.convert(bytes);
        break;
      case HashMethod.MD5:
        digest = md5.convert(bytes);
        break;
      case HashMethod.HMACMD5:
        List<int> key = utf8.encode(widget.hashKey);
        Hmac hmacMd5 = new Hmac(md5, key);
        digest = hmacMd5.convert(bytes);
        break;
      case HashMethod.HMACSHA1:
        List<int> key = utf8.encode(widget.hashKey);
        Hmac hmacSha1 = new Hmac(sha1, key);
        digest = hmacSha1.convert(bytes);
        break;
      case HashMethod.HMACSHA256:
        List<int> key = utf8.encode(widget.hashKey);
        Hmac hmacSha256 = new Hmac(sha256, key);
        digest = hmacSha256.convert(bytes);
        break;
    }
    return digest.toString();
  }

  void onSubmit(_val) {
    if (_val.length == 0) return;

    if (hashInput(_val) == widget.hashedPassword) {
      setState(() => inputFieldLeftVal = widget.slideSpace);
      widget.onUnlock(true);
    } else {
      setState(() => inputFieldLeftVal = 0);
      widget.controller.clear();
      widget.onUnlock(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: widget.color)),
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: inputFieldLeftVal,
            child: Container(
              margin: EdgeInsets.all(0),
              width: widget.width - widget.slideSpace,
              height: widget.height - 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border: Border.all(color: widget.color)),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                controller: widget.controller,
                obscureText: true,
                style: TextStyle(
                  color: widget.color,
                  fontFamily: 'AvenirNextCondensed',
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: InputBorder.none,
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(color: widget.color)),
                onSubmitted: (val) => onSubmit(val),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
