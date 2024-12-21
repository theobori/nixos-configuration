# Features

Here's an overview of what my Nix configuration offers:

- **External Dependency Integrations**:
  - Access the Nix User Repository (NUR) for additional packages and
    enhancements.

- **Home Manager**: Manage your dotfiles, home environment, and user-specific
  configurations with [Home Manager](https://github.com/nix-community/home-manager).

- **DevShell Support**: The flake provides a development shell (`devShell`) to
  support maintaining this flake. You can use the devShell for convenient
  development and maintenance of your Nix environment.

- **CI with Cachix**: The configuration includes continuous integration (CI)
  that pushes built artifacts to [Cachix](https://github.com/cachix/cachix). This ensures efficient builds and
  reduces the need to build dependencies on your local machine.

- **Utilize sops-nix**: Secret management with [sops-nix](https://github.com/Mic92/sops-nix) for secure and encrypted
  handling of sensitive information.

- **Theming with stylix**: Management of system and application colorscheme,
  fonts and wallpaper with [stylix](https://stylix.danth.me).

- **Declarative disk partitioning**: Use [disko](https://github.com/nix-community/disko) to declare your disk and format it
  using the Nix language.

- **Declarative Vencord configuration**: Use [nixcord](https://github.com/KaylorBen/nixcord) to declare your
  Vencord settings and plugins.

- **Declarative KDE Plasma configuration**: Use [plasma-manager](https://github.com/nix-community/plasma-manager) to declare your
  Vencord settings and plugins.

- **Declarative Flatpak installation**: Use [declarative-flatpak](https://github.com/GermanBread/declarative-flatpak) to manage
  KDE Plasma with Home Manager.

- **Declarative Spotify customization**: Use [spicetify-nix](https://github.com/Gerg-L/spicetify-nix) to modify Spotify.
