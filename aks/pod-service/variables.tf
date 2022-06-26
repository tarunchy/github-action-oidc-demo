variable "kubeconfig" {
  default = "/home/dlyog1/.kube"
}

variable "kubernetes_host" {
  type          =  "string"
  description   = "kubernetes host"
}
