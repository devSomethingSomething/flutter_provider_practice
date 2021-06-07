import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building MainPage');
    // This is where the provider starts to be used
    // Also only place it as high up as needed, do not
    // place it higher than it should be
    return ChangeNotifierProvider(
      // Must give it create, then the model class name
      create: (context) => AppData(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            // Old way, now we use provider
            // title: Text('Data Here'),
            // Consumer is the way to go
            // Prevents entire rebuilds
            title: Consumer<AppData>(
              // child: Text(
              // Old way, there is the simpler approach below
              // Provider.of<AppData>(context).name,
              // context.watch<AppData>().name,
              // ),
              builder: (context, value, child) {
                return Text(
                  value.name,
                );
              },
            ),
          ),
          body: Screen2(),
        );
      },
      // So we should not use child, can throw an exception
      // See solution above, use builder instead
      // child: Scaffold(
      //   appBar: AppBar(
      //     // Old way, now we use provider
      //     // title: Text('Data Here'),
      //     title: Text(
      //       Provider.of<AppData>(context).name,
      //     ),
      //   ),
      //   body: Screen2(),
      // ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building Screen2');
    return Container(
      child: Screen3(),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building Screen3');
    return Container(
      child: Screen4(),
    );
  }
}

class Screen4 extends StatelessWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building Screen4');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('Data Here'),
          // Text(
          // Provider.of<AppData>(context).name,
          // context.watch<AppData>().name,
          // ),
          Consumer<AppData>(
            // child: Text(
            // Old way, there is the simpler approach below
            // Provider.of<AppData>(context).name,
            // context.watch<AppData>().name,
            // ),
            builder: (context, value, child) {
              return Text(
                value.name,
              );
            },
          ),
          ElevatedButton(
            // Well this is not part of the widget tree
            onPressed: () {
              // Not part of the widget tree, need to handle this
              // Need to set listen to false for things not part of
              // the widget tree
              // Provider.of<AppData>(context, listen: false)
              //     .changeData('John Doe');
              context.read<AppData>().changeData('Jane Doe');
            },
            child: Text('Change data'),
          ),
        ],
      ),
    );
  }
}

/// Model class, should go in a models folder
class AppData with ChangeNotifier {
  String _name = 'John Rambo';

  void changeData(String data) {
    _name = data;

    // Must call this to notify any listeners
    notifyListeners();
  }

  String get name => _name;
}
