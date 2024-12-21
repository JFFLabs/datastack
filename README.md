# Data Stack by JFF

Data Stack is intended to be a relatively turn-key solution and service offering to meet demands of intermediate level data teams in the workforce and education systems landscape.  While the infrastructure could serve general audiences as well, we place particular focus on extensions and development as it relates to our mission.

## Components

Data Stack is not a custom solution, rather, it is a tool for wrapping and integrating a number of open source solutions.  Specifically:

- PosgreSQL
- Baserow
- Matatika
- Superset

## Prerequisites

- Install Docker

## Install / Setup

To begin using Data Stack, you will want to decide first and foremost on your chosen infrastructure pathway.  We've made that choice easier by only supporting two options out of the box:

1. AWS (Recommended)
2. Local

### AWS

Installing with `docker run -v datastack:/data jff/datastack install --aws` will require you to have an AWS account and some additional information on hand.  Specifically:

- AWS Key
- AWS Secret

## Command References



