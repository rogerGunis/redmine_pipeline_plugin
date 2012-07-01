# Redmine Pipeline Plugin

Pipeline is a Redmine plugin to ease the estimation of available capacity.

## Features

* Sums the estimated times of open issues
* Multiple filter and grouping-options build-in, for the calculation of these times
* An optional capacity calculation on a per month basis 

## Install

1. Follow the Redmine plugin installation steps at: http://www.redmine.org/wiki/redmine/Plugins 
Make sure the plugin is installed to <tt>vendor/plugins/redmine_pipeline</tt>.
2. This plugin doesn't need any database migrations
3. Restart your Redmine

## Usage

To be able to use the pipeline report, a user must be Administrator.
Then, the link to the report is displayed on the top left menu.

## Feedback

Feedback is very much appreciated.
This plugin is tested on Redmine 2.0.3.stable, backed with a PostgreSQL-database.
