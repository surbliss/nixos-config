# Important - _not_ to be imported into NixOS-config
let
  asus21-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG/LpSdViH0+Ksk93UINInLOX5UANVCLWOAUHYMpT00K";
  asus21-user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2I6rQN0INm8Y4lajgTzgTZdBX1U/9NdiqtZ3xYjwoj";
  surface-book-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQSzkjLsfRzeDRpgZQI+KXfdqHq3vqt2MnInr4AH3qG root@surface-book";
  server-surface-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8wwPs6zmhawSbJM6+lIy1la2S6fVeOYIoySsXuKzgw root@server-surface";
  all-systems = [
    asus21-system
    asus21-user
    surface-book-system
    server-surface-system
  ];
in
{
  "KU_PASSWORD.age".publicKeys = all-systems;
  "KU_MAIL.age".publicKeys = all-systems;
}
