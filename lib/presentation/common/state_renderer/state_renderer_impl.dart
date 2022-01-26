import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/data/mapper/mapper.dart';
import 'package:flutter_advanced_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_advanced_course/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading State
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading.tr();

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

// Error State
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

// Content State
class ContentState extends FlowState {
  ContentState();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;

  @override
  String getMessage() => EMPTY;
}

// Empty State
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;

  @override
  String getMessage() => message;
}

// Success State
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.POPUP_SUCCESS_STATE;

  @override
  String getMessage() => message;
}

extension FlowStateExtesion on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function retryActionFunction,
  ) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case SuccessState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_SUCCESS_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return contentScreenWidget;
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(
    BuildContext context,
    StateRendererType stateRendererType,
    String message,
  ) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: () {},
        ),
      ),
    );
  }
}
