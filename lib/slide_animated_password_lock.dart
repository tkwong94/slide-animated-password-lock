library slide_animated_password_lock;

import 'package:flutter/material.dart';

class SlideAnimatedPasswordLock extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<bool> onUnlock;
  final Color color;
  final double width;
  final double height;
  final String placeholder;
  final String password;

  double slideSpace = 50;

  SlideAnimatedPasswordLock(
      {@required this.password,
      @required this.controller,
      @required this.onUnlock,
      @required this.color,
      this.width = 250,
      this.height = 40,
      this.placeholder = ''}) {
        print(this.width);
    assert(password != null && password.length > 0);
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

  void onSubmit(val) {
    if (val == widget.password) {
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
                    hintStyle:
                        TextStyle(color: widget.color)),
                onSubmitted: (val) => onSubmit(val),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
