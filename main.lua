--Physics library



local physics = require( "physics" )

physics.start() 



--variables



catch = 0

score = 0



--Music



local audio1 = audio.loadSound( "assets2/mario.m4a" )

audio.play(audio1)



-- Scrollspeeds

scrollSpeed1 = 3

scrollSpeed2 = 3.5

scrollSpeed3 = 2.5



--The environment sprites

display.setDefault( "background", 20/255, 223/255, 255/255 )



local image = display.newImageRect( "assets/images/tree.png", 700, 700 )

image.x = 160

image.y = 100



local image = display.newImageRect( "assets/images/ground.png", 400, 200 )

image.x = 160

image.y = 425



local barrier = display.newImageRect( "assets/images/ground.png", 400, 200 )

barrier.x = 160

barrier.y = 600

barrier.id = "barrier"

physics.addBody( barrier, "static", { 

    friction = 0.5, 

    bounce = 0.3 

} )



--The fruit and bleach sprites

local orange = display.newImageRect("assets/images/orange.png", 35, 35)

orange.x = math.random (1, 320)

orange.y = -30 

orange.id = "orange"

physics.addBody( orange, "static", { 

    friction = 0, 

    bounce = 0 

    } )



local apple = display.newImageRect("assets/images/apple.png", 35, 35)

apple.x = math.random (1, 320)

apple.y = -50 

apple.id = "apple"

physics.addBody( apple, "static", { 

    friction = 0, 

    bounce = 0 

    } )



local banana = display.newImageRect("assets/images/banana.png", 35, 35)

banana.x = math.random (1, 320)

banana.y = -70 

banana.id = "banana"

physics.addBody( banana, "static", { 

    friction = 0, 

    bounce = 0 

    } )



local bomb = display.newImageRect("assets/images/bomb.png", 40, 50)

bomb.x = math.random (1, 320)

bomb.y = -110 

bomb.id = "bleach"

physics.addBody( bomb, "static", { 

    friction = 0, 

    bounce = 0 

    } )



--The basket and functionality sprites

local basket = display.newImageRect( "assets/images/basket.png", 100, 100 )

basket.x = 160

basket.y = 425

basket.id = "basket"

physics.addBody( basket, "dynamic", { 

    density = 0, 

    friction = 0, 

    bounce = 0 

    } )

basket.isFixedRotation = true



--Kill switch activator

local clock = os.clock

function sleep(n)  -- seconds

  local t0 = clock()

  while clock() - t0 <= n do end

end



--Point Counter

points = display.newText( "Points: " .. score, 165, 125, native.systemFont, 30 )

points:setFillColor( 255/255, 255/255, 255/255 )



--Instructional text



prompt = display.newText( "Drag the basket!", 160, 0, native.systemFont, 30 )

prompt:setFillColor( 255/255, 255/255, 255/255 )



prompt2 = display.newText( "Catch the fruit!", 160, 30, native.systemFont, 30 )

prompt2:setFillColor( 255/255, 255/255, 255/255 )



--End text



endGame = display.newText( "", 160, 220, native.systemFont, 30 )

endGame:setFillColor( 255/255, 255/255, 255/255 )



endPoints = display.newText( "", 160, 250, native.systemFont, 20 )

endPoints:setFillColor( 255/255, 255/255, 255/255 )





--Move the basket by dragging

local function basketTouch ( event )

    local self = event.target

    if ( event.phase == "began" ) then

        

    

        -- Set touch focus

        display.getCurrentStage():setFocus( self )

        self.isFocus = true

        

        self.markX = self.x

        

     

    elseif ( self.isFocus ) then

        if ( event.phase == "moved" ) then

            

            

            self.x = event.x - event.xStart + self.markX

            

        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then

 

            -- Reset touch focus

            display.getCurrentStage():setFocus( nil )

            self.isFocus = nil

            

        end

    end



    return true

end



--Falling sprites

 

local function MoveImage1(event)

    orange.y = orange.y + scrollSpeed1 

end



local function MoveImage2(event)

   apple.y = apple.y + scrollSpeed2 

end



local function MoveImage3(event)

   banana.y = banana.y + scrollSpeed3 

end



local function MoveImage4(event)

    bomb.y = bomb.y + scrollSpeed3

end



local function imageReset ( event )

    if bomb.y >= 600 then

        math.randomseed = (os.time())

        bomb.x = math.random ( 1,320 )

        bomb.y = -110

        print ("it worked")

    end

end



--Collision Functions 



local function fruitCollision1( self, event )

 

math.randomseed = (os.time())



    if ( event.phase == "began" ) then

      

        if event.other.id == "basket" then

            score = score + 1

            points.text = ("Points: ".. score)

            timer.performWithDelay(1, function() 

            orange.x = math.random (1,320)

            orange.y = -30

        end

        )

    elseif ( event.phase == "ended" ) then

        

    end

end

end



local function fruitCollision2( self, event )

 

math.randomseed = (os.time())



    if ( event.phase == "began" ) then

       

        if event.other.id == "basket" then

            score = score + 1

            points.text = ("Points: ".. score)

            timer.performWithDelay(1, function() 

            apple.x = math.random (1,320)

            apple.y = -50

        end

        )

    elseif ( event.phase == "ended" ) then

       

    end

end

end



local function fruitCollision3( self, event )

 

math.randomseed = (os.time())



    if ( event.phase == "began" ) then

        

        if event.other.id == "basket" then

            score = score + 1

            points.text = ("Points: ".. score)

            timer.performWithDelay(1, function() 

            banana.x = math.random (1,320)

            banana.y = -70

        end

        )

    elseif ( event.phase == "ended" ) then

        

    end

end

end



local function bleachCollision( self, event )

 

    if ( event.phase == "began" ) then

        

        Runtime:removeEventListener( "collision", fruitCollision3 )

        Runtime:removeEventListener( "collision", fruitCollision2 )

        Runtime:removeEventListener( "collision", fruitCollision1 )

        catch = 1



    elseif ( event.phase == "ended" ) then

          



    end

end



--Kill switch



local function killSwitch ( event )



if orange.y >= 600 or apple.y >= 600 or banana.y >= 600 or catch == 1 then

        Runtime:removeEventListener( "enterFrame", killSwitch )

        

        if catch == 1 then

            prompt.text = "BOOM! You caught" 

            prompt2.text = "the bomb!"

        else   

            prompt.text = "The fruit touched"

            prompt2.text = "the ground!"

        end



        orange.alpha = 0

        apple.alpha = 0

        banana.alpha = 0

        bomb.alpha = 0



        basket.alpha = 0



end

end



local function killSwitch2 ( event )

    

    if orange.y >= 700 or apple.y >= 700 or banana.y >= 700 or catch == 2 then

        Runtime:removeEventListener( "enterFrame", killSwitch2 )

        

        scrollSpeed3 = 0

        scrollSpeed2 = 0

        scrollSpeed1 = 0



        prompt.text = ""

        prompt2.text = ""

        points.text = ""

        

        sleep(3)

        

        audio.stop(1)

        endGame.text = "Game Over"

        endPoints.text = "Score: "..score



    end

end



--Event listeners

basket:addEventListener("touch", basketTouch)



Runtime:addEventListener("enterFrame", MoveImage1)



Runtime:addEventListener("enterFrame", killSwitch)



Runtime:addEventListener("enterFrame", killSwitch2)



Runtime:addEventListener("enterFrame", MoveImage2)



Runtime:addEventListener("enterFrame", MoveImage3)



Runtime:addEventListener("enterFrame", MoveImage4)



Runtime:addEventListener("enterFrame", imageReset)



orange.collision = fruitCollision1

orange:addEventListener( "collision" )



apple.collision = fruitCollision2

apple:addEventListener( "collision" )



banana.collision = fruitCollision3

banana:addEventListener( "collision" )



bomb.collision = bleachCollision

bomb:addEventListener( "collision" )

--TEST FUNCTIONS