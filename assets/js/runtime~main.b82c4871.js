(()=>{"use strict";var e,t,r,f,o,a={},n={};function c(e){var t=n[e];if(void 0!==t)return t.exports;var r=n[e]={exports:{}};return a[e].call(r.exports,r,r.exports,c),r.exports}c.m=a,e=[],c.O=(t,r,f,o)=>{if(!r){var a=1/0;for(b=0;b<e.length;b++){r=e[b][0],f=e[b][1],o=e[b][2];for(var n=!0,d=0;d<r.length;d++)(!1&o||a>=o)&&Object.keys(c.O).every((e=>c.O[e](r[d])))?r.splice(d--,1):(n=!1,o<a&&(a=o));if(n){e.splice(b--,1);var i=f();void 0!==i&&(t=i)}}return t}o=o||0;for(var b=e.length;b>0&&e[b-1][2]>o;b--)e[b]=e[b-1];e[b]=[r,f,o]},c.n=e=>{var t=e&&e.__esModule?()=>e.default:()=>e;return c.d(t,{a:t}),t},r=Object.getPrototypeOf?e=>Object.getPrototypeOf(e):e=>e.__proto__,c.t=function(e,f){if(1&f&&(e=this(e)),8&f)return e;if("object"==typeof e&&e){if(4&f&&e.__esModule)return e;if(16&f&&"function"==typeof e.then)return e}var o=Object.create(null);c.r(o);var a={};t=t||[null,r({}),r([]),r(r)];for(var n=2&f&&e;"object"==typeof n&&!~t.indexOf(n);n=r(n))Object.getOwnPropertyNames(n).forEach((t=>a[t]=()=>e[t]));return a.default=()=>e,c.d(o,a),o},c.d=(e,t)=>{for(var r in t)c.o(t,r)&&!c.o(e,r)&&Object.defineProperty(e,r,{enumerable:!0,get:t[r]})},c.f={},c.e=e=>Promise.all(Object.keys(c.f).reduce(((t,r)=>(c.f[r](e,t),t)),[])),c.u=e=>"assets/js/"+({27:"b6dba6d0",53:"935f2afb",85:"1f391b9e",119:"3d45ce62",257:"059960bc",285:"cf286c5c",347:"70378784",374:"d3874e59",392:"c10c0f6f",395:"3e649013",453:"5c12f19a",485:"f7b62a56",490:"6830fa90",508:"258a40b5",514:"1be78505",556:"8deedfb8",671:"0e384e19",789:"6ff1cf3f",897:"f941a00d",918:"17896441",996:"b42990c8"}[e]||e)+"."+{27:"57219b2a",53:"3a337a17",85:"324eb1d3",119:"e970a265",257:"1f1465d3",285:"36d11056",289:"3adf4ac8",339:"ea7d7f66",343:"0365238a",347:"1261b88c",374:"eed5d50f",392:"ee730c0b",395:"12b1d851",453:"8f9c8efd",485:"70bdfb5a",490:"330ade3e",508:"354475d7",514:"832df318",556:"ed3ccb5f",671:"5e70e649",789:"07e73b4e",878:"27baceba",897:"817ff792",918:"baadba73",972:"b370daa7",996:"b3141f31"}[e]+".js",c.miniCssF=e=>{},c.g=function(){if("object"==typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"==typeof window)return window}}(),c.o=(e,t)=>Object.prototype.hasOwnProperty.call(e,t),f={},o="docs:",c.l=(e,t,r,a)=>{if(f[e])f[e].push(t);else{var n,d;if(void 0!==r)for(var i=document.getElementsByTagName("script"),b=0;b<i.length;b++){var u=i[b];if(u.getAttribute("src")==e||u.getAttribute("data-webpack")==o+r){n=u;break}}n||(d=!0,(n=document.createElement("script")).charset="utf-8",n.timeout=120,c.nc&&n.setAttribute("nonce",c.nc),n.setAttribute("data-webpack",o+r),n.src=e),f[e]=[t];var l=(t,r)=>{n.onerror=n.onload=null,clearTimeout(s);var o=f[e];if(delete f[e],n.parentNode&&n.parentNode.removeChild(n),o&&o.forEach((e=>e(r))),t)return t(r)},s=setTimeout(l.bind(null,void 0,{type:"timeout",target:n}),12e4);n.onerror=l.bind(null,n.onerror),n.onload=l.bind(null,n.onload),d&&document.head.appendChild(n)}},c.r=e=>{"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},c.p="/Stir/",c.gca=function(e){return e={17896441:"918",70378784:"347",b6dba6d0:"27","935f2afb":"53","1f391b9e":"85","3d45ce62":"119","059960bc":"257",cf286c5c:"285",d3874e59:"374",c10c0f6f:"392","3e649013":"395","5c12f19a":"453",f7b62a56:"485","6830fa90":"490","258a40b5":"508","1be78505":"514","8deedfb8":"556","0e384e19":"671","6ff1cf3f":"789",f941a00d:"897",b42990c8:"996"}[e]||e,c.p+c.u(e)},(()=>{var e={303:0,532:0};c.f.j=(t,r)=>{var f=c.o(e,t)?e[t]:void 0;if(0!==f)if(f)r.push(f[2]);else if(/^(303|532)$/.test(t))e[t]=0;else{var o=new Promise(((r,o)=>f=e[t]=[r,o]));r.push(f[2]=o);var a=c.p+c.u(t),n=new Error;c.l(a,(r=>{if(c.o(e,t)&&(0!==(f=e[t])&&(e[t]=void 0),f)){var o=r&&("load"===r.type?"missing":r.type),a=r&&r.target&&r.target.src;n.message="Loading chunk "+t+" failed.\n("+o+": "+a+")",n.name="ChunkLoadError",n.type=o,n.request=a,f[1](n)}}),"chunk-"+t,t)}},c.O.j=t=>0===e[t];var t=(t,r)=>{var f,o,a=r[0],n=r[1],d=r[2],i=0;if(a.some((t=>0!==e[t]))){for(f in n)c.o(n,f)&&(c.m[f]=n[f]);if(d)var b=d(c)}for(t&&t(r);i<a.length;i++)o=a[i],c.o(e,o)&&e[o]&&e[o][0](),e[o]=0;return c.O(b)},r=self.webpackChunkdocs=self.webpackChunkdocs||[];r.forEach(t.bind(null,0)),r.push=t.bind(null,r.push.bind(r))})()})();