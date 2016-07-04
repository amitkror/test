# NYC College Line

## INSTALLATION

Must be running postgresql  

Install image magick for processing images.  
OSX w/ homebrew: `brew install imagemagick`  
Ubuntu: `sudo apt-get install imagemagick`

If using rvm, you should have ruby 1.9.3 and a gemlist named nyc-college-line.  
Refer to the ~/.rvmrc file for reference.

Install bundler 
`gem install bundler`  

From rails root  
`bundle install`  
`cp config/database.yml.example config/database.yml`   
enter the correct config info for your postgresql database.  

`cp config/nyc_college_line.yml.example config/nyc_college_line.yml`  
`rake db:setup`  
`rspec spec`

## DEVELOPMENT

To annotate your models, run this locally  
`bundle exec annotate -p before`  


### Starting Solr  

Solr is a standalone HTTP server, use the rake task to fire it up:  

`rake sunspot:solr:start`

### SEED DATA

`rake db:seed` #if it fails with "Connection refused - connect(2)" then start SOLR (see below)  
You can also run `rake db:reset` to start fresh, which also automatically runs `rake db:seed`

seeding creates a dummy user from the spec/factories/users.rb  
grad-nyc.team@blenderbox.com / -Bagel is the bomb!  

You can access the administrative section by going to /admissions and using that login.

  
## SEARCH

### Indexing  

After making a change to a model's searchable property, you need to re-index
your search by running 

`rake sunspot:reindex`  

## DEPLOYING

`cap stage deploy # deploys to stage`  
`cap prod deploy # deploys to production`  

The default deployments do not run migrations.

## LOGS 
  
Log rotate should be set up on prod
  
Add the following entry with the correct domain to /etc/logrotate.conf 
  
```bash
/var/www/nyccollegeline.org/shared/log/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    copytruncate
}

/var/www/stage.nyccollegeline.org/shared/log/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    copytruncate
}

```
  
To force the logrotate run  
`/usr/sbin/logrotate -f /etc/logrotate.conf`


# Monit

sudo apt-get install monit

sudo ln -s /var/www/nyccollegeline.org/current/config/production/monit/monitrc.conf
sudo ln -s /var/www/nyccollegeline.org/current/config/production/monit/nginxrc.conf
sudo ln -s /var/www/nyccollegeline.org/current/config/production/monit/tomcatrc.conf

http://nyccollegeline.org:9000/ u: blenderbox p: coffee42

# Backups

Backups are setup using the [backup gem](https://github.com/meskyanichi/backup).  They are stored on AWS and configuration can be found in the [git repostiry](https://github.com/blenderbox/nyc-college-line/tree/master/config/production/backup)
