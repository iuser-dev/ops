#!/usr/bin/env coffee

> @alicloud/tea-util > RuntimeOptions
  @alicloud/openapi-client:OpenApi > Config
  ../KEY.mjs

< (mod, name) =>
  {default:_mod} = mod
  runtime = new RuntimeOptions {}

  cas = new _mod(
    new Config({
      endpoint: name+'.aliyuncs.com'
      ...KEY
    })
  )

  bind = (name,k)=>
    func = cas[name+'WithOptions']
    req = mod[k]
    (o)=>
      r = await func.call(
        cas
        new req o
        runtime
      )
      r.body

  r = {}
  for [k,v] from Object.entries(mod)
    if k.endsWith 'Request'
      name = k[0].toLowerCase()+k[1..-8]
      r[name] = bind(name,k)
  r
