import 'dart:async';
import 'dart:ffi';

import 'package:flutter_advanced_course/domain/model/model.dart';
import 'package:flutter_advanced_course/domain/usecase/home_usecase.dart';
import 'package:flutter_advanced_course/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  StreamController _bannersStreamController = BehaviorSubject<List<BannerAd>>();
  StreamController _servicesStreamController = BehaviorSubject<List<Service>>();
  StreamController _storesStreamController = BehaviorSubject<List<Store>>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,
      ),
    );

    (await _homeUseCase.execute(Void)).fold(
      (failure) => {
        // left - failure
        inputState.add(
          ErrorState(
            StateRendererType.FULL_SCREEN_ERROR_STATE,
            failure.message,
          ),
        )
      },
      (homeObject) => {
        // right - success
        inputState.add(
          ContentState(),
        ),
        inputState.add(ContentState()),
        inputBanners.add(homeObject.data.banners),
        inputServices.add(homeObject.data.services),
        inputStores.add(homeObject.data.stores),
      },
    );
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInputs {
  Sink get inputStores;
  Sink get inputBanners;
  Sink get inputServices;
}

abstract class HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;
}
