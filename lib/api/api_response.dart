enum Status {
  Loading,
  Success,
  Error,
  Unauthorized,
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
