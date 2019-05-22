curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a45%7c11219%7c10.42.2.37%7cbegin%7cwe-ts2019.sh%20release%3a%202.0.6-ci.13%20start._____________________ -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a45%7c11219%7c10.42.2.37%7cdependencies%7cInstall%20sshpass... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a45%7c11219%7c10.42.2.37%7crepo_source%7c%20Lost%2c%20HTTP%3a000%20%3d%20http%3a%2f%2flocalhost%3a8181%2fsshpass-1.06-2.el7.x86_64.rpm -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a46%7c11219%7c10.42.2.37%7crepo_source%7cFound%2c%20HTTP%3a200%20%3d%20http%3a%2f%2fmirror.centos.org%2fcentos%2f7%2fextras%2fx86_64%2fPackages%2fsshpass-1.06-2.el7.x86_64.rpm -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a46%7c11219%7c10.42.2.37%7cdownload%7chttp%3a%2f%2fmirror.centos.org%2fcentos%2f7%2fextras%2fx86_64%2fPackages%2fsshpass-1.06-2.el7.x86_64.rpm... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a46%7c11219%7c10.42.2.37%7cdownload%7cSuccess%3a%20sshpass-1.06-2.el7.x86_64.rpm -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a46%7c11219%7c10.42.2.37%7cdependencies%7cInstall%20jq... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a46%7c11219%7c10.42.2.37%7crepo_source%7c%20Lost%2c%20HTTP%3a000%20%3d%20http%3a%2f%2flocalhost%3a8181%2fjq-linux64 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a47%7c11219%7c10.42.2.37%7crepo_source%7cFound%2c%20HTTP%3a302%20%3d%20https%3a%2f%2fgithub.com%2fstedolan%2fjq%2freleases%2fdownload%2fjq-1.5%2fjq-linux64 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a47%7c11219%7c10.42.2.37%7cdownload%7chttps%3a%2f%2fgithub.com%2fstedolan%2fjq%2freleases%2fdownload%2fjq-1.5%2fjq-linux64... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a48%7c11219%7c10.42.2.37%7cdownload%7cSuccess%3a%20jq-linux64 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a49%7c11219%7c10.42.2.37%7cpe_license%7cIDEMPOTENCY%3a%20Checking%20PC%20API%20responds%2c%20curl%20failures%20are%20acceptable... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a52%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%201%2f2%3d000%3a%20sleep%200%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a55%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%202%2f2%3d000%3a%20sleep%200%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a58%7c11219%7c10.42.2.37%7cprism_check%7cWarning%2077%20%40PC%3a%20Giving%20up%20after%203%20tries. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a58%7c11219%7c10.42.2.37%7cpe_license%7cValidate%20EULA%20on%20PE%3a%20_test%3d%7c%7c -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a50%3a59%7c11219%7c10.42.2.37%7cpe_license%7cDisable%20Pulse%20in%20PE%3a%20_test%3d%7c%7c -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a04%7c11219%7c10.42.2.37%7cpe_init%7cConfigure%20SMTP -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a17%7c11219%7c10.42.2.37%7cpe_init%7cConfigure%20NTP -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a24%7c11219%7c10.42.2.37%7cpe_init%7cRename%20default%20container%20to%20Default -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a34%7c11219%7c10.42.2.37%7cpe_init%7cRename%20default%20storage%20pool%20to%20SP01 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a44%7c11219%7c10.42.2.37%7cpe_init%7cCheck%20if%20there%20is%20a%20container%20named%20Images%2c%20if%20not%20create%20one -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a49%7c11219%7c10.42.2.37%7cpe_init%7cContainer%20Images%20exists -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a49%7c11219%7c10.42.2.37%7cpe_init%7cSet%20Data%20Services%20IP%20address%20to%2010.42.100.38 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a51%3a56%7c11219%7c10.42.2.37%7cnetwork_configure%7cRemove%20Rx-Automation-Network... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a00%7c11219%7c10.42.2.37%7cnetwork_configure%7cCreate%20primary%20network%3a%20Name%3a%20Primary%2c%20VLAN%3a%200%2c%20Subnet%3a%2010.42.100.1%2f25%2c%20Domain%3a%20NTNXLAB%2c%20Pool%3a%2010.42.100.50%20to%2010.42.100.125 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a04%7c11219%7c10.42.2.37%7cnetwork_configure%7cCreate%20secondary%20network%3a%20Name%3a%20Secondary%2c%20VLAN%3a%201001%2c%20Subnet%3a%2010.42.100.129%2f25%2c%20Pool%3a%2010.42.100.132%20to%2010.42.100.229 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a08%7c11219%7c10.42.2.37%7cauthentication_source%7cPC_VERSION%205.10.2%20%3e%3d%205.9%2c%20setting%20AutoDC-2.0... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a10%7c11219%7c10.42.2.37%7cdns_check%7cError%2044%3a%20result%20was%209%3a%20%3b%3b%20connection%20timed%20out%3b%20no%20servers%20could%20be%20reached -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a10%7c11219%7c10.42.2.37%7cauthentication_source%7cAutoDC2.IDEMPOTENCY%20failed%2c%20no%20DNS%20record%20dc.ntnxlab.local -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a10%7c11219%7c10.42.2.37%7crepo_source%7cConvenience%3a%20omitted%20package%20argument%2c%20added%20package%3d -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a10%7c11219%7c10.42.2.37%7crepo_source%7c%20Lost%2c%20HTTP%3a000%20%3d%20http%3a%2f%2flocalhost%3a8181%2fAutoDC2.qcow2 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a10%7c11219%7c10.42.2.37%7crepo_source%7cFound%2c%20HTTP%3a200%20%3d%20http%3a%2f%2f10.42.8.50%2fimages%2fAutoDC2.qcow2 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a10%7c11219%7c10.42.2.37%7cauthentication_source%7cImport%20AutoDC2%20image%20from%20http%3a%2f%2f10.42.8.50%2fimages%2fAutoDC2.qcow2... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a20%7c11219%7c10.42.2.37%7cauthentication_source%7cCreate%20AutoDC2%20VM%20based%20on%20AutoDC2%20image -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a22%7c11219%7c10.42.2.37%7cauthentication_source%7cPower%20on%20AutoDC2%20VM... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a30%7c11219%7c10.42.2.37%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d255%2c%20_host%3d10.42.100.40 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a30%7c11219%7c10.42.2.37%7cauthentication_source%7c_test%201%2f40%3d%7c2019-03-11%2017%3a52%3a30%7c11219%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d255%2c%20_host%3d10.42.100.40%7c%3a%20sleep%2010%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a43%7c11219%7c10.42.2.37%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d255%2c%20_host%3d10.42.100.40 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a43%7c11219%7c10.42.2.37%7cauthentication_source%7c_test%202%2f40%3d%7c2019-03-11%2017%3a52%3a43%7c11219%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d255%2c%20_host%3d10.42.100.40%7c%3a%20sleep%2010%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a53%7c11219%7c10.42.2.37%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d255%2c%20_host%3d10.42.100.40 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a52%3a53%7c11219%7c10.42.2.37%7cauthentication_source%7c_test%203%2f40%3d%7c2019-03-11%2017%3a52%3a53%7c11219%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d255%2c%20_host%3d10.42.100.40%7c%3a%20sleep%2010%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a03%7c11219%7c10.42.2.37%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d3%2c%20_host%3d10.42.100.40 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a03%7c11219%7c10.42.2.37%7cauthentication_source%7c_test%204%2f40%3d%7c%20%2a%20status%3a%20stopped%0a2019-03-11%2017%3a53%3a03%7c11219%7cremote_exec%7cError%2022%3a%20pwd%3d%2fhome%2fnutanix%2c%20_test%3d3%2c%20_host%3d10.42.100.40%7c%3a%20sleep%2010%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a14%7c11219%7c10.42.2.37%7cauthentication_source%7cAutoDC2%20is%20ready. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a24%7c11219%7c10.42.2.37%7cauthentication_source%7cCreate%20Reverse%20Lookup%20Zone%20on%20AutoDC2%20VM... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a41%7c11219%7c10.42.2.37%7cauthentication_source%7cSuccess%3a%20DNS%20record%20dc.ntnxlab.local%20set. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a51%7c11219%7c10.42.2.37%7cpe_auth%7cAdjusted%20directory-url%3dldap%3a%2f%2f10.42.100.40%3a389%20because%20AOS-5.10.2%20%3e%3d%205.9 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a51%7c11219%7c10.42.2.37%7cpe_auth%7cConfigure%20PE%20external%20authentication -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a53%3a56%7c11219%7c10.42.2.37%7cpe_auth%7cConfigure%20PE%20role%20map -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a01%7c11219%7c10.42.2.37%7cpc_install%7cIDEMPOTENCY%3a%20Checking%20PC%20API%20responds%2c%20curl%20failures%20are%20acceptable... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a04%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%201%2f2%3d000%3a%20sleep%200%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a07%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%202%2f2%3d000%3a%20sleep%200%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a10%7c11219%7c10.42.2.37%7cprism_check%7cWarning%2077%20%40PC%3a%20Giving%20up%20after%203%20tries. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a10%7c11219%7c10.42.2.37%7cpc_install%7cGet%20cluster%20network%20and%20storage%20container%20UUIDs... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a15%7c11219%7c10.42.2.37%7cpc_install%7cPrimary%20network%20UUID%3a%2084f854ca-e65a-4ba4-8e84-7c3061c33c42 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a15%7c11219%7c10.42.2.37%7cpc_install%7cDefault%20storage%20container%20UUID%3a%20118bd727-366f-418f-8686-e3434b18e6bd -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a25%7c11219%7c10.42.2.37%7cpc_install%7cPC-5.10.2%20not%20completed.%20 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a25%7c11219%7c10.42.2.37%7cntnx_download%7cRetrieving%20download%20metadata%20pcdeploy-5.10.2.json%20... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a25%7c11219%7c10.42.2.37%7cdownload%7chttp%3a%2f%2f10.42.8.50%2fimages%2fpcdeploy-5.10.2.json... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a25%7c11219%7c10.42.2.37%7cdownload%7cSuccess%3a%20pcdeploy-5.10.2.json -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a26%7c11219%7c10.42.2.37%7cntnx_download%7cRetrieving%20Nutanix%20PRISM_CENTRAL_DEPLOY%20bits... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a26%7c11219%7c10.42.2.37%7cdownload%7chttp%3a%2f%2f10.42.8.50%2fimages%2feuphrates-5.10.2-stable-prism_central.tar... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a37%7c11219%7c10.42.2.37%7cdownload%7cSuccess%3a%20euphrates-5.10.2-stable-prism_central.tar -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a54%3a45%7c11219%7c10.42.2.37%7cntnx_download%7cSuccess%3a%20PRISM_CENTRAL_DEPLOY%20bits%20downloaded%20and%20passed%20MD5%20checksum%21 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a58%3a41%7c11219%7c10.42.2.37%7cntnx_download%7cSuccess%21%20Delete%20PRISM_CENTRAL_DEPLOY%20sources%20to%20free%20CVM%20space... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a58%3a41%7c11219%7c10.42.2.37%7cpc_install%7cDeploy%20Prism%20Central%20%28typically%20takes%2017%2b%20minutes%29... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a58%3a45%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%201%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2017%3a59%3a48%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%202%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a00%3a51%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%203%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a01%3a54%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%204%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a02%3a54%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%205%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a03%3a54%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%206%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a04%3a54%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%207%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a05%3a54%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%208%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a06%3a55%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%209%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a07%3a55%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%2010%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a08%3a55%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%2011%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a09%3a55%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%2012%2f40%3d000%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a10%3a55%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%2013%2f40%3d403%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a11%3a59%7c11219%7c10.42.2.37%7cprism_check%7cWarning%3a%20unauthorized%20PC%20user%20or%20password%20on%2010.42.100.39. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a11%3a59%7c11219%7c10.42.2.37%7cprism_check%7cWarning%20%40PC%3a%20Fallback%20on%2010.42.100.39%3a%20try%20initial%20password%20next%20cycle... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a11%3a59%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%2014%2f40%3d401%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a13%3a02%7c11219%7c10.42.2.37%7cprism_check%7cWarning%3a%20unauthorized%20PC%20user%20or%20password%20on%2010.42.100.39. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a13%3a02%7c11219%7c10.42.2.37%7cprism_check%7cWarning%20%40PC-dev%3a%20Fallback%20on%2010.42.100.39%3a%20try%20PE%20cluster%20password%20next%20cycle... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a13%3a02%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%2015%2f40%3d401%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a14%3a04%7c11219%7c10.42.2.37%7cprism_check%7cWarning%3a%20unauthorized%20PC%20user%20or%20password%20on%2010.42.100.39. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a14%3a04%7c11219%7c10.42.2.37%7cprism_check%7cWarning%20%40PC%3a%20Fallback%20on%2010.42.100.39%3a%20try%20initial%20password%20next%20cycle... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a14%3a04%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%2016%2f40%3d401%3a%20sleep%2060%20seconds... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a05%7c11219%7c10.42.2.37%7cprism_check%7c%40PC%3a%20successful. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a05%7c11219%7c10.42.2.37%7ccluster_check%7cPC%3e%3d5.10%2c%20checking%20multicluster%20state... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a05%7c11219%7c10.42.2.37%7cpc_configure%7cSend%20configuration%20scripts%20to%20PC%20and%20remove%3a%20global.vars.sh%20lib.pc.sh%20we-ts2019.sh%20we-lib.common.sh%20release.json -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a05%7c11219%7c10.42.2.37%7cpc_configure%7cOPTIONAL%3a%20Send%20binary%20dependencies%20to%20PC%3a%20bin%2fjq-linux64%20sshpass-1.06-2.el7.x86_64.rpm%20id_rsa.pub -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a06%7c11219%7c10.42.2.37%7cremote_exec%7cOptional%3a%20giving%20up. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a06%7c11219%7c10.42.2.37%7cpc_configure%7cRemote%20asynchroneous%20launch%20PC%20configuration%20script...%20EMAIL%3dnathan.cox%40nutanix.com%20%20%20%20%20PC_HOST%3d10.42.100.39%20PE_HOST%3d10.42.2.37%20PE_PASSWORD%3dtechX2019%21%20%20%20%20%20PC_LAUNCH%3dwe-ts2019.sh%20PC_VERSION%3d5.10.2%20nohup%20bash%20%2fhome%2fnutanix%2fwe-ts2019.sh%20PC -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a07%7c11219%7c10.42.2.37%7cpc_configure%7cPC%20Configuration%20complete%3a%20try%20Validate%20Staged%20Clusters%20now. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a07%7c11219%7c10.42.2.37%7cmain%7cPC%20Configuration%20complete%3a%20Waiting%20for%20PC%20deployment%20to%20complete%2c%20API%20is%20up%21 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a07%7c11219%7c10.42.2.37%7cmain%7cPE%20%3d%20https%3a%2f%2f10.42.2.37%3a9440 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a07%7c11219%7c10.42.2.37%7cmain%7cPC%20%3d%20https%3a%2f%2f10.42.100.39%3a9440 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a07%7c11219%7c10.42.2.37%7cfinish%7c%2fhome%2fnutanix%2fwe-ts2019.sh%20ran%20for%201462%20seconds._____________________ -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a07%7c11219%7c10.42.2.37%7cdependencies%7cSuccess%3a%20found%20jq. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a07%7c11219%7c10.42.2.37%7cfiles_install%7cIDEMPOTENCY%3a%20checking%20for%20afs%20completed... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a10%7c11219%7c10.42.2.37%7ccluster_check%7cCluster%20status%3a%20%7c%7c%2c%20exit%3a%205. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a17%7c11219%7c10.42.2.37%7cfiles_install%7cFiles%203.2.0.1%20not%20completed.%20 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a17%7c11219%7c10.42.2.37%7cntnx_download%7cRetrieving%20download%20metadata%20nutanix-afs-el7.3-release-afs-3.2.0.1-stable-metadata.json%20... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a17%7c11219%7c10.42.2.37%7cdownload%7chttp%3a%2f%2f10.42.8.50%2fimages%2fnutanix-afs-el7.3-release-afs-3.2.0.1-stable-metadata.json... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a18%7c11219%7c10.42.2.37%7cdownload%7cSuccess%3a%20nutanix-afs-el7.3-release-afs-3.2.0.1-stable-metadata.json -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a18%7c11219%7c10.42.2.37%7cntnx_download%7cRetrieving%20Nutanix%20afs%20bits... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a18%7c11219%7c10.42.2.37%7cdownload%7chttp%3a%2f%2f10.42.8.50%2fimages%2fnutanix-afs-el7.3-release-afs-3.2.0.1-stable.qcow2... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a23%7c11219%7c10.42.2.37%7cdownload%7cSuccess%3a%20nutanix-afs-el7.3-release-afs-3.2.0.1-stable.qcow2 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a25%7c11219%7c10.42.2.37%7ccluster_check%7cManual%20join%20PE%20to%20PC%20%3d%20%7cCluster%20registration%20is%20currently%20in%20progress.%20This%20operation%20may%20take%20a%20while.%0a%0a%20%20%20%20Status%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%3a%20true%7c%2c%20exit%3a%200. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a27%7c11219%7c10.42.2.37%7cntnx_download%7cSuccess%3a%20afs%20bits%20downloaded%20and%20passed%20MD5%20checksum%21 -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a30%7c11219%7c10.42.2.37%7ccluster_check%7cCluster%20status%3a%20%7ctrue%7c%2c%20exit%3a%200. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a30%7c11219%7c10.42.2.37%7ccluster_check%7cPE%20to%20PC%20%3d%20cluster%20registration%3a%20successful. -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a15%3a30%7c11219%7c10.42.2.37%7cmain%7cRemote%20asynchroneous%20PC%20Image%20import%20script...%20EMAIL%3dnathan.cox%40nutanix.com%20%20%20%20%20%20%20%20%20%20%20%20PC_HOST%3d10.42.100.39%20PE_HOST%3d10.42.2.37%20PE_PASSWORD%3dtechX2019%21%20%20%20%20%20%20%20%20%20%20%20%20PC_LAUNCH%3dwe-ts2019.sh%20PC_VERSION%3d5.10.2%20nohup%20bash%20%2fhome%2fnutanix%2fwe-ts2019.sh%20IMAGES -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a17%3a26%7c11219%7c10.42.2.37%7cntnx_download%7cSuccess%21%20Delete%20afs%20sources%20to%20free%20CVM%20space... -H 'cache-control: no-cache' -H 'content-length: 0'
sleep 10
curl -s -X POST http://127.0.0.1:8080/2019-03-11%2018%3a17%3a57%7c11219%7c10.42.2.37%7cdependencies%7cWarning%3a%20assuming%20on%20PC%20or%20PE%20VM%2c%20removing%20jq... -H 'cache-control: no-cache' -H 'content-length: 0'