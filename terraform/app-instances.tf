/* Setup our aws provider */
provider "aws" {
  profile  = "${var.aws_profile}"
  region   = "us-east-1"
}

resource "aws_instance" "server" {
  count           = "1"
  instance_type   = "m4.large"
  ami             = "ami-bcf84ec6"
  key_name        = "${aws_key_pair.deployer.key_name}"

  vpc_security_group_ids = ["${aws_security_group.rocketchat.id}"]

  connection {
    # The default username for our AMI
    user        = "fedora"
    private_key = "${file(var.ssh_private_key_path)}"
    agent       = true
  }

  tags {
    Name    = "skane-rocketchat-${format("%d", count.index + 1)}"
    Trainer = "Sean P. Kane"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf clean all",
      "sudo dnf -y update",
      "sudo dnf -y install convert-to-edition",
      "sudo convert-to-edition -p -e server",
      "sudo setenforce Permissive",
      "sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config",
      "sudo dnf -y install dnf-plugins-core",
      "sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo",
      "sudo dnf -y install docker-ce",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo dnf -y install the_silver_searcher htop",
      "sudo dnf -y install mongodb",
      "sudo mkdir -p /opt/rocketchat/data/uploads",
      "sudo mkdir -p /opt/mongodb/data/db"
    ]
  }

  provisioner "file" {
    source      = "./files/mongodb.service"
    destination = "mongodb.service"
  }

  provisioner "file" {
    source      = "./files/rocketchat.service"
    destination = "rocketchat.service"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /etc/data",
      "sudo chown fedora /etc/data",
      "echo EXT_IP=$(curl -s ipconfig.io) > /etc/data/external-ip",
      "sudo mv mongodb.service /etc/systemd/system/mongodb.service",
      "sudo chown root:root /etc/systemd/system/mongodb.service",
      "sudo mv rocketchat.service /etc/systemd/system/rocketchat.service",
      "sudo chown root:root /etc/systemd/system/rocketchat.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable mongodb",
      "sudo systemctl start mongodb",
      "mongo 127.0.0.1/rocketchat --eval \"rs.initiate({ _id: 'rs0', members: [ { _id: 0, host: '127.0.0.1:27017' } ]})\"",
      "sudo systemctl enable rocketchat",
      "sudo systemctl start rocketchat"
    ]
  }

}
