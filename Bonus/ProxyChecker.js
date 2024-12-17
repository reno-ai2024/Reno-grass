
/*
------------------------------------------
Coder  : Furqonflynn
Contact: https://t.me/furqonflynn/
GitHub : https://github.com/cmalf/
Script : Proxy Checker
------------------------------------------
*/

const fs = require('fs');
const { exec } = require('child_process');

const cl = {
    gr: '\x1b[32m',
    br: '\x1b[34m',
    red: '\x1b[31m',
    oc: '\x1b[95m',
    am: '\x1b[91m',
    rt: '\x1b[0m'
};

const proxies = fs.readFileSync('proxy.txt', 'utf-8').split('\n').filter(Boolean);
const activeProxies = [];
const inactiveProxies = [];

function checkProxy(proxy) {
  return new Promise((resolve) => {
    const url = 'http://www.google.com';
    exec(`curl -s -o /dev/null -w "%{http_code}" --proxy ${proxy} ${url}`, (error, stdout) => {
      resolve(stdout.trim() === '200');
    });
  });
}

async function checkProxies() {
  for (const proxy of proxies) {
    const isActive = await checkProxy(proxy);
    if (isActive) {
      activeProxies.push(proxy);
      console.log(`${cl.gr}]-> ${cl.rt}Proxy${cl.oc} ${proxy}${cl.gr} is active.\x1b[0m`);
    } else {
      inactiveProxies.push(proxy);
      console.log(`${cl.gr}]-> ${cl.rt}Proxy${cl.am} ${proxy}${cl.red} is not active.\x1b[0m`);
    }
  }

  fs.writeFileSync('proxy_active.txt', activeProxies.join('\n'));
  fs.writeFileSync('proxy_inactive.txt', inactiveProxies.join('\n'));
}

checkProxies().catch(err => console.error(err));

