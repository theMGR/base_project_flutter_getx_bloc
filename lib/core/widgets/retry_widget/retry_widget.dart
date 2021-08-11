import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  final String message;
  final String retryText;
  final Function()? retryFunction;
  final Color? backGroundColor;

  const RetryWidget({Key? key, this.message = "", required this.retryFunction, this.backGroundColor = Colors.white, this.retryText = "Retry"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        body: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              message.trim().length > 0
                  ? Text(
                      message,
                      style: TextStyle(
                        fontSize: 26.0,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(retryText),
                onPressed: retryFunction,
              )
            ],
          ),
        ));
  }
}
