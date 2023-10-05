import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:p2p_clone/dependency_injection/main_injection.dart';
import 'package:p2p_clone/features/loading_feature/presentation/loading_page.dart';
import 'package:p2p_clone/features/main_feature/data/model/car_model.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/auth/auth_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/bloc/cars/cars_bloc.dart';
import 'package:p2p_clone/features/main_feature/presentation/pages/main_page.dart';
import 'package:web_socket_channel/io.dart';

void startWebSocketService() async {
  // Use the compute function to run WebSocket logic in a separate isolate.
  // TODO find a webSocket to add in the url
  // I couldn't fina a webSocket show i wasne't able to test this part
  await compute(backgroundWebSocketService, "ws://*****");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'id',
    'mainNotificationChunnel', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
      true;
  if (!granted) {
    return;
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  isFlutterLocalNotificationsInitialized = true;
}

void showNotification(CarModel car) {
  int id = (DateTime.now().microsecond.toInt() +
      DateTime.now().millisecond.toInt() +
      DateTime.now().second.toInt());
  flutterLocalNotificationsPlugin.show(
    id,
    "${car.make} - ${car.model}",
    "The car is now available",
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: 'notification_icon',
      ),
    ),
  );
}

void backgroundWebSocketService(String url) {
  // Implement WebSocket connection logic here and keep it alive.
  final channel = IOWebSocketChannel.connect(url);

  channel.stream.listen((message) {
    // I think that in this point the message will contain the car that changed it's state from available false to true.
    // So i will fetch a car data in the format of the car
    var car = CarModel.fromJson(message);
    showNotification(car);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  startWebSocketService();
  setupFlutterNotifications();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarsBloc>(
          create: (context) => sl<CarsBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade600,
          ),
          useMaterial3: true,
        ),
        home: const LoadingPage(),
        routes: {
          '/loading': (context) => const LoadingPage(),
          '/home': (context) => const MainPage(),
        },
      ),
    );
  }
}
