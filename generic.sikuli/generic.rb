#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#generic functions for FTAS
#Giel Raijmakers
#Version 0.1
# https://github.com/GielRaijmakers/FTAS
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#

#add path to the project
ImagePath.setBundlePath( File.dirname(__FILE__) +"/aut.sikuli")
ImagePath.setBundlePath( File.dirname(__FILE__) +"/repository.sikuli");
require File.dirname(__FILE__) + "/generic.sikuli/aut.rb'"
require File.dirname(__FILE__) + "/repository.sikuli/repository.rb'"
###############################################
# when a script needs to be executed
###############################################
def RunTestScript(path)      
   begin
       #read file
       fileObj = File.new(path, "r")
    while (line = fileObj.gets)
       HandleTestScriptFile(line)
    end
    rescue
       ErrorHandler("error","ScreenShot")
    ensure
       fileObj.close
   end 
end
def HandleTestScriptFile(fileline)
   #split function name from arguments
   sArray = fileline.split("(")   
   #strip all " and ()
    sArray[1].gsub!(/[^0-9A-Za-z,:;<>]/, '')  
    
    if sArray[1].include? ";"
       #regular function, with actions on objects
        send(sArray[0], sArray[1])
    else
        #actions like logon or "menu"
        #check how many arguments there are
        aNumberOfArguments = sArray[1].scan(",")  

        saArguments = sArray[1].split(",")

        case aNumberOfArguments.count + 1
           when 0 
                send(sArray[0])            
           when 1               
                send(sArray[0],saArguments[0])
           when 2
                send(sArray[0],saArguments[0],saArguments[1])
           when 3
                send(sArray[0],saArguments[0],saArguments[1],saArguments[2])
           else
                popup "wrong number of arguments"
         end            
    end
end


########################################
#handler action to object (like click)
########################################
def HandelActionToObject(action,object)
    
       #based on the action (like click, check, wait, type) take care of the object. 
       #<> are action, else it is text  
       if action.include?("<") then
            #other
            case action
                when "<click>"   
                    wait(object.to_s + ".png")             
                    click(object.to_s + ".png")
                when "<check>"
                    # 
                when "<wait>"
                    #
                when "<selectall>"
                    wait(object.to_s + ".png")             
                    click(object.to_s + ".png")
                    keyDown(Key.CTRL + "a")
                    keyUp()        
                when "<doubleClick>"
                    wait(object.to_s + ".png")             
                    doubleClick(object.to_s + ".png")
                else
                    WriteToLog("not found" + action.to_s, False)
              end   
            sleep(1)  
       else
        #not a specific action, only type text
        type(action)    
       end  

end

########################################
#handel test step
########################################
def HandelTestStep(list)
    begin
      #check if last item is a ";" to make sure the split will work.
        sLast = list[-1..-1] || list
        if  sLast != ";" then 
            list = list + ";"
        end
        #split up string into seperate items
        sArray = list.split(";")
        #0=item, 1=action
        i=0
        while i< sArray.size         
           if sArray[i].include?(":") then 
                sArray2 = sArray[i].split(":")
               # 1 is the action, 0 is the object it self.
               HandelActionToObject(sArray2[1],sArray2[0])
            end
            i=i+1 
        end
        passed = true
    rescue
        ErrorHandler("error","HandelTestStep")
        passed = false
   ensure 
        WriteToLog(list,passed) 
    end

end

########################################
#error handler
########################################
def ErrorHandler(err, functionName)
    # http://marxsoftware.blogspot.nl/2009/05/jrubys-ruby-style-exception-handling.html    
    popup err.to_s
    popup("in errorhandler, source:" + functionName )   
    exit
end

############################################
#screenshot
############################################
#
# devdaily.com
# ruby/jruby code to create an image/screenshot of your desktop
#
def ScreenShot(functionname)
    begin
        require 'java'
        
        include_class 'java.awt.Dimension'
        include_class 'java.awt.Rectangle'
        include_class 'java.awt.Robot'
        include_class 'java.awt.Toolkit'
        include_class 'java.awt.event.InputEvent'
        include_class 'java.awt.image.BufferedImage'
        include_class 'javax.imageio.ImageIO'
        
        toolkit = Toolkit::getDefaultToolkit()
        screen_size = toolkit.getScreenSize()
        rect = Rectangle.new(screen_size)
        robot = Robot.new
        image = robot.createScreenCapture(rect)
        path =  File.dirname(__FILE__)
        f = java::io::File.new(path.to_s + "\\" + functionname + '.png')
        ImageIO::write(image, "png", f)       
    rescue
        ErrorHandler("error","ScreenShot")
    end
end

##########################################
# write to log
##########################################
def WriteToLog(teststep,pass, e="false")
    #e (error) is optional
    #http://stackoverflow.com/questions/2777802/how-to-write-to-file-in-ruby    
    require 'date'
   begin
      current = DateTime.now  
      file = File.open("D:\\sikuli scripts\\genericfunctions.sikuli\\log.txt", "a")
     case pass
        when true
            #passed
            file.write( current.to_s + " " + teststep.to_s + " " + "passed" +  "\n") 
        when false
            ScreenShot(teststep.to_s)
            file.write( "\n") 
            file.write( current.to_s + " " + teststep.to_s + " " + "FAILED" +  "\n") 
            file.write( e.to_s +  "\n") 
            file.write ("look at: " + teststep.to_s + ".png\n")        
        when "warning"    
            ScreenShot(teststep.to_s)
            file.write( "\n") 
            file.write( current.to_s + " " + teststep.to_s + " " + "Warning" +  "\n") 
            file.write ("look at: " + teststep.to_s + ".png\n") 
    end     
 
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end
end
