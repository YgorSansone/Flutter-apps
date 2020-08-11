class Photos{
  int _albumId;
  int _id;
  String _title;
  String _url;
  String _thumbnailUrl;

  Photos(this._albumId, this._id, this._title, this._url, this._thumbnailUrl);

<<<<<<< HEAD
  Map toJson(){
    return{
      "albumId": _albumId,
      "id": _id,
      "title": _title,
      "url": _url,
      "thumbnailUrl": _thumbnailUrl
    };
  }

=======
>>>>>>> c4c3823... Developer
  String get thumbnailUrl => _thumbnailUrl;

  set thumbnailUrl(String value) {
    _thumbnailUrl = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get albumId => _albumId;

  set albumId(int value) {
    _albumId = value;
  }
}