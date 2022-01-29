import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_prac/clients/api_service.dart';
import 'package:riverpod_prac/providers/plane_notifier.dart';
import 'package:riverpod_prac/providers/states.dart';

final planeDetailsProvider = StateNotifierProvider<PlanNotifier, ListState>(
    (ref) => PlanNotifier(ApiService(Dio())));
