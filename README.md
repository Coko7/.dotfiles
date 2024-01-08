# .dotfiles

All my Linux configuration files. I use this to configure my entire system.

## System setup

- Operating system: [Arch Linux](https://archlinux.org/)
- Display server: [Xorg](https://www.x.org/)
- Window manager: [awesome](https://awesomewm.org/)
- Application launcher: [Rofi](https://github.com/davatorium/rofi) (also using [emoji](https://github.com/Mange/rofi-emoji) and [calc](https://github.com/svenstaro/rofi-calc))
- Compositor: [picom](https://github.com/yshui/picom)
- Shell: [Zsh](https://www.zsh.org/) (with [Starship](https://starship.rs/) for my prompt)
- Terminals:
  - [Alacritty](https://alacritty.org)
  - [Konsole](https://konsole.kde.org/)
- Text/code editor: [Neovim](https://neovim.io/) (using [kickstart](https://github.com/nvim-lua/kickstart.nvim))
- Audio:
  - Drivers and interface: [ALSA](https://www.alsa-project.org/)
  - Sound server: [PipeWire](https://pipewire.org/)
  - GUI apps:
    - [PulseAudio Volume Control](https://freedesktop.org/software/pulseaudio/pavucontrol/) for simple audio control
    - [QjackCtl](https://qjackctl.sourceforge.io/) for advanced audio stuff
- Theming:
  - [Catpuccin](https://github.com/catppuccin/catppuccin) Mocha for my color scheme (I also use [Rigel](https://github.com/Rigellute/rigel) sometimes)
  - [LXAppearance](https://github.com/lxde/lxappearance) to configure my GTK theme
  - [Qt5ct](https://github.com/desktop-app/qt5ct) for apps that use QT toolkit (KDE apps)

## Other applications

- Browser: [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- Communication:
  - Messaging: [Signal](https://www.signal.org/)
  - Discord client: [Webcord](https://github.com/SpacingBat3/WebCord)
- File managers:
  - [Dolphin](https://apps.kde.org/dolphin/)
  - [Nemo](https://github.com/linuxmint/nemo)
  - [ranger](https://github.com/ranger/ranger) (terminal-based)
- Images
  - Drawing: [Krita](https://krita.org/)
  - Editing: [Gimp](https://www.gimp.org/)
  - Vewing: [feh](https://feh.finalrewind.org/)
- Network:
  - Synchronization: [Syncthing](https://syncthing.net/)
  - VPN: [OpenVPN](https://openvpn.net/)
- Office:
  - [ONLYOFFICE](https://www.onlyoffice.com/) for my Office suite 
  - [Joplin](https://joplinapp.org/) for taking notes (uses Markdown)
- Screenshots: [Flameshot](https://flameshot.org/)
- Torrent: [qBittorrent](https://www.qbittorrent.org/)
- Videos:
  - Editing: [Kdenlive](https://kdenlive.org/en/)
  - Viewing: [mpv](https://mpv.io/)
  - YouTube client: [FreeTube](https://freetubeapp.io/)

I try to limit myself to only use [FLOSS](https://wikipedia.org/wiki/Free_and_open-source_software) software. If you are interested, I recommend you to check the following websites:
- [Privacy Tools](https://www.privacytools.io/)
- [Privacy Guides](https://www.privacyguides.org/)
- [Thew New Oil](https://thenewoil.org/)

## Inspiration

I did not make all of this myself. I am mainly tweaking existing configs from other people:
- [Phantas0s](https://github.com/Phantas0s/.dotfiles): Solid Zsh setup (without [omz](https://ohmyz.sh/)) and overall nice directory structure (Blog: [The Valuable Dev](https://thevaluable.dev/))
- [BrodieRobertson](https://github.com/BrodieRobertson/dotfiles): Automatic sourcing of aliases (Youtube: [Brodie Robertson](https://www.youtube.com/channel/UCld68syR8Wi-GY_n4CaoJGA)
- [Derek Taylor](https://gitlab.com/dwt1/dotfiles): Offers great advice on how to manage dotfiles (Youtube: [DistroTube](https://youtu.be/RIvJ8FNZrfc))
