# windows-service-switcher
Simple batch script that switches between Windows services by stopping one and starting the other, resolving conflicts in different use cases.

In my case, I use this as an easy way to swap between using MariaDB and MySQL server on the same machine without having them conflict at the same time over the same port.

# Usage/configuration

Script **must be ran as an administrator** to manage system services.

To configure the two services to switch, edit the batch script, and edit the two service name variables at the top.
