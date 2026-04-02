import 'package:flutter/material.dart';

import '../widgets/error_status_widget.dart';
import '../widgets/loading_status_widget.dart';
import '../widgets/success_status_widget.dart';
import 'status_type.dart';

class StatusWidgetFactory {
  static Widget create(StatusType type, {String message = ''}) {
    switch (type) {
      case StatusType.loading:
        return const LoadingStatusWidget();

      case StatusType.success:
        return SuccessStatusWidget(
          message: message.isEmpty ? 'Success' : message,
        );

      case StatusType.error:
        return ErrorStatusWidget(
          message: message.isEmpty ? 'Something went wrong' : message,
        );
    }
  }
}
