# README

Ruby scripts to perform common one-off administrative tasks in the SDR.

## Pre-requisites

- A ruby version manager, [RVM](https://rvm.io/rvm/install) or [rbenv](https://gist.github.com/stonehippo/cc0f3098516fb52390f1)

- Knowlege of and credentials for the workflow endpoint you will use.

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Setup

1. `rvm use 2.6.0`, or whatever ruby version you need.

2. `git clone` this repository.

3. `cd` to the cloned repo.

4. `bundle install` to install dependencies.

5. Make sure you populate your `config/config.yml` file with values for `host`, `user`, and `password` keys.

## Quick start

```ruby
updater = WorkflowStatusUpdater.update(druid: 'bm459md8742',
                                       workflow: 'accessionWF',
                                       step: 'descriptive-metadata',
                                       status: 'waiting')
updater.update
```
