import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/Models/tasbeeh_data.dart';
import 'package:tasbeeh_counter/database/tasbeeh_db.dart';
import 'package:tasbeeh_counter/pages/count_tasbeeh_page.dart';
import 'package:tasbeeh_counter/utils/themes.dart';
import 'package:tasbeeh_counter/widgets/appbar.dart';

class MyCounters extends StatefulWidget {
  const MyCounters({Key? key}) : super(key: key);

  @override
  State<MyCounters> createState() => _MyCountersState();
}

class _MyCountersState extends State<MyCounters> {
  late List<Tasbeeh> tasbeehat;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  dispose() {
    TasbeehDatabase.instance.close();
    super.dispose();
  }

  refresh() async {
    setState(() {
      isLoading = true;
    });
    tasbeehat = await TasbeehDatabase.instance.readTasbeehat();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: MyTheme.cream,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(title: 'Tasbeeh', subTitle: 'Counter'),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : tasbeehat.isEmpty
                          ? Center(
                              child: Text(
                                'Nothing to show\n click + to add.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyTheme.primaryContrast,
                                    fontSize: 16.0),
                              ),
                            )
                          : tasbeehBuilder(),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: fab(),
      );

  Widget tasbeehBuilder() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: tasbeehat.length,
        itemBuilder: (BuildContext context, int index) {
          final int currentCount = tasbeehat[index].currentCount;
          final int totalCount = tasbeehat[index].totalCount;
          final String tasbeehName = tasbeehat[index].counterName;
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TasbeehCounter(
                    tasbeeh: tasbeehat[index],
                  ),
                ),
              ).then((value) => refresh());
            },
            child: Card(
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              margin: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        tasbeehName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '$currentCount/$totalCount',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.0, color: MyTheme.primaryContrast),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          TasbeehDatabase.instance
                              .deleteTasbeeh(tasbeehat[index].id!);
                          refresh();
                        },
                        icon: Icon(
                          Icons.close,
                          color: MyTheme.primaryContrast,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  Widget fab() => Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: MyTheme.primarySwatch,
        ),
        child: InkWell(
          onTap: () async {
            await Navigator.pushNamed(context, 'createTasbeeh')
                .then((value) => refresh());
          },
          child: const Icon(
            Icons.add,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      );
}
