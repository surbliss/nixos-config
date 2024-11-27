# My NixOS-configuration
For personal use, but feel free to use it for inspiration.

# First installation on NixOS
`git clone` this repo into `/etc/nixos/`. After building and creating a user,
remember to `sudo chown -R USER:` the `nixos` folder, so the git repo doesn't
require sudo-privileges.

# How to set up /etc/nixos/ folder as a git repo, that can be pushed.
Souce: https://www.youtube.com/watch?v=20BN4gqHwaQ
1. Configure git username/email (in home-manager)
2. Configure SSH: Either copy existing private and public ssh-key to `.ssh` and add the public SSH-key to `user.users.<username>.openssh.authorizedKeys.keys = []` in `configuration.nix`, or create a new key with `ssh-keygen`, and add the public key to Github (or what else you are using).
    
3. Make `.git` folder: `sudo mkdir .git` in `/etc/nixos`
4. Remove `sudo` requirement: `sudo chown <user-name>:users .git` (replace `<user-name>` with the system's username).
5. Run `git init`.
6. Add `progams.git.extraConfig.safe.directory = "/etc/nixos";` in home-manager.
7. Make an **empty** repo (on Github, or another site).
8. `git remote add <remote-name> <link-to-repo>`
    Note1: `<remote-name>` is often `origin`, but it can be more descriptive, like `github`.
    Note2: If using SSH on Github, `<link-to-repo>` is of the form `git@github.com:<github-username>/<git-repo-name>.git`.
9. `git push <remote-name> main`, and you're done!

Alternative `git push <remote-name> master`, (github-syntax)and you're done!
* Optional: Add `programs.git.extraConfig.init.defaultBranch = "main";` to home-manager.

 Alternative: Add `programs.git.extraConfig.init.defaultBranch = "master";` to home-manager.

## Potential errors
### 'Git tree ... is dirty'
Make sure to add (and commit) everything to the git repo, and it should be fine.
Comes up when you import a file (in configuration.nix, or likewise), but the file is not added to your git repo. Is to make sure, that there are no errors when cloning the repo, and building from it.

### Note on git
Note that when running `sudo`, the local git configuration is not passed.
Thus, you should at some point do `git config user.email ...` and `git config
user.name ...`.
