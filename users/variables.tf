variable "username" {
  type    = list(string)
  default = ["Developer1", "manager"]

}
variable "env" {
  type    = list(string)
  default = ["Development", "Production"]

}
variable "tags" {
  type = map(string)
  default = {
    "Env" = "Production"
  }

}