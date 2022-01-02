import 'dart:async';

import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/domain/usecase/home_usecase.dart';
import 'package:juliaca_store0/presentation/base/base_viewmodel.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  HomeUseCase _homeUseCase;
  final _dataStreCtrl = BehaviorSubject<Data>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {inputState.add(ContentState());
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(null)).fold(
        (l) => inputState
            .add(ErrorState(StateRendererType.fullScreenErrorState, l.message)),
        (r) {
      inputState.add(ContentState());
      inputData.add(r.data);
    });
  }

  @override
  void dispose() {
    _dataStreCtrl.close();
    super.dispose();
  }

  @override
  getHome() {
    _getHome();
  }

  @override
  Sink get inputData => _dataStreCtrl.sink;

  @override
  Stream<Data> get outputData => _dataStreCtrl.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputData;

  getHome();
}

abstract class HomeViewModelOutput {
  Stream<Data> get outputData;
}
