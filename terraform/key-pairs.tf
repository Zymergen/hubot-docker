resource "aws_key_pair" "deployer" {
  key_name = "trainer_sean_kane_hubot"
  public_key = "${file(var.ssh_public_key_path)}"
}
