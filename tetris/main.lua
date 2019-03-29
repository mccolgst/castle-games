-- Welcome to your new Castle project!
-- https://castle.games/get-started
-- Castle uses Love2D 11.1 for rendering and input: https://love2d.org/
-- See here for some useful Love2D documentation:
-- https://love2d-community.github.io/love-api/

local t = 0
local board_w=10
local board_h=21
local board_spacing = 32
local offset = {
  x=400,
  y=100
}

local minos = {}
minos.l = {
  {
    {1,0},
    {1,0},
    {1,1},
  },
  {
    {1,1,1},
    {1,0,0},
  },
  {
    {1,1},
    {0,1},
    {0,1},
  },
  {
    {0,0,1},
    {1,1,1},
  },
}
minos.j = {
  {
    {0,1},
    {0,1},
    {1,1},
  },
  {
    {1,0,0},
    {1,1,1},
  },
  {
    {1,1},
    {1,0},
    {1,0},
  },
  {
    {1,1,1},
    {0,0,1},
  },
}
minos.i = {
  {
    {12,12,12,12},
  },
  {
    {12},
    {12},
    {12},
    {12},
  },
}
minos.o = {
  {
    {10,10},
    {10,10},
  },
}
minos.s = {
  {
    {0,11,11},
    {11,11,0},
  },
  {
    {11,0},
    {11,11},
    {0,11},
  },
}
minos.t = {
  {
    {0,2,0},
    {2,2,2},
  },
  {
    {2,0},
    {2,2},
    {2,0},
  },
  {
    {2,2,2},
    {0,2,0},
  },
  {
    {0,2},
    {2,2},
    {0,2},
  },
}
minos.z = {
  {
    {8,8,0},
    {0,8,8},
  },
  {
    {0,8},
    {8,8},
    {8,0},
  },
}
mino_types = {"l","z","t","s","o","i","j"}
mino_colors = {
  l = {239, 121, 34},
  i = {48, 199, 239},
  j = {0, 0, 255},
  o = {248, 212, 7},
  s = {0, 255, 1},
  t = {173, 78, 158},
  z = {255, 1, 0}
}
function love.load()
  mino = new_mino()
end

function love.draw()
  draw_board()
  draw_mino(mino)
end
function love.keypressed(key)
  if key == "left" then
    mino.x = mino.x-1
  elseif key == "right" then
    mino.x = mino.x+1
  elseif key == "up" then
    mino.y = mino.y-1
  elseif key == "down" then
    mino.y = mino.y+1
  end
end
function love.update(dt)
  t = t + dt
end

function draw_board(board_obj)
  -- draw minos
  -- draw grid
  love.graphics.setColor(0, 0.4, 0.4)

  -- -- debug lines
  -- for i=0,board_w do
  --   love.graphics.line(
  --     (i*board_spacing)+offset.x,
  --     0+offset.y,
  --     (i*board_spacing)+offset.x,
  --     (board_spacing*board_h)+offset.y
  --   )
  -- end
  -- -- debug lines
  -- for i=0,board_h do
  --   love.graphics.line(
  --     0+offset.x,
  --     (i*board_spacing)+offset.y,
  --     (board_w*board_spacing)+offset.x,
  --     (i*board_spacing)+offset.y
  --   )
  -- end

  -- left border line
  love.graphics.line(
    0+offset.x,
    0+offset.y,
    0+offset.x,
    (board_h*board_spacing)+offset.y
  )
  -- bottom border line
  love.graphics.line(
    0+offset.x,
    (board_h*board_spacing)+offset.y,
    (board_w*board_spacing)+offset.x,
    (board_h*board_spacing)+offset.y
  )
  -- right border line
  love.graphics.line(
    (board_w*board_spacing)+offset.x,
    0+offset.y,
    (board_w*board_spacing)+offset.x,
    (board_h*board_spacing)+offset.y
  )
end

function draw_mino(mino_obj)
  -- find color
  mino_color = mino_colors[mino_obj.type]
  love.graphics.setColor(
    1,
    1,
    1
  )
  for i=1,#mino_obj.piece do
    for j=1,#mino_obj.piece[i] do
      if mino_obj.piece[i][j] > 0 then
        love.graphics.rectangle(
          "fill",  -- drawmode
          (mino_obj.x * board_spacing) + ((j-1) * board_spacing) + (offset.x + 1),
          (mino_obj.y * board_spacing) + ((i-1) * board_spacing) + (offset.y + 1),
          board_spacing + 1, -- width
          board_spacing + 1, -- height
          board_spacing/6
        )
      end
    end
  end
  love.graphics.setColor(
    mino_color[1]/255,
    mino_color[2]/255,
    mino_color[3]/255
  )
  for i=1,#mino_obj.piece do
    for j=1,#mino_obj.piece[i] do
      if mino_obj.piece[i][j] > 0 then
        love.graphics.rectangle(
          "fill",  -- drawmode
          (mino_obj.x * board_spacing) + ((j-1) * board_spacing) + offset.x,
          (mino_obj.y * board_spacing) + ((i-1) * board_spacing) + offset.y,
          board_spacing, -- width
          board_spacing, -- height
          board_spacing/6
        )
      end
    end
  end
end

function new_mino()
  local mino = {}
  mino.x = 3
  mino.y = 0
  local type=mino_types[love.math.random(1, #mino_types)]
  mino.type = type
  mino.piece = minos[type][1]
  return mino
end