import 'dart:async';

class Streams {
  final StreamController _controller = StreamController.broadcast();
  Stream get stream => _controller.stream;

  void triggerMethod() {
    _controller.sink.add(true);
  }
}

final streams = Streams();
