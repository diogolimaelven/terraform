variable "instance_type" {
  type    = string
  default = ""

}


variable "tags" {
  type = map(any)
 
  default = {
    Name = "app_server"
    Env  = "DEV"

  }

}