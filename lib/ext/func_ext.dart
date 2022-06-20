

tryCatch(Function tryFunc, {Function(Object o, StackTrace s)? catchFunc, Function? finallyFunc}) {
  try {
    tryFunc.call();
  } catch (e, s) {
    catchFunc?.call(e, s);
  } finally {
    finallyFunc?.call();
  }
}
