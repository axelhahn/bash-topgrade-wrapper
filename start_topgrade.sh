#!/bin/bash
# ===============================================================
#
# Topgrade wrapper with notify-send
#
# <https://github.com/topgrade-rs/topgrade>
#
# Author: Axel Hahn
# Source: <https://github.com/axelhahn/bash-topgrade-wrapper>
# License: GNU GPL 3.0
#
# ---------------------------------------------------------------
# 2025-09-01  1.0  Initial version
# ===============================================================

# ---------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------

# --- INIT
which topgrade >/dev/null || exit 1
. "$( dirname "$0" )/inc_notify.sh"

# --- START
_notify "Topgrade :: Start" "Starting OS update with topgrade..."
sudo topgrade -y
rc=$?

_notify "Topgrade :: Done" "topgrade finished with rc=$rc" $rc
exit $rc

# ---------------------------------------------------------------
