enum Status {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isLoaded => this == Status.loaded;
  bool get isError => this == Status.error;
}

class BaseState {
  BaseState({
    this.status = Status.initial,
    this.message = '',
    this.data,
  });

  BaseState.loading({String message = ''})
      : this(
          status: Status.loading,
          message: message,
        );

  BaseState.loaded(dynamic data, {String message = ''})
      : this(
          status: Status.loaded,
          message: message,
          data: data,
        );

  BaseState.error(String message)
      : this(
          status: Status.error,
          message: message,
        );

  BaseState copyWith({
    Status? status,
    String? message,
    dynamic data,
  }) {
    return BaseState(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Status status;
  String message;
  dynamic data;
}
