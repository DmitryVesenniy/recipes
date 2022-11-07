sudo npm install -g @angular/cli

# ERROR in Module build failed (from ./node_modules/sass-loader/lib/loader.js):
# Error: Node Sass does not yet support your current environment: Linux 64-bit with Unsupported runtime (88)
npm uninstall node-sass
npm install node-sass@4.14.0
npm i gulp-sass --save-dev

# Error: ENOSPC: System limit for number of file watchers reached
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
