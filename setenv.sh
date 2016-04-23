export APPSERVER_TYPE=wls

[ -z "${ORACLE_HOME}" ] && . ~/.env/idm.env

. ${ORACLE_HOME}/server/bin/setEnv.sh  >/dev/null

# classpath
#
cp=./classes
cp+=:${ORACLE_HOME}/server/platform/iam-platform-utils.jar
cp+=:${ORACLE_HOME}/server/platform/iam-platform-auth-server.jar
cp+=:${ORACLE_HOME}/server/apps/oim.ear/APP-INF/lib/csv.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jrf_11.1.1/jrf-api.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jmx_11.1.1/jmxframework.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jmx_11.1.1/jmxspi.jar
cp+=:${MW_HOME}/Oracle_IDM/modules/oracle.oes_11.1.1/thirdparty/identitystore.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.pki_11.1.1/oraclepki.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-manifest.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jacc-spi.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-common.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-internal.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-wls-trustprovider.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-api.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-platform.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-wls.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-unsupported-api.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-az-common.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-az-api.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-az-sspi.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-az-management.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-ee.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-mbeans.jar
cp+=:${MW_HOME}/oracle_common/modules/oracle.jps_11.1.1/jps-az-rt.jar
cp+=:${MW_HOME}/modules/javax.management.j2ee_1.0.jar
cp+=:${MW_HOME}/modules/javax.servlet_1.0.0.0_2-5.jar

export CLASSPATH=${cp}:${CLASSPATH}

# vi:ft=sh:
