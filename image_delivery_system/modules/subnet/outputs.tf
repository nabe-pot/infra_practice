output "subnets" {
  value = {
    # i.availability_zone => i.idは、配列のKeyをavailability_zoneに設定している
    for i in aws_subnet.main : i.availability_zone => i.id
  }
}