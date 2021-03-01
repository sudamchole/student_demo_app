

class User {
  int _id;
  String _name;
  String _email;
  String _mobile;
  String _class;
  String _branch;
  String _address;
  String _lat;
  String _lang;



  User(this._name, this._email,this._mobile,this._class,this._branch,this._address,this._lat,this._lang);

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._email = obj['email'];
    this._mobile = obj['mobile'];
    this._class = obj['class'];
    this._branch = obj['branch'];
    this._address = obj['address'];
    this._lat = obj['lat'];
    this._lang = obj['lang'];

  }

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get mobile => _mobile;
  String get sClass => _class;
  String get branch => _branch;
  String get address => _address;
  String get lat => _lat;
  String get lang => _lang;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['class'] = _class;
    map['branch'] = _branch;
    map['address'] = _address;
    map['lat'] = _lat;
    map['lang'] = _lang;


    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._email = map['email'];
    this._mobile = map['mobile'];
    this._class = map['class'];
    this._branch = map['branch'];
    this._address = map['address'];
    this._lat = map['lat'];
    this._lang = map['lang'];

  }
}
