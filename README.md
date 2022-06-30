# Install terraform

## HOW TO

```
git clone https://github.com/tfutils/tfenv.git ~/.tfenv

echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
sudo ln -s ~/.tfenv/bin/* /usr/local/bin

mkdir -p ~/.local/bin/
. ~/.profile
ln -s ~/.tfenv/bin/* ~/.local/bin

touch /home/$USER/.tfenv/version

which tfenv

tfenv install VERSION

tfenv use VERSION
terraform -h 

```

## 

```
terraform init

terraform fmt

terraform plan

terraform apply

terraform show

terraform state list
terraform state rm "resource_name" 
terraform taint "resource_name" - copia o recurso
terraform untaint "resource_name"

```

## 

```
terraform apply -var="instance_type=t2.micro"

terraform apply -varfile="var.tfvars"

terraform import "resource_name" "id-instance"

```