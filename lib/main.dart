import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/providers/providers.dart';
import 'package:riverpod_prac/providers/states.dart';
import 'package:riverpod_prac/second_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        SecondPage.routeName: (ctx) => const SecondPage(),
      },
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    ref.read(planeDetailsProvider.notifier).getPlaneDetails();
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(planeDetailsProvider) as Loaded;
      if (state.page != state.planeDetails.totalPages - 1) {
        ref.read(planeDetailsProvider.notifier).getNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(planeDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SecondPage.routeName),
              icon: const Icon(Icons.ac_unit))
        ],
      ),
      body: state.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        loaded: (data) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.read(planeDetailsProvider.notifier).getPlaneDetails();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: data.page == data.planeDetails.totalPages - 1
                  ? data.planeDetails.data!.length
                  : data.planeDetails.data!.length + 1,
              itemBuilder: (ctx, pos) {
                if (pos == data.planeDetails.data!.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListTile(
                  title: Text(
                    '${data.planeDetails.data![pos].id} ',
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(planeDetailsProvider.notifier).markFav(pos);
                    },
                    icon: Icon(data.planeDetails.data![pos].isFav
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                );
              },
            ),
          );
        },
        error: (err) => Center(
          child: Text(err.errorMessage),
        ),
      ),
    );
  }
}
