// ignore_for_file: depend_on_referenced_packages

import 'package:appnation_spacex_project/model/flight_detail_model.dart';
import 'package:appnation_spacex_project/service/flight_detail_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'flight_detail_event.dart';
part 'flight_detail_state.dart';

class FlightDetailBloc extends Bloc<FlightDetailEvent, FlightDetailState> {
  final FlightDetailService flightDetailService;

  FlightDetailBloc(this.flightDetailService)
      : super(FlightDetailLoadingState()) {
    on<GetFlightDetailEvent>((event, emit) async {
      emit(FlightDetailLoadingState());

      try {
        final flightDetailModel = await flightDetailService.getFlightDetails();
        emit(FlightDetailGotState(flightDetailModel));
      } catch (e) {
        emit(FlightDetailErrorState(e.toString()));
      }
    });

    on<FlightDetailRefreshEvent>((event, emit) async {
      emit(FlightDetailRefreshingState());

      try {
        final flightDetailModel = await flightDetailService.getFlightDetails();
        emit(FlightDetailGotState(flightDetailModel));
      } catch (e) {
        emit(FlightDetailErrorState(e.toString()));
      }
    });
  }
}
