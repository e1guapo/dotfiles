# System setup
This setup is for a Lenovo ThinkPad X1 Carbon running Fedora i3 Spin (Fedora 42).

## packages/management
- notifications: `dunst`
- config: `lxappearance`, `xfce4-settings`, `xfce4-power-manager`
- bluetooth: `blueman-applet` (blueman)
- network: `nm-applet` (network-manager-applet)
- screenshot: `flameshot`
- lockscreen signal: `xset`
- program launcher: `dmenu`

## Install basic packages

### Install packages using native package manager (`dnf`)
- `install lxappearance - configure system settings (like font size)`
- `Install bolt - kernel driver for thunderbolt`
- `Install power/settings management apps`
- `Install flatpak`
- `Install virtualization group`
```
sudo dnf install -y lxappearance bolt blueman xfce4-settings
sudo dnf install -y xfce4-power-manager flatpak
sudo dnf install @virtualization
```

### Use `xfce4-power-manager-settings` to configure power management settings.
GUI

### Install obsidian.
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub md.obsidian.Obsidian
```

### Fix graphics for second monitor
1. Remove nomodeset if it exists
```
sudo grubby --update-kernel=ALL --remove-args="nomodeset"
```

2. Add `force_probe` for Lunar Lake GPU
```
sudo grubby --update-kernel=ALL --args="i915.force_probe=64a0 xe.force_probe=64a0"
sudo reboot
```

### adjust lightdm font/size
adding the following to `/etc/lightdm/lightdm-gtk-greeter.conf`
```
[greeter]
font-name = Sans 18
xft-dpi = 120
```

### Then restart the service
```
sudo systemctl restart lightdm
```

### remove `plymouth` for text-based boot/luks prompt (needed for my new thinkpad)
1. Remove Plymouth package completely
```
sudo dnf remove plymouth plymouth-*
```

2. Update `GRUB_CMDLINE_LINUX`:
    - remove these parameters:
        - `rhgb`
        - `quiet`
    - add this parameter:
        - `rd.luks.options=none`

_note: No need for `plymouth.enable=0` since Plymouth is gone._

3. Regenerate GRUB config.
```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

4. Regenerate initramfs without Plymouth.
```
sudo dracut -f
```

### Install uv and brave browser
```
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsS https://dl.brave.com/install.sh | sh
```

_Change startup for brave to increase font size with the `--force-device-scale-factor=2` parameter. We currently do this with a wrapper script: `~/bin/browser`._

### install guix
```
wget 'https://git.savannah.gnu.org/gitweb/?p=guix.git;a=blob_plain;f=etc/guix-install.sh;hb=HEAD'
chmod +x guix-install.sh
sudo ./guix-install.sh
```

### set up selinux policy for guix
[`https://guix.gnu.org/manual/devel/en/html_node/SELinux-Support.html`](https://guix.gnu.org/manual/devel/en/html_node/SELinux-Support.html)

### Set up virtualization
https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/\#\_enabling\_hardware\_virtualization\_support

### fix boot legibility
1. Change GRUB to make the GRUB menu legible. First, generate a font:
```
sudo grub2-mkfont --output=/boot/grub2/fonts/DejaVuSansMono32.pf2 \
  --size=32 /usr/share/fonts/dejavu-sans-mono-fonts/DejaVuSansMono.ttf
```

2. Then edit /etc/default/grub to include the following.
```
GRUB_TERMINAL_OUTPUT="gfxterm"
GRUB_FONT=/boot/grub2/fonts/DejaVuSansMono32.pf2
```

3. Then run:
```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

4. Edit `/etc/vconsole.conf` to change the font (controls boot logs and LUKS prompt after GRUB). Change the font line to:
```
FONT=latarcyrheb-sun32
```

5. Then regenerate the `initramfs` so the font is available during early boot:
```
sudo dracut -f
```

6. Reboot to verify that everything worked.
