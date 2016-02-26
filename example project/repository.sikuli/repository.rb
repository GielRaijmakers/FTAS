#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#generic functions for FTAS
#Giel Raijmakers
#Version 0.1
# https://github.com/GielRaijmakers/FTAS
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#

#add path to the project
#addImagePath('../repository.sikuli')
#addImagePath('../aut.sikuli')

###############################################
# when a script needs to be executed
###############################################
include Sikulix

path = StripProjectDir(File.dirname(__FILE__).to_s)

ImagePath.setBundlePath( path +"/aut.sikuli")
ImagePath.setBundlePath(path +"/generic.sikuli");
require path + "/aut.sikuli/aut.rb"
require path + "/generic.sikuli/generic.rb"

#require 'C:\jruby-9.0.0.0\lib\ruby\gems\shared\gems\sikulix-1.1.0.3\lib\sikulix.rb'

#ImagePath.add('D:\tests\Github\FTAS\FTAS\example project\calc.sikuli')
Settings.setShowActions(false)

def StripProjectDir(projectPath)
    path = projectPath.split("/")
    projectPath.slice! path[path.length-1].to_s
    return projectPath.to_s
end

def repo
  click("1.png")
  click("2.png")
  click("3.png")
  click("4.png")
  click("5.png")
  click("6.png")
  click("7.png")
  click("8.png")
  click("9.png")
  click("0.png")

  click("plus.png")
  click("1436507994441.png")
  click("1436508008496.png")
  click("1436508023794.png")
  click("1436508033116.png")
  click("is.png")
end