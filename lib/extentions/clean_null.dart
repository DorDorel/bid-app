extension CleanNull<T> on Iterable<T?> {
  Iterable<T> cleanNull<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}
