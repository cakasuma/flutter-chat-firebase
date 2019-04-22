class User {
  String _id;
  String _name;
 
  User(this._id, this._name);
 
  User.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
  }
 
  String get id => _id;
  String get name => _name;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
 
    return map;
  }
 
  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
  }
}