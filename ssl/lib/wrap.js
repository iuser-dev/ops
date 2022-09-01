  //!/usr/bin/env coffee
import {
  RuntimeOptions
} from '@alicloud/tea-util';

import OpenApi from '@alicloud/openapi-client';

import {
  Config
} from '@alicloud/openapi-client';

import KEY from '../KEY.mjs';

export default (mod, name) => {
  var _mod, bind, cas, k, r, ref, runtime, v, x;
  ({
    default: _mod
  } = mod);
  runtime = new RuntimeOptions({});
  cas = new _mod(new Config({
    endpoint: name + '.aliyuncs.com',
    ...KEY
  }));
  bind = (name, k) => {
    var func, req;
    func = cas[name + 'WithOptions'];
    req = mod[k];
    return async(o) => {
      var r;
      r = (await func.call(cas, new req(o), runtime));
      return r.body;
    };
  };
  r = {};
  ref = Object.entries(mod);
  for (x of ref) {
    [k, v] = x;
    if (k.endsWith('Request')) {
      name = k[0].toLowerCase() + k.slice(1, -7);
      r[name] = bind(name, k);
    }
  }
  return r;
};
