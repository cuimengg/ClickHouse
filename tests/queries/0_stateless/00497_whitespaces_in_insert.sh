#!/usr/bin/env bash

CURDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=../shell_config.sh
. "$CURDIR"/../shell_config.sh

$CLICKHOUSE_CLIENT -q "DROP TABLE IF EXISTS ws";
$CLICKHOUSE_CLIENT -q "CREATE TABLE ws (i UInt8) ENGINE = Memory";

$CLICKHOUSE_CLIENT -q "INSERT INTO ws FORMAT RowBinary ;";
$CLICKHOUSE_CLIENT -q "INSERT INTO ws FORMAT RowBinary 	; ";
$CLICKHOUSE_CLIENT -q "INSERT INTO ws FORMAT RowBinary
; ";
echo -n ";" | $CLICKHOUSE_CLIENT -q "INSERT INTO ws FORMAT RowBinary";

$CLICKHOUSE_CLIENT --max_threads=1 -q "SELECT * FROM ws ORDER BY ALL";
$CLICKHOUSE_CLIENT -q "DROP TABLE ws";


$CLICKHOUSE_CLIENT -q "SELECT ''";


$CLICKHOUSE_CLIENT -q "CREATE TABLE ws (s String) ENGINE = Memory";
$CLICKHOUSE_CLIENT -q "INSERT INTO ws FORMAT TSV	;
";
echo ";" | $CLICKHOUSE_CLIENT -q "INSERT INTO ws FORMAT TSV"
if $CLICKHOUSE_CLIENT -q "INSERT INTO ws FORMAT TSV;" 1>/dev/null 2>/dev/null; then
    echo ERROR;
fi
$CLICKHOUSE_CLIENT --max_threads=1 -q "SELECT * FROM ws ORDER BY ALL";

$CLICKHOUSE_CLIENT -q "DROP TABLE ws";
