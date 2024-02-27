# Virgin Media Router Reboot Script
Simple bash script to enable you to automate Virgin Media reboots for your router.

This was tested on the Super Hub 4 and I have it deployed on my Raspberry Pi 4 being run on a schedule using cron.

## Description

`reboot.sh` is a shell script that logs into the router and then sends a reboot command. It uses the router's own REST API to authenticate and send the reboot command.

## Usage

After downloading the script you can run it using the following command:

```bash
bash reboot.sh "<router password>"
```

The password you use, is the same one you would use when logging into the router at [`192.168.0.1`](http://192.168.0.1/).

## Scheduling with Cron (Linux / Unix)

To schedule this script to run at specific times, you can use the `cron` utility.

1. Open the crontab file:

```bash
crontab -e
```

2. Add a new line to schedule the script. For example, to run the script every day at 3 AM, you would add:

```bash
0 3 * * * /path/to/reboot.sh "<router password>"
```

This line means "run `/path/to/reboot.sh "<router password>"` at minute 0 of hour 3, every day of the month, every month, and every day of the week".

3. Save and close the crontab file.

Replace `/path/to/reboot.sh` with the actual path to the `reboot.sh` script on your system.

## Note

Ensure that the `reboot.sh` script has the necessary execute permissions. You can add execute permissions using the following command:

```bash
chmod +x /path/to/reboot.sh
```