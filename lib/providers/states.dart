import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_prac/models/plane_details.dart';

part 'states.freezed.dart';

@freezed
class ListState with _$ListState {
  const factory ListState.loading() = Loading;
  const factory ListState.loaded(
      {required PlaneDetails planeDetails, required int page}) = Loaded;
  const factory ListState.error({required String errorMessage}) = Error;
}
