extension NestedListExtension on Iterable<Iterable> {
  Iterable<T> flatten<T>() {
    return expand<T>((element) => element.cast<T>()).toList();
  }
}
