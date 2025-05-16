# noppes
nixos configuration modules for a kid friendly (locked down) machine setup

## About
A computing environment for my soon to be four year old.
It has to be easy to use, hard to break and fully free of advertisements.
Internet access is available, but not for browsing; mostly for installing updates and new features.

I've used a few different setups (some GNU/Linux distro, openbox, tint2, gcompris, basic stuff) and it's getting boring to set up similar systems all the time.
Now I have to replace a malfunctioning machine and get to set it all up once again.
Then the neighbour asked me to set up the same thing for their kid.

Enter NixOS!
This repository comes with a few configuration files for the apps listed below, some shell scripts and a few nix modules.
Use it by downloading the repo to a NixOS installation, follow the steps below and presto: a machine a child can pretty safely just play around with.

Please realise that this isn't a perfectly locked down system: the user can screw up their own config by opening emulator menus, changing the language of gcompris from it's settings menu et cetera.
You'll have to pick your own strategy in dealing with this (from home manager to having a conversation about it with your kid).

Depending on your preferences this could probably suite a child into their very early teens; gcompris scales with them through primary school.
When my users grow out of this system, I'll set up a new one.

Below are the installation and initial configuration instructions.
Further included are an overview of the most important apps and several lists containing what I wont do here, todos, et cetera.

> Just going over the files in this repo is probably the easiest way to get an overview of the system.
> There simply isn't that much here.
> This writeup mostly serves to allow me to forget all of this, I'll happily tinker on this, but like said: I'm done with setting this stuff up.

Use at your own risk!

## Deployment

> You should be at least familiar and preferably comfortable with NixOS and working in a shell in general before attempting the following.

### Install nixos
As the title says.
See the nixos manual.

### Add a user account for the kid user
As the title says.
See the nixos manual.

### Download the repo
Download this entire repo (for example, using git).

For now, it's important to keep the repo at `/etc/nixos/noppes/`.

> In my opinion, this shouldn't bother you, I'm assuming you are installing this on a machine that will only be used by one/some kids.
> I suggest just leaving the two basic nixos configuration files in place as well; why overcomplicate this machine?
> Do as you please, of course.

### Place your wallpaper into the repo
Add a wallpaper as `wallpaper.jpg` in the repo root.

### Update your openbox configs
Be sure to add a menu and or add some auto starting apps to your user.

You will need some way to open a terminal emulator for performing updates and cleanups.

> Alternatively, use ctrl-alt-<f#> to get a shell.

There are a few options here:

1. Copy the default openbox menu file into your openbox directory (has entries for `xterm`, `xfce4-launcher`, `firefox` by default; but also many other things).
2. Add an `autorun` to your openbox directory that opens a terminal emulator on login.
3. Create a custom menu file into your openbox directory.

### Update `configuration.nix`
Assuming that this repo was placed at `/etc/nixos/noppes`, add the following to your `configuration.nix` imports:

```
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./noppes/noppes.nix
      ./noppes/noppes_lightdm.nix
    ];
```

> If you do not want to use `lightdm`, don't add the `lightdm.nix` import.
> Lightdm is configured to use the wallpaper at `/etc/nixos/noppes/wallpaper.jpg`, consider doing the same for other display managers.

### Make sure you have `x11` enabled:

```
services.xserver.displayManager.lightdm.enable = true;
```

Since we'll be using `openbox`.

### Build
Build and switch is an option, probably best to build and reboot.

## Initial configuration

Log into the openbox session as the kid account, perform the following actions:

### volumeicon

> Note: At first launch, `volumeicon` will create a configuration file in`~/.config/`.
> If you don't see the icon in the tray, that probably means the config file needs some tweaking (likely another theme).

- Pick an icon that fits your wallpaper ().
- (Optional) enable the volume up, down and mute key hotkeys.

> Make sure you are using the right sound device (once you have the tray app working, you can fix that from there).

### Network

- Connect to your (wireless) network.

### gcomrpis

- Set the language.
- Download extra data from configuration screen (required to properly work).
- (Optional) pin apps to the first tab.
- (Optional) change the difficulty slider.
- (Optional) change other settings;
  - from the main settings;
  - with the per app settings (not available for every program).

### nestopia, snes9x

- (Optional) Connect and configure gamepads and other input settings.

> Also consult the entry on `noppes_app_launcher` below.

