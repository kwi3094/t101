variable "nick_name" {
  type = string
  default = "ongja"
}

variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "public_subnet_map" {
   type = map
   default = {
      public-sub-1 = {
         az = "ap-northeast-2a"
         cidr = "10.10.1.0/24"
      }
      public-sub-2 = {
         az = "ap-northeast-2c"
         cidr = "10.10.2.0/24"
      }
   }
}

variable "private_subnet_map" {
   type = map
   default = {
      private-sub-1 = {
         az = "ap-northeast-2a"
         cidr = "10.10.101.0/24"
      }
      private-sub-2 = {
         az = "ap-northeast-2c"
         cidr = "10.10.102.0/24"
      }
   }
}




