import 'dart:async';

class GCompleter<T> implements Completer<T> {
  Completer<T>? _completer;

  GCompleter() {
    _completer = Completer<T>();
  }

  /// The complement of [Completer.isCompleted]
  bool get isNotCompleted => _completer?.isCompleted == false;

  @override
  void complete([FutureOr<T>? value]) {
    _completer?.complete(value);
  }

  @override
  void completeError(Object error, [StackTrace? stackTrace]) {
    _completer?.completeError(error, stackTrace);
  }

  @override
  Future<T> get future => _completer?.future ?? Future<T>.value();

  @override
  bool get isCompleted => _completer?.isCompleted ?? false;
}
