import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fugi_movie_app_team2/src/features/movie_detail/presentation/movie_watchlist_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../search/presentation/widgets/movie_item_widget.dart';
import 'movie_detail_screen.dart';

class WatchlistScreen extends StatefulHookConsumerWidget {
  const WatchlistScreen({Key? key}) : super(key: key);
  static const routeName = 'watchlist-screen';

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends ConsumerState<WatchlistScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final watchlistState = ref.watch(watchlistControllerProvider);

    return SafeArea(
      top: false,
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onVerticalDragDown,
          GestureType.onVerticalDragEnd,
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Watch List'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: watchlistState != null
              ? ListView.builder(
                  itemCount: watchlistState.length,
                  itemBuilder: (context, index) {
                    final watchlist = watchlistState[index];
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        MovieItemWidget(
                          imagePath: watchlist.posterPath,
                          title: watchlist.title,
                          rating: watchlist.voteAverage.toString(),
                          date: DateFormat('dd MMM yyyy').format(DateTime.parse(watchlist.releaseDate.toString())),
                        ),
                        IconButton(
                          color: Colors.red.shade800,
                          onPressed: () {
                            ref.read(watchlistControllerProvider.notifier).removeFromWatchlist(watchlist);
                            setState(() {});
                          },
                          icon: Icon(FontAwesomeIcons.circleXmark),
                        )
                      ],
                    );
                  },
                  padding: EdgeInsets.only(top: 20.0.sp, left: 20.0.sp),
                  // children: const [
                  //   WatchListItem(),
                  //   WatchListItem(),
                  //   WatchListItem(),
                  //   WatchListItem(),
                  // ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

class WatchListItem extends StatelessWidget {
  const WatchListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 95,
            height: 120,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/movie1.png'),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Jurassic World'),
              const SizedBox(
                height: 10,
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.star_border,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '9.5',
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                    // textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.airplane_ticket,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Action',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    // textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '2019',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    // textAlign: TextAlign.start,
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.watch_later,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '139 minutes',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    // textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
