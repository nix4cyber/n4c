---
title: "Recovery"
description: "Essential data recovery techniques and tools for digital forensics. Learn file carving with TestDisk and PhotoRec, disk imaging with dd and ddrescue to recover deleted files, lost partitions, and damaged filesystems from storage devices."
seo:
  title: "Data Recovery Guide - File Carving, Disk Imaging & Partition Recovery"
  description: "Complete data recovery tutorial covering TestDisk for partition recovery, PhotoRec for file carving, ddrescue for damaged drive imaging, and disk forensics techniques to recover deleted files from FAT, NTFS, ext2 filesystems and corrupted storage devices."
---

## File Carving

File carving is a technique used to recover files from a disk image or raw data by searching for file signatures and extracting the data without relying on the filesystem structure. This is particularly useful when the filesystem is damaged or missing.

### TestDisk

[TestDisk](https://www.cgsecurity.org/wiki/TestDisk) is a powerful open-source data recovery software designed to recover lost partitions and repair non-booting disks. It can recover deleted files from FAT, NTFS, and ext2 filesystems, and it is particularly useful for recovering lost partitions and making non-bootable disks bootable again, it has write privileges, so it can write to the disk to recover partitions.

To recover partitions from a media image or repair a filesystem image, run the following command:

```bash
testdisk file.img
```

To give multiple Encase images as input, you can use the following command:

```bash
testdisk 'image.???'
```

Choose the disk you want to recover partitions from, and use raw devices if possible (`/dev/rdisk*`) instead of (`/dev/disk*`) to avoid unnecessary buffering.
After that, select the partition table type, usually the default value is the correct one, and then select the partition you want to recover. You can then use the `Analyse` option to search for lost partitions.
Then, you can use the `Quick Search` option to search for lost partitions, and you can press `P` to list files in the highlighted partition (and then `q` to go back to the previous display).
If all partitions are found, you can use the `Write` option to write the partition table to disk. If not, you can use the `Deeper Search` option to search for more partitions. Examine the results, and remove any partitions that is damaged (D) and add new working partitions to the logical partition table (L), using the arrow keys to change the statuses of the partitions.
Finally, if all partitions are listed and only in this case, confirm at `Write` with Enter, `y` and `OK`.
Now, the partitions are registered in the partition table.
If you have any questions about how to use TestDisk, you can refer to the [TestDisk documentation](https://www.cgsecurity.org/wiki/TestDisk_Step_By_Step).

### PhotoRec

[PhotoRec](https://www.cgsecurity.org/wiki/PhotoRec) is a file data recovery software designed to recover lost files including videos, documents, and archives from hard disks, CD-ROMs, and memory cards. It ignores the filesystem and goes after the underlying data, making it effective even if the filesystem has been severely damaged or reformatted. It only has read privileges, so it cannot write to the disk, which makes it safer to use in some scenarios.

To recover files from a media image, you can use the following command:

```bash
photorec file.img
```

To give multiple Encase images as input, you can use the following command:

```bash
photorec 'image.???'
```

Then, choose the disk you want to recover files from, select the partition that holds the lost files to then start the recovery.

If you have any questions about how to use PhotoRec, you can refer to the [PhotoRec documentation](https://www.cgsecurity.org/wiki/PhotoRec_Step_By_Step).

## Disk Imaging

Disk imaging is the process of creating a bit-by-bit copy of a storage device, such as a hard drive or USB flash drive. This is often done to preserve the original data while allowing analysis or recovery operations to be performed on the copy.

### dd

[dd](https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html) is a command-line utility for Unix and Unix-like operating systems that converts and copies files. It can be used to create disk images by copying the raw data from a device or file to another file.

### ddrescue

[GNU ddrescue](https://www.gnu.org/software/ddrescue/) is a data recovery tool that copies data from one file or block device (hard drive, CD-ROM, etc.) to another, trying to rescue the good parts first in case of read errors. It is particularly useful for recovering data from drives.

To use ddrescue, you can run the following command:

```bash
ddrescue -d "$source" "$output" file.map
```

Where `source` is the device or file you want to recover data from (e.g. `/dev/sda`), `output` is the file or device where you want to save the recovered data, and `file.map` is a file that keeps track of the progress of the recovery.

Then define the starting position and maximum recovery size of the execution :

```bash
ddrescue -i"$starting_size" -s"$max_recovery_size" "$source" "$output" file.map
```

This will start the recovery from the specified position and limit the maximum size of the recovered data.
If you need more information about how to use ddrescue, you can refer to the [GNU ddrescue manual](https://www.gnu.org/software/ddrescue/manual/ddrescue_manual.html).

## Honourable Mentions

DMDE, R-Photo and Recuva are other notable data recovery tools that can be useful in various scenarios, although not availabe in nixpkgs.
