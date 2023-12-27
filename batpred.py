"""
Battery Prediction app
see Readme for information
"""
# fmt off
# pylint: disable=consider-using-f-string
# pylint: disable=line-too-long
# pylint: disable=attribute-defined-outside-init
from datetime import datetime, timedelta
import math
import re
import time
import pytz
import requests
import copy
import os
import yaml
import sys

CORE_API = "http://supervisor/core/api"
SUPERVISOR_TOKEN = os.environ.get('SUPERVISOR_TOKEN', '')

def read_states():
    """
    Get inverter status
    """
    url = CORE_API + "/" + "states"
    headers = {"Authorization" : "Bearer " + SUPERVISOR_TOKEN, "Content-Type" : "application/json"}
    try:
        r = requests.get(url, headers=headers)
    except Exception as e:
        print("ERROR: Exception raised {}".format(e))
        r = None

    if r and (r.status_code == 200):
        json = r.json()
        print("Got {}".format(json))

def main():
  print("Batpred startup python")
  read_states()
  return 0

if __name__ == '__main__':
  sys.exit(main())  # next section explains the use of sys.exit
