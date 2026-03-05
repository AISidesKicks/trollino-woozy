Gemini said
When your system starts heavily using swap, it feels like wading through wet cement. To figure out exactly which rogue processes are dumping their memory onto your hard drive, you have a few options ranging from built-in tools to visual monitors.

Here are the best ways to hunt down swap hogs on Linux:

1. The Power-User Tool: smem (Highly Recommended)
smem is a brilliant little utility specifically designed to give you accurate memory and swap reporting per process. It’s not always installed by default, but it is worth its weight in gold.

Install it:

Bash
sudo apt update && sudo apt install smem
Run it to see top swap users:

Bash
smem -r -s swap -t | head -n 20
-r reverses the sort (highest at the top).

-s swap sorts the list specifically by swap usage.

-t adds a total at the bottom.
This will spit out a clean table showing the exact Name, PID, and Swap usage (in kilobytes) of your worst offenders.

2. The Interactive Visual Way: htop
If you prefer a live-updating dashboard, htop is fantastic, but you usually have to tell it to show the Swap column.

Install/Run it:

Bash
sudo apt install htop
htop
How to show and sort by Swap:

Press F2 to enter the Setup menu.

Arrow down to Columns on the left.

Arrow right to the Available Columns section, scroll down, and find SWAP.

Press F5 to add it to your active columns.

Press F10 to exit setup.

Now, press F6 (Sort By), select SWAP on the left menu, and hit Enter.Gemini said
When your system starts heavily using swap, it feels like wading through wet cement. To figure out exactly which rogue processes are dumping their memory onto your hard drive, you have a few options ranging from built-in tools to visual monitors.

Here are the best ways to hunt down swap hogs on Linux:

1. The Power-User Tool: smem (Highly Recommended)
smem is a brilliant little utility specifically designed to give you accurate memory and swap reporting per process. It’s not always installed by default, but it is worth its weight in gold.

Install it:

Bash
sudo apt update && sudo apt install smem
Run it to see top swap users:

Bash
smem -r -s swap -t | head -n 20
-r reverses the sort (highest at the top).

-s swap sorts the list specifically by swap usage.

-t adds a total at the bottom.
This will spit out a clean table showing the exact Name, PID, and Swap usage (in kilobytes) of your worst offenders.

2. The Interactive Visual Way: htop
If you prefer a live-updating dashboard, htop is fantastic, but you usually have to tell it to show the Swap column.

Install/Run it:

Bash
sudo apt install htop
htop
How to show and sort by Swap:

Press F2 to enter the Setup menu.

Arrow down to Columns on the left.

Arrow right to the Available Columns section, scroll down, and find SWAP.

Press F5 to add it to your active columns.

Press F10 to exit setup.

Now, press F6 (Sort By), select SWAP on the left menu, and hit Enter.
