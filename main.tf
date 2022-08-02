resource "yandex_vpc_network" "this" {
  name        = var.name
  folder_id   = var.folder_id  
  labels      = var.vpc_labels  
  description = var.vpc_description
}

resource "yandex_vpc_route_table" "this" {
  network_id = yandex_vpc_network.this.id
  count = var.create_custom_route_table && var.custome_route_table_routes != [] ? 1 : 0

  dynamic "static_route" {
    for_each    = var.custome_route_table_routes
    iterator    = route
    content {
      destination_prefix = lookup(route.value, "destination_prefix", null)
      next_hop_address   = lookup(route.value, "next_hop_address", null)
    }
  }
}

resource "yandex_vpc_subnet" "this" {
  for_each       = { for k, v in var.vpc_subnets : k => v }
  description    = lookup(each.value, "description", null)
  folder_id      = lookup(each.value, "folder_id", null)
  v4_cidr_blocks = lookup(each.value, "v4_cidr_blocks")
  labels         = lookup(each.value, "labels", null)
  name           = lookup(each.value, "name", null)
  zone           = lookup(each.value, "zone")
  network_id     = yandex_vpc_network.this.id
  route_table_id = var.create_custom_route_table && var.custome_route_table_routes != [] ? yandex_vpc_route_table.this[0].id : null

  dynamic "dhcp_options" {
    for_each    = length(keys(lookup(each.value, "dhcp_options", {}))) == 0 ? [] : [each.value.dhcp_options]
    content {
        domain_name         = lookup(dhcp_options.value, "domain_name", null)
		    ntp_servers         = lookup(dhcp_options.value, "ntp_servers", null)
        domain_name_servers = lookup(dhcp_options.value, "domain_name_servers", null)
    }
  }
}

resource "yandex_vpc_security_group" "this" {
  network_id  = yandex_vpc_network.this.id
  name        = "sg-default-${yandex_vpc_network.this.id}"
  count       = var.create_default_security_group && (var.default_security_group_ingress != [] || var.default_security_group_egress != []) ? 1 : 0
  
  dynamic "ingress" {
    for_each    = { for k, v in var.default_security_group_ingress : k => v }
    iterator    = ingress
    content {
      protocol       = lookup(ingress.value, "protocol", null)
      description    = lookup(ingress.value, "description", null)
      labels         = lookup(ingress.value, "labels", null)
      from_port      = lookup(ingress.value, "from_port", null)
      to_port        = lookup(ingress.value, "to_port", null)
      port           = lookup(ingress.value, "port", null)
      v4_cidr_blocks = lookup(ingress.value, "v4_cidr_blocks", null)
      v6_cidr_blocks = lookup(ingress.value, "v6_cidr_blocks", null)
    }
  }

  dynamic "egress" {
    for_each    = { for k, v in var.default_security_group_egress : k => v }
    iterator    = egress
    content {
      protocol       = lookup(egress.value, "protocol", null)
      description    = lookup(egress.value, "description", null)
      labels         = lookup(egress.value, "labels", null)
      from_port      = lookup(egress.value, "from_port", null)
      to_port        = lookup(egress.value, "to_port", null)
      port           = lookup(egress.value, "port", null)
      v4_cidr_blocks = lookup(egress.value, "v4_cidr_blocks", null)
      v6_cidr_blocks = lookup(egress.value, "v6_cidr_blocks", null)
    }
  }
}
