# DeepDetect: Open Source Deep Learning Platform (Changelog)

## 0.13.0 (2021-02-03)


### Features

* **deepdetect:** upgrade to v0.13.0 ([7a3b808](https://github.com/jolibrain/dd_platform_docker/commit/7a3b80847b8a1a36dd2af2331fda67363a5ee01e))
* **platform_ui:** upgrade to v0.13.0 ([b9904c1](https://github.com/jolibrain/dd_platform_docker/commit/b9904c17f15f09557407ae7a5c2ffa688dd6e4bd))

## 0.12.0 (2021-01-09)


### Features

* **deepdetect:** upgrade to v0.12.0 ([a96b7e8](https://github.com/jolibrain/dd_platform_docker/commit/a96b7e8e50256dbc3a1c2fd2c2f41023d6efcc70))
* **platform_ui:** upgrade to v0.11.0 ([3b2054f](https://github.com/jolibrain/dd_platform_docker/commit/3b2054f662e80dece33bfa206b9a99256349a36d))
* allow jupyter to access to GPUs ([f146ab9](https://github.com/jolibrain/dd_platform_docker/commit/f146ab92adc878167f65861a1de01e5e0bea328f))


### Bug Fixes

* add /docker-tags nginx location to list available platorm_ui images on dockerhub, and eventually notify about possible update ([64277a4](https://github.com/jolibrain/dd_platform_docker/commit/64277a41cfb2115c5291fe24f5a8146bcc381b90))
* gpu platform had cpu deepdetect ([c3307a3](https://github.com/jolibrain/dd_platform_docker/commit/c3307a33287f0f97c13ad49b35501a6bc8d7f41c))

## 0.11.0 (2020-11-10)


### Features

* **deepdetect:** upgrade to v0.11.0 ([edc32a9](https://github.com/jolibrain/dd_platform_docker/commit/edc32a90b8c1aa489965f93961046e08eb03d6cb))
* **platform_ui:** upgrade to v0.10.0 ([1b569bd](https://github.com/jolibrain/dd_platform_docker/commit/1b569bdb1fe45dbf40d761945471157553563cf9))
* add --platform-ui-only flag to only update platform_ui container ([c18c165](https://github.com/jolibrain/dd_platform_docker/commit/c18c1653c5ee2756f93d5b2fae8789c6a6e3c58e))
* add dozzle log viewer for docker containers ([df181b0](https://github.com/jolibrain/dd_platform_docker/commit/df181b0678340e2f6c2499eb5258c1bb32286cb9)), closes [#14](https://github.com/jolibrain/dd_platform_docker/issues/14)
* allow to configure server & ui tag ([3c73ccc](https://github.com/jolibrain/dd_platform_docker/commit/3c73ccc3c1f8c77e716230aac4a40b4340a6e2ee))
* block HTTP DELETE method on filebrowser by default ([370b0c5](https://github.com/jolibrain/dd_platform_docker/commit/370b0c5079fa82f24a1b6837afe06c95e308dd3d))
* install last dd_client ([3eb4269](https://github.com/jolibrain/dd_platform_docker/commit/3eb4269f92015f6e832b154487fe078dbfd5abf3))
* upgrade filebrowser 1.10.0 -> 2.9.0 ([c5c1b52](https://github.com/jolibrain/dd_platform_docker/commit/c5c1b5245d70b2ee16845469c0a4cc44dd4aba79))
* **tests:** add more debug information ([d7633f9](https://github.com/jolibrain/dd_platform_docker/commit/d7633f9c9fe1c4f6c44699020d87410dd062b56e))


### Bug Fixes

* add default maxDepth to 1 for DataRepositoriesStore path exploration ([efbfae0](https://github.com/jolibrain/dd_platform_docker/commit/efbfae0e4191abc068db0772dcb840abe0d7c52c))
* add empty notebooks directory to avoid permission issue with platform_data container ([888b4fe](https://github.com/jolibrain/dd_platform_docker/commit/888b4fe74e3eedc56611da6aedb5dfcf5b29977c))
* add empty version.json file to avoid directory creation by docker when this file is missing ([7be8d96](https://github.com/jolibrain/dd_platform_docker/commit/7be8d96ad68862626999ebc4881a0c05aae86d71))
* add examples/ folder to avoid permission issues ([18a33b8](https://github.com/jolibrain/dd_platform_docker/commit/18a33b8071161a009efeb123794e0be681b46b57))
* add exec flag on update.sh scripts ([b672619](https://github.com/jolibrain/dd_platform_docker/commit/b6726193dc33b278906cb3c1a3219d59c23933fa))
* add filebrowser database.db in config folder ([706ec78](https://github.com/jolibrain/dd_platform_docker/commit/706ec7876e33c1d1ff93a519ec956a0ca8f8a79d))
* add git pull in update.sh ([93b3f6e](https://github.com/jolibrain/dd_platform_docker/commit/93b3f6e9401d5b8197cf54a89e524f9287fdb365))
* add jsonPath in platform_ui config for compatibility with latest platform_ui version ([4d53aea](https://github.com/jolibrain/dd_platform_docker/commit/4d53aead1551b4ff369fa08f3dabaca05f7136ca))
* add missing dep between nginx and dozzle ([65fc8e9](https://github.com/jolibrain/dd_platform_docker/commit/65fc8e97982e8fa05d49c10fc45218a5b5cfb0dd))
* add models/ folder to avoid permission issues ([d1f14f9](https://github.com/jolibrain/dd_platform_docker/commit/d1f14f9119d7fcedf655bde410efef47b18ae955))
* add nginx json routes to support new platform_ui version ([6faf595](https://github.com/jolibrain/dd_platform_docker/commit/6faf595422b5a5229a74bf85cc7c67450763c8b1))
* add placeholders in platform_ui config file to avoid exeption ([7104c4a](https://github.com/jolibrain/dd_platform_docker/commit/7104c4a25372906208e9d52123069f9a00105b6c))
* add user on docs container ([3b4bce3](https://github.com/jolibrain/dd_platform_docker/commit/3b4bce394a1e3e3d1b69847651fca96634be271e))
* add version.json file in order to start docker-compose from scratch ([439a410](https://github.com/jolibrain/dd_platform_docker/commit/439a4105ce83f4c283e2e391b32f658fe15bdd83))
* change linkJupyter in platform_ui config.json ([383a939](https://github.com/jolibrain/dd_platform_docker/commit/383a93981c2cfb286abf62bcf0c1dd130c170749))
* change README title ([caf3700](https://github.com/jolibrain/dd_platform_docker/commit/caf3700e7611e817d6fe185ac04d0422544e3d33))
* check version.json file exists during update.sh ([05c060c](https://github.com/jolibrain/dd_platform_docker/commit/05c060ccc5a3f3f265809d76425d1e990b370d71))
* code object for imaginate, sameOrigin support with deepdetect-js v1.7 ([d8eea4c](https://github.com/jolibrain/dd_platform_docker/commit/d8eea4cfc98613313273b6595fbf20b44442efa6))
* code object for imaginate, sameOrigin support with deepdetect-js v1.7 ([896abe1](https://github.com/jolibrain/dd_platform_docker/commit/896abe16acdfca1f16ad909e649b2ae7d566a7d3))
* correct update.sh with docker volume ls ([39bb456](https://github.com/jolibrain/dd_platform_docker/commit/39bb456f0c7283f4111127f62fc408e1a801d3bb))
* empty filebrowser database ([5b598e7](https://github.com/jolibrain/dd_platform_docker/commit/5b598e70066d6a9d6796e1c7ce1d99823c7d2810))
* force nginx to resolve dns name every 1s ([ad77448](https://github.com/jolibrain/dd_platform_docker/commit/ad77448170a330bca90782c9ffcc941ec4a13395)), closes [#2](https://github.com/jolibrain/dd_platform_docker/issues/2)
* ignore filebrowser database changes ([0c8701f](https://github.com/jolibrain/dd_platform_docker/commit/0c8701f594e97c0d3893e8f840b77e74c9c34c13))
* in update.sh, Verify that DD_PLATFORM exists, and set it if not ([ebcf291](https://github.com/jolibrain/dd_platform_docker/commit/ebcf2919448d5ac9fda6af76fd689db5ec022ebf))
* increase timeout ([cbc5e38](https://github.com/jolibrain/dd_platform_docker/commit/cbc5e383ca1ac916a44df5150803f70ec6aecfc9))
* jupiter don't need to be rewrited ([dda42b5](https://github.com/jolibrain/dd_platform_docker/commit/dda42b50809d2e9a51dfa05d3c222b28e5fd73dd)), closes [#26](https://github.com/jolibrain/dd_platform_docker/issues/26)
* jupyter container must be root ([39cfce4](https://github.com/jolibrain/dd_platform_docker/commit/39cfce4ab326ce47ebdb287206e379ea40f6bc9a))
* jupyter docker image url ([c531825](https://github.com/jolibrain/dd_platform_docker/commit/c5318252ec035507893152fe627ab61540e1c724))
* missing chain default config for imaginate ([68fb0e0](https://github.com/jolibrain/dd_platform_docker/commit/68fb0e08d7ddd483dd7d67d3048c8e5559febdd5))
* only add font headers if no location have already matched ([7e12975](https://github.com/jolibrain/dd_platform_docker/commit/7e129756fa515f3bff9081a21f68680a18c63661))
* randomize platform-ui port ([f5bf5f3](https://github.com/jolibrain/dd_platform_docker/commit/f5bf5f31ff3faa86b8597e8bea74c47466a9ace6))
* refactor rules to access static files in /opt/platform ([1767ac1](https://github.com/jolibrain/dd_platform_docker/commit/1767ac1e4f249e3bd2ee32e01736596382251333))
* refactor rules to access static files in /opt/platform ([ac2d289](https://github.com/jolibrain/dd_platform_docker/commit/ac2d289f859ed19de0afdb635be1b35b5be4619e))
* remove container_name in docker-compose.yml ([17390db](https://github.com/jolibrain/dd_platform_docker/commit/17390dbd4aca2713999bfe7478cfdd6d849e0d65))
* remove gpuInfo server in cpu platform_ui config [#32](https://github.com/jolibrain/dd_platform_docker/issues/32) ([1cdb01d](https://github.com/jolibrain/dd_platform_docker/commit/1cdb01d3c86f215742711132356894124c55160b))
* remove useless rewrite api/dozzle rewriting rule ([a934695](https://github.com/jolibrain/dd_platform_docker/commit/a934695206ab0f020d62a7dcea582a36d66c19da)), closes [#29](https://github.com/jolibrain/dd_platform_docker/issues/29)
* use --project-name docker-compose option to setup project name ([d8bb350](https://github.com/jolibrain/dd_platform_docker/commit/d8bb350ba2a08ca4eebec8636bc1c18eb2c4c6ee))
* **filebrowser:** filebrowser need the subpath to work ([6f3171d](https://github.com/jolibrain/dd_platform_docker/commit/6f3171decfe696155a49b9f307cab6f7084cc032)), closes [#24](https://github.com/jolibrain/dd_platform_docker/issues/24)
* **gpu:** rename nginx to platform_ui ([985cc79](https://github.com/jolibrain/dd_platform_docker/commit/985cc791105791e093d4cecee0e14a2830462d72))
* **nginx:** don't cache react app initial page ([7602877](https://github.com/jolibrain/dd_platform_docker/commit/76028774a554347fa132c9dc602b44631ae9fdc8))
* refactor update.sh script to include project_name parameter ([f386a86](https://github.com/jolibrain/dd_platform_docker/commit/f386a86ab809af5f993b1f62172d12fe962e9d9f))
* remove analytics log from cpu nginx config ([dc9e7cc](https://github.com/jolibrain/dd_platform_docker/commit/dc9e7cc44423c4e4c3f957c0ab95e0ceab8ebf41))
* remove container_name from docker-compose.yml ([ce0d2cf](https://github.com/jolibrain/dd_platform_docker/commit/ce0d2cf8d33cf51ef23545e08d8d4fd49467bc48))
* remove named volume in update.sh ([0b9d9ac](https://github.com/jolibrain/dd_platform_docker/commit/0b9d9ac2a41588a8a46347536f08086e7c4e9529))
* remove version.json ([1e9791e](https://github.com/jolibrain/dd_platform_docker/commit/1e9791ec8f29dd05f52f676cbec5d588b2ef9aa4))
* set update.sh number of mandatory args to 0 ([aa7b489](https://github.com/jolibrain/dd_platform_docker/commit/aa7b4891aac7457ef3d56ae49cd846a0916ef478))
* typo in chain platform_ui config ([f0e8157](https://github.com/jolibrain/dd_platform_docker/commit/f0e815753a4fc92b1cfb5f74fc59be93f24cc8fd))
* update nginx and platform-ui config ([9234bb2](https://github.com/jolibrain/dd_platform_docker/commit/9234bb2f0749d5c128af5de0fe17fee85e15f186))
* use $PROJECT_NAME env in docker-compose ([9d201d1](https://github.com/jolibrain/dd_platform_docker/commit/9d201d120c142139ad3f6678ce32e65ec1e205df))
