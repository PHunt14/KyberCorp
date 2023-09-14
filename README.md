node: 18.17.1
helm: 3.12.2
terraform: 1.5.6
kubernetes: 1.27

helm upgrade  --install kyber helm/kyberapp --create-namespace --namespace kyber-test

aws eks update-kubeconfig --name dev-eks-psixNwuA --region us-east-1