# Lumber 

Lumber is the script that builds the [Vagrant](https://www.vagrantup.com) box for [Laravel](http://www.phoenixframework.org) application development environment with Japanese font support and PDF generation with [wkhtmltopdf](http://wkhtmltopdf.org).

It's build on top of [Laravel Homestead](https://laravel.com/docs/5.2/homestead).

You can download the Vagrant box at https://atlas.hashicorp.com/kiaking/boxes/lumber.

## Included Software

- Ubuntu 16.04
- Git
- PHP 7.0
- HHVM
- Nginx
- MySQL
- MariaDB
- Sqlite3
- Postgres
- Composer
- Node (With PM2, Bower, Grunt, and Gulp)
- Redis
- Memcached
- Beanstalkd

## To Build Vagrant Box 

To build Relight Vagrant box, just execute `build.sh` scripts.

```shell
$ sh build.sh
```

After executing the script, the `virtualbox.box` file will be created at root of the project folder.

## License

The Lumber is open-sourced software licensed under the [MIT license](LICENSE.md).
