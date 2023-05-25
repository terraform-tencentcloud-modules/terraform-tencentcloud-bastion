ingress_with_cidr_blocks=[
                           {
                             port       = "36000"
                             protocol   = "TCP"
                             cidr_block = "211.159.183.0/24"
                             policy     = "accept"
                           },
                           {
                             port       = "36000"
                             protocol   = "TCP"
                             cidr_block = "81.69.102.0/24"
                             policy     = "accept"
                           },
                           {
                             port       = "36000"
                             protocol   = "TCP"
                             cidr_block = "106.55.203.0/24"
                             policy     = "accept"
                           },
                           {
                             port       = "36000"
                             protocol   = "TCP"
                             cidr_block = "101.33.121.0/24"
                             policy     = "accept"
                           },
                           {
                             port       = "36000"
                             protocol   = "TCP"
                             cidr_block = "101.32.250.0/24"
                             policy     = "accept"
                           },
                           {
                             port       = "36000"
                             protocol   = "TCP"
                             cidr_block = "175.27.43.0/24"
                             policy     = "accept"
                           },
                           {
                             #port      = ""
                             protocol   = "ICMP"
                             cidr_block = "211.159.183.0/24"
                             policy     = "accept"
                           },
                        ]
egress_with_cidr_blocks=[
                            {
                              port      = "36000"
                              protocol   = "TCP"
                              cidr_block = "211.159.183.0/24"
                              policy     = "accept"
                            },
                            {
                              #port      = ""
                              protocol   = "ICMP"
                              cidr_block = "211.159.183.0/24"
                              policy     = "accept"
                            },
                        ]
security_group_name="bob_security_group_name"

instance_name     = "bob-tf-app"
availability_zone = "ap-guangzhou-6"
allocate_public_ip = false
internet_max_bandwidth_out = 0
tags = {name:"bob"}
host_name = "bobdom.com"
key_ids = ["skey-ktc6c3at"]
#user_data_raw = "yum intall mysql-common.x86_64"
user_data_base64 = "IyEvYmluL2Jhc2gKZWNobyAiSGVsbG8gVGVuY2VudCBDbG91ZC4iCg=="

cbs_block_devices=[
                    {
                      "storage_name":"test_cbs",
                      "storage_size":"10",
                      "storage_type":"CLOUD_PREMIUM"
                      "force_delete":false
                    }
                  ]
region="ap-guangzhou"
create_security_group=true