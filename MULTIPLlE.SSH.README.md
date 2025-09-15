It is possible to have multiple ssh keys (one for work and one for personal) on the same computer. 

first you run the normal ssh-keygen but write it to a file called id_company. That will generate id_company_keytype and id_company_keytype.pub
Then you run ssh-keygen again but you name the file id_personal. That will generate the private public keys for the personal .

next you place the following information into .ssh/config

#Company Account
Host companynamegoeshere
HostName github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_company_ed25519

#Personal Account
Host personalnamegoeshere
HostName github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_personal_ed25519

From here you can access the company git hub by using git clone git@companynamegoeshere:organization/reponame.git or git clone git@personalnamegoeshere:organization/reponame.git
