import 'package:juliaca_store0/app/dependency_injection.dart';
import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/domain/usecase/store_details_usecase.dart';
import 'package:juliaca_store0/presentation/base/base_viewmodel.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutPut {
  final _storeDetailsStreCtrl = BehaviorSubject<StoreDetails>();
  StoreDetailsUseCase _storeDetailUseCase ;

  StoreDetailsViewModel(this._storeDetailUseCase);

  @override
  void start() {
    inputState.add(ContentState());
    _storeDetails();
  }

  @override
  void dispose() {
    _storeDetailsStreCtrl.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreCtrl.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreCtrl.stream.map((storeDetails) => storeDetails);


  @override
  storeDetails() {
    _storeDetails();
  }
  void _storeDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeDetailUseCase.execute(1)).fold(
        (l) => inputState
            .add(ErrorState(StateRendererType.fullScreenErrorState, l.message)),
        (r) {
      inputState.add(ContentState());
      inputStoreDetails.add(r);
    });
  }
}

abstract class StoreDetailsViewModelInput {
  storeDetails();
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutPut {
  Stream<StoreDetails> get outputStoreDetails;
}
