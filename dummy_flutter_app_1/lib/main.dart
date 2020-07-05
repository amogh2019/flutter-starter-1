import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy App One',
      home: TabbedScaffold(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class NormalScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Dummy App One')),
        body: Center(child: WordGeneratorStatefulWidget()));
  }
}

class WordGeneratorStatefulWidget extends StatefulWidget {
  @override
  _WordGeneratorStatefulWidgetState createState() =>
      _WordGeneratorStatefulWidgetState();
}

class _WordGeneratorStatefulWidgetState
    extends State<WordGeneratorStatefulWidget> {
  final List<WordPair> listOfWordPair = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);

    return _suggestions();
  }

  Widget _suggestions() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return Divider(thickness: 0.5);
        }
        int index = i ~/ 2;
        if (index >= listOfWordPair.length) {
          listOfWordPair.addAll(generateWordPairs().take(10));
        }
        return ListTile(
            title: Center(
                child: Text(listOfWordPair[index].asPascalCase,
                    style: TextStyle(fontSize: 18))));
      },
      padding: const EdgeInsets.all(16),
    );
  }
}

class TabbedScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
          )
        ]),
        tabBuilder: (context, i) {
          if (i == 1) {
            return NormalScaffold();
          }
          return TabbedScaffoldPage(WordPair.random().asPascalCase);
        });
  }
}

class TabbedScaffoldPage extends StatelessWidget {
  TabbedScaffoldPage(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Hello, ' + '$name!',
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navLargeTitleTextStyle),
            CupertinoButton(
              child: Text('This click bait is waiting for you',
                  style:
                      CupertinoTheme.of(context).textTheme.navActionTextStyle),
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) {
                  return ClickBaitDetails(name);
                }));
              },
            )
          ]),
        ),
        navigationBar:
            CupertinoNavigationBar(middle: Text('Welcome to DummyAppOne!')));
  }
}

class ClickBaitDetails extends StatelessWidget {
  const ClickBaitDetails(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Hi $name, These are the clickbait details.',
                style:
                    CupertinoTheme.of(context).textTheme.navActionTextStyle)
          ]),
        ),
        navigationBar: CupertinoNavigationBar(middle: Text('Details')));
  }
}
