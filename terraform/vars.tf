variable "ssh_keys" {
  type = list(object({
    publickey = string
    user = string
  }))
  description = "list of public ssh keys that have access to the VM"
  default = [
      {
        user = "$SSH USER$"
        publickey = "$SSH PUBLIC KEY$"
      }
  ]
}
