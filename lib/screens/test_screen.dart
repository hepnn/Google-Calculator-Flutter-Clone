import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/const.dart';
import '../models/historyitem.dart';
import '../provider/calculator_provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final List<HistoryItem> result = Hive.box<HistoryItem>('history')
        .values
        .toList()
        .reversed
        .toList()
        .cast<HistoryItem>();
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SlidingUpPanel(
            minHeight: 350,
            maxHeight: 750,
            panel: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xff2d2f33),
                    child: result.isEmpty
                        ? Center(
                            child: Text(
                              'Empty!',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 12.0),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(10.0),
                            itemCount: result.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 10),
                            itemBuilder: (BuildContext context, int i) {
                              return ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                tileColor: buttonsBackgroundColor,
                                title: Text(result[i].title),
                                subtitle: Text(result[i].subtitle),
                              );
                            },
                          ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  width: mediaQuery.width,
                  height: mediaQuery.height * .45,
                  padding: EdgeInsets.symmetric(
                    vertical: mediaQuery.width * 0.08,
                    horizontal: mediaQuery.width * 0.06,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 20.0,
                        child: ListView(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Consumer<CalculatorProvider>(
                              builder: (context, equation, child) => Text(
                                equation.equation,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Consumer<CalculatorProvider>(
                        builder: (context, equation, child) => Text(
                          equation.result,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 30,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Container(
              child: Text('Hello'),
              color: Colors.black,
            ),
            slideDirection: SlideDirection.DOWN,
          ),
          Expanded(
            child: Container(
              color: buttonsBackgroundColor,
              width: double.infinity,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(15.0),
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.3,
                mainAxisSpacing: 9.0,
                crossAxisCount: 4,
                children: buttons,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
