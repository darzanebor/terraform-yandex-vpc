### Yandex.Cloud Terraform VPC module
#### Example
```
module "vpc" {
  source    = "github.com/darzanebor/terraform-yandex-vpc.git"
  name      = "my-vpc"
  folder_id = "my-folder-id"
  
  create_custom_route_table     = true
  create_default_security_group = true

  vpc_labels = { 
    env = "production"
  }

  vpc_subnets = [
    {
      v4_cidr_blocks = ["10.2.0.0/16"]
      zone           = "ru-central1-a"
      labels = { 
        type = "default-subnet"
      }
      dhcp_options   = {
        domain_name = null
        domain_name_servers = ["8.8.8.8", "8.8.8.8"] 
        ntp_servers = ["8.8.8.8", "8.8.8.8"]       
      }
    },
  ]

  custome_route_table_routes = [
    {
      destination_prefix = "10.2.0.0/16"
      next_hop_address   = "172.16.10.10"
    },
    {
      destination_prefix = "10.3.0.0/16"
      next_hop_address   = "172.16.10.10"
    }
  ]

  default_security_group_ingress = [
    {
      protocol       = "TCP"
      description    = "rule1 description"
      v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
      port           = 8080
    },
  ]

  default_security_group_egress = [
    {
      protocol       = "ANY"
      description    = "rule2 description"
      v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
      from_port      = 8090
      to_port        = 8099
    },
  ]  
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_route_table.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table) | resource |
| [yandex_vpc_security_group.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_security_group) | resource |
| [yandex_vpc_subnet.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_custom_route_table"></a> [create\_custom\_route\_table](#input\_create\_custom\_route\_table) | (Optional) - Create custom route table. | `bool` | `false` | no |
| <a name="input_create_default_security_group"></a> [create\_default\_security\_group](#input\_create\_default\_security\_group) | (Optional) - Create default security group. | `bool` | `false` | no |
| <a name="input_custome_route_table_routes"></a> [custome\_route\_table\_routes](#input\_custome\_route\_table\_routes) | (Optional) - Create custom route table routes. | `list` | `[]` | no |
| <a name="input_default_security_group_egress"></a> [default\_security\_group\_egress](#input\_default\_security\_group\_egress) | (Optional) - A list of egress rules to create with default security group. | `list` | `[]` | no |
| <a name="input_default_security_group_ingress"></a> [default\_security\_group\_ingress](#input\_default\_security\_group\_ingress) | (Optional) - A list of ingress rules to create with default security group. | `list` | `[]` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | (Optional) ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used. | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) Name of the network. Provided by the client when the network is created. | `any` | `null` | no |
| <a name="input_vpc_description"></a> [vpc\_description](#input\_vpc\_description) | (Optional) An optional description of this resource. Provide this property when you create the resource. | `any` | `null` | no |
| <a name="input_vpc_labels"></a> [vpc\_labels](#input\_vpc\_labels) | (Optional) Labels to apply to this network. A list of key/value pairs. | `map` | `{}` | no |
| <a name="input_vpc_subnets"></a> [vpc\_subnets](#input\_vpc\_subnets) | (Required) Subnets for creation in VPC | `list` | `[]` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_yandex_vpc_network"></a> [yandex\_vpc\_network](#output\_yandex\_vpc\_network) | n/a |
| <a name="output_yandex_vpc_route_table"></a> [yandex\_vpc\_route\_table](#output\_yandex\_vpc\_route\_table) | n/a |
| <a name="output_yandex_vpc_security_group"></a> [yandex\_vpc\_security\_group](#output\_yandex\_vpc\_security\_group) | n/a |
| <a name="output_yandex_vpc_subnet"></a> [yandex\_vpc\_subnet](#output\_yandex\_vpc\_subnet) | n/a |
