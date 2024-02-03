#!/usr/bin/env -S node --loader=@u6x/jsext --trace-uncaught --expose-gc --unhandled-rejections=strict --experimental-import-meta-resolve
var CAS, CDN, MONTH, TODAY, bind, cdnLs, iter, sslLs, sslMap, upload;

import _CAS from '@alicloud/cas20180713';

import _CDN from '@alicloud/cdn20180510';

import read from '@iuser/read';

import {
  readdirSync,
  existsSync
} from 'fs';

import {
  join
} from 'path';

import pager from './pager';

import wrap from './wrap';

CAS = wrap(_CAS, 'cas');

CDN = wrap(_CDN, 'cdn');

TODAY = new Date().toISOString();

MONTH = '_' + TODAY.slice(0, 7);

iter = function*(exist) {
  var acme, dir, fullchain, i, name, ref;
  acme = '/mnt/www/.acme.sh';
  ref = readdirSync(acme, {
    withFileTypes: true
  });
  for (i of ref) {
    if (i.isDirectory()) {
      ({name} = i);
      if (name.includes('.') && (!exist.has(name))) {
        dir = join(acme, name);
        fullchain = join(dir, 'fullchain.cer');
        if (existsSync(fullchain)) {
          yield ({
            name,
            cert: read(fullchain),
            key: read(join(dir, name.replace('_ecc', '') + '.key'))
          });
        }
      }
    }
  }
};

sslLs = pager(async(currentPage, showSize) => {
  var certificateList;
  ({certificateList} = (await CAS.describeUserCertificateList({showSize, currentPage})));
  return certificateList;
});

upload = (site) => {
  return CAS.createUserCertificate(site);
};

cdnLs = pager(async(pageNumber, pageSize) => {
  var pageData;
  ({
    domains: {pageData}
  } = (await CDN.describeCdnUserDomainsByFunc({
    funcId: 18,
    pageNumber,
    pageSize
  })));
  return pageData;
});

bind = (domainName, certName) => {
  console.log(domainName, certName);
  return CDN.setDomainServerCertificate({
    domainName,
    certName,
    serverCertificateStatus: 'on',
    certType: 'upload'
  });
};

sslMap = async(hostLi) => {
  var bindLi, common, endDate, exist, i, id, li, name, nm, ref, ref1;
  bindLi = (host, cert) => {
    return Promise.all(hostLi(host).map((d) => {
      return bind(d, cert);
    }));
  };
  exist = new Set();
  ref = sslLs();
  for await (i of ref) {
    ({common, name, id, endDate} = i);
    if (TODAY.slice(0, 10) > endDate) {
      await CAS.deleteUserCertificate({
        certId: id
      });
    } else if (name.endsWith(MONTH)) {
      if (common.startsWith('*.')) {
        common = common.slice(2);
      }
      exist.add(common);
      await bindLi(common, name);
    }
  }
  ref1 = iter(exist);
  for (i of ref1) {
    ({name} = i);
    li = hostLi(name);
    if (li.length) {
      nm = name + MONTH;
      i.name = nm;
      await upload(i);
      await bindLi(name, nm);
    }
  }
};

(async() => {
  var domainName, domainStatus, li, ref, x;
  li = [];
  ref = cdnLs();
  for await (x of ref) {
    ({domainStatus, domainName} = x);
    if (domainStatus === 'online') {
      li.push(domainName);
    }
  }
  console.log(li);
  await sslMap((host) => {
    var i, r;
    host = host.replace('_ecc', '');
    console.log(host);
    r = [];
    for (i of li) {
      if (host === i || i.endsWith('.' + host)) {
        r.push(i);
      }
    }
    return r;
  });
})();
