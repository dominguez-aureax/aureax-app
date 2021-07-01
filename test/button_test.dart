import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aureax_app/widget/button.dart';

// Tests createButton custom widget.
void main() {
  testWidgets('createButton creates a simple button',
      (WidgetTester tester) async {
    //Create the widget by telling the tester to build it
    await tester.pumpWidget(const ButtonView());

    // Create the Finder
    var btnFinder = find.byType(ElevatedButton);

    // check that the button is available
    expect(btnFinder, findsOneWidget);
  });
}

class ButtonView extends StatefulWidget {
  const ButtonView({Key? key}) : super(key: key);

  @override
  _ButtonViewState createState() => _ButtonViewState();
}

class _ButtonViewState extends State<ButtonView> {
  static const _appTitle = 'Button View';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _appTitle,
        home: Scaffold(
            appBar: AppBar(
              title: const Text(_appTitle),
            ),
            body: Column(
              children: [
                TextField(
                  controller: controller,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          var todo = todos[index];

                          return Dismissible(
                              key: Key('$todo$index'),
                              onDismissed: (direction) => todos.removeAt(index),
                              background: Container(color: Colors.red),
                              child: ListTile(
                                title: Text(todo),
                              ));
                        })),
                createButton(
                    onPressed: () {
                      todos.add('value');
                    },
                    child: Text('check'),
                    context: context),
              ],
            )));
  }
}
