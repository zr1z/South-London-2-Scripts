local hasOpened, hasRead = false, false
local timeVisible = 0.0
local fadeSpeed = 1.5

local screensize = vec2(ac.getSim().windowWidth, ac.getSim().windowHeight)
local windowSize = vec2(550, 600)
local windowPos = screensize / 2 - windowSize / 2

local logo = {
  src = 'https://neyc7leaimwu59as.public.blob.vercel-storage.com/xaxg1sjdEF-03zgRZ9kJhC3m1Mgg1wKhJUVOisZzo.png',
  size = vec2(500, 230),
}

function script.update(dt)
  if not ac.getSim().isInMainMenu and not hasOpened and not hasRead then
    hasOpened = true
  end

  if hasOpened and not hasRead then
    timeVisible = math.min(timeVisible + dt * fadeSpeed, 1.0)
    local car = ac.getCar(0)
    if car and car.gas > 0.95 then
      hasRead = true
    end
  end
end

function script.drawUI()
  if not hasOpened or hasRead then return end

  local fadeAlpha = timeVisible
  local bgColor = rgbm(0.05, 0.05, 0.08, 0.95 * fadeAlpha)
  local textColor = rgbm(1, 1, 1, fadeAlpha)
  local accent = rgbm(1.0, 0.5, 0.1, fadeAlpha)

  ui.pushStyleColor(ui.StyleColor.ChildBg, bgColor)
  ui.pushStyleColor(ui.StyleColor.Text, textColor)
  ui.pushStyleColor(ui.StyleColor.Button, accent)
  ui.pushStyleVar(ui.StyleVar.GrabRounding, 5)
  ui.pushStyleVar(ui.StyleVar.FrameRounding, 12) -- Add this line for button/frame rounding
  -- Optionally, if supported:
  -- ui.pushStyleVar(ui.StyleVar.WindowRounding, 18)

  ui.toolWindow("🚗 App Welcome", windowPos, windowSize, false, true, function()
    local logoX = (windowSize.x - logo.size.x) / 2
    display.image({
      image = logo.src,
      pos = vec2(logoX, 1),
      size = logo.size,
      color = rgbm.colors.white
    })

    ui.dummy(vec2(0, logo.size.y + 1))
    local yBase = ui.getCursor().y

    local welcomeText = "                          Welcome to"
    local titleFont = ui.Font.Title
    local welcomeWidth = ui.measureText(welcomeText, titleFont).x
    local x1 = (windowSize.x - welcomeWidth - 520) / 2

    ui.setCursor(vec2(x1, yBase))
    ui.pushFont(titleFont)
    ui.text(welcomeText)
    ui.popFont()

    local clubText = "MAX'D Out"
    local clubWidth = ui.measureText(clubText, titleFont).x
    ui.sameLine()
    ui.setCursor(vec2(ui.getCursor().x, yBase + 1))
    ui.pushFont(titleFont)
    ui.pushStyleColor(ui.StyleColor.Text, accent)
    ui.text(clubText)
    ui.popStyleColor()
    ui.popFont()

    ui.sameLine()
    ui.text(" 🎢")

    ui.separator()

    ui.pushFont(ui.Font.Medium)
    ui.text("📏 RULES")
    ui.popFont()

    ui.text("- ")
    ui.text("- ")
    ui.text("- ")
    ui.text("- ")
    ui.text("- ")

    ui.newLine()
    ui.pushFont(ui.Font.Title)
    ui.text("Failure to respect the rules = kick or ban 🚫")
    ui.popFont()

    ui.separator()
    ui.text("💬 Join us:")
    ui.sameLine()
    if ui.button("🔗 Discord") then
      os.openURL("https://discord.gg/maxdout")
    end

    ui.separator()

    local btnWidth = 530
    local btnX = (windowSize.x - btnWidth) / 2
    ui.dummy(vec2(btnX, 0))
    if ui.button("🚀 Accept and Continue", vec2(btnWidth, 40)) then
      hasRead = true
    end
  end)
  ui.popStyleColor(3)
  ui.popStyleVar(2) -- Change to 2 if you added one style var, 3 if you added two
end
