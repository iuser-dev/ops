#!/usr/bin/env -S node --loader=@u6x/jsext --trace-uncaught --expose-gc --unhandled-rejections=strict
export default (func, limit = 20) => {
  var page;
  page = 0;
  return async function*() {
    var r, results;
    results = [];
    while (true) {
      r = (await func(++page, limit));
      yield* r;
      if (r.length < limit) {
        break;
      } else {
        results.push(void 0);
      }
    }
    return results;
  };
};
