import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentdemoapp/model/UserModel.dart';
import 'package:studentdemoapp/screens/welcome.dart';
import 'package:studentdemoapp/utils/DatabaseHelper.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterState();
}

class _RegisterState extends State<Register>
  with SingleTickerProviderStateMixin {
  final _formKey = new GlobalKey<FormState>();

  String _selectedCountry;
  String _country;
  String platform;
  String osVersion;


  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _isChecked = false;

  String passwordStrengthText="";
  Color textColorHint=Colors.white;
  //Pattern emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
  Pattern emailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  Pattern passwordPattern = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})";
  FocusNode emailFocus;
  FocusNode mobileFocus;
  FocusNode classFocus;
  FocusNode branchFocus;
  FocusNode addressFocus;
  FocusNode latFocus;
  FocusNode langFocus;


  DatabaseHelper db = new DatabaseHelper();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var addressController = TextEditingController();
  var branchController = TextEditingController();
  var classController = TextEditingController();
  var latController = TextEditingController();
  var langController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    mobileFocus = FocusNode();
    classFocus = FocusNode();
    branchFocus = FocusNode();
    addressFocus = FocusNode();
    latFocus=FocusNode();
    langFocus=FocusNode();


  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    emailFocus.dispose();
    mobileFocus.dispose();
    classFocus.dispose();
    branchFocus.dispose();
    addressFocus.dispose();
    latFocus.dispose();
    langFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[_showBody(context)],
          )),
      ),
    );
  }

  Widget _showBody(context) {
    return new Container(
      padding: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0,bottom: 16),
      child: new Form(
        key: _formKey,
        child: new SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              _registerHintText(),
              _hintText(),
              _showName(),
              _showEmail(),
              _showMobile(),
              _showClass(),
              _showBranch(),
              _showAddress(),
              _showLat(),
              _showLong(),
              _showRegisterButton(),

            ],
          ),
        ),
      ));
  }

  Widget _logoImage() {
    return Container(
      margin: EdgeInsets.only(bottom: 32.0),
      alignment: Alignment.center,
      child: Image(
        image: AssetImage("assets/splash.png"),
        width: MediaQuery.of(context).size.width,
        height: 90,
      ),
    );
  }

  Widget _registerHintText() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Center(
        child: Text("Registration",
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.normal),
          textAlign: TextAlign.center),
      ),
    );
  }

  Widget _hintText() {
    return Padding(
      padding:
      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 0.0),
      child: Center(
        child: Text(
          "Student Registration details goes here..",
          style: TextStyle(color: Colors.grey, fontSize: 18.0,fontFamily: 'Montserrat'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _showName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new TextFormField(
        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]"))],
        controller: nameController,
        maxLines: 1,
        cursorColor: Colors.lightBlue,
        textInputAction: TextInputAction.go,
        maxLength: 50,
        style: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black,fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
          border:new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[300]),
          ),
          labelStyle: TextStyle(color: Colors.grey),
          labelText: "Name*",
          counterText: "",
        ),
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(emailFocus);
        },
        validator: (value) {
          if (value.isEmpty) {
            return "Name should not be empty";
          }
          return null;
        },
        onSaved: (value) => nameController.text = value,
      ),
    );
  }

  Widget _showEmail() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new TextFormField(
        controller: emailController,
        maxLines: 1,
        cursorColor: Colors.lightBlue,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.go,
        style: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black,fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
          border:new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[300]),
          ),
          labelStyle: TextStyle(color: Colors.grey),
          labelText: "Email*",
        ),
        focusNode: emailFocus,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(mobileFocus);
        },
        validator: (value) {
          RegExp regex = new RegExp(emailPattern);
          if (value.isEmpty) {
            return "Email should not be empty";
          } else if (!regex.hasMatch(value)) {
            return "Invalid email address";
          }
          return null;
        },
        onSaved: (value) => emailController.text = value,
      ),
    );
  }

  Widget _showMobile() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new TextFormField(
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        controller: mobileController,
        maxLines: 1,
        cursorColor: Colors.lightBlue,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.number,
        maxLength: 12,
        style: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black,fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
          border:new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[300]),
          ),
          labelStyle: TextStyle(color: Colors.grey),
          labelText: "Phone*",
        ),
        focusNode: mobileFocus,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(classFocus);
        },
        validator: (value) {
          if (value.isEmpty) {
            return "Mobile should not be empty";
          }if(value.length<10){
            return 'Enter valid mobile number';
          }
          return null;
        },
        onSaved: (value) => mobileController.text = value,
      ),
    );
  }

  Widget _showAddress() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new Container(
        color: Colors.transparent,
        child: new TextFormField(
          inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]"))],
          controller: addressController,
          //enabled: false,
          maxLines: 1,
          cursorColor: Colors.lightBlue,
          textInputAction: TextInputAction.done,
          maxLength: 50,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            color: Colors.black,fontFamily: 'Montserrat'),
          decoration: new InputDecoration(
            border:new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[300]),
            ),
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "Address",
            counterText: "",
          ),
          focusNode: addressFocus,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(latFocus);
          },
          validator: (value) {

            return null;
          },
          onSaved: (value) => addressController.text = value,
        ),
      ));
  }
  Widget _showBranch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new TextFormField(
        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]"))],
        controller: branchController,
        maxLines: 1,
        cursorColor: Colors.lightBlue,
        textInputAction: TextInputAction.go,
        maxLength: 50,
        style: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black,fontFamily: 'Montserrat'),
        decoration: new InputDecoration(
          border:new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey[300]),
          ),
          labelStyle: TextStyle(color: Colors.grey),
          labelText: "Branch",
          counterText: "",
        ),
        focusNode: branchFocus,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(addressFocus);
        },
        validator: (value) {

          return null;
        },
        onSaved: (value) => branchController.text = value,
      ),
    );
  }

  Widget _showClass() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new Container(
        color: Colors.transparent,
        child: new TextFormField(
          controller: classController,
          //enabled: false,
          maxLines: 1,
          cursorColor: Colors.lightBlue,
          textInputAction: TextInputAction.go,
          maxLength: 50,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            color: Colors.black,fontFamily: 'Montserrat'),
          decoration: new InputDecoration(
            border:new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[300]),
            ),
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "Class",
            counterText: "",
          ),
          focusNode: classFocus,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(branchFocus);
          },
          validator: (value) {
            return null;
          },
          onSaved: (value) => classController.text = value,
        ),
      ));
  }

  Widget _showLat() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new Container(
        color: Colors.transparent,
        child: new TextFormField(
          controller: latController,
          //enabled: false,
          maxLines: 1,
          cursorColor: Colors.lightBlue,
          textInputAction: TextInputAction.go,
          maxLength: 50,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            color: Colors.black,fontFamily: 'Montserrat'),
          decoration: new InputDecoration(
            border:new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[300]),
            ),
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "Lattitude",
            counterText: "",
          ),
          focusNode: latFocus,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(langFocus);
          },
          validator: (value) {

            return null;
          },
          onSaved: (value) => latController.text = value,
        ),
      ));
  }
  Widget _showLong() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: new Container(
        color: Colors.transparent,
        child: new TextFormField(
          controller: langController,
          //enabled: false,
          maxLines: 1,
          cursorColor: Colors.lightBlue,
          textInputAction: TextInputAction.done,
          maxLength: 50,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            color: Colors.black,fontFamily: 'Montserrat'),
          decoration: new InputDecoration(
            border:new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.grey[300]),
            ),
            labelStyle: TextStyle(color: Colors.grey),
            labelText: "Longitude",
            counterText: "",
          ),
          focusNode: langFocus,
          validator: (value) {

            return null;
          },
          onSaved: (value) => langController.text = value,
        ),
      ));
  }

  Widget _showRegisterButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      margin: EdgeInsets.only(top: 10.0, bottom: 16.0, right: 32.0, left: 32.0),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: new Material(
        child: MaterialButton(
          child: Text(
            "Register Now",
            style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Colors.white, fontSize: 18.0,fontFamily: 'Montserrat'),
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _validateAndSave(context);
          },
          highlightColor: Colors.purple,
          splashColor: Colors.red,
        ),
        color: Colors.brown,
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }


  Future<bool> _validateAndSave(context) async {

    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      DateTime now = DateTime.now().toUtc();
      //String currentDate = DateFormat('MM/dd/yyyy HH:mm').format(now);
      List userList = await db.getUserWithEmailID(emailController.text);
    if(userList.length==0){
        db.saveUser(User(nameController.text, emailController.text, mobileController.text, classController.text,branchController.text, addressController.text,latController.text,langController.text)).then((_) {
          // Navigator.pop(context, 'Home');
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/welcome', (Route<dynamic> route) => false);
          Toast.show("Register successfully!", context);
        });
      }else{
        Toast.show("User already Exits.", context);
      }

      return true;
    }
    return false;
  }

}
