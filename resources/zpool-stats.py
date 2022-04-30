#!/usr/bin/env python3

import json
import subprocess

def get_pools(use_sudo=True):
    cmd = 'zpool list -H -p -o name,size,alloc,free,frag,cap'
    if use_sudo:
        cmd = 'sudo ' + cmd

    pools = []

    output = subprocess.getoutput(cmd).split('\n', -1)
    for line in output:
        line = line.strip()

        name, size, alloc, free, frag, cap = line.split('\t', 6)

        pools.append({
            'name': name,
            'size': int(size),
            'alloc': int(alloc),
            'free': int(free),
            'frag': int(frag),
            'cap': int(cap),
        })

    return pools


if __name__ == '__main__':
    metrics = []

    for pool in get_pools():
        metrics.append(pool)

    print(json.dumps(metrics, indent=4))

