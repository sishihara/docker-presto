#!/bin/bash

PRESTO_NODETYPE=$1

if [ "$PRESTO_NODETYPE" = "coordinator" ]; then
    printf "cat <<EOS\n`cat /opt/config.properties.coordinator.tmpl`\nEOS\n" | sh > ${PRESTO_HOME}/etc/config.properties
else
    printf "cat <<EOS\n`cat /opt/config.properties.worker.tmpl`\nEOS\n" | sh > ${PRESTO_HOME}/etc/config.properties
fi

printf "cat <<EOS\n`cat /opt/hive.properties.tmpl`\nEOS\n" | sh > ${PRESTO_HOME}/etc/catalog/hive.properties
printf "cat <<EOS\n`cat /opt/node.properties.tmpl`\nEOS\n" | sh > ${PRESTO_HOME}/etc/node.properties

${PRESTO_HOME}/bin/launcher run
