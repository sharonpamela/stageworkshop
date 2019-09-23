# Bugs, Priorities, and Notes #

---
<!-- MDTOC maxdepth:6 firsth1:0 numbering:0 flatten:0 bullets:1 updateOnSave:1 -->

- [Bugs](#bugs)   
- [Semi-prioritized Backlog with Technical Debt](#semi-prioritized-backlog-with-technical-debt)   
   - [Improved Software Engineering](#improved-software-engineering)   
- [Notes](#notes)   
   - [Push Button Calm](#push-button-calm)   
   - [Citations for other Calm automation](#citations-for-other-calm-automation)   
   - [AutoDC](#autodc)   
   - [NuCLeI](#nuclei)   
      - [nuclei authconfig (run local from container?)](#nuclei-authconfig-run-local-from-container)   
   - [Image Uploading](#image-uploading)   
   - [File servers for container updates](#file-servers-for-container-updates)   
   - [Git](#git)   

<!-- /MDTOC -->
---

# Bugs #

- BUG = AOS 5.9, 5.10: all calm.sh PC service timeout detect/retry
  - 2018-10-24 21:54:23|14165|Determine_PE|Warning: expect errors on lines 1-2, due to non-JSON outputs by nuclei...
  E1024 21:54:24.142107   14369 jwt.go:35] ZK session is nil
  2018/10/24 21:54:24 Failed to connect to the server: websocket.Dial ws://127.0.0.1:9444/icli: bad status: 403
  - @Michael workaround: py-nuclei?
    - ssh nutanix@10.21.78.39 'source /etc/profile; py-nuclei -u admin -p "password" image.list | grep acs'
  - dev :: PC-5.10 bugs: activate Calm, auth, import images
    - ```2018-12-26 16:05:25|96508|calm_enable|Enable Nutanix Calm...
    2018-12-26 16:05:26|96508|calm_enable|_test=||
    2018-12-26 16:05:26|96508|lcm|PC_VERSION 5.10.0.1 >= 5.9, starting LCM inventory...
    2018-12-26 16:05:26|96508|lcm|inventory _test=|500|```
  - PE> ncli multicluster add-to-multicluster external-ip-address-or-svm-ips=$PC_HOST username=admin password=yaknow
  - Notify bart.grootzevert when fixed
  - 2019-02-20 21:28:12|4424|pc_configure|PC>=5.10, manual join PE to PC = |Cluster registration is currently in progress. This operation may take a while.
Error: The username or password entered is incorrect.|

- ADC2 wonky
  - 2019-02-15 16:12:08|20294|pe_auth|Adjusted directory-url=ldap://10.42.23.40:389 because AOS-5.10.0.1 >= 5.9
2019-02-15 16:12:08|20294|pe_auth|Configure PE external authentication
Error: Failed to process server response. Possible reason includes version mismatch between NCLI and Prism Gateway server.
2019-02-15 16:17:12|20294|pe_auth|Configure PE role map
Error: Directory name NTNXLAB does not exist
  - workaround: rerun script, all good.

- FIXED = PC 5.9 authentication regression
  - https://jira.nutanix.com/browse/ENG-180716 = "Invalid service account details" error message is incorrect
    - Fix scheduled for PC 5.10.1
  - Workaround = [AutoDC: Version2](autodc/README.md#Version2)
  - deprecate AutoDC1 for 5.6-8?

# Semi-prioritized Backlog with Technical Debt #

- Linux migration:
  - https://hub.docker.com/u/gittools
    - https://hub.docker.com/r/gittools/gitversion 2 years old: v4.0.0-beta.12 493 MB
    - https://hub.docker.com/r/gittools/gitversion-fullfx
      - latest=linux-4.0.1beta, linux-4.0.0 works on LinuxMint
      - docker pull gittools/gitversion-fullfx:linux{-version}
      - docker run --rm -v "$(pwd):/repo" gittools/gitversion-fullfx:linux{-version} /repo

            docker image inspect $(docker image ls | grep gitversion | awk '{print $3}') > documentation/container.gitversion.$(uname -s).txt

      - Last known good @MacOS from: image inspect (above):
        "Created": "2018-10-24T11:46:33.952190652Z",
        "Container": "404031c17f634908b685d0b1b5f7d015b9f23b6c018a5dc288983306338d8464",
    - https://hub.docker.com/r/gittools/gitversion-dotnetcore
      - https://hub.docker.com/r/asimonf/docker-gitversion-compose/dockerfile
      - https://hub.docker.com/r/pblachut/gitversionindocker/tags
  - How to:
    - check for latest remote container tags
      - How to find all container tags from a remote image registry:
        - https://stackoverflow.com/questions/24481564/how-can-i-find-a-docker-image-with-a-specific-tag-in-docker-registry-on-the-dock

        curl -s -S "https://registry.hub.docker.com/v2/repositories/library/$@/tags/" | jq '."results"[]["name"]' |sort
        - https://stackoverflow.com/questions/28320134/how-to-list-all-tags-for-a-docker-image-on-a-remote-registry
    - purge unused container tags
- Small improvements/bugs:
  - Check DNS for cluster is set
  - Banner: PC-X bug:,@HPOC #
    - PE banner: PUT /PrismGateway/services/rest/v1/application/system_data
    {"type":"WELCOME_BANNER","key":"welcome_banner_status","value":true,"username":"system_data","updatedTimeInUsecs":1550212264611000}
    {"type":"WELCOME_BANNER","key":"welcome_banner_content","value":"Welcome!","username":"system_data","updatedTimeInUsecs":1550212264751000}
  - Add AutoDC to PE DNS, like PC_DNS
  - Duplicate images are already active/uploaded on PC: check on import/inactive?
  - dependencies 'install' 'sshpass' && dependencies 'install' 'jq' || exit 13 everywhere for robustness/parallelization
  - capture NFS URL timeout error message?
  - stage-workshop: load into an array, Round-robin clusters
    - shell-convenience: load cluster array, menu of array index selection
  - tail -f $Branch/workshop.log?
  - Email when PC is ready, point to next steps in guidebook
  - Refactor PC_URL to be an array?
  - LCM inventory (check AOS, PC, and LCM version)
    - Calm 2.6 containers
- Auth + role mappings
  - OpenLDAP is now supported for Self Service on Prism Central: ENG-126217
  - OpenLDAP works fine for authentication, but Prism Central has a problem with anything more than simple RBAC with it.
    - https://jira.nutanix.com/browse/ENG-126217 openldap authentication difference in PC vs PE
      - fixed with PC 5.7.1
  - SSP Admins
  - PE, PC: clear our warnings: resolve/ack issues for cleanliness?
  - Create adminuser2, assign privs, use it instead of base admin user (drop privs/delete at end?)
  - Fix role mappings, logins on PE, PC
    - PE, PC: use RBAC user for APIs, etc.: cluster Admin
    - improve/run autodc/add_group_and_users.sh
    - adminuser01@ntnxlab.local (password = nutanix/4u) can’t login to PE.
      “You are not authorized to access Prism. Please contact the Nutanix administrator.”
      add user01@ntnxlab.local to role mapping, same error as above.
    - PC_Init|Reset PC password to PE password, must be done by nci@PC, not API or on PE
      Error: Password requirements: Should be at least 8 characters long. Should have at least 1 lowercase character(s). Should have at least 1 uppercase character(s). Should have at least 1 digit(s). Should have at least 1 special character(s). Should differ by at least 4 characters from previous password. Should not be from last 5 passwords. Should not have more than 2 same consecutive character(s). Should not be a dictionary word or too simplistic/systematic. Should should have at least one character belonging to 4 out of the 4 supported classes (lowercase, uppercase, digits, special characters).
      2018-10-02 10:56:27|92834|PC_Init|Warning: password not reset: 0.#
- RFE: AOS 5.10.0.1 may need latest or have incompatible AHV release
  - PE: ncli software ls software-type=Hypervisor
    - cluster --version <version.185> --md5sum=<md5 from portal> --bundle=<full path to bundle location on CVM> -p host_upgrade
- RFE: refactor sshpass dependency
  - Sylvain Huguet   https://nutanix.slack.com/archives/C0JSE04TA/p1549918415017800?thread_ts=1549915109.010300&cid=C0JSE04TA
    @mark.lavi jot down a note somewhere that I need to revisit that one with you, maybe providing an alternative version as a Docker container would help. Many people have Docker for Mac/Docker for Windows these days
    Or we can replace that `sshpass` dependancy with a Python script instead, might be another idea.
    Or start with an API call to push an SSH key to the cluster... then ssh should work passwordless.
    Chris Rasmussen
    @shu API call or Python would be preferable, IMO.  More likely that a Python binary already exists on the user's system than Docker.
    Sylvain Huguet: Docker has other added benefits in terms of packaging sources/binaries with the script and using the docker hub as a CDN/delivery mechanism, especially with Big Bang happening. But we can at least provide alternative method to `sshpass` based on some logic to identify what’s available on the machine.
    Chris Rasmussen: Yeah, not saying Docker is a _bad_ idea.  Just that in terms of the number of people that could use this script without any changes, Python/API is likely the best choice (on OS X).
- Test Calm 5.8 bootcamp labs and 5.5-6 bugs
  - https://github.com/nutanixworkshops/introcalm
  vs. https://github.com/mlavi/calm_workshop
  - file Calm bugs from guide
- Calm configuration:
  - Projects:
    - update default or create new project
  - nuclei (run local from container?)
    - version.get # gives API 3.1 and AOS 5.7.0.1 (bug!)
      - vs: cat /etc/nutanix/release_version
    - project.create name=mark.lavi.test \
      description='test_from NuClei!'
    - project.get mark.lavi.test
    - project.update mark.lavi.test
        spec.resources.account_reference_list.kind= or .uuid
        spec.resources.default_subnet_reference.kind=
        spec.resources.environment_reference_list.kind=
        spec.resources.external_user_group_reference_list.kind=
        spec.resources.subnet_reference_list.kind=
        spec.resources.user_reference_list.kind=

        resources:
          account_reference_list: []
          environment_reference_list: []
          external_user_group_reference_list: []
          is_default: false
          resource_domain:
            resources: []
          subnet_reference_list: []
          user_reference_list: []
    - nuclei authconfig (run local from container?) See notes#nuceli section, below.
  - (localize?) and upload blueprint via nuclei (see unit tests)?
  - Default project environment set, enable marketplace item, launch!
  - Enable multiple cloud account settings, then environments, then marketplace launch
  - Add widget Deployed Applications to (default) dashboard
- SRE cluster automation
  - Louie: https://confluence.eng.nutanix.com:8443/display/LABS/Internal+Networks
- Refactor URLs into global.vars.sh via: test/url_hardcoded.sh
  - refactor out all passwords, hardcoded values to variables
  - Remove backticks: scripts/lib.pe.sh:354 remains outside of *md
  - ncli rsyslog
  - Improve log output to be syslog compatible?
    - syslog format: INFO|DEBUG|etc.
    - https://en.wikipedia.org/wiki/Syslog#Severity_level
  - Documentation:
    - review, refactor & migrate to bugs.md: TODO, TOFIX comments
    - Insure exit codes unique/consistent, error messages consistent
    - release notes/Changelog?
  - JSON or YAML options? from bash/jq?
  - Create a data structure to specify an image name (or rename after uploading)
    - Change global.vars.sh to .json for new data structures
      - https://github.com/kristopolous/TickTick
      - https://github.com/dominictarr/JSON.sh
      - https://medv.io/json-in-bash/
        - https://github.com/sharkdp/hyperfine
- FEATURE = [Darksite](darksite.md): cache+ordering+detection
  - Ping derik.davenport@ for testing
  - Tasks:
    - focus on dependencies first (check $HOME/bin), then images?
    - local devstation (never purge), for each:
      - check if in ./cache
      - else, download to ./cache
      - upload to PE:~/cache
      - IMPROVEMENT: array of directories to check:
        - $HOME
        - $HOME/cache
        - $HOME/stageworkshop*/cache
        - PE:software_downloads
        - PE+PC:ssh_keys
    - PE CVM, for each:
      - check if in ~/cache
        - BENEFIT: reusable cache for any use case
      - else, download to ~/cache
      - install dependencies from ~/cache to ~
      - eventually, upload to PC:~/cache
      - DEFER: purge
    - PC VM: repeat above for images
    - detect HPOC networks to favor local URLs?
    - Check remote file for cache, containers, images before uploading and skip when OPTIONAL
    - download 403 detection: authentication unauthorized
    - restore http_resume check/attempt
    - create,use cache, fall back to global, next: propagate cache to PC
      - Refactor all functions to use ${HOME}/cache : ntnx_download, etc.
    - PC import PE images
      - Move images from PE to PC? Make Karbon and Era optional?
      - migrate/import image catalog on PC:
      {"action_on_failure":"CONTINUE","execution_order":"SEQUENTIAL","api_request_list":[{"operation":"POST","path_and_params":"/api/nutanix/v3/images/migrate","body":{"image_reference_list":[],"cluster_reference":{"uuid":"00057b0a-2472-da09-0000-0000000086b7","kind":"cluster","name":"string"}}}],"api_version":"3.0"}
    - Optimization: Upload AutoDC image in parallel with PC.tar
- Demos:
  - Azure LAMP demo
  - CI/CD pipeline demo
  - LAMP v2 application improvements (reboot nice to have)
  - Calm videos/spreadsheet
  - Multi product demo

## Improved Software Engineering ##
- I've been wrestling with how to best make my bash scripts test driven. There are TDD Bash frameworks, however most of the systems leveraged/orchestrated are external and would require mocking, something I’m not sure how to approach.

What I have done, in most functions, is try to make them [idempotent](https://en.wiktionary.org/wiki/idempotent) by "testing" for the desired outcome and skipping if accomplished. Of course, most of these tests are cheats: they only check for the final stage of a function being accomplished. Usually, this is good enough, because the final configuration is predicated on all preceding stages in the function. It would be ideal to test every operation, but as you can imagine, that’s quite a bit of work.

This gives the ability to rerun the script from the beginning, skip all previously successful work, and rapidly begin work on the next, unaccomplished stage.

I've looked into some server testing frameworks.

- https://githooks.com/
  - https://github.com/nkantar/Autohook (success)
  - Also investigated:
    - https://pre-commit.com/
      - brew install pre-commit
    - https://github.com/rycus86/githooks
  - Research https://medium.freecodecamp.org/improve-development-workflow-of-your-team-with-githooks-9cda15377c3b
  - TODO via hook?: check if unpushed commits, then allow git commit --amend
    - https://stackoverflow.com/questions/253055/how-do-i-push-amended-commit-to-the-remote-git-repository
- Add (git)version/release to each script (assembly?) for github archive cache
  - https://semver.org/
    - https://github.com/GitTools/GitVersion
      - https://gitversion.readthedocs.io/en/stable/usage/command-line/
      - brew install gitversion
      - GitVersion /showConfig
    - sudo apt-get install mono-complete
      - do not: sudo apt-get install libcurl3 # removes curl libcurl4
    - Download dotnet4 zip archive and put on mono-path?
    - gitversion | tee gitversion.json | jq -r .FullSemVer
    - ````ls -l *json && echo _GV=${_GV}````
    - ````_GV=gitversion.json ; rm -f ${_GV} \
    && gitversion | tee ${_GV} | grep FullSemVer | awk -F\" '{print $4}' && unset _GV````
    - https://blog.ngeor.com/2017/12/19/semantic-versioning-with-gitversion.html
  - versus https://github.com/markchalloner/git-semver
- ~/Documents/github.com/ideadevice/calm/src/calm/tests/qa/docs
  = https://github.com/ideadevice/calm/tree/master/src/calm/tests/qa/docs
- https://stackoverflow.com/questions/14494747/add-images-to-readme-md-on-github
- https://guides.github.com/introduction/flow/index.html
- https://bors.tech/ "Bors is a GitHub bot that prevents merge skew / semantic merge conflicts, so when a developer checks out the main branch, they can expect all of the tests to pass out-of-the-box."
- Per Google shell style guide:
  - refactor function names to lowercase: https://google.github.io/styleguide/shell.xml?showone=Function_Names#Function_Names
- http://jake.ginnivan.net/blog/2014/05/25/simple-versioning-and-release-notes/
  - https://github.com/GitTools/GitReleaseNotes
- Bash test framework for unit tests and on blueprints?
  - https://kitchen.ci/ which can do spec, BATS, etc. = https://github.com/test-kitchen/test-kitchen
    - https://kitchen.ci/docs/getting-started/writing-test
    - https://serverspec.org/ DSL Spec TDD
    - http://rspec.info/ Ruby TDD
    - inspec
      - more compliance from supermarket
      - https://dev-sec.io/features.html#os-hardening
      - https://www.cisecurity.org/cis-benchmarks/
    - https://en.wikipedia.org/wiki/ERuby
    - https://www.engineyard.com/blog/bats-test-command-line-tools
    - https://medium.com/@pimterry/testing-your-shell-scripts-with-bats-abfca9bdc5b9
      - http://ohmyz.sh/
      - https://github.com/jakubroztocil/httpie#scripting
      - https://github.com/pimterry/git-confirm
  - BATS https://github.com/bats-core/bats-core
  - https://invent.life/project/bash-infinity-framework
  - Runit/rundeck? http://bashdb.sourceforge.net/
  - Tests:
    - external URLs working (PC x, sshpass, jq, autodc, etc.)
    - userX login to PE, PC
    - userX new project, upload, run blueprint
    - GOOD: user01@ntnxlab.local auth test fine@PE, bats?
  - Knowledge base/articles/documentation:
    - https://github.com/orientation/orientation
  - https://shields.io/
    - https://github.com/badges/shields
  - Changelog:
    - https://github.com/olivierlacan/keep-a-changelog
      - https://keepachangelog.com/en/1.0.0/
      - Good discussions in the issues, tags such as: breaking, internal, etc.
    - http://krlmlr.github.io/using-gitattributes-to-avoid-merge-conflicts/
  - Boxcutter for AHV:
    - extend scripts/vmdisk2image-pc.sh to
      - https://qemu.weilnetz.de/doc/qemu-doc.html#disk_005fimages_005fssh
        qemu-system-x86_64 -drive file=ssh://[user@]server[:port]/path[?host_key_check=host_key_check]
      - download (NFS?)/export image
      - upload/import image
    - drive into Jenkinsfile pipeline job
      - periodic runs: weekly?
    - Base images/boxes: https://github.com/chef/bento

# Notes #

## Push Button Calm #

- https://github.com/mlavi/stageworkshop/blob/master/guidebook.md
- MP4 Video = 292MB: https://drive.google.com/open?id=1AfIWDff-mlvwth_lKv9DG4x-vi0ZsWij
 ~11 minute screencast overview of the 70 minute journey from Foundation
  to Calm running a blueprint: most of it is waiting for foundation and PC download/upload/deploy.
- Social coding: https://github.com/nutanixworkshops/stageworkshop/pull/1
- Biggest pain:
  - finding a HPOC
  - second biggest pain: keeping it for more than a few hours except on the weekend.
  - third biggest pain: coding in Bash :slightly_smiling_face: it makes you miss even script kiddie programming languages!

## Citations for other Calm automation ##

- Acknowledge https://drt-it-github-prod-1.eng.nutanix.com/sylvain-huguet/auto-hpoc
  - "Drafted a first version. Then @Christophe Jauffret took over and polished it
    Then we handed over the whole thing to Matt and Nathan during the prep for TS18"
- https://github.com/MMouse-23/FoundationDemoAddon in Powershell!
- One more: @anthony.c?
- Add links: https://drt-it-github-prod-1.eng.nutanix.com/akim-sissaoui/calm_aws_setup_blueprint/blob/master/Action%20Create%20Project/3-Create%20AWS%20Calm%20Entry
- https://gitlab.com/Chandru.tkc/Serviceability_shared/
  - pc-automate/installpc.py
  - 24:     "heartbeat":    "/PrismGateway/services/rest/v1/heartbeat",
  - 326: def validate_cluster(entity):
  - 500: def add_network_to_project(name,directory_uuid):
- https://github.com/digitalformula/nutanix-cluster-setup

## AutoDC ##
  - See also: [AutoDC](autodc/README.md)
  - GOOD:
    - NTNXLAB, ntnxlab.local, root:nutanix/4u
    - samba --version Version 4.2.14-Debian
    - https://wiki.archlinux.org/index.php/samba
    - https://gitlab.com/mlavi/alpine-dc (fork)
  - yum install samba-ldap
    - https://help.ubuntu.com/lts/serverguide/samba-ldap.html.en
  - Move AutoDC to DHCP?

## NuCLeI ##

https://jira.nutanix.com/browse/ENG-78322 <nuclei>
````app_blueprint
availability_zone
available_extension
available_extension_images
catalog_item
category
certificate
changed_regions
client_auth
cloud_credentials
cluster
container
core                          CLI control.
diag                          Diagnostic tools.
directory_service
disk
docker_image
docker_registry
exit                          Exits the CLI.
extension
get                           Gets the current value of the given configuration options.
help                          Provides help text for the named object.
host
image
network_function_chain
network_security_rule
oauth_client
oauth_token
permission
project
protection_rule
quit                          Exits the CLI.
recovery_plan
recovery_plan_job
remote_connection
report_config
report_instance
role
set                           Sets the value of the given configuration options.
ssh_user
subnet
user
version                       NuCLEI Version Information.
virtual_network
vm
vm_backup
vm_snapshot
volume_group
volume_group_backup
volume_group_snapshot
webhook
````

### nuclei authconfig (run local from container?) ####

````list | ls
edit | update
remove | rm
list-directory | ls-directory
create-directory | add-directory
edit-directory | update-directory
remove-directory | rm-directory
list-role-mappings | ls-role-mappings
delete-role-mapping
add-role-mapping
add-to-role-mapping-values
remove-from-role-mapping-values
get-directory-values-by-type
test-ldap-connection
````

## Image Uploading ##
TOFIX:
- https://jira.nutanix.com/browse/FEAT-7112
- https://jira.nutanix.com/browse/ENG-115366
once PC image service takes control, rejects PE image uploads. Move to PC, not critical path.

KB 4892 = https://portal.nutanix.com/#/page/kbs/details?targetId=kA00e000000XePyCAK
v3 API = http://developer.nutanix.com/reference/prism_central/v3/#images two steps:

1. POST /images to create image metadata and get UUID, see logs/spec-image.json
2. PUT images/uuid/file: upload uuid, body, checksum and checksum type: sha1, sha256
or nuclei, only on PCVM or in container

## File servers for container updates ##

- https://sewiki.nutanix.com/index.php/Hosted_Proof_of_Concept_(HPOC)#What_you_get_with_each_reservation
- https://sewiki.nutanix.com/index.php/Hosted_Proof_of_Concept_(HPOC)#Lab_Resources
- https://sewiki.nutanix.com/index.php/HPOC_Access_Instructions#FTP
  - \\lab-ftp\ftp
  - smb://hpoc-ftp/ = \\hpoc-ftp\ftp
  - ftp://nutanix:nutanix/4u@hostedpoc.nutanix.com/
  - \\pocfs.nutanixdc.local and \\hpoc-afs.nutanixdc.local
  - smb://pocfs/    = \\pocfs\iso\ and \images\
    - nutanixdc\username
  - smb://pocfs.nutanixdc.local use: auth
    - WIN> nslookup pocfs.nutanixdc.local
    - smbclient -I 10.21.249.12 \\\\pocfs\\images \
      --user mark.lavi@nutanixdc.local --command "prompt ; cd /Calm-EA/pc-5.7.1/ ; mget *tar"
  - smb://hpoc-afs/ = \\hpoc-afs\se\
    - smbclient \\\\hpoc-afs\\se\\ --user mark.lavi@nutanixdc.local --debuglevel=10
    - WIN> nslookup hpoc-afs.nutanixdc.local
    10.21.249.41-3
    - smbclient -I 10.21.249.41 \\\\hpoc-afs\\se\\ --user mark.lavi@nutanixdc.local
  - smb://NTNX-HPOC-AFS-3.NUTANIXDC.LOCAL
  default password = welcome123
  - https://ubuntuswitch.wordpress.com/2010/02/05/nautilus-slow-network-or-network-does-not-work/
- smb-client vs cifs?
  - https://www.tldp.org/HOWTO/SMB-HOWTO-8.html
  - https://www.samba.org/samba/docs/current/man-html/smbclient.1.html
  - https://linux-cifs.samba.org/
    - https://pserver.samba.org/samba/ftp/cifs-cvs/linux-cifs-client-guide.pdf
    - https://serverfault.com/questions/609365/cifs-mount-in-fstab-succeeds-on-ip-fails-on-hostname-written-in-etc-hosts
      - sudo apt-get install cifs-utils
      - yum install cifs-utils
        man mount.cifs
        USER=mark.lavi@nutanix.com PASSWD=secret mount -t cifs //hpoc-afs/se /mnt/se/
  - mac: sudo mount -v -r -t nfs -o resvport,nobrowse,nosuid,locallocks,nfc,actimeo=1 10.21.34.37:/SelfServiceContainer/ nfstest
- mount AFS and then put a web/S/FTP server on top
- python -m SimpleHTTPServer 8080 || python -m http.server 8080

## Git ##

https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project

```
$ git remote show
origin

# https://gitversion.readthedocs.io/en/stable/reference/git-setup/
$ git remote add upstream https://github.com/nutanixworkshops/stageworkshop.git
$ git remote show
upstream
origin

$ git fetch upstream
$ git merge upstream/master

$ git tag
$ git tag -a 2.0.1 [optional_hash]
$ git push origin --tags

git remote show origin
git checkout master && git merge [topic_branch]
git branch --delete [topic_branch]
git push origin --delete [topic_branch|tag]
git remote set-url origin git@github.com:mlavi/stageworkshop.git #change transport

$ git stash list
git stage && git pull --rebase && git stash pop
````
