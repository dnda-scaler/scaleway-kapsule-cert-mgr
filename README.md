# scaleway-kapsule-cert-mgr
The main goal of this Sample is to deploy cert manager along with External DNS.
[external DNS](https://github.com/kubernetes-sigs/external-dns) will create the DNS Part in Scaleway DNS whereas Cert Manager will be use to rely on LetsEncrypt to generate certificate.

For that purpose, we will deplot the user-management app that allows the creation of a user through react based interface.
# K8S yaml file that will deploy the sample application which consists
# in API,Recat Web interface exposed through API and an ingress that will be in another file for explanation purpose


Faire un schema explicatif
kueconfig durectement téléchargé pour interagir avec le cluster
Dashboard Access
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:https/proxy
Issuer staging Vs Prod

Resources
- https://mricher.fr/post/scaleway-kapsule-howto-ingress-nginx-cert-manager/
- https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/annotations.md
