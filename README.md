# scaleway-kapsule-cert-mgr
The main goal of this Sample is to deploy cert manager along with External DNS.
[external DNS](https://github.com/kubernetes-sigs/external-dns) will create the DNS Part in Scaleway DNS whereas Cert Manager will be use to rely on LetsEncrypt to generate certificate.

For that purpose, we will deplot the user-management app that allows the creation of a user through react based interface.

Faire un schema explicatif