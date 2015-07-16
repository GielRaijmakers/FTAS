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
def RunTestScript(path)      
   popup path 
    #read file
    fileObj = File.new(path, "r")
    while (line = fileObj.gets)
      HandleTestScriptFile(line)
    end
    fileObj.close

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
    #http://stackoverflow.com/questions/2777802/how-to-write-to-file-in-ruby    
    require 'date'
   begin
      current = DateTime.now  
        #this should be in a configuration file... 
      file = File.open("C:\\sikuliscripts\\calc.sikuli\\log.txt", "a")
      if pass == true then
        #passed
          file.write( current.to_s + " " + teststep.to_s + " " + "passed" +  "\n") 
      else
        ScreenShot(teststep.to_s)
        file.write( "\n") 
        file.write( current.to_s + " " + teststep.to_s + " " + "FAILED" +  "\n") 
        file.write( e.to_s +  "\n") 
        file.write ("look at: " + teststep.to_s + ".png\n")
      end  
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end
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



def Numbers(list)
    begin       
      HandelTestStep(list)
      passed = true
    rescue
        ErrorHandler("error", "Numbers")         
        passed = false
    ensure 
       WriteToLog("Numbers",passed)  
    end
end

def MathExpressions(list)
    begin       
      HandelTestStep(list)
      passed = true
    rescue
        ErrorHandler("error", "MathExpressions")         
        passed = false
    ensure 
       WriteToLog("MathExpressions",passed)  
    end

end

def SwitchCalculatorType(kind)
    begin  
        case kind
            when "standard"
                 keyDown(Key.ALT + "1")
            when "scientific" 
                 keyDown(Key.ALT + "2")    
            when "programmer"
                 keyDown(Key.ALT + "3")
            when "statistic"
                 keyDown(Key.ALT + "4")
        end
    rescue
        ErrorHandler("error", "SwitchCalculatorType")         
        passed = false
    ensure 
       WriteToLog("SwitchCalculatorType",passed)  
    end
end

def StartCalculator()
   begin 
    IO.popen 'C:\\windows\system32\\calc.exe'
    end
end



StartCalculator()
Numbers('1:<click>;2:<click>;')
MathExpressions('plus:<click>;')
Numbers('1:<click>;2:<click>;')
MathExpressions('is:<click>;')
SwitchCalculatorType("scientific")