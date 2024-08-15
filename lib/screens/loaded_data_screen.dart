import 'package:flutter/material.dart';
import 'package:intern_test/model/data_model.dart';
import 'package:intern_test/provider/data_provider.dart';
import 'package:provider/provider.dart';

class KeepAlivePage extends StatelessWidget {
  const KeepAlivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cached Tab View'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TabContentWidget(tabKey: 'tab1'),
            TabContentWidget(tabKey: 'tab2'),
          ],
        ),
      ),
    );
  }
}

class TabContentWidget extends StatefulWidget {
  final String tabKey;

  TabContentWidget({required this.tabKey});

  @override
  _TabContentWidgetState createState() => _TabContentWidgetState();
}

class _TabContentWidgetState extends State<TabContentWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return FutureBuilder(
          future: dataProvider.fetchData(widget.tabKey),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DataModel>? data = dataProvider.getData(widget.tabKey);
              return ListView.builder(
                itemCount: data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data![index].title),
                    subtitle: Text(data[index].content),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
