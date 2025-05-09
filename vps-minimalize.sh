#!/bin/bash

# Minimal VPS Cleanup Script for Ubuntu (DigitalOcean specifically...)
# (Use only on fresh VPS setups or if you're sure of what you're disabling.)
set -e

echo "🔧 Starting VPS minimalization..."

### DigitalOcean: Disable metrics agent
if command -v do-agent &>/dev/null && systemctl is-active --quiet do-agent; then
  echo "Disabling DigitalOcean do-agent..."
  sudo systemctl disable --now do-agent
fi

### udisks2: Unused disk management service (safe to disable on headless VPS)
if systemctl is-active --quiet udisks2.service; then
  echo "Disabling udisks2.service..."
  sudo systemctl disable --now udisks2.service
fi

### polkit: Used for GUI privilege escalation (safe to disable on servers)
if systemctl is-active --quiet polkit; then
  echo "Disabling polkit..."
  sudo systemctl disable --now polkit
fi

### MOTD (Message of the Day): Remove login spam
echo "Cleaning up MOTD..."
sudo chmod -x /etc/update-motd.d/*
echo "Welcome to your clean VPS 🎉" | sudo tee /etc/motd >/dev/null

### Reboot flag: Remove "System restart required" message
if [ -f /var/run/reboot-required ]; then
  echo "Removing reboot-required flag..."
  sudo rm -f /var/run/reboot-required
fi

### SSH login noise: Disable MOTD and last login message
echo "Silencing SSH login banners..."
sudo sed -i 's/^#\?PrintMotd.*/PrintMotd no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?PrintLastLog.*/PrintLastLog no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

### Optional: Install useful monitoring tools
echo "Installing optional CLI tools (htop, glances)..."
sudo apt update
sudo apt install -y htop glances

echo ""
echo "✅ VPS cleanup complete!"
echo "🌀 You may reboot your server for all changes to take effect."
echo "[!] sudo reboot"
