import 'dart:core';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(MapEntry<int, E> mapEntry) f) {
    var i = 0;
    
    return map((e) => f(MapEntry(i++, e)));
  }
}