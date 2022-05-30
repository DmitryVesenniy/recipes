sudo npm install -g @angular/cli

npm install node-sass@4.14.0
npm i gulp-sass --save-dev

# Error: ENOSPC: System limit for number of file watchers reached
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
