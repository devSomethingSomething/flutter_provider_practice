import 'package:flutter/material.dart';
import 'package:flutter_provider_practice/models/news_data.dart';
import 'package:flutter_provider_practice/widgets/news_card_widget.dart';
import 'package:provider/provider.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NewsData>().fetchData;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {
              context.read<NewsData>().initialValues();

              context.read<NewsData>().fetchData;
            },
          ),
        ],
        title: Text(
          'Top Stories - CBS News',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<NewsData>().fetchData;
        },
        child: Center(
          child: Consumer<NewsData>(
            builder: (context, value, child) {
              return value.map.length == 0 && !value.error
                  ? CircularProgressIndicator()
                  : value.error
                      ? Text(
                          'Something broke somewhere ${value.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: value.map['stories'].length,
                          itemBuilder: (context, index) {
                            return NewsCard(
                              map: value.map['stories'][index],
                            );
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}
