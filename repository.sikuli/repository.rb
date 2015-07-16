#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#repository functions for FTAS
#Giel Raijmakers
#Version 0.1
# https://github.com/GielRaijmakers/FTAS
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#


#add path to the project
ImagePath.setBundlePath( File.dirname(__FILE__) +"/aut.sikuli")
ImagePath.setBundlePath( File.dirname(__FILE__) +"/generic.sikuli");
require File.dirname(__FILE__) + "/generic.sikuli/aut.rb'"
require File.dirname(__FILE__) + "/repository.sikuli/generic.rb'"
#this script should contain all images for the project. The images should have the name of the arguments you also use.
#e.g. a searchbutton should be named. "searchbutton.png".