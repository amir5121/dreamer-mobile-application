abstract class Serializable<T> {
  Serializable(Map<String, dynamic> json);

  Object toJson();
}
