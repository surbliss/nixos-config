# My NixOS-configuration
For personal use, but feel free to use it for inspiration.

# How to set up /etc/nixos/ folder as a git repo, that can be pushed.
1. Configure git username/email (in home-manager)
2. Make `.git` folder: `sudo mkdir .git` in `/etc/nixos`
3. Remove `sudo` requirement: `sudo chown <user-name>:users .git` (replace `<user-name>` with the system's username).
4. Run `git init`.
5. Add `progams.git.extraConfig.safe.directory = /etc/nixos;` in home-manager.
