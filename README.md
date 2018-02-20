# Components
* Base Image: Ubuntu 16.04
* Apache2
* PHP 5.6
* Apache Subversion
* iF.SVNAdmin (Credits: http://svnadmin.insanefactory.com/. It's a web interface for subversion repositories and users management . http://svnadmin.insanefactory.com/screenshots/)

## Volumes

| Container Folder               | Description                                                                   |
| ------------------------------ | ----------------------------------------------------------------------------- |
| `/var/www/html/svnadmin/data/` | Data folder of IF.SVNAdmin for config.ini and userroleassignments.ini         |
| `/home/ubuntu/svndata/`        | Repositories folder                                                           |
| `/etc/apache2/conf/`           | Apache subversion folder for access_svn and dav_svn.passwd files              |

## Ports
**`80 TCP/IP`**

## URL Endpoints

| App URL                                   | Description                     |
| ----------------------------------------- | ------------------------------- |
| `http://serverip/svnadmin`                | Endpoint for iF.SVNAdmin        |
| `http://serverip/svnrepos/myRepo`         | Endpoint for SVN myRepo example |

## Environment variables

| Env Var            | Default value               |
| ------------------ | --------------------------- |
| `SVN_LOCATION`     | svnrepos                    |
