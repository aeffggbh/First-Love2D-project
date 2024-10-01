
function animate(character, moveY)
  
    if animations.timer <= 0 then
      
      animations.timer = 1/animations.fps
      character.spriteSheet.currentFrame = character.spriteSheet.currentFrame + 1
      
      if(character.spriteSheet.currentFrame > character.spriteSheet.frames) then
        --back to the first frame
        character.spriteSheet.currentFrame = 0
      end
    
      animations.xOffSet = character.dimensions * character.spriteSheet.currentFrame
  
      character.sprite:setViewport(animations.xOffSet, moveY, character.dimensions, character.dimensions)
      
    end
  end
  
function newZombie(x, y)
    local zombie = {}
  
    zombieId = zombieId + 1
    zombie.id = zombieId
    zombie.spriteSheet = {}
    zombie.spriteSheet.sheet = love.graphics.newImage("res/sprites/Zombie.png")
    zombie.spriteSheet.frames = 7
    zombie.spriteSheet.currentFrame = 0
    zombie.dimensions = 32;
    zombie.sprite = love.graphics.newQuad(0, zombie.dimensions*2, zombie.dimensions, zombie.dimensions, zombie.spriteSheet.sheet:getDimensions())
    zombie.spriteDimension = {}
    zombie.spriteDimension.width = zombie.dimensions;
    zombie.spriteDimension.height = zombie.dimensions;
    
    zombie.x = x
    zombie.y = y
    zombie.angle = 0
    local randomSpeed = math.random(100, 300);
    zombie.speed = randomSpeed
    zombie.scale = 3;
  
    return zombie
end
  
function moveZombie(zombie, dt)
    local centerX, centerY = (zombie.spriteDimension.width*zombie.scale) / 2, (zombie.spriteDimension.height*zombie.scale) / 2 -- get center point
  
    centerX = zombie.x + centerX
    centerY = zombie.y + centerY
  
    math.floor(centerX)
    math.floor(centerY)
    math.floor(targetX)
    math.floor(targetY)
  
    errorMargin = 5
  
    closeArea = targetX - 50
  
    if centerX < targetX - errorMargin then
      zombie.x = zombie.x + zombie.speed * dt
    end
  
    if centerX > targetX + errorMargin then
      zombie.x = zombie.x - zombie.speed * dt
    end
    
    if centerY < targetY - errorMargin then
      zombie.y = zombie.y + (zombie.speed/2) * dt
    end
    
    if centerY > targetY + errorMargin then
      zombie.y = zombie.y - (zombie.speed/2) * dt
    end
  
end
  
function checkZombieShot(myZombie, pos)
    
    if myZombie then
      local mousePosX, mousePosY = love.mouse.getPosition()
  
      local leftClick = 1
  
      local zombieCorners = {}
  
      zombieCorners.first = {} 
      zombieCorners.second = {} 
      zombieCorners.third = {} 
      zombieCorners.fourth = {} 
  
      if myZombie.x >= cat.x then
        zombieCorners.first = {
          x = myZombie.x - myZombie.dimensions*myZombie.scale,
          y = myZombie.y
        }
        zombieCorners.second = {
          x = myZombie.x,
          y = myZombie.y
  
        }
        zombieCorners.third = {
          x = myZombie.x - myZombie.dimensions*myZombie.scale,
          y = myZombie.y + myZombie.dimensions*myZombie.scale
        }
        zombieCorners.fourth = {
          x = myZombie.x,
          y = myZombie.y + myZombie.dimensions*myZombie.scale
        }
      elseif myZombie.x < cat.x then
        zombieCorners.first = {
          x = myZombie.x,
          y = myZombie.y
        }
        zombieCorners.second = {
          x = myZombie.x + myZombie.dimensions*myZombie.scale,
          y = myZombie.y
  
        }
        zombieCorners.third = {
          x = myZombie.x,
          y = myZombie.y + myZombie.dimensions*myZombie.scale
        }
        zombieCorners.fourth = {
          x = myZombie.x + myZombie.dimensions*myZombie.scale,
          y = myZombie.y + myZombie.dimensions*myZombie.scale
        }
      end
  
  
      if mousePosX >= zombieCorners.first.x and mousePosX <= zombieCorners.second.x and mousePosY >= zombieCorners.first.y and mousePosY <= zombieCorners.fourth.y then
        if love.mouse.isDown(leftClick) then
          table.remove(zombies, pos)
        end
      end
    end
    
end
  
function checkCatHit(myZombie, pos)
  
    if myZombie then
      if (myZombie.x + myZombie.dimensions*myZombie.scale >= cat.x and myZombie.x <= cat.x + cat.dimensions*cat.scale) and (myZombie.y + myZombie.dimensions*myZombie.scale >= cat.y and myZombie.y <= cat.y + cat.dimensions*cat.scale) then
      
        table.remove(zombies, pos)
    
      end
    end
end
  
function getRandomZombieSpawn()
    local zombieSpawn = {
      above = 1,
      under = 2,
      left = 3,
      right = 4
    }
    
    local posX, posY = 0, 0
  
    local randomPos = math.random(zombieSpawn.above, zombieSpawn.right)
  
    local randomRange1, randomRange2 = 100, 500
  
    if randomPos == zombieSpawn.left then
      posX = 0;
      posY = math.random(randomRange1,randomRange2)
    elseif randomPos == zombieSpawn.right then
      posX = screenWidth - 32
      posY = math.random(randomRange1, randomRange2)
    elseif randomPos == zombieSpawn.above then
      posY = 0
      posX = math.random(randomRange1, randomRange2)
    elseif randomPos == zombieSpawn.under then
      posY = screenHeight- 32
      posX = math.random(randomRange1, randomRange2)
    end
  
    return posX, posY
  
end