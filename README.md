# lsgroup_pro.sh

This repository contains a small Bash script created to simplify Linux system administration tasks, along with personal Linux notes documented using GitHub Wiki.

---

## About the Script

While working with Linux, I noticed that there is **no built-in command** to list only **user-created groups** together with information about **when they were created**.

To address this, I wrote a custom shell script called `lsgroup_pro.sh`.

The script displays:
- Group name
- Group ID (GID)
- Approximate creation date

It helps quickly inspect group information without manually searching through system logs.

---

## How It Works

- Reads group data from `/etc/group`
- Filters groups with **GID between 1000 and 65533** (typically user-created groups)
- Retrieves group creation dates by searching:
  - `journalctl`
  - `/var/log/auth.log`
  - `/var/log/syslog`
- If no creation log is found, the script marks the group as **Created Today**

---

## Example Output

```text
GROUP NAME      | GID    | CREATION DATE
developers      | 1001   | Jan 12 10:24
docker          | 1002   | Jan 15 14:03
```

Github Linux Notes (Github Wiki)
https://github.com/merveocal/linux-tools/wiki

