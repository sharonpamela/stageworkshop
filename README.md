This script supports staging HPoC clusters for [Nutanix Workshops](https://nutanix.handsonworkshops.com/).
It automates the majority of the [Workshop Setup Guide](http://www.nutanixworkshops.com/en/latest/setup/).
After HPoC Foundation, you can have push-button Calm in about half an hour!

---

# Table of Contents #
<!-- MDTOC maxdepth:6 firsth1:0 numbering:0 flatten:0 bullets:1 updateOnSave:1 -->

- [Available Workshops](#available-workshops)   
- [HPoC Cluster Reservation](#hpoc-cluster-reservation)   
- [Staging Your HPoC](#staging-your-hpoc)   
   - [Interactive Usage](#interactive-usage)   
   - [Non-interactive Usage](#non-interactive-usage)   
   - [Validate Staged Clusters](#validate-staged-clusters)   
- [Authentication](#authentication)   

<!-- /MDTOC -->
---
## Available Workshops ##

1. Calm Introduction Workshop (AOS/AHV 5.5+)
2. Citrix Desktop on AHV Workshop (AOS/AHV 5.6)

See the WORKSHOPS list at the top of [stage_workshop.sh](blob/master/stage_workshop.sh#L8).

## HPoC Cluster Reservation ##

Make your new reservation on https://rx.corp.nutanix.com/ with:

- __AOS + Hypervisor:__ proper versions for your workshop, specified above
  - Recommended: AOS and AHV 5.8
  - Older or newer versions may not function as expected
- __VM Images:__ *you do not* need to specify images (CentOS, Windows2012, etc.) for your reservation

## Staging Your HPoC ##

All clusters must be Foundationed prior to Workshop staging.

This script should be run from a host on the corporate/lab network,
 such as a CentOS VM running on an HPoC cluster or your laptop with VPN access.
Execute the following:

    git clone https://github.com/nutanixworkshops/stageworkshop.git
    cd stageworkshop
    chmod +x stage_workshop.sh

Next, you'll need to create or reuse and update a text file (*e.g.:* example_pocs.txt)
 containing your cluster IP and password details.
 It's easiest to create this file in the same directory as the stage_workshop.sh script.
 Input files must use the following format:

    <Nutanix Cluster #1 IP>|<Cluster #1 Password>|first.lasty@nutanix.com
    <Nutanix Cluster #2 IP>|<Cluster #2 Password>|example@nutanix.com
    ...
    <Nutanix Cluster #N IP>|<Cluster #N Password>|example@nutanix.com

For example:

    10.21.1.37|nx2Tech123!|you@nutanix.com
    10.21.7.37|nx2Tech517!|me@nutanix.com
    #10.21.5.37|nx2Tech789!|first.last@nutanix.com <-- The script will ignore commented out clusters
    10.21.55.37|nx2Tech456!|se@nutanix.com

Finally, execute the script to stage the HPOC clusters defined in your text file.

### Interactive Usage ###

`./stage_workshop.sh`

Running the script interactively will prompt you to input the name of your text file containing your cluster IP and password details. You will then be prompted to choose a Workshop to stage.

### Non-interactive Usage ###

`./stage_workshop.sh -f [example_pocs.txt] -w [workshop number]`

Each staging option will deploy:

- all images required to complete a given workshop
- a domain controller (ntnxlab.local)
- Prism Central
- configuring AHV networks for your Primary and Secondary VLANs.

Ask questions not covered here to the Global Sales Technical Enablement team via Slack, review the pinned items in each channel first:
- __#technology-bootcamps:__ for customer and prospect bootcamps
- __#hands-on-workshops:__ for Nutanix Partner and SE workshops

### Validate Staged Clusters ###

After staging (~30m), you can re-run the stage_workshop script and select "Validate Staged Clusters" to perform a quick check to ensure all images were uploaded and that Prism Central was provisioned as expected.

Example:

    ./stage_workshop.sh
    Cluster Input File: example_pocs.txt
    1) Calm Introduction Workshop (AOS/AHV 5.6)
    2) Citrix Desktop on AHV Workshop (AOS/AHV 5.6)
    3) Change Cluster Input File
    4) Validate Staged Clusters
    5) Quit
    Select an option: 4
    10.21.44.37 - Prism Central staging FAILED
    10.21.44.37 - Review logs at 10.21.44.37:/home/nutanix/config.log and 10.21.44.39:/home/nutanix/pcconfig.log

## Authentication ##

One can use Windows Server: Active Directory, but for simpler and faster results, the automation leverages [AutoDC](documentation/autodc/README.md).
