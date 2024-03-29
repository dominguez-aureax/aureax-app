import 'package:flutter_test/flutter_test.dart';

void main() {
  test('String.split() splits the string on the delimiter', () {
    var string = 'foo.bar.baz';
    expect(string.split('.'), equals(['foo', 'bar', 'baz']));
  });

  test('String.trem removes surrounding whitespace', () {
    var string = '  foo ';
    expect(string.trim(), equals('foo'));
  });
}
