# Important - _not_ to be imported into NixOS-config
let

  asus21-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/LpSdViH0+Ksk93UINInLOX5UANVCLWOAUHYMpT00K";
  asus21-user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj";
  asus21 = [
    asus21-system
    asus21-user
  ];
in
{
  "KU_PASSWORD.age".publicKeys = asus21;
  "KU_MAIL.age".publicKeys = asus21;
}
