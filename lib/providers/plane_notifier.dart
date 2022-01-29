import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/clients/api_service.dart';
import 'package:riverpod_prac/models/plane_details.dart';
import 'package:riverpod_prac/providers/states.dart';

class PlanNotifier extends StateNotifier<ListState> {
  final ApiService _apiService;

  PlanNotifier(this._apiService) : super(const ListState.loading());

  Future<void> getPlaneDetails() async {
    try {
      state = const ListState.loading();
      final response = await _apiService.instance.get(
        'https://api.instantwebtools.net/v1/passenger',
        queryParameters: {
          'page': 0,
          'size': 20,
        },
      );
      if (response.statusCode == 200) {
        state = ListState.loaded(
          planeDetails: PlaneDetails.fromJson(response.data),
          page: 0,
        );
      } else {
        state = const ListState.error(errorMessage: 'Api Request Failed');
      }
    } catch (err) {
      state = ListState.error(errorMessage: err.toString());
    }
  }

  Future<void> getNextPage() async {
    try {
      final prevState = state as Loaded;
      int page = prevState.page;

      final response = await _apiService.instance.get(
        'https://api.instantwebtools.net/v1/passenger',
        queryParameters: {
          'page': ++page,
          'size': 20,
        },
      );
      if (response.statusCode == 200) {
        final planedeta = PlaneDetails(
            totalPassengers:
                PlaneDetails.fromJson(response.data).totalPassengers,
            totalPages: PlaneDetails.fromJson(response.data).totalPages,
            data: [
              ...prevState.planeDetails.data!,
              ...PlaneDetails.fromJson(response.data).data!
            ]);
        state = ListState.loaded(
          planeDetails: planedeta,
          page: page,
        );
      } else {
        state = const ListState.error(errorMessage: 'Api Request Failed');
      }
    } catch (err) {
      state = ListState.error(errorMessage: err.toString());
    }
  }

  void markFav(int pos) {
    final prevState = state as Loaded;

    prevState.planeDetails.data![pos].isFav =
        !prevState.planeDetails.data![pos].isFav;
    state = ListState.loaded(
        planeDetails: prevState.planeDetails, page: prevState.page);
  }
}
