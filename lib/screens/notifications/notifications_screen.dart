import 'package:dreamer/models/dream/dreamer_notification.dart';
import 'package:dreamer/view_models/notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    NotificationsViewModel notificationsViewModel =
        Provider.of<NotificationsViewModel>(context, listen: false);
    _pagingController.addPageRequestListener((pageKey) {
      notificationsViewModel.loadNotifications(pageKey).then(
        (NotificationsViewModel notifications) {
          if (notifications.hasError == true) {
            if (notificationsViewModel.errorStatus == 404) {
              _pagingController.appendLastPage([]);
            } else {
              _pagingController.error = notifications.errorMessage;
            }
          } else {
            if (notifications.notifications.data.next == null) {
              _pagingController.appendLastPage(notifications.notifications.data.results);
            } else {
              _pagingController.appendPage(
                  notifications.notifications.data.results, pageKey + 1);
            }
          }
        },
      );
    });

    super.initState();
  }

  final PagingController<int, DreamerNotification> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            PagedSliverList<int, DreamerNotification>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<DreamerNotification>(
                itemBuilder: (context, item, index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.notifications),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(item.text),
                                  ],
                                ),
                              ),
                              Text(item.createdFormatted)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ],
                ),
                noItemsFoundIndicatorBuilder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Wow such a empty!"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
