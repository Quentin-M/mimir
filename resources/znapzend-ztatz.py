#!/usr/bin/env python3

import json
import subprocess

from datetime import datetime

TAG_PREFIX = 'znap-'

def get_datasets(use_sudo=True):
    cmd = 'zfs list -H -o name -t snapshot'
    if use_sudo:
        cmd = 'sudo ' + cmd

    datasets = {}

    output = subprocess.getoutput(cmd).split()
    for line in output:
        line = line.strip()

        dataset, tag = line.split('@', 1)
        if not tag.startswith(TAG_PREFIX):
            continue

        # preprocess the tag
        tag = tag[len(TAG_PREFIX):]
        ts = datetime.strptime(tag, '%Y-%m-%dT%H:%M:%S')

        if not dataset in datasets:
            datasets[dataset] = []

        datasets[dataset].append(ts)

    # sort the tags so the first one is the newest
    for dataset, tags in datasets.items():
        datasets[dataset] = sorted(tags, reverse=True)

    return datasets


if __name__ == '__main__':
    metrics = []

    for dataset, tags in get_datasets().items():
        delta = datetime.utcnow() - tags[0]

        data = {
            'dataset': dataset,
            'count': len(tags),
            'seconds_since_last': int(delta.total_seconds()),
        }

        # metrics[dataset] = data
        metrics.append(data)

    print(json.dumps(metrics, indent=4))