## Finish up: get rid of the previous DE
Assuming you installed a DE during installation, this is the perfect moment to remove that from your `configuration.nix`.

> Don't clean up those previous generations just yet, better safe than sorry!

## Apps

### Noppes app launcher
Clicking or tapping any empty space on the "desktop" will open up the main app launcher.

This is done through `noppes_app_launcher`, which can be found in this repository's `bin/` directory.

The launcher is hardcoded to show `gcompris` first.

It then looks for `~/roms/nes` and `~/roms/sfc`.

The launcher is set up to show 3 columns, which each can show 4 apps.
If more than 12 apps are added, the launcher can be scrolled, this doesn't support touch dragging.

#### The `~/roms/` directory.

For roms to show up in the launcher, add a directory containing the rom and an image in `.png` format.
The directory, rom file and image should all have the exact same name.

For example:

```
roms/
  nes/
    Mopper Monster Adventure
      Mopper Monster Adventure.nes
      Mopper Monster Adventure.png
  sfc/
    Super Mopper Monster Adventure - Mopper Quest
      Super Monster Adventure - Mopper Quest.png
      Super Monster Adventure - Mopper Quest.sfc
```

Use the shell to log into the kid user account, no need to mess around with file managers to copy a few files around or create a few directories.

## Usage

- Click/tap the screen anywhere on the empty desktop to show the app launcher.
- Right click to show openbox menu, which shows only an `Exit` entry by default.
- Pressing escape will kill (most) emulators.

## Tips

Do with this whatever you want.

### Escape kills emulators, but
Not the nes emulator, use alt-f4 for now.

### Don't overload it
Don't add to many programs; the first twelve app slots for the main app launcher are quite a lot.
Gcompris alone comes with a huge array of apps.
When it takes a user a minute to find an app, that's just bad UX (my primary user can't read yet, so filters wont help here).

### Copy openbox config files into home before using obconf
The openbox graphical configuration manager `obconf` is not available by default, however, you can easily run it with `nix-shell -p opbconf`.
Make sure to copy this repositories openbox configuration files into your home directory before running, so obconf knows what to open (and before you save a default config into your `~/.config/openbox`).

## What I wont do here

- Provide a `configuration.nix`: you'll have to perform your own install.
- Home manager: if you want to use it, you can, but I don't want any of that in here (for those who do not use it).
- Flakes (probably): I don't see any need for them now, who knows, that could change in the future.
- Web filtering, such as blocking websites or advertisements; I prefer solving these situations network wide.
- Video platforms: YouTube, Netflix, etc, it's all good fun, but we have a big screen for watching video.
- "Social media": that's exactly the type of content we are trying to avoid here.
- Email, chat, other communication platforms.
- A complicated configuration screen: you have your `configuration.nix` and whatever else you want to use, if you want small changes, use `~/.config/openbox/` `autostart`, `rc.xml` and `menu.xml` and other entries in `~/.config/`.
- Hibernation, screen savers, proper sleep support, security: I think these machine are functionally closer to a video game console / kid tablet fusion, no need for lock screens here.
- Anything else that is an invasion of privacy, comes with advertisements, et cetera.

Besides, if you want any of the above, you can easily set things up through `configuration.nix`, `autostart` et cetera.

## Todo list

- Add a super simple drawing program, tux paint is already too complicated, should work well with touch input
- Add a radio stream listener, probably as an optional module, my main user likes her heavy metal radio station.
- Add an easy way to add entries to the main app launcher from `~/.config/`.
- `nestopia` can't be killed with the escape key, see also the next section.
- Shrink this document by getting rid of todo items, bugs and things that require long explanations (whenever possible).
- Muck around with fonts and styles to create a more coherent environment.

## Things to keep in mind / I'm considering

### App kill button
One button to nuke any app instantly.
Escape is perfect for that, and at the same time, a bit too much.

### Removing firefox
To prevent an about link in some app becoming a way to open a browser.

Possible solution: install a browser only for your account.

### Tablet features
Some button to rotate the screen 90 degrees?

### Touch screen virtual gamepad
Add a little virtual gamepad left and right of emulator screens?
Would require some work, especially disabling on non touch machines (module can fix that) and supporting funky screens (such as 4:3 aspect ratio or super thin and wide displays).

### Recoding software
Be it vocals or video.
I'm somewhat reluctant regarding video of course.
Maybe audio recording and a "mirror" app through the webcam?
