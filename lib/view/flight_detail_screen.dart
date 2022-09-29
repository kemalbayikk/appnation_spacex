import 'package:appnation_spacex_project/bloc/flight_detail_bloc.dart';
import 'package:appnation_spacex_project/model/flight_detail_model.dart';
import 'package:appnation_spacex_project/service/flight_detail_service.dart';
import 'package:appnation_spacex_project/utils/loading_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FlightDetailScreen extends StatefulWidget {
  const FlightDetailScreen({super.key});

  @override
  State<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends State<FlightDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider<FlightDetailBloc>(
        create: (context) => FlightDetailBloc(
            RepositoryProvider.of<FlightDetailService>(context))
          ..add(GetFlightDetailEvent()),
        child: BlocBuilder<FlightDetailBloc, FlightDetailState>(
          builder: (context, state) {
            if (state is FlightDetailErrorState) {
              return Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              );
            } else if (state is FlightDetailGotState) {
              return flightDetails(context, state.flightDetailModel);
            }
            return const LoadingScreen();
          },
        ),
      ),
    );
  }

  flightDetails(BuildContext context, FlightDetailModel flightDetailModel) {
    final flightDetailBloc = BlocProvider.of<FlightDetailBloc>(context);

    return RefreshIndicator(
      onRefresh: () async {
        flightDetailBloc.add(FlightDetailRefreshEvent());
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          slivers: [
            const SliverAppBar(
              floating: true,
              backgroundColor: Colors.black,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("SpaceX Latest Launch",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                centerTitle: true,
              ),
            ),
            fixedHeight(),
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 200,
                child: Lottie.network(
                    "https://assets9.lottiefiles.com/packages/lf20_0xy74gsm.json",
                    repeat: true, onLoaded: (composition) {
                  controller.forward();
                }),
              ),
            ),
            fixedHeight(),
            const SliverToBoxAdapter(
                child: Text(
              "Launch Name",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
            fixedHeight(),
            SliverToBoxAdapter(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(0, 39, 254, 1),
                        Color.fromRGBO(130, 0, 255, 1),
                        Color.fromRGBO(215, 3, 255, 1)
                      ])),
              child: Center(
                child: Text(
                  flightDetailModel.name!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )),
            fixedHeight(),
            const SliverToBoxAdapter(
                child: Text(
              "Launch Patches",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
            fixedHeight(),
            SliverToBoxAdapter(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(0, 39, 254, 1),
                        Color.fromRGBO(130, 0, 255, 1),
                        Color.fromRGBO(215, 3, 255, 1)
                      ])),
              child: Center(
                  child: CarouselSlider.builder(
                      itemCount: flightDetailModel.patches!.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          CachedNetworkImage(
                            imageUrl: flightDetailModel.patches![itemIndex]!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const LoadingScreen(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ))),
            )),
            fixedHeight(),
            const SliverToBoxAdapter(
                child: Text(
              "Launch Details",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
            fixedHeight(),
            SliverToBoxAdapter(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(0, 39, 254, 1),
                        Color.fromRGBO(130, 0, 255, 1),
                        Color.fromRGBO(215, 3, 255, 1)
                      ])),
              child: Center(
                child: Text(
                  flightDetailModel.details!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )),
            fixedHeight(),
            const SliverToBoxAdapter(
                child: Text(
              "Local Date",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
            fixedHeight(),
            SliverToBoxAdapter(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(0, 39, 254, 1),
                        Color.fromRGBO(130, 0, 255, 1),
                        Color.fromRGBO(215, 3, 255, 1)
                      ])),
              child: Center(
                child: Text(
                  DateTime.fromMillisecondsSinceEpoch(
                          flightDetailModel.unixDate! * 1000)
                      .toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )),
            fixedHeight(),
            const SliverToBoxAdapter(
                child: Text(
              "Flight Number",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
            fixedHeight(),
            SliverToBoxAdapter(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color.fromRGBO(0, 39, 254, 1),
                        Color.fromRGBO(130, 0, 255, 1),
                        Color.fromRGBO(215, 3, 255, 1)
                      ])),
              child: Center(
                child: Text(
                  flightDetailModel.flightNumber!.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  fixedHeight() => const SliverToBoxAdapter(
        child: SizedBox(
          height: 30,
        ),
      );
}
