import 'dart:convert';

import 'package:appnation_spacex_project/model/flight_detail_model.dart';
import 'package:http/http.dart' as http;

class FlightDetailService {
  final String url = "https://api.spacexdata.com/v4/launches/";

  getFlightDetails() async {
    final response = await http.get(Uri.parse(url));
    final length = jsonDecode(response.body).length;

    // SON 5 PATCH, API VERILERINDE NULL O YUZDEN -6'NCI VERIYI KULLANDIM"
    final FlightDetailModel flightDetailModels =
        FlightDetailModel.fromJson(jsonDecode(response.body)[length - 6]);

    return flightDetailModels;
  }
}
