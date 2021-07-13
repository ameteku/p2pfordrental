import 'package:blocks/appstate.dart';
import 'package:blocks/model/user.dart';
import 'package:blocks/service/block_service.dart';
import 'package:blocks/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'EditPage.dart';

enum AuthState { Login, SignUp, SignOut }

class Login extends StatefulWidget {
  final AuthState status;
  final AppState appState;
  final BlockService blockService;
  final UserService userService;
  final Function onLogin;

  Login({this.userService, this.status, this.appState, this.blockService, this.onLogin});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController uidController = TextEditingController();
  TextEditingController passCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool isActive = false;
  bool isSuccess = false;
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    // userService = Provider.of<UserService>(context);
    print(widget.appState);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(widget.status == AuthState.Login
          ? 'Login to Admin Area'
          : widget.status == AuthState.SignUp
              ? 'Request Admin Access'
              : ''),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasError)
            Container(
              child: Text(
                'Username or passcode is not correct, try again.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: widget.status == AuthState.SignOut
                ? Column(
                    children: [
                      Text('Successfully Signed Out'),
                      // Center(
                      //   child: OutlinedButton(
                      //     onPressed: () => Navigator.pop(context),
                      //     child: Text('Back to HomePage'),
                      //   ),
                      // ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.status == AuthState.SignUp) ...[
                        Text('Your name'),
                        TextField(
                          controller: nameController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            //errorText: 'Try again',
                            hintText: 'John Depp',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Text('Phone number'),
                        TextField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                          decoration: InputDecoration(
                            hintText: '6147807220',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ],
                      Text('Enter userName'),
                      TextField(
                        controller: uidController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          //errorText: 'Try again',
                          hintText: 'userName',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Enter ${widget.status == AuthState.SignUp ? 'new' : ''} 6 digit pass-code'),
                      ),
                      TextField(
                        controller: passCodeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                        decoration: InputDecoration(
                          hintText: '123456',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          OutlineButton(
              padding: EdgeInsets.all(10),
              child: Text(widget.status == AuthState.SignUp ? 'SignUp' : 'Login'),
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              disabledBorderColor: Colors.white,
              disabledTextColor: Colors.white,
              onPressed: checkForValidity() ? onTap : null //,
              ),
        ],
      ),
    );
  }

  bool checkForValidity() {
    return uidController.text != '' &&
        (uidController.text.length > 3) &&
        passCodeController.text.length == 6 &&
        (widget.status == AuthState.Login ? true : nameController.text) != '' &&
        (widget.status == AuthState.Login ? true : phoneNumberController.text.length == 10);
  }

  void onTap() async {
    User verifiedUser;
    if (widget.status == AuthState.SignUp) {
      verifiedUser = User(
        phoneNumber: phoneNumberController.text,
        passCode: int.parse(passCodeController.text),
        userName: uidController.text,
        name: nameController.text,
      );
      await widget.userService.addUser(verifiedUser);
    } else {
      verifiedUser = await widget.userService.validateUser(uidController.text, int.parse(passCodeController.text));
    }

    if (verifiedUser != null) {
      await widget.appState.updateUser(verifiedUser);
      widget.onLogin();
    } else {
      setState(() {
        hasError = true;
      });
      print("Error has occured, try again");
    }
  }
}
