[![Build Status](https://travis-ci.org/hajee/connect_encrypted.png?branch=master)](https://travis-ci.org/hajee/connect_encrypted) [![Coverage Status](https://coveralls.io/repos/hajee/connect_encrypted/badge.svg)](https://coveralls.io/r/hajee/connect_encrypted)[![Code Climate](https://codeclimate.com/github/hajee/connect_encrypted/badges/gpa.svg)](https://codeclimate.com/github/hajee/connect_encrypted)

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What YAML importer for Connect does and why it is useful](#module-description)
3. [Setup - The basics of getting started with the YAML importer for Connect](#setup)
    * [What connect affects](#what-connect-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with the YAML importer for Connect](#beginning-with-connect)
    * [Tools](#tools)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Troubleshooting](#troubleshooting)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
    * [OS support](#os-support)
    * [Tests - Testing your configuration](#testing)

##Overview

[Connect](https://github.com/hajee/connect) is a replacement for YAML in hiera when using Puppet. Connect allows you to assign, manipulate and reference data. It  also allows you to import data items from external sources. The code to import this data is called a datasource.

##Module Description

This module contains the data source for reading encrypted data into [Connect](https://github.com/hajee/connect). This can be useful for example in the following use cases:
- Storing passwords or ssh private keys in your Connect files
- Storing privacy sensitive information in your Connect Files

By storing the decrypted password in an other (offline) source, you can be certain, the Connect files stored in a git repository are not readable by non authorized persons.

##Example

Here is an example reading encrypted data in your connect file.

```
import from encryped("${password}") into passwords:: do
  ftp_password        = 4tXI3V4yU3+E0b8MB4Td2A==|RGh76OTpA0wQ9pK1bCuCkA==
  satellite_password  = OUMkw35FgJs5eK51BvBvAw==|ixoQf091i/wGKEWjZJAd9g==
  download_password   = Pv/AZPVyUTVAXZzwTDBlvg==|wLb96I7c6iBN2nIcp62zPA==
  secret_stuff        = j2S3BHEeRqLnCJV8MaVQ3A==|r1UcBZgiatyMh62CWxjCRg==
end
```

In this example, we decrypt our data using the password set in the variable `password`. The values are trhen put into the Connect variables: `passwords::ftp_password` , ` passwords::satellite_password`, `passwords::download_password`  and `passwords::secret_stuff`

##Setup

###Installing the module

To use the YAML datasource module, you first have to make sure it is installed.

```sh
puppet module install hajee/connect_encrypted
```

If you are using a Puppetfile, you need the following lines:

```
mod 'hajee-connect_encrypted'
```

No additional actions are required. Connect searches for available data sources when staring. So when this data source is installed, it is usable instantaneous.

###What connect_encrypted affects

`connect_encrypted`  affects no other modules then only Connect. 

###Setup Requirements

A requirement for ` connect_encrypted`  is the [Connect]](https://github.com/hajee/connect), module. This requirement is specified in the module metadata so you don’t have to manage it yourself.

###Beginning with connect YAML module

###Usage

To create an encrypted file, create a normal connect file with values you want to encrypt:
```
a = 10
b = ‘This is secret’
```

The get the encrypted output by using the following command:

```sh
$ puppet connect encrypt data.connect --password thisneedsalongpassword
```
This created the output:
```ruby
password = 'Hallodaarditiseenpassword'
import from encryped("${@password}") do
  a = 8uIcgM340JOHt2u6HHzkOw==|0JMomNWYFu9z/+o9XBsKBg==
  b = X7hv99N710533t7oO3zEyA==|nA5eKFnx92QS0cenPEcIjA==
end
```
You can redirect this to the file that you want to use it, in.

Check [the Connect Language, in a Nutshell](https://github.com/hajee/connect/blob/master/doc/nutshell.md), for more intro into the language.

##Troubleshooting

Use the `--debug`  option to puppet to see what is happening. 


##Limitations

This module is tested CentOS and Redhat. It will probably work on other Linux distributions. 

##Development

This is an open source project, and contributions are welcome.

###OS support

Currently we have tested:

* CentOS 5
* Redhat 5

###Testing

Make sure you have:

* rake
* bundler

Install the necessary gems:

    bundle install

And run the tests from the root of the source code:

    rake spec

We are currently working on getting the acceptance test running as well.


