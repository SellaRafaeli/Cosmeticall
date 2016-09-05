Cosmeticall
===========

- Liliya was here.

#Spec
https://docs.google.com/document/d/1bycYLyWyU18VPU3SDAKrsyZStw9CBSBU2sOOH_Fh_0E/edit

#Sublime Keyboard shortcuts
http://docs.sublimetext.info/en/latest/file_management/file_management.html

# CSS Filewatcher:
$ filewatcher '**/*.scss' 'scss $FILENAME > $FILENAME.css; echo "created"-$FILENAME; date'

# Exclude searches:
-public/css/font*, -public/css/bootstrap_3.3.4.min.css, -public/css/lib*, -public/js/lib*, -*/node_modules/*, -*/js_dist/*, -*/.sass-cache*

# Setup:
$ git clone [this project]
$ cd Cosmeticall
$ bundle install #installs all the packages
$ mongod & #runs mongo in background, after having installed MongoDB
$ bundle exec rackup -p 9292 #runs the server, listening on port 9292