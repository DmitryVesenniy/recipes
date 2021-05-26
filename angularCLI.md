## Update angular
    ng update @angular/cli @angular/core

## Generating and serving an Angular project via a development server
  ng new PROJECT-NAME
  cd PROJECT-NAME
  ng serve

## Create component
  ng generate component my-new-component
  ng g component my-new-component # using the alias 
   
  # components support relative path generation 
  # if in the directory src/app/feature/ and you run 
  ng g component new-cmp
  # your component will be generated in src/app/feature/new-cmp 
  # but if you were to run 
  ng g component ./newer-cmp
  # your component will be generated in src/app/newer-cmp 
  # if in the directory src/app you can also run 
  ng g component feature/new-cmp
  # and your component will be generated in src/app/feature/new-cmp 


## Scaffold	Usage
# Component	
  ng g component my-new-component --skipTests

# Directive	
  ng g directive my-new-directive

# Pipe	
  ng g pipe my-new-pipe

# Service	
  ng g service my-new-service

# Class	
  ng g class my-new-class

# Guard	
  ng g guard my-new-guard
# Interface	
  ng g interface my-new-interface

# Enum	
  ng g enum my-new-enum

# Module	
  ng g module my-module


# Error: ENOSPC: System limit for number of file watchers reached
  echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Mobile
https://capacitorjs.com/solution/angular

# material
