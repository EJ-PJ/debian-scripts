# cronjobs

## aptup.sh

A script to provide apt daily without systemd, config is located at `/etc/apt/aptup.conf` and can be
like this:

```sh
# this script will sleep for a random amount of time since being
# ran by the cronjob, this file just CAPS OFF the MAXIMUM amount of time it will sleep
SLEEP_FOR_HOURS=4.5
```

The logs will be written to the cron logs spool

To set up the cronjob just copy the script onto `/etc/cron.daily/`

## fstrim.sh

A script to provide weekly fstrim without systemd, no configuration is needed as the FileSystems
which are on hardware that does support trim will be the only ones taken into consideration by
default, the logs are written to `/var/log/trim.log`

To set up the cronjob just copy the script onto `/etc/cron.weekly/`

NOTE however that even if the filesystem does support the trim operation the underliying
hardware may silently ignore the trim call altogether, for example with hard drives from western
digital fstrim sends the trim operation to every mounted partition with a filesystem that supports
it, the discard is calculated and then passed from the filesystem (through the kernel i'd assume)
onto the drive's firmware, the firmware accepts the trim operation with the provided discard
parameters, reports back that the proposed operation was accepted but then ignores it internally as
the firmware does it's own handling of empty/unused space, the kernel gets the success status back
to fstrim and fstrim reports back that the operation was a success and prints out the output that
as far as the process is concerned was correct, fstrim simply has no way to know that the drive's
firmware is lying.
