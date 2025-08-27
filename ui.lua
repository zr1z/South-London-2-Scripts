local opened, accepted = false, false
local fade = 0.0
local fadeRate = 1.5

local screen = vec2(ac.getSim().windowWidth, ac.getSim().windowHeight)
local winSize = vec2(550, 600)
local winPos = screen / 2 - winSize / 2

local logoImg = {
  src = 'https://maxdout.pages.dev/assets/img/max.png',
  size = vec2(50, 50),
}

function script.update(dt)
  if not ac.getSim().isInMainMenu and not opened and not accepted then
    opened = true
  end

  if opened and not accepted then
    fade = math.min(fade + dt * fadeRate, 1.0)
    local car = ac.getCar(0)
    if car and car.gas > 0.95 then
      accepted = true
    end
  end
end

function script.drawUI()
  if not opened or accepted then return end

  local alpha = fade
  local bg = rgbm(0.05, 0.05, 0.08, 0.95 * alpha)
  local txt = rgbm(1, 1, 1, alpha)
  local btn = rgbm(1.0, 0.0, 0.0, alpha)

  ui.pushStyleColor(ui.StyleColor.ChildBg, bg)
  ui.pushStyleColor(ui.StyleColor.Text, txt)
  ui.pushStyleColor(ui.StyleColor.Button, btn)
  ui.pushStyleVar(ui.StyleVar.GrabRounding, 5)

  ui.toolWindow("🚗 App Welcome", winPos, winSize, false, true, function()
    local logoX = (winSize.x - logoImg.size.x) / 2
    display.image({
      image = logoImg.src,
      pos = vec2(logoX, 1),
      size = logoImg.size,
      color = rgbm.colors.white
    })

    ui.dummy(vec2(0, logoImg.size.y + 1))
    local yBase = ui.getCursor().y

    local welcomeMsg = "                          Welcome to"
    local titleFont = ui.Font.Title
    local welcomeWidth = ui.measureText(welcomeMsg, titleFont).x
    local x1 = (winSize.x - welcomeWidth - 520) / 2

    ui.setCursor(vec2(x1, yBase))
    ui.pushFont(titleFont)
    ui.text(welcomeMsg)
    ui.popFont()

    local clubName = "MAX'D Out"
    local clubWidth = ui.measureText(clubName, titleFont).x
    ui.sameLine()
    ui.setCursor(vec2(ui.getCursor().x, yBase + 1))
    ui.pushFont(titleFont)
    ui.pushStyleColor(ui.StyleColor.Text, txt)
    ui.text(clubName)
    ui.popStyleColor()
    ui.popFont()
    
    ui.separator()

    ui.pushFont(ui.Font.Medium)
    ui.text("📏 RULES")
    ui.popFont()

    ui.text("- Accidents happen, but be careful not to crash into other drivers.")
    ui.text("- Do not drive on the wrong side of the carriageway. (UK left side)")
    ui.text("- When using the in game chat, be respectful. Bullying and harassment will not be tolerated!")
    ui.text("- Do not block the road! If you're parking up, then use a layby, bus stop or parking space.")
    ui.text("- The most important rule. Have fun!")

    ui.newLine()
    ui.pushFont(ui.Font.Title)
    ui.text("Rules are in place for a reason. Respect them or take the consequence.")
    ui.popFont()

    ui.separator()
    ui.text("Discord Server:")
    ui.sameLine()
    if ui.button("🔗 Discord") then
      os.openURL("https://discord.gg/maxdout")
    end

    ui.separator()

    local btnW = 530
    local btnX = (winSize.x - btnW) / 2
    ui.dummy(vec2(btnX, 0))
    if ui.button("Accept and Continue", vec2(btnW, 40)) then
      accepted = true
    end
  end)

  ui.popStyleColor(3)
  ui.popStyleVar()
end
