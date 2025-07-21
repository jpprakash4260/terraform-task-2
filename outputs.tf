output "ec2_us_east_public_ip" {
  value = aws_instance.ec2_us_east.public_ip
}

output "ec2_ap_south_public_ip" {
  value = aws_instance.ec2_ap_south.public_ip
}
