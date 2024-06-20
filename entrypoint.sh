#!/bin/sh

cd / && git clone https://github.com/Dash-Industry-Forum/livesim-content.git 
cd /livesim-content/ && ./unpack_all.sh
/livesim2 --writerepdata --port $PORT --logformat json --vodroot /livesim-content
