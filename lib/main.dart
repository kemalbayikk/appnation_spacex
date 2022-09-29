import 'package:appnation_spacex_project/service/flight_detail_service.dart';
import 'package:appnation_spacex_project/view/flight_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => FlightDetailService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpaceX Flight Details',
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        home: const FlightDetailScreen(),
      ),
    );
  }
}
