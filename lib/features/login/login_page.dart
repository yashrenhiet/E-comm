import 'package:e_comm_app/features/_common/app_state.dart';
import 'package:e_comm_app/features/_model/user.dart';
import 'package:e_comm_app/features/forgot_password/forgot_password.dart';
import 'package:e_comm_app/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  bool _isLoading = false;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  late FocusNode _dummyFocusNode;

  @override
  void initState() {
    super.initState();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _dummyFocusNode = FocusNode();

    _emailTextController.addListener(() {
      handleTextChange(_emailTextController);
    });
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _dummyFocusNode.dispose();

    super.dispose();
  }

  void handleTextChange(TextEditingController controller) {
    debugPrint("value is changes ${controller.text}");
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint('$_email & $_password');

      setState(() {
        _isLoading = true;
      });

      var user = User(_email!, _password!);

      Get.find<AppState>().logInUser(user);

      // Future.delayed(Duration(seconds: 2), () {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (_) => HomeScreen()));
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus(); //.requestFocus(_dummyFocusNode);
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login here"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    focusNode: _emailFocusNode,
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      hintText: "your@email.com",
                      labelText: "Email",
                      prefix: Icon(Icons.email),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Please provide your email";
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                    onEditingComplete: () {},
                    onFieldSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordTextController,
                    decoration: InputDecoration(
                        hintText: "your password...",
                        labelText: "Password",
                        prefix: Icon(Icons.vpn_key)),
                    // obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Please provide your password";
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                    onFieldSubmitted: (_) => handleSubmit(),
                  ),
                  SizedBox(height: 16),
                  Offstage(
                    offstage: _isLoading,
                    child: ElevatedButton(
                        onPressed: handleSubmit, child: Text("Login")),
                  ),
                  Offstage(
                      offstage: !_isLoading,
                      child: CircularProgressIndicator()),
                  SizedBox(height: 16),
                  MaterialButton(
                    onPressed: () async {
                      // _formKey.currentState!.reset();
                      // Navigator.pop(context);

                      // debugPrint("going to forgot pass");
                      Get.to(ForgotPassword());
                      // if (res == true) {
                      //   debugPrint("success");
                      // } else {
                      //   debugPrint("failed");
                      // }
                    },
                    child: Text("Forgot Password?"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
