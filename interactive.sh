#! /usr/bin/env bash

set -e

ALT_PROMPT="[What you paste here will not be displayed]"

ec2 () {
    echo " Sorry mate, wrong branch. Implement your stuff, here."
    exit 1;
}

scaleway () {

    read -p "Enter your auth token (https://www.scaleway.com/docs/generate-an-api-token/) $ALT_PROMPT ...]: " -rs scaleway_auth_token

    read -p "
    Enter your organization name (https://cloud.scaleway.com/#/billing)
    $ALT_PROMPT
    [...]: " -rs scaleway_organization


    read -p "
        What region should the server be located in?
        1.   par1           Paris
        2.   ams1           Amsterdam
        Enter the number of your desired region:
        [1]: " -r netm4ul_region
    readonly netm4ul_region=${netm4ul_region:-1}
    case "$netm4ul_region" in
        1) region="par1" ;;
        2) region="ams1" ;;
    esac

    ROLES="scaleway"
}

own_server () {
    read -p " Enter the IP address of your master node: (or use localhost for local installation) [localhost]: " -r server_ip
    readonly server_ip=${server_ip:-localhost}

    read -p "What user should we use to login on the server? (note: passwordless login required, or ignore if you're deploying to localhost) [root]: " -r server_user
    readonly server_user=${server_user:-root}

    if [ "x${server_ip}" = "xlocalhost" ]; then
        myip=""
    else
        myip=${server_ip}
    fi

    ROLES="local master"
}

deploy () {

    ansible-playbook -vv deploy.yml -t "${ROLES// /,}"

}

netm4ul_provisioning () {
  echo -n "
  What provider would you like to use?
    1. Amazon EC2
    2. Scaleway
    s. Setup on own server (Beware, this is for real hackerz)
    Enter the number of your desired provider
    : "

  read -r N

  case "$N" in
    1) ec2; ;;
    2) scaleway; ;;
    7) own_server; ;;
    *) exit 1 ;;
  esac

  # run poney
  deploy
}

netm4ul_provisioning