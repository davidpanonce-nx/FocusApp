import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Services/authentication_service.dart';
import 'package:provider/provider.dart';

class RegisterCredentials extends StatefulWidget {
  const RegisterCredentials({Key? key}) : super(key: key);

  @override
  _RegisterCredentialsState createState() => _RegisterCredentialsState();
}

class _RegisterCredentialsState extends State<RegisterCredentials> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _repassworController;
  TextEditingController? _usernameController;
  TextEditingController? _codeController;

  final _formKey = GlobalKey<FormState>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _otpSent = false;
  bool _otpVerified = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repassworController = TextEditingController();
    _usernameController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    _repassworController!.dispose();
    _usernameController!.dispose();
    _codeController!.dispose();
    super.dispose();
  }

  //toggles password to obscure
  void _togglePassword1() {
    _obscureText1 = !_obscureText1;
  }

  //toggle re-enter password to obscure
  void _togglePassword2() {
    _obscureText2 = !_obscureText2;
  }

  void sendOtp() async {
    EmailAuth.sessionName = "Focus App";

    var data = await EmailAuth.sendOtp(receiverMail: _emailController!.text);
    if (data) {
      setState(() {
        _otpSent = true;
      });
    }
  }

  void verifyOtp() {
    var res = EmailAuth.validate(
        receiverMail: _emailController!.text, userOTP: _codeController!.text);
    if (res) {
      setState(() {
        _otpVerified = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthServices>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: primary),
            ),
            Image.asset(
              'assets/stack-2.png',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 50, 15, 45),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset('assets/pink-button.png',
                            fit: BoxFit.contain),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Center(
                        child: Text(
                          'Register',
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      Text(
                        'What do you want to be known as?',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Text(
                        'Username',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: size.height / 70,
                      ),
                      TextFormField(
                        controller: _usernameController,
                        validator: (val) =>
                            val!.isNotEmpty ? null : "Please enter a username",
                        cursorColor: secondaryVariant,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                                color: secondaryVariant,
                                fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: secondaryVariant,
                          ),
                          errorStyle: TextStyle(color: Colors.amberAccent),
                          labelText: "Enter username here",
                          labelStyle: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                  color: greenVariant,
                                  fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryVariant),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      Text(
                        'Password',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: size.height / 70,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (val) => val!.length < 6
                            ? "Enter more than 6 characters"
                            : null,
                        obscureText: _obscureText1,
                        cursorColor: secondaryVariant,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                                color: secondaryVariant,
                                fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: secondaryVariant,
                          ),
                          errorStyle: TextStyle(color: Colors.amberAccent),
                          labelText: "Enter password here",
                          labelStyle: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                  color: greenVariant,
                                  fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryVariant),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _togglePassword1();
                              });
                            },
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: secondaryVariant,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Text(
                        'Re-enter Password',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: size.height / 70,
                      ),
                      TextFormField(
                        controller: _repassworController,
                        validator: (val) => val == _passwordController!.text
                            ? null
                            : "Password doesn't match",
                        obscureText: _obscureText2,
                        cursorColor: secondaryVariant,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                                color: secondaryVariant,
                                fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: secondaryVariant,
                          ),
                          errorStyle: TextStyle(color: Colors.amberAccent),
                          labelText: "Re-enter password here",
                          labelStyle: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                  color: greenVariant,
                                  fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryVariant),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _togglePassword2();
                              });
                            },
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: secondaryVariant,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Text(
                        'Email',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                              color: secondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: size.height / 70,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : "Please enter an email address",
                        cursorColor: secondaryVariant,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(
                                color: secondaryVariant,
                                fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: secondaryVariant,
                          ),
                          errorStyle: TextStyle(color: Colors.amberAccent),
                          labelText: "Enter email here",
                          labelStyle: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                  color: greenVariant,
                                  fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: secondaryVariant),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.amberAccent)),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 70,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => sendOtp(),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                primary: buttonColor,
                                minimumSize: Size(size.width - 300, 0)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Send Code',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(color: primary),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (_otpSent == true)
                            Text(
                              "Code already sent to email",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.amberAccent,
                                  ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      Container(
                        width: size.width - 150,
                        child: TextFormField(
                          cursorColor: secondaryVariant,
                          controller: _codeController,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                  color: secondaryVariant,
                                  fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.no_encryption_gmailerrorred_rounded,
                              color: secondaryVariant,
                            ),
                            errorStyle: TextStyle(color: Colors.amberAccent),
                            labelText: "Enter code here",
                            labelStyle: Theme.of(context)
                                .primaryTextTheme
                                .bodyText2!
                                .copyWith(
                                    color: greenVariant,
                                    fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryVariant),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.amberAccent)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 70,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => verifyOtp(),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                primary: buttonColor,
                                minimumSize: Size(size.width - 300, 0)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Verify Code',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(color: primary),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (_otpVerified == true)
                            Text(
                              "Code Verified",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.amberAccent,
                                  ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("Email: ${_emailController!.text}");
                              print("Password: ${_passwordController!.text}");
                              print("Username: ${_usernameController!.text}");
                              await loginProvider.register(
                                _emailController!.text.trim(),
                                _passwordController!.text.trim(),
                              );
                            }
                            _otpSent = false;
                            _otpVerified = false;
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              primary: buttonColor,
                              minimumSize: Size(size.width, 0)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: loginProvider.isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Submit',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2!
                                        .copyWith(color: primary),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      if (loginProvider.errorMessage != '')
                        Container(
                          color: Colors.amberAccent,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: ListTile(
                            title: Text(loginProvider.errorMessage),
                            leading: Icon(Icons.error),
                            trailing: IconButton(
                              onPressed: () => loginProvider.setMessage(''),
                              icon: Icon(Icons.close),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
