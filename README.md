

helm upgrade  --install kyber helm/kyberapp --create-namespace --namespace kyber-test

aws eks update-kubeconfig --name dev-eks-psixNwuA --region us-east-1