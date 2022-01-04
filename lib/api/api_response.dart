enum Status {
  Loading,
  Success,
  Error,
  Forbidden,
  Empty,
}

class ResponseApi<T> {
  Status status;
  T data;
  ResponseApi({
    required this.status,
    required this.data,
  });
}
