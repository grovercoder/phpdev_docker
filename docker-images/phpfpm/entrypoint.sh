#!/bin/bash

# ensure any bash shells have the TERM variable set so tools like LESS and NANO run properly.
grep -q -F 'export TERM' /etc/bash.bashrc || echo '' >> /etc/bash.bashrc && \
			echo "export TERM=xterm" >> /etc/bash.bashrc 


chown :webuser /var/log/php7.0-fpm.log
chmod g+w /var/log/php7.0-fpm.log

echo '**************************'
echo '*** PHPFPM Container Ready '
echo '**************************'
echo "CMD: $@"
exec "$@"
