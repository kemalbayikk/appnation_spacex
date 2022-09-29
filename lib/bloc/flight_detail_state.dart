part of 'flight_detail_bloc.dart';

@immutable
abstract class FlightDetailState {}

class FlightDetailLoadingState extends FlightDetailState {}

class FlightDetailErrorState extends FlightDetailState {
  final String message;
  FlightDetailErrorState(this.message);
}

class FlightDetailGotState extends FlightDetailState {
  final FlightDetailModel flightDetailModel;
  FlightDetailGotState(this.flightDetailModel);
}

class FlightDetailRefreshingState extends FlightDetailState {}
