import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FormMode { LOGIN, SIGNUP }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  bool _isIos;
  bool _isLoading;
  String _email;
  String _password;
  String _errorMessage;
  FormMode _formMode = FormMode.LOGIN;

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.only(top: 70),
        child: CircleAvatar(
          backgroundColor: Colors.amber,
          radius: 48,
          child: Text(
            'F',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }

  Widget _showPrimaryButton() {
    return Container(
      margin: EdgeInsets.only(top: 45),
      child: RaisedButton(
        padding: EdgeInsets.all(12),
        elevation: 5,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.blue,
        child: _formMode == FormMode.LOGIN
            ? Text('Login', style: TextStyle(fontSize: 20, color: Colors.white))
            : Text(
                'Create Account',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
        onPressed: _validateAndSubmit,
      ),
    );
  }

  Widget _showSecondaryButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: FlatButton(
        padding: EdgeInsets.all(16),
        child: _formMode == FormMode.LOGIN
            ? Text(
                'Create an account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              )
            : Text(
                'Have an account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
        onPressed: _formMode == FormMode.LOGIN
            ? _changeFormToSignup
            : _changeFormToLogin,
      ),
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13,
            color: Colors.red,
            height: 1,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _showBody() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showLogo(),
            _showEmailInput(),
            _showPasswordInput(),
            _showPrimaryButton(),
            _showSecondaryButton(),
            _showErrorMessage()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
        appBar: AppBar(
          title: Text('Login to Chat App'),
        ),
        body: Stack(
          children: <Widget>[_showBody(), _showCircularProgress()],
        ));
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignup() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";

      try {
        if (_formMode == FormMode.LOGIN) {
        }
      } catch(e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else {
            _errorMessage = e.message;
          }
        });
      }
    }
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }
}
