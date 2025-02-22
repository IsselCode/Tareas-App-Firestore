abstract class TareasFailure {

  String message;

  TareasFailure({
    required this.message
  });

}

class NetworkFailure extends TareasFailure {
  NetworkFailure({required super.message});
}

class FirestoreFailure extends TareasFailure {
  FirestoreFailure({required super.message});
}

class UnknownFailure extends TareasFailure {
  UnknownFailure({required super.message});
}