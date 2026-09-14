# NVIDIA-Settings-Helper
A Batch file that helps you to get the right settings for your Nvidia Card
# NVIDIA Settings Helper

A simple Windows batch tool that provides guided NVIDIA and Windows settings recommendations for supported NVIDIA GPUs.

## Supported GPUs

* NVIDIA GeForce RTX 3060
* NVIDIA GeForce RTX 4070
* NVIDIA GeForce RTX 5070

The helper can automatically detect a supported NVIDIA GPU or let you manually select a GPU profile.

## What NVIDIA Settings Helper Does

NVIDIA Settings Helper provides a step-by-step guide for configuring settings in:

* Windows Advanced Display
* NVIDIA App
* NVIDIA Control Panel
* DLSS settings
* Frame Generation
* Super Resolution
* Ray Reconstruction
* Smooth Motion
* Low Latency
* DSR
* Image Scaling
* G-SYNC
* Power Management
* Shader Cache
* Texture Filtering
* Color settings
* NVIDIA Reference Mode
* NVIDIA Automatic Tuning

It also includes optional system tools for:

* Cleaning temporary files
* Flushing DNS
* Resetting network configuration
* Resetting Winsock
* Closing selected background applications
* Switching Windows to High Performance power mode

## GPU Profiles

### RTX 3060

The RTX 3060 profile is designed around the capabilities of the RTX 3060 and includes settings such as:

* DLSS Quality
* Smooth Motion: Off
* DSR: 2.00x
* Image Scaling: Off
* G-SYNC Compatible
* Prefer Maximum Performance

### RTX 4070

The RTX 4070 profile includes settings for its DLSS and Frame Generation capabilities, including:

* DLSS Quality
* Frame Generation
* Smooth Motion: On
* DSR: 2.00x
* Image Scaling: Off
* G-SYNC Compatible
* Prefer Maximum Performance

### RTX 5070

The RTX 5070 profile includes settings specifically configured for the RTX 5070, including:

* DLSS Super Resolution
* Frame Generation
* Smooth Motion: Off
* DSR: 1.78x
* Image Scaling: On
* Render Resolution: 77%
* Sharpen: 85%
* G-SYNC Compatible
* Prefer Maximum Performance

## How to Use

1. Download `NVIDIA-Settings-Helper.bat`.
2. Right-click the `.bat` file.
3. Select **Run as administrator**.
4. Choose **Auto Select GPU** or **Manual Select GPU**.
5. Follow the instructions shown on screen.
6. Move through the guide using the **N** key.

Administrator privileges are required because some of the optional system functions use Windows commands that require elevated permissions.

## Important

NVIDIA Settings Helper is a **guided settings tool**. It does not automatically change every NVIDIA setting for you.

The guide tells you which settings to use and where to find them in Windows, NVIDIA App, and NVIDIA Control Panel.

Some settings and options can vary depending on:

* NVIDIA driver version
* Windows version
* GPU model
* Monitor
* Game
* NVIDIA App version
* NVIDIA Control Panel version

Your available options may therefore differ from the screenshots or instructions.

## System Functions

The helper includes optional maintenance functions.

### System Clean

Can clear:

* User temporary files
* Windows temporary files

It also flushes the DNS cache.

### Network Reset

The network function can:

* Flush DNS
* Reset TCP/IP
* Reset Winsock

A Windows restart may be required afterward.

### Background Process Cleanup

The helper can close selected applications such as:

* OneDrive
* Microsoft Teams
* Discord
* Xbox App

It can also switch Windows to the High Performance power plan and clear temporary files.

**Important:** Make sure you are not using an application before selecting this function, as it may be closed.

## Automatic Tuning

The NVIDIA profiles include instructions for NVIDIA Automatic Tuning.

Automatic Tuning can take approximately 30–45 minutes.

It is recommended to leave the PC unused while the tuning process is running.

## Disclaimer

These settings are recommendations and are not guaranteed to provide higher FPS, lower latency, or better image quality in every game or system.

Performance and image quality depend on your individual hardware, drivers, games, monitor, and existing configuration.

Use the tool at your own discretion.

The author is not responsible for problems resulting from changes made to Windows, NVIDIA settings, network configuration, or other system settings.

## License

This project is provided for personal and educational use.

You may download and use the NVIDIA Settings Helper for your own PC.

---

**NVIDIA Settings Helper**

Supported profiles: **RTX 3060 | RTX 4070 | RTX 5070**
