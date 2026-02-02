# Secrets

The input `my-secrets` refers to my private GitHub repository which contains my secrets used in my NixOS configuration, notably through sops-nix. To retrieve this repository, you need to be able to authenticate via SSH. If you wish to use certain features exposed on Nix Flake, such as `packages`, I strongly recommend that you fork this repository and comment out the `my-secrets` input on Nix Flake. Otherwise you'll get an error due to a lack of permissions.
