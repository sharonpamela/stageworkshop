<H1>Changelog stageworkshop</H1>

* Unreleased

* Version 2.0.6-ci.14

<H2>Changes made</H2>

* 2019-04-12 willem@nutanix.com

<H3>Stageworkshop part</H3>
  * Changed the following files:
    * scripts/lib.pe.sh;      Changed the way we check if the PC is running
                              Changed the PE to PC registration
                          
    * scripts/lib.pc.sh;      Before we can enable calm we need to make sure the system is ready for it.
    * scripts/lib.common.sh;  Removed the acli as 5.8.2 has an error on that. All on nuclei now.
    * stage_workshop.sh;      Re-enabled calm workshop (AOS and PC 5.8.2)

<H3>Call back server part</H3>
  
  * No changes


<H2>Changes made</H2>


* 2019-04-04 willem@nutanix.com

<H3>Stageworkshop part</H3>
  * Changed the following files:
  
    * scripts/lib.pc.sh; Added LCM upgrades using API calls and not files. Also added Karbon enable

<H3>Call back server part</H3>
  
  * No changes


<H2>Changes made</H2>


* 2019-03-21 willem@nutanix.com

<H3>Stageworkshop part</H3>
  * Changed the following files:
  
    * scripts/lib.pc.sh; Added a loop function for the waiting for Calm to be enabled before starting the LCM.

<H3>Call back server part</H3>
  
  * No changes


* 2019-03-20 willem@nutanix.com

<H3>Stageworkshop part</H3>
  * Changed the following files:
  
    * release.json; Changed all the 13 to 14 as a number
    * scripts/lib.pc.sh; Added a loop function for the LCM part to follow the progress of teh API call. Also added an extra wait of 5 minutes so that the "Enable Application" is done before we start the LCM! Otherwise it will crash.
    * script/lib/pe/sh; Added a line that if it's being called by we- something, it changes lib.common.sh to we-lib.common.sh
    
  * Copied for keeping the original the following files:
    
    * scripts/lib.pc.org.sh
  
  * Created extra files for a server reporting system (centralised logging using curl)
    
    * we_stage_workshop.sh; the new version of the staging workshop script. This one holds the lines for the centralised feedback
    * we_push_centos_cl_disk.sh; small script to push the CentOS Image that is needed in the TS2019 workshops
    * script/we-ts2019.sh; has a more debug info fired for the scripts run at PE and PC timeframe (nohup bash -x)
    * script/we-lib.common.sh; contains extra functions for the call back to the server 
    
    
<H3>Call back server part</H3>
  * Reason for this server is to have the possibility to send the logging/steps of the stageworkshop script to a centralised server. The "tool" is based on python.
  
  * Created files and their goal:
  
    * logserver/logserver.py; Listener for the messagees from the scripts.
      * usage: python3 logserver.py 3000 to start the logserver on port 3000 (used by the scripts for now)
    * logserver/webserver.py; Webserver to show the messages of the different running scripts
      * usage: python3 webserver to start the webserver which will default to port 5000 by default.
      
    
