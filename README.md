# netm4ul-ansible
Deployement script of netm4ul

Links :

    *https://aws.amazon.com/fr/blogs/apn/getting-started-with-ansible-and-dynamic-amazon-ec2-inventory-management/
    *http://docs.ansible.com/ansible/latest/scenario_guides/guide_aws.html
    *http://docs.ansible.com/ansible/latest/modules/ec2_module.html

Infos :

	In /testing/playbooks/, the file "demo_setup.yml" will create 5 instances. The “exact_count” of instances is set to 5. This means if there are 0 instances already existing, then 5 new instances would be created. If there were 2 instances, only 3 would be created, and if there were 8 instances, 3 instances would be terminated.
	
	Needs to be root
	The following variables need to be defined : 
		* $ export AWS_ACCESS_KEY_ID='YOUR_AWS_API_KEY'
		* $ export AWS_SECRET_ACCESS_KEY='YOUR_AWS_API_SECRET_KEY'

	And to enable the use of ssh agent :
		$ ssh-agent bash 
		$ ssh-add ~/.ssh/keypair.pem 