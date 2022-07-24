import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliver AppBar',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFEDF2F8),
            title: const Text(
              'Sliver AppBar',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            expandedHeight: 250,
            floating: _floating,
            snap: _snap,
            pinned: _pinned,
            stretch: true,
            leading: IconButton(
              tooltip: 'Home',
              onPressed: () {},
              icon: const Icon(Icons.home_outlined),
            ),
            leadingWidth: 20,
            actions: [
              IconButton(
                  tooltip: 'Favourite',
                  onPressed: () {},
                  padding: const EdgeInsets.all(15),
                  icon: const Icon(Icons.favorite)),
              IconButton(
                  tooltip: 'Search',
                  onPressed: () {},
                  padding: const EdgeInsets.all(15),
                  icon: const Icon(Icons.search_sharp)),
              IconButton(
                  tooltip: 'list',
                  onPressed: () {},
                  padding: const EdgeInsets.all(15),
                  icon: const Icon(Icons.list_outlined))
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const [
                StretchMode.blurBackground,
                // StretchMode.zoomBackground,
                StretchMode.fadeTitle
              ],
              background: Image.network(
                  "https://images.unsplash.com/photo-1603785608232-44c43cdc0d70?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDY4fEo5eXJQYUhYUlFZfHxlbnwwfHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.cover),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effact.'),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              color: index.isOdd ? Colors.white : Colors.black12,
              height: 100,
              child: Center(
                child: Text(
                  '$index',
                  textScaleFactor: 5,
                ),
              ),
            );
          }, childCount: 30)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('pinned'),
                  Switch(
                      value: _pinned,
                      onChanged: (bool val) {
                        setState(() {
                          _pinned = val;
                        });
                      })
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('snap'),
                  Switch(
                      value: _snap,
                      onChanged: (bool val) {
                        setState(() {
                          _snap = val;
                          _floating = _floating || _snap;
                        });
                      })
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
