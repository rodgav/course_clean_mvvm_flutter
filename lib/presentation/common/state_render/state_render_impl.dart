import 'package:flutter/material.dart';
import 'package:juliaca_store0/presentation/common/state_render/state_render.dart';
import 'package:juliaca_store0/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
abstract class FlowState {
  StateRendererType getStateRendererType();

  String getmessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading.tr();

  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class SuccessState extends FlowState {
  StateRendererType stateRendererType;
  String title;
  String message;

  SuccessState(this.stateRendererType, this.title, this.message);

  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  @override
  String getmessage() => AppStrings.empty.tr();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getmessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreen,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadinState) {
          showPopUp(context, getStateRendererType(), getmessage());
          return contentScreen;
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getmessage());
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          showPopUp(context, getStateRendererType(), getmessage());
          return contentScreen;
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getmessage());
        }
      case SuccessState:
        dismissDialog(context);
        showPopUp(context, getStateRendererType(), getmessage(),
            title: AppStrings.success.tr());
        return contentScreen;
      case ContentState:
        dismissDialog(context);
        return contentScreen;
      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
            message: getmessage());
      default:
        return contentScreen;
    }
  }

  dismissDialog(BuildContext context) {
    if (_isthereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isthereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = AppStrings.empty}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
            stateRendererType: stateRendererType,
            retryActionFunction: () {},
            message: message,
            title: title)));
  }
}
