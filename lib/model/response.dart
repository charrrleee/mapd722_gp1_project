import '../type.dart';

class GetResponse {
  late final bool success;

  late final int status;
  late final String message;
  late final Map<String, dynamic>? data;

  GetResponse(this.success, this.status, this.message, this.data);
}

class ListResponse {
  final bool success;

  final int status;
  final String message;
  List<Map<String, dynamic>>? list = [];

  ListResponse(this.success, this.status, this.message, {this.list});

  factory ListResponse.fromJson(Dict json) {
    if (json["success"] == true) {
      return ListResponse(
        json["success"],
        json["status"],
        json["message"],
        list: List<Dict>.from(json["data"]),
      );
    } else {
      return ListResponse(
        json["success"],
        json["status"],
        json["message"],
      );
    }
  }
}
