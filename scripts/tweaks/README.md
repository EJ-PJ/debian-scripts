# tweaks

Scripts for tweaking some system options


## tweak-fstab

Tweak the mount options of filesystems for performance and efficiency, by default only tweaks the
mount options of btrfs, with the `-o` option it will also tweak for other filesystems:

- btrfs: changes the mount options from "defaults" to "noatime,compress=zstd:${comp}", the default
  comp value is 10

- other filesystems: if the `-o` flag is passed then it changes "default" for "noatime"
