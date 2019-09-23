# HPoC Automation: Push Button Calm
<!-- MDTOC maxdepth:6 firsth1:0 numbering:0 flatten:0 bullets:1 updateOnSave:1 -->

- [Caveat](#caveat)   
- [Acknowledgements](#acknowledgements)   
- [For the Impatient](#for-the-impatient)   
- [How to Do a Calm Bootcamp](#how-to-do-a-calm-bootcamp)   
   - [Extended Enablement](#extended-enablement)   
- [Bugs, Priorities, Notes](#bugs-priorities-notes)   
- [Development](#development)   
   - [Feature Branches](#feature-branches)   
   - [Local Development Strategies and Tactics](#local-development-strategies-and-tactics)   
   - [How to Update or Add a Workshop](#how-to-update-or-add-a-workshop)   
   - [How to Update Nutanix Software Version Used in a Workshop](#how-to-update-nutanix-software-version-used-in-a-workshop)   
- [Timing](#timing)   
- [Procedure](#procedure)   

<!-- /MDTOC -->
---
## Caveat ##

This is a work in progress and your milage may vary!

## Acknowledgements ##

The entire Global Technical Sales Enablement team has delivered an amazing amount of content and automation for Nutanix Tech Summits and Workshops alongside the Corporate SE team automation gurus. It has been a pleasure to work with all of them and this work stands on the shoulders of those giants. Thank you!

## For the Impatient ##

You can get push button Calm in two ways. It is best to decide by answering this question:<br/> *do you need to set up a single or multiple Nutanix AHV clusters?*

- __Single:__ the easiest manner is to SSH to the cluster IP address and run the bootstrap script on a CVM:

        curl --remote-name --location https://raw.githubusercontent.com/nutanixworkshops/stageworkshop/master/bootstrap.sh && sh ${_##*/}

    answer a few questions* and watch the log progress.
    - The `nutanixworkshops` repository places a premium on stability, not on the bleeding edge of the latest releases; use one of the forked repos for latest development.

- __Multiple:__ or to use development branches, satisfy these requirements:

    1. Tested on Ubuntu and Mac, but could work easily on other Linux distributions.
        - Mac requires https://brew.sh installed, which first requires ``xcode-select --install``
    2. Terminal with command line git.

      echo "Start Foundation on your HPoC now, script retries for 60 minutes..."

      export PE=10.21.X.37 && export PE_PASSWORD='nx2Tech###!' && EMAIL=first.last@nutanix.com \
      && cd $(git clone https://github.com/mlavi/stageworkshop.git 2>&1 | grep Cloning | awk -F\' '{print $2}') \
      && echo "${PE}|${PE_PASSWORD}|${EMAIL}" > clusters.txt \
      && ./stage_workshop.sh -f clusters.txt -w 1 #latest stable Calm workshop

   Cluster Foundation typically takes *~30 minutes,* in the meantime, the above will:

    1. Set the Prism Element (PE) IP address, password, and your email address
    2. Change directory into the cloned git repository
    3. Put settings into a configuration file
    4. Retry for 60 minutes to stage the cluster with the configuration file and Workshop #1.

  Approximately 30 minutes later, you can login to PE to get to PC (or directly to PC) and follow step #7 below to finish push button Calm automation.

## How to Do a Calm Bootcamp ##

- __Planning:__
    - Work with your stakeholders at the partner or customer to plan the bootcamp/workshop agenda, facilities, and proposed schedule dates. Facility considerations for all attendees:
        - Leader podium/projector
        - WiFi access
        - Seating with tables and power access
        - Breakfast/Lunch/refreshments
        - Local SEs to help moderate, assist, and troubleshoot each attendee's needs while the leader continues to drive the bootcamp.
        - *Do not do a 15+ person workshop alone* unless you are comfortable dealing with adverse situations, have back up plans, and can easily adapt to make the most of attendee's valuable time (i.e. videos, presentation decks, and/or print outs).
    - If appropriate, work with your local field marketing team to make a Bootcamp event landing and registration page, they can also help reserve a marketing cluster.
      - You should drive attendees to register.
      - More information and supporting materials are on GDrive in the [Technology Bootcamp](https://drive.google.com/drive/folders/0B_IfSpggJeFVfjdrVUxkZ25tQVRINHFVMkl4TFpWMG1GUUNhOVhaWnJOZ1gtSkJfa2QzSGc) folder.
    - Estimate the count of your audience, reserve a HPOC cluster for every 20 attendees (due to VDI login constraints).
      - You can workaround the 20 VDI user constraint per HPOC by using Juniper VPN.
      - Budget for extra people to attend at the last moment and expect last minute attrition as well.
      - Confirm your dates.
      - Think about bringing Nutanix schwag: stickers, t-shirts, etc. for giveaways.
    - Ask questions not covered here in Slack to the Global Sales Technical Enablement team, first see the pinned items in each channel:
      - __#technology-bootcamps:__ for customer and prospect bootcamps
      - __#hands-on-workshops:__ for Nutanix Partner and SE workshops
   - Make a HPOC reservation(s) on https://rx.corp.nutanix.com/ with:

      - __AOS + Hypervisor:__ proper versions for your workshop, specified in the Workshop title.
        - *Recommended:* AOS 5.8
        - Older or newer versions of AOS may not function as expected.
        - Use for the Calm development workshop to test with the latest Prism Central and Calm versions.
        - Prism Central and Calm UIs are continually evolving, you may encounter variations that require different feature navigation from the step by step directions.
      - __OS Images:__ *you do not* need to specify images (CentOS, Windows2012, etc.) for your reservation.
      - __Start and End Times:__ It is nice to have the cluster extend to the end of the day in case anyone would like to save their blueprints or work after the bootcamp ends.
      - The default HPOC reservation comes with 25 VDI user sessions, therefore it is recommended that you reserve a cluster for every 25 attendees.
          - For attendees that can install and use Juniper Pulse VPN to access the HPOC, you can consolidate those users to access a single cluster in addition to the VDI users.

3. __Once your HPOC reservation starts:__
    - Leverage Push button Calm automation to stage your cluster with the Calm workshop of your choice.
    - *Optional:*
        - For every attendee over 20 or a previously known/arranged audience, it is ideal to populate them by userXX or by email in the directory and then configure sign on into Prism Central.
          - https://sewiki.nutanix.com/index.php/HPOC_Access_Instructions
          - There is a printout available in GDrive?
        - Populate the authentication directory with additional users and email addresses, add into groups if desired.
        - Configure SSP role mappings if desired.
        - Populate PC projects with groups and/or users with roles.

5. __Before the Bootcamp:__
    - Survey the site and conference/classroom, correct any logistical problems, confirm driving, parking, sign-in procedures, room location/directions, and WiFi access.
    - The day(s) before the Bootcamp or as soon as push button Calm completes with any optional configuration, send a reminder notice in email with logistical details, and *ask people to test their VDI and/or VPN access.*
      - This reduces logistical problems encountered on the bootcamp day starting to access the cluster(s).
    - Send WiFi details for on-site network access.
    - Run through the first lab to check everything works!

6. __The Day of the Bootcamp__

    - Arrive early, re-survey the site, send any updates to the e-mail attendee list, and include this link:
      - [Nutanix Partner Workshop](https://nutanix.handsonworkshops.com/workshops/6070f10d-3aa0-4c7e-b727-dc554cbc2ddf/start/)
      - Alternatively, have them access http://nutanix.handsonworkshops.com and register/log in.
    - Project WiFi/logisical and Agenda info
    - Once quorum is established, I like to begin with a introductions and review of the agenda:
      - why are we here?
      - what do want to accomplish today?
      - who is the Nutanix team in the room to ask for help?
    - I take a role call of who is in the room, writing down their first name and last initial to protect their privacy, and I ask: "what is your role and company, what do you want to accomplish or for us to address today?"
      - Amend the agenda if needed based on feedback
    - Review the agenda and begin the day, here is the typical agenda:
      - Introductions and Logistics
      - Calm overview and enablement: see the next section for detail
      - Lab 1, etc.

### Extended Enablement ###

It is easy to do a full day of enablement on Calm. There are many topics which you can pick from for the best audience engagement; shed topics for the appropriate depth and time.

1. Nutanix+Calm=DevOps
   - DevOps enablement: What is DevOps? [Enablement deck](https://drive.google.com/open?id=1f0o9YSHy6BW_5cHS_7n716zNtKuPXTXu) [[article](https://mlavi.github.io/post/calm.io-recap/calm.io-i-dream-of-devops-but-what-is-devops/)]
       1. The Journey: move the mountain stone by stone
       2. Business outcome = __agility__: DevOps Definition
       3. Business outcome = __scalability__: Pets versus Cattle
       4. Plan, implement, measure, repeat.
   - [DevOps Maturity Diagram](https://mlavi.github.io/post/devops-maturity-diagram/): journey up and to the right, evaluate vendors who imprison you in the lower left quadrant. Then bring down the silos.
      - The goal of DevOps is to become invisible, we cattle DevOps across the organization and we all become DevOps.
      - Nutanix is on this journey, we are cattle architecture, infrastructure, and operations: this is how we disrupt and lead the industry by doing so for our customers. Calm accelerates and completes the customer journey:

          - Invisible infrastructure (HW), invisible hypervisors, invisible clouds, invisible DevOps = invisible silos (hyperconverged teams) and invisible/continuous ops.

    - The traditional Nutanix customer base is Ops, now we have a new audience: the Dev. What is a Developer and how does a developer look at the world?

      1. [Build-Test-Deploy pattern](https://mlavi.github.io/post/devops-btd-pattern/) for a mature agile SDLC engineering organization leads to Continuous Integration, Delivery, and Deployment (CI/CD)
      4. [The DevOps Automation Diagram](http://mlavi.github.io/post/devops_automation.pu.svg) [[article](https://mlavi.github.io/post/devops-automation/)] illustrates CI/CD [[article](https://mlavi.github.io/post/calm.io-recap/calm.io-demystifying-continuous-integration-delivery-and-deployment/)]
      4. [Configuration Management](https://mlavi.github.io/post/calm.io-recap/calm.io-configuration-management-in-the-devops-world/) means Ops cares about infrastructure as code and becomes infrastructure developers.
          - Proof that software eats the world and we have The New Kingmakers.

  2. Calm Selling:

      - Typical customer use cases, success, and summary of business
      - How to do the first customer Calm presentation
        - Calm Customer Preso (Seismic)
        - SKO2018 Selling the Enterprise Cloud with Calm: [Video](https://drive.google.com/open?id=0B05FlI1TwLEzTHFyUzdxUnp6a3M) [Slides](https://drive.google.com/a/nutanix.com/file/d/0B57gwWrKd9AVQjVaVFdRS1VnSEk/view?usp=sharing)
          - Qualification questions
          - Competitive analysis/Objection Handling
      - How to demo Calm in 5, 10, 20 minutes
        - Where: HPOC versus demo.nutanix.com versus expo.nutanix.com
          - Be aware that I never do a Calm demo in less than 30 minutes because the platform can address so many use cases. It is better to do discovery, qualification of use cases, and  plan a follow up engagement than it is to do short demo.
        - 5 minute Calm demo outline:
          - Just rip through the presentation slides! If there is interest, create a SFDC opp and schedule the follow up with Calm seller team.
        - 10 minute Calm demo outline:
          - Skip the slides and message: Calm delivers enterprise applications with a few clicks
          - Show the marketplace, launch a LAMP blueprint, show application profiles with TCO, launch and audit the deployment, explain operations in flight
        - 20 minute Calm demo outline:

      - [Calm History, OrgChart, Resources](https://sites.google.com/a/nutanix.com/corp/calm)
      - Deeper dives and advanced features (later in the day, second day, etc.):
        - Calm Releases and Roadmap
          - Calm LCM 2.x feature releases
        - [Service Now](https://github.com/nutanix/ServiceNow) bridge open sourced, productization in beta
        - [CI/CD blueprint](https://next.nutanix.com/blog-40/automation-ci-cd-and-nutanix-calm-31147)

      - __Anatomy of a Calm Sale:__ with escalation points
        - *This section is about to be updated with the new Calm go to market plan and selling team.*
          - Platform, first customer pitch
          - Discovery on qualification questions:
            - Do you have automation, software devs, etc.
          - Map out how they deploy a change to production,
          get the metrics/silos, time to deploy value.
          - Find use case(s) for Calm/automation/platform,
          create SFDC opportunity with Calm SKUs,
          schedule platform follow ups and/or Calm deep dive.
          - Offer a bootcamp for engagement.
          - Define a PoC, escalate to solutions arch if needed.
              - Implement a PoC, exit PoC successfully for a technical close.
          - Sales close.
      - __Continuous Selling:__ nurture Calm and upsell platform value, features, and product engagement.
        - Typical use case is SSP-IaaS deployment, but the use case can be progressed over many stages to DevOps maturity:
          1. Add self-service and showback
          1. Add t-shirt sizes, multiple application profiles
          1. Add apps
          1. Add integrations
          1. Add multiple providers (active-active)
          1. Add app lifecycle operations
          1. Drive to CI/CD pipelines
          1. Drive to continuous operations
        - Repeat for the next business initiative:
            - Continuously prospect for other business teams, apps, integrations, marketplace blueprints, use cases which influence roadmap priority, and *for competition*: report back to the team in #calm.
        - Profit!

      - __Group Exercise:__
        - Pitch a slide or answer a Calm objection question
        - Entire team offers positive criticism to improve member response, typical sidebar discussion
        - Make the pitch your own voice, not by wrote.
          - Add your your own story and experience to illustrate how we do it better, customer proof points, and lay traps.
          - Improve your strategy/tactics using XCommand and the Calm battlecard.
          - Avoid traps which isolate Calm from platform or lower value.

## Bugs, Priorities, Notes ##

See [the planning and working document](bugs.md).

## Development ##

Shell scripting is not a complete computer language, but despite its drawbacks, it is capable. In the limited environment of the CVM, it is the easiest manner to orchestrate other command line tools, including Nutanix CLIs. You will also see RESTful API calls to exercise platform functionality.

I refer to the [Advanced Bash-Scripting Guide](http://tldp.org/LDP/abs/html/index.html) every time I forget something or see strange syntax, it is a great way to learn and understand shell scripting!

### Feature Branches ###

In order to keep the master branch stable, a developer should work on a feature branch when possible. The following shows how to change to a feature branch, it assumes you are working with the `mlavi` repository and want to change to a branch named <BRANCH>:

    cd $(git clone https://github.com/mlavi/stageworkshop.git 2>&1 \
      | grep Cloning | awk -F\' '{print $2}') \
      && git checkout <BRANCH>

    # Create your cluster file, e.g.: echo "${PE}|${PE_PASSWORD}|${EMAIL}" > pocs.txt
    ./stage_workshop.sh -f pocs.txt

### Local Development Strategies and Tactics ###

- [Semantic Versioning](https://semver.org/) implemented via:
  - /hooks/ = local git hooks
    - [Autohook](https://github.com/nkantar/Autohook).sh
  - /hooks/pre-commit/... = symbolic link to hooks/script/...
  - /hooks/scripts/semver_release.sh
    - [GitVersion](https://github.com/GitTools/GitVersion) container outputs to /release.json
  - Setup:
    - Docker + GitVersion (see: semver_release.sh::${CONTAINER_TAG})
    - cd hooks && ./autohook.sh install
- Shell Style Guide
  - shfmt via IDE
  - [Google Shell Script Guide](https://google.github.io/styleguide/shell.xml)

### How to Update or Add a Workshop ###

Everything takes place in `stage_workshop.sh`:
1. line 5: Update the `WORKSHOPS` array with the title of your new workshop.
    - Insure you use a keyword and a `MAJOR.MINOR` semantic version version.
    These will be used for switching between workshops and versions.
    You should not need to use precision past the .MINOR point release.
        - *e.g.:* use "PC 5.9" (not "Prism Central 5.9.0.1")
        - ````WORKSHOPS=(\
        "Calm Workshop (AOS 5.5+/AHV PC 5.8.x) = Stable (AutoDC1)" \
        "Calm Workshop (AOS 5.5+/AHV PC 5.10.x) = Development" \
        "Citrix Desktop on AHV Workshop (AOS/AHV 5.6)" \
        #"Tech Summit 2018" \
    )````
2. Adjust/update function stage_clusters() (which immediately follows the `WORKSHOPS` array) for mappings to latest version number and staging scripts, as needed.

### How to Update Nutanix Software Version Used in a Workshop ###

1. See above, update `stage_workshop.sh` function stage_clusters() version number.
2. Adjust `global.vars.sh` if appropriate for:
  - `PC_DEV_VERSION` and/or `PC_STABLE_VERSION`
  - `FILES_VERSION`
  and update the corresponding metadata URLs.

## Timing ##

We'll round up to the nearest half minute.

1. 30 min = RX Foundation times to PE up (approximate)

| Cluster | 5/24 (minutes) | 6/2 (min) | 6/10 (min) |
| :------------- | ------------- | --- | ---------- |
| NX-1060 | 30 | N/A | N/A |
| NX-3060-G5 | 25 | 35 | 33 |

    When rebuilding a HPOC from rx, Foundation automation takes:
    - 4 nodes@NX-3060-G5: 30 minutes
    - 4 nodes@NX-1050: 40 minutes.

2. 0.5 min per cluster = ./stage_workshop.sh

3. 28/26/20 min = calm.sh PE
Typical download and install of Prism Central is 17 minutes of waiting!

| Function | Run1@5/24 (minutes) | 6/2 (min) | 6/10 (min) |
| :------------- | :------------- | --- | ---------- |
| __start__ | 11:26:53 | 09:07:55 | 03:15:35 |
| __end__ | 11:54:28 | 09:34:09 | 03:35:25 |

4. 1.5 min = calm.sh PC

| Function | Run1@5/24 (minutes) | 6/2 (min) | 6/10 (min) |
| :------------- | :------------- | --- | ---------- |
| __start (localtime)__ | 04:54:27 | 02:34:08 | 20:35:24 |
| __end (localtime)__ | 04:55:57 | 02:35:37 | 20:36:45 |

5. 2 min: Login to PC, manual configuration of Calm default project (see step 7, below).

## Procedure ##

0. Crank some tunes and record the start time!
1. __Browse (tab1)__ to this page = https://github.com/mlavi/stageworkshop/blob/master/documentation/guidebook.md
2. __Browse (tab2)__ to review HPoC reservation details in https://rx.corp.nutanix.com:8443/

    1. Find the __Cluster External IP__ and the __PE admin password__:
    we will use both of these in a moment.
    2. Memorize the HPOC number (third octet of the External IPv4)
    and prepare to copy by highlighting the __PE admin password__
    or merely memorize the three digits of __PE admin password__.
    3. *Browse (tab3)* to the PE URL to show unavailable before or during foundation process.
    4. *Launch a new terminal*:

        1. Change terminal font size for demo.
        2. Cut and paste the first line the follows to create, and change to the repository directory
            - or cut and paste the entire code block if you're comfortable editing the command line,
            - otherwise copy one line at a time and substitute __Cluster External IP__
            on the ````MY_HPOC```` assignment line or change that ````X```` you cleverly memorized
            and paste the __PE admin password__ onto the ````PE_PASSWORD```` line
            or change the ````###```` you cleverly memorized.

        git clone https://github.com/mlavi/stageworkshop.git && cd $_
        export MY_HPOC=10.21.X.37 \
        && export PE_PASSWORD='nx2Tech###!' \
        && echo "${MY_HPOC}|${PE_PASSWORD}" >> example_pocs.txt

        - *OPTIONAL:* Make a mistake with the HPoC octet to show a failure mode.
        - That's it, you're done! Just sit back and wait, periodically
        reload browser tab3, or follow the log output on PE and PC...

1. Side by side: (screens because split desktop doesn't work well enough)

   1. __Browser (tab 2):__ Open RX automation cluster foundation status detail page, it will be tab4.
   2. __Terminal:__ After the automation is uploaded to the cluster CVM, copy and paste the command to monitor the ````calm.sh```` progress.

   3. __Browser (tab3):__ Reload the PE URL, accept security override, login as admin and password to PE EULA.
   4. __Terminal:__ Once PE UI configured, reload browser tab3 to show EULA bypassed or click on the decline EULA button to return to login prompt.

      - *BUG:* Once Authentication Server is up, you should be able to login as a SSP admin = adminuser05@ntnxlab.local
  5. __Browser:__

      - Show PE Authentication: test above user with the default password.
      - View All Tasks, wait until software is uploading
  6. __Terminal:__ Show that we're waiting...approximately 17 minutes (fast forward). Highlight automation scripts sent to PC.
  7. __Browser:__ from PE, show VM table, go to home and show PE registered to PC, launch PC and login as admin.

    * *BUG:* Can't login as a SSP admin = adminuser05@ntnxlab.local
    * Show Authentication, show role mapping, show images.

1. Push button Calm!

    1. __PC> Apps (or PC-5.10+: Services > Calm):__ click lower left ? to show Calm version
    2. __Projects:__ Default: add the following:

        - Description: "Freedom to Cloud",
        - Roles: assign and save,
        - Local and Cloud,
        - choose PoC AHV cluster,
        - Network: enable VLANs,
        - and Save.
    3. __Blueprints:__ Upload blueprint: ````test/beachhead-centos7-calm5.7.0.1.json```` in default project.

        - Resize icon
        - Pull left tab open, note public key in AHVCluster application profile, zoom to show end of the value.
      - __Credentials:__ upload private key, note user centos, save, back.
      - __Service = Webtier:__

          - Show VM name, zoom in to show macros.
          - Choose local image uploaded to cluster to save time versus the dynamic imported image.
          - Show user centos in cloud-init and @@{your_public_key}@@ macro.
          - Show package install task: uncomment install work
          - Show service tab: Deployment Config

            - *bug* service > service is redundant!
        - Save, Launch!
    4. __Application Launch:__

        - Name application deployment: marklavi-beachhead-took-X-minutes
        - Terminal: find start time, find end time.

          - *BUG:* time zones of server, cloud-init?

        - Show logical deployment, open terminal, audit logs
