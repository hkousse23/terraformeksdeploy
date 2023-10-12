#data block to read local vpc terraform.tfstate file ### this is a local remote backend 
#but you can't used this as backend for gitaction worflows bcos it will not work USE!! remote backend instead... 
data "terraform_remote_state" "network" {  # this data can run  before the vpc module is ran  --- the state wont be ready before the terraform plsan
  backend = "local"
  config = {
    path = "./vpcseries/terraform.tfstate"
  }
}


#s3 backend setup ! this remote backend can be use for gitActions
#backend "s3" {
#bucket = "lanmark-automation-kenmak"                  ----->>>  ## this is your s3 buckect name
#region = "us-west-2"                                  ----->>>  ## my buckect location Azs
#key =  "terraform.tfstate"                            ----->>>  ## this is what you want to be in your s3 buckect
#dynamodb_table = "control-tower-terraform-statelock"
#encrypt  =  true
#}



# Create node group in the create vpc using created node role
# ( this what create your node group{ all your nodes} )


resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "private-nodes"
  node_role_arn   = data.terraform_remote_state.network.outputs.node_role
  #node_role_arn = "arn:aws:iam::109753259968:role/eks-node-group-nodes"

  subnet_ids = [
    data.terraform_remote_state.network.outputs.private[0], data.terraform_remote_state.network.outputs.private[1]
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.micro"]

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "devOps"
  }
  # This tags are important if we are going to use an auto-scaler
  tags = {
    "k8s.io/cluster-autoscaler/demo"    = "owned"
    "k8s.io/cluster-autoscaler/enabled" = true

  }
}