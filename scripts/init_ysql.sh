#!/bin/bash

###############################################################################
# Run initdb on one of the nodes
###############################################################################
echo "Initializing YSQL on node ${MASTER_ADDR_ARRAY[0]} via initdb..."
YB_HOME=/home/ec2-user/yugabyte-db
source ${YB_HOME}/.yb_env.sh
YB_ENABLED_IN_POSTGRES=1 FLAGS_pggate_master_addresses=${YB_MASTER_ADDRESSES} ${YB_HOME}/tserver/postgres/bin/initdb -D /tmp/yb_pg_initdb_tmp_data_dir --no-locale --encoding=UTF8 -U postgres >>${YB_HOME}/tserver/ysql.out
echo "YSQL initialization complete."