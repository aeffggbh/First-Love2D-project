
scenes = {
  gamePlay = 1,
  menu = 2,
  paused = 3,
  over = 4
}

local currentScene = scenes.menu

function getCurrentScene()
    return currentScene
end

function setCurrentScene(scene)
    currentScene = scene
end