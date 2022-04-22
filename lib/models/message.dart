class Message {
  String? _messageText;
  String? _subject;
  String? _display;

  Message(
    _messageText,
    _subject,
    _display,
  );

  // method that assign values to respective instance variables
  Message.fromJson(Map<String, dynamic> json) {
    _messageText = json['message'];
    _subject = json['subject'];
    _display = json['display'];
  }

  // accessor methods
  String? get getMessageText {
    return _messageText;
  }

  String? get getSubject {
    return _subject;
  }

  String? get getDisplay {
    return _display;
  }
}
