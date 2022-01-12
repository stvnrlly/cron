# cron for norns

This is a mod script for the Monome Norns, providing a basic interface for `cron` functions.

When initialized, it creates a crontab file and loads it as the file for the `we` user. This starter crontab file contains a recursive cron job that reloads itself each minute, so user edits will get picked up by the system automatically.

If you want it to reload faster, you can do so in the mod menu.

NOTE: check your time zone! After setting it with `sudo raspi-config`, you may still need to restart in order for `cron` to pick up the change.

## Public domain

This work is dedicated to the public domain. Copyright is waived under a
[CC0-1.0 license](LICENSE.md).
