import 'dart:async';

import 'package:juliaca_store0/domain/model/model.dart';
import 'package:juliaca_store0/presentation/base/base_viewmodel.dart';
import 'package:juliaca_store0/presentation/resources/assets_manager.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';import 'package:easy_localization/easy_localization.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //strem controllers
  final _streamController = StreamController<SlideViewObject>.broadcast();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //output
  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  //private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1.tr(),
            AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2.tr(),
            AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3.tr(),
            AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4.tr(),
            AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onBoardingLogo4)
      ];

  postDataToView() {
    inputSliderViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

//inputs mean the order that our view model recieve from our view
abstract class OnBoardingViewModelInputs {
  goNext(); //when user clicks on right arrow or swipe
  goPrevious(); //when user clicks on left arrow or swipe right
  onPageChanged(int index);

  Sink
      get inputSliderViewObject; //this is the way add data to the stresm ... stream input
}

//outputs mean data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}
