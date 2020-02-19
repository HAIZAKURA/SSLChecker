# SSLChecker
 🔧 A Node.js (with Shell Script) tool to check your site's SSL status. Used Shell Script is [here](https://github.com/HAIZAKURA/CheckSSL).

[![Author](https://img.shields.io/badge/Author-HAIZAKURA-b68469?style=flat-square)](https://nya.run)
[![License](https://img.shields.io/github/license/HAIZAKURA/SSLChecker?style=flat-square)](./LICENSE)

## Usage

First clone this repo:

```bash
$ git clone https://github.com/HAIZAKURA/SSLChecker.git
$ cd SSLChecker
```

Setup in and run `app.js`  , just like

```bash
$ npm i # or use 'yarn'
$ chmod +x runcheck.sh
$ node app.js
```

Then You can go to `localhost:4000` to check your site's SSL status.

The default check site config is in the `/public/index.html`

```
SSLChecker
├─app.js
├─package.json
├─runcheck.sh
├─results
|    ├─lab.nya.run.json
|    ├─nya.run.json
|    ├─skk.moe.json
|    └─v2ex.com.json
└─public
     └─index.html
```
**Notice: This tool can not work on Windows !**

**Notice: The default Config is for Ubuntu 18.04. If you are using CentOS 7, please edit `runcheck.sh` .**

## Author

**SSLChecker** © [HAIZAKURA](https://nya.run), Released under the [MIT](./LICENSE) License.

> [Personal Website](https://nya.run) · GitHub [@HAIZAKURA](https://github.com/HAIZAKURA) · Twitter [@haizakura_0v0](https://twitter.com/haizakura_0v0) · Telegram [@haizakura](https://t.me/haizakura)

## Thanks

**CheckSSL** © [Sukka](https://github.com/SukkaW), Released under the [MIT](./LICENSE) License.

> [Personal Website](https://skk.moe) · [Blog](https://blog.skk.moe) · GitHub [@SukkaW](https://github.com/SukkaW) · Telegram Channel [@SukkaChannel](https://t.me/SukkaChannel)