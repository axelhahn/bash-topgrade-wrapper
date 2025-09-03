#!/bin/bash
# ===============================================================
#
# notify-send wrapper function
#
# ===============================================================

# ---------------------------------------------------------------
# FUNCTIONS
# ---------------------------------------------------------------

# show a desktop notification using notify-send
# param  string   summary (aka title)
# param  string   message text
# paran  integer  optional: exitcode; if set it adds a prefix OK or ERRROR on summary and sets urgency on error
function _notify(){
  local _summary; _summary="$1"
  local _body;    _body="$( date +%H:%M:%S ) $2"
  local _rc;      _rc="$3"

  if which notify-send >/dev/null 2>&1; then
    if [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then

      local _urgency="normal"
      if [ -n "$_rc" ]; then
        if [ "$_rc" = "0" ]; then
          _summary="OK: ${_summary}"
        else
          _summary="ERROR: ${_summary}"
          _urgency="critical"
        fi
      fi

      if [ -n "$SUDO_USER" ]; then
        su "$SUDO_USER" -c "notify-send --urgency=${_urgency} '${_summary}' '${_body}'"
      else
        notify-send --urgency=${_urgency} "${_summary}" "${_body}"
      fi
    fi
  fi
}

# ---------------------------------------------------------------

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  DESKTOPUSER=$USER
  if [ -n "$SUDO_USER" ]; then
    DESKTOPUSER=$SUDO_USER
  fi
  export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u "$DESKTOPUSER")/bus"
fi

# ---------------------------------------------------------------
