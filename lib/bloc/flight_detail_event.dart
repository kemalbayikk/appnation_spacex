part of 'flight_detail_bloc.dart';

@immutable
abstract class FlightDetailEvent {}

class GetFlightDetailEvent extends FlightDetailEvent {}

class FlightDetailRefreshEvent extends FlightDetailEvent {}
