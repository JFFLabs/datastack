# Data Stack by JFF

Data Stack is intended to be a relatively turn-key solution and service offering to meet demands of intermediate level data teams in the workforce and education systems landscape.  While the infrastructure could serve general audiences as well, we place particular focus on extensions and development as it relates to our mission.

## Components

Data Stack is not a custom solution, rather, it is a tool for wrapping and integrating a number of open source solutions.  Specifically:

- PosgreSQL
- Baserow
- Matatika
- Superset

## Prerequisites

- OAuth+OID identity provider
- The `wget` command installed
- The `bash` shell installed

## Setup and Installation

From a [compatible system](#compatibility) execute the following:

```
wget -O- https://setup.datastack.jff.org/ | sudo bash
```

This script will:

1. Install additional dependencies via your OS package manager
2. Create a docker control container for:
   1. Executing `stack` commands
   2. Tracking installation / configuration state
3. Create the `/usr/sbin/stack` wrapper

Once complete, you're ready to install:

```
sudo stack install
```

