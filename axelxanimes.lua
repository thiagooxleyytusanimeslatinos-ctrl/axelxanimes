local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:FindFirstChild("HumanoidRootPart")
local mouse = player:GetMouse()
local camera = Workspace.CurrentCamera
local allConnections = {}
local persistentConnections = {}
local originalGravity = (Workspace.Gravity > 0) and Workspace.Gravity or 196.2
local antiGravityForce = nil
local lockedPlayer = nil
local isR6 = (humanoid.RigType == Enum.HumanoidRigType.R6)
local R6_FLIGHT_ANIMS = {
	Idle = 97172005, Idle2 = 21633130, Forward = 46196309, Fast = 282574440,
	Back = 48957148, Up = 90872539, Down = 233322916
}
-- FLIGHT VARIABLES
local isFlying = false
local r6FlightIdleMode = 1
local fastFlightMode = 1
local flightSpeedValue = 16
local flightIdleAnim = "119943574268614"
local flightForwardAnim = "121652468298377"
local flightForwardAnim = "100783666275892"
local flightFastAnim = "88949763608807"
local flightMidSpeedAnim = "133479030483520"
local flightSlowAnim = "100783666275892"
local flightSlowAnim = "121652468298377"
local flightBackwardAnim = "78684337927052"
local currentFlightAnimTrack = nil
local currentAnimTrack = nil
local currentEmoteSound = nil
local flyGyro = nil
local flyVelocity = nil
local flightMoveState = {forward = 0, backward = 0, left = 0, right = 0, up = 0, down = 0}
local flightConns = {}
local r6FlightTracks = {}
local r6ForwardHold = 0
local currentFlightCF = nil
local flightCurrentRoll = 0
local flightEmoteActive = false
local lastStationaryPos = nil
local flightStaticRotation = true
local flightRegenEnabled = false
local currentImpulseVelocity = Vector3.new(0, 0, 0)
local walkPos = nil
local lastWalkStationaryPos = nil
local FLIGHT_EMOTES = isR6 and {66703954, 54513258} or {
	110459850241477, 102620389167016, 104879320142507, 118287320739937, 120718177198595,
	124369689700678, 89173946476926, 133245709757511, 72132583099218,
	136280235646918, 114527286143657, 77099947447557, 127117414275525,
	90117338161077
}
local currentFlightEmoteIndex = 1
-- ANIMACIONES
local ANIMATIONS = {
	Idle = 135235217809048, Walk = 16738340646, Run = 70636286183373,
	Jump = 104325245285198, Fall = 16738333171, Climb = 10921257536,
	Swim = 10921243048, SwimIdle = 10921265698, Sit = 2506281703
}
local idleAnimId = 135235217809048
local hurtAnimId = 140704739422954
local exhaustedIdleAnimId = "78328282298953"
local exhaustedWalkAnimId = "99498309796580"
local exhaustedFlyAnimId = "122810984847235"
local hurtWalkAnimId = "138562662004109"
local managedAnimationIds = {}
local LOOP_ANIMATION_IDS = {}
local selectableAnimations

do
	local function registerManagedId(id)
		if not id then return end
		local numId = typeof(id) == "number" and string.format("%.0f", id) or tostring(id):match("%d+")
		if numId then managedAnimationIds[numId] = true end
	end

	for _, id in pairs(ANIMATIONS) do
		LOOP_ANIMATION_IDS["rbxassetid://" .. id] = true
		registerManagedId(id)
	end
	local extraIds = {flightIdleAnim, "93032051646965", flightForwardAnim, flightFastAnim, flightSlowAnim, flightBackwardAnim, "138992096476836", "84043660421785", "96731289267640", "111690963588496", "128406664848479", "140704739422954", "83860986564910", "103145593690285", "128578785610052", "77128372412361", "72301599441680", "87088218490918", "104687069461693", "142495255", "248336294", "54513258", "95424077", "97170520", "97172005", "21633130", "48957148", "56146409", "66703954", "73033633", "97171309", "133479030483520", "117251315086498", "129768396663808",
		exhaustedIdleAnimId, exhaustedWalkAnimId, exhaustedFlyAnimId, hurtWalkAnimId
	}
	for _, id in ipairs(extraIds) do
		LOOP_ANIMATION_IDS["rbxassetid://" .. id] = true
		registerManagedId(id)
	end
	registerManagedId(idleAnimId)
	selectableAnimations = isR6 and {73033633, 128777973, 128853357, 129423131} or {
	117722192552703, 124200992648318, 113375965758912, 83766124558950, -- Emotes 1-4
	133394554631338, 138316142522795, 126644738448952, 97751249599208, -- Emotes 5-8
	120071905410216, 95494576365544, 102274955976143, 136687532783709, -- Emotes 9-12
	112192314086885, 91398182744709, 102439655497210, 93655929598076, -- Emotes 13-16
	122599479076921, -- Emote 17
	-- Emotes agregados
	82682811348660, 92689671662713, 104687069461693, 104998729896195,
	106516971471692, 76167683097846, 129115715729473, 106394178681320,
	133979485105808, 80222624644964, 70456775231265, 132990883627615,
	130196652446769, 140409138293585, 72101120437031, 119822440796584,
	127786890738997, 129269946654799, 130264584381746, 99873676774268,
	101409107532852, 82238508652742, 140536225775470, 76176643257712,
	137880837576956, 117913449580238, 72326999255699, 84668569083234,
	75117059305996, 110608120999378, 108703544549132, 131673340109237,
	77949063578180
}
	for _, id in ipairs(selectableAnimations) do registerManagedId(id) end
	for _, id in ipairs(FLIGHT_EMOTES) do registerManagedId(id) end
	local r6ExtraIds = {90872539, 136801964, 142495255, 97169019, 46196309, 282574440, 106772613, 42070810, 214744412, 233322916, 97171309, 248336294, 54513258, 95424077, 97170520, 97172005, 21633130}
	for _, id in ipairs(r6ExtraIds) do registerManagedId(id) end
end
local currentAnimationIndex = 1
local muteEmotes = false
local noSitActive = false
local MOVEMENT_AUDIO_VOLUME = 0.7
local originalSoundProperties = {}
local originalAmbientVolumes = {}
local emoteMusicActive = false
local ambientSoundMuteThread = nil
-- OTRAS HABILIDADES
local isWalkSpeedActive = false
local walkSpeed = 16
local targetWalkSpeed = 16
local walkSpeedLerpFactor = 0.08
local maxWalkSpeed = 500
local preFlightWalkSpeed = nil
local preFlightIsSpeedActive = nil
local originalWalkSpeed = 11
local originalJumpPower = 50
local walkAnimTrack = nil
local hurtOverlayTrack = nil
local sitAnimTrack = nil
local swimAnimTrack = nil
local swimIdleAnimTrack = nil
local climbAnimTrack = nil
local jumpAnimTrack = nil
local fallAnimTrack = nil
local exhaustedIdleTrack = nil
local exhaustedWalkTrack = nil
local isMirageSpeedActive = false
local mirageSpeedEmoteTrack = nil
local mirageSpeedValue = 10
local minMirageSpeed = 0.5 
local maxMirageSpeed = 30
local mirageSpeedStep = 9.5
local isSuperJumpActive = false
local superJumpPower = 70
local isSuperSaltoCharged = false
local superSaltoChargeTime = 0
local superSaltoTrack = nil
local isGravJumpActive = false
local targetGravity = 196.2
local SuperStrength = {
	Active = false, GrabbedData = nil, Distance = 500, Connection = nil,
	ThrowForce = 999, AnimTrack = nil, LastActionTime = 0, ActivationTime = 0
}
local SuperHearing = {
	Active = false, Heartbeat = nil, PlayerHighlights = {}, NPCHighlights = {},
	Sound = nil, LastUpdate = 0, PlayerCache = {}, NPCCache = {}, ActiveNPCs = {},
	Timer = nil, Blur = nil, ColorCorrection = nil, CleanupTimer = nil,
	CachedNPCList = {}, ActiveNPCs = {}, LastNPCScanTime = 0, Echo = nil, Reverb = nil
}
local InstantReaction = {
	Active = false, LastDodge = 0, Cooldown = 0.3, DetectionRange = 20,
	Connection = nil, DodgeActive = false
}
local XRayVision = {
	Active = false, ColorCorrection = nil, Heartbeat = nil,
	Highlights = {}, LastScanTime = 0, CachedNPCList = {},
	CachedItemList = {}, TransparentParts = {}, LastTransparencyUpdateTime = 0
}
local isInvisibilityActive = false
local invisibilitySeat = nil
local preInvisibilityCF = nil
local antiFallConnections = {}
local antiFallTeleporting = false
local antiFlingConnection = nil
local isSprintActive = false
local sprintAnimTrack = nil
local isCrouching = false
local lastStunTime = 0
local customAnimationsLoaded = false
local animationTracks = {}

-- VIBRACIÓN MOLECULAR (NOCLIP)
local isMolecularVibrationActive = false
local molecularVibrationConn = nil
local molecularVibrationOriginalCollisions = {}
local molecularVibrationRequesters = {mirage = false, speed = false}
local startMolecularVibration, stopMolecularVibration, updateMolecularVibrationState -- forward declare

local toggleAbility = nil
local cleanupEverything = nil
local adjustSpeed = nil
local startMainAnimationLoop = nil
local playAnimation = nil
local loadAnimations = nil

-- BATERÍA KRYPTONIANA
local battery = 100
local maxBattery = 100
local batteryUpdateConn = nil
local isBatteryDepleted = false
local batteryDepletedBlur = nil

local function isExternalAnimPlaying()
	if not humanoid or not character then return false end
	-- Detección de "agarre" o interacciones externas mediante soldaduras (Welds).
	-- Si el torso o la raíz del personaje está soldado a algo fuera del propio personaje,
	-- se considera una animación externa (como ser llevado por otro jugador).
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("Weld") or descendant:IsA("WeldConstraint") then
			local p0 = descendant.Part0
			local p1 = descendant.Part1
			if p0 and p1 then
				local p0_in_char = p0:IsDescendantOf(character)
				local p1_in_char = p1:IsDescendantOf(character)
				if (p0_in_char and not p1_in_char) or (p1_in_char and not p0_in_char) then
					local our_part = p0_in_char and p0 or p1
					if our_part.Name:find("Torso") or our_part.Name:find("Root") then
						return true -- Es una interacción de agarre/llevar.
					end
				end
			end
		end
	end
	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		local numId = track.Animation.AnimationId:match("%d+")
		local name = track.Name:lower()
		local isBasic = name:find("walk") or name:find("run") or name:find("idle") or name:find("jump") or name:find("fall") or name:find("strafe") or name:find("swimming") or name:find("movement") or name:find("dash") or name:find("sprint") or track.Looped
		if track.IsPlaying and numId and not managedAnimationIds[numId] then
			if not isBasic and (name:find("cutscene") or name:find("scene") or name:find("event") or name:find("elevator") or name:find("intro") or name:find("cinematic") or name:find("search") or name:find("open") or track.Priority.Value >= Enum.AnimationPriority.Action3.Value) then
				return true
			end
		end
	end
	return false
end

local function getTargetFromCamera()
	local center = camera.ViewportSize / 2
	local target = nil
	local minDistance = 250
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hum = p.Character:FindFirstChild("Humanoid")
			if hum and hum.Health > 0 then
				local pos, onScreen = camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
				if onScreen then
					local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
					if dist < minDistance then
						minDistance = dist
						target = p
					end
				end
			end
		end
	end
	return target
end

-- ============ SUPER STRENGTH HELPERS ============
local function canGrabObject(part)
	if not part or part:IsDescendantOf(character) or part:IsA("Terrain") then return false end
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {character}
	local groundCheck = Workspace:Raycast(hrp.Position, Vector3.new(0, -10, 0), rayParams)
	if groundCheck and (part == groundCheck.Instance or part:IsAncestorOf(groundCheck.Instance)) then
		return false
	end

	local function getVehicleRootPart(targetPart)
		local model = targetPart:FindFirstAncestorOfClass("Model")
		if not model then return targetPart end
		local vehicleParts = {"MainPart", "Body", "Chassis", "RootPart", "PrimaryPart", "Handle", "VehicleSeat", "Seat"}
		for _, partName in ipairs(vehicleParts) do
			local foundPart = model:FindFirstChild(partName, true)
			if foundPart and foundPart:IsA("BasePart") then return foundPart end
		end
		return model.PrimaryPart or targetPart
	end

	local model = part:FindFirstAncestorOfClass("Model")
    local isVehicle = false
    if model and (model:FindFirstChildWhichIsA("VehicleSeat", true) or model:FindFirstChildWhichIsA("Seat", true) or
        model.Name:lower():find("car") or model.Name:lower():find("vehic") or model.Name:lower():find("chassis")) then
        isVehicle = true
    end

    if isVehicle then
        local mainPart = getVehicleRootPart(part)
        -- Para vehículos, permitimos el agarre incluso si están anclados, ya que la lógica de agarre los desanclará.
        return true, mainPart or part, model, isVehicle
    end

    if part.Anchored and part.Size.Magnitude > 50 then return false end
    local mainPart = getVehicleRootPart(part)
    if mainPart and mainPart.Anchored then return false end
    return true, mainPart or part, model, isVehicle
end

local function releaseGrabbedObject(shouldThrow)
	if not SuperStrength.GrabbedData then return end

	local function stopGrabAnim()
		if SuperStrength.AnimTrack then
			SuperStrength.AnimTrack:Stop(0.1)
			SuperStrength.AnimTrack = nil
		end
	end

	local data = SuperStrength.GrabbedData
	SuperStrength.GrabbedData = nil
	SuperStrength.LastActionTime = tick()
	if data.savedPhysics then
		for part, props in pairs(data.savedPhysics) do
			if part and part.Parent then
				part.Massless = props.Massless
				part.CanCollide = props.CanCollide
				for _, child in ipairs(part:GetChildren()) do
					if child:IsA("NoCollisionConstraint") and child.Name == "SuperGrabNC" then
						child:Destroy()
					end
				end
			end
		end
	end
	local root = data.root
	if data.alignPos then data.alignPos:Destroy() end
	if data.alignOrient then data.alignOrient:Destroy() end
	if data.att0 then data.att0:Destroy() end
	if data.att1 then data.att1:Destroy() end
	stopGrabAnim()
	-- Si no estamos volando, es seguro reactivar las animaciones por defecto.
	-- Si estamos volando, el bucle de vuelo se encargará de las animaciones.
	if not isFlying then
		enableDefaultAnimate()
	end

	if shouldThrow then
		local camLook = camera.CFrame.LookVector

		local function getVehicleMass(model)
			local totalMass = 0
			for _, part in ipairs(model:GetDescendants()) do
				if part:IsA("BasePart") then totalMass = totalMass + part:GetMass() end
			end
			return math.max(totalMass, 1)
		end

		local mass = (data.isVehicle and data.model) and getVehicleMass(data.model) or (root.AssemblyMass or 1)
		pcall(function() root:ApplyImpulse(camLook * SuperStrength.ThrowForce * mass * 2) end)
	end
	if data.model and data.savedStates then
		for seat, state in pairs(data.savedStates) do
			if seat and seat.Parent then seat.Disabled = state.Disabled end
		end
	end
	SuperStrength.Active = false
	if SuperStrength.Connection then
		SuperStrength.Connection:Disconnect()
		SuperStrength.Connection = nil
	end
	updateMainUI()
end

-- ==========================================================
local abilities = {
	{name = "Espejismo", key = "miragespeed"},
	{name = "Super Audición", key = "superhearing"},
	{name = "Gravedad", key = "gravjump"},
	{name = "Super Salto", key = "supersalto"},	
	{name = "Rayos X", key = "xrayvision"},
	{name = "Velocidad", key = "walkspeed"},
	{name = "Vuelo", key = "flight"},
	{name = "Super Agarre", key = "superstrength"},
	{name = "Re.Instantanea", key = "instantreaction"}
}

local function isAbilityAvailable(key)
	if isR6 and (key == "miragespeed" or key == "supersalto") then return false end
	if not isR6 and key == "instantreaction" then return false end
	return true
end

-- ============ MENÚ SELECTOR ============
local MODES = {ABILITIES = 1, EMOTES = 2, SETTINGS = 3}
local currentMode = MODES.ABILITIES
local modeNames = {[1] = "HABILIDADES", [2] = "EMOTES", [3] = "AJUSTES"}
local settingOptions = {"ESTATICO: ON", "SILENCIAR: OFF", "NOSIT: OFF", "VUELO+BATERIA: OFF", "VUELO RAPIDO: 1", "R6 FLY: 1", "DESTRUIR"}
local UI = {}
local currentSettingIndex = 1
local scriptActive = true
local menuOpen = false
local currentAbilityIndex = 7
local lastAbilityTap = 0
local abilityTapThread = nil

-- ============ FLIGHT FUNCTIONS ============
local function disableDefaultAnimate()
	local function process(parent)
		if not parent then return end
		for _, scr in ipairs(parent:GetChildren()) do
			if scr:IsA("LocalScript") and (scr.Name:find("Animate") or scr.Name:find("Anim") or scr.Name:find("Handler") or scr.Name:find("Movement") or scr.Name:find("Sprint")) then
				scr.Disabled = true
			end
		end
	end
	process(character)
	process(player:FindFirstChild("PlayerGui"))
end

local function enableDefaultAnimate()
	local function process(parent)
		if not parent then return end
		for _, scr in ipairs(parent:GetChildren()) do
			if scr:IsA("LocalScript") and (scr.Name:find("Animate") or scr.Name:find("Anim") or scr.Name:find("Handler") or scr.Name:find("Movement") or scr.Name:find("Sprint")) then
				scr.Disabled = false
			end
		end
	end
	process(character)
	process(player:FindFirstChild("PlayerGui"))
end

local function playFlightAnimation(animId, startTime, speed, blendTime)
	if not character or not humanoid then return end
	blendTime = blendTime or 0.1
	if currentFlightAnimTrack then
		currentFlightAnimTrack:Stop(blendTime)
		currentFlightAnimTrack = nil
	end
	disableDefaultAnimate()
	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		if not SuperStrength.AnimTrack or track ~= SuperStrength.AnimTrack then
			track:Stop(blendTime)
		end
	end
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. tostring(animId)
	currentFlightAnimTrack = humanoid:LoadAnimation(anim)
	currentFlightAnimTrack.Priority = Enum.AnimationPriority.Action4
	currentFlightAnimTrack.Looped = true
	currentFlightAnimTrack:Play(blendTime)
	if startTime then currentFlightAnimTrack.TimePosition = startTime end
	if speed then currentFlightAnimTrack:AdjustSpeed(speed) end
end

local function stopFlightAnimation(blendTime)
	blendTime = blendTime or 0.1
	if currentFlightAnimTrack then
		currentFlightAnimTrack:Stop(blendTime)
		currentFlightAnimTrack = nil
	end
	if jumpAnimTrack then jumpAnimTrack:Stop(blendTime) end
	if fallAnimTrack then fallAnimTrack:Stop(blendTime) end
	if not SuperStrength.GrabbedData then
		enableDefaultAnimate()
	end
end

local function setupFlightMovementAudio()
	if flightAudio then flightAudio:Destroy() end
	flightAudio = Instance.new("Sound")
	flightAudio.SoundId = "rbxassetid://596046130"
	flightAudio.Volume = 0
	flightAudio.Looped = true
	flightAudio.Name = "FlightMovementSound"
	flightAudio.Parent = hrp or character:FindFirstChild("HumanoidRootPart")
	flightAudio:Play()
end

local function updateFlightAudios(fwd, side)
	if not flightAudio or not isFlying then return end
	if math.abs(fwd) > 0.1 or math.abs(side) > 0.1 then
		if flightAudio.Volume < MOVEMENT_AUDIO_VOLUME then
			flightAudio.Volume = math.min(flightAudio.Volume + 0.05, MOVEMENT_AUDIO_VOLUME)
		end
		local currentSpeed = isWalkSpeedActive and walkSpeed or 16
		local speedFactor = currentSpeed / 200
		flightAudio.Pitch = 0.8 + (speedFactor * 0.4)
	else
		if flightAudio.Volume > 0 then
			flightAudio.Volume = math.max(flightAudio.Volume - 0.05, 0)
		end
	end
end

local function stopFlightAudio()
	if flightAudio then
		local target = flightAudio
		flightAudio = nil
		task.spawn(function()
			local startVol = target.Volume
			for i = 1, 10 do
				target.Volume = startVol * (1 - i/10)
				task.wait(0.05)
			end
			target:Stop()
			target:Destroy()
		end)
	end
end

local function stopR6FlightAnims(blendTime)
	blendTime = blendTime or 0.1
	for _, track in pairs(r6FlightTracks) do
		track:Stop(blendTime)
	end
end

local function setupR6FlightAnims()
	if not isR6 or not humanoid then return end
	stopR6FlightAnims(0)
	r6FlightTracks = {}
	local idleId = (r6FlightIdleMode == 1) and R6_FLIGHT_ANIMS.Idle or R6_FLIGHT_ANIMS.Idle2
	local anims = {
		up = 90872539, down = 233322916,
		l1 = 48957148, l2 = 142495255,
		r1 = 48957148, r2 = 142495255,
		b1 = 48957148, b2 = 106772613, b3 = 42070810, b4 = 214744412,
		fLow1 = 46196309, fLow2 = 282574440,
		fFast = 282574440, idle = idleId
	}
	for k, id in pairs(anims) do
		local a = Instance.new("Animation")
		a.AnimationId = "rbxassetid://" .. id
		local track = humanoid:LoadAnimation(a)
		track.Priority = Enum.AnimationPriority.Action4
		r6FlightTracks[k] = track
	end
end

-- Variables para suavizado de vuelo (lerp)
local currentFlightVelocity = Vector3.zero
local targetFlightVelocity = Vector3.zero
local flightVelocityLerp = 0.15
local flightRotationLerp = 0.2

local function startFlight()
	if isFlying then return end
	preFlightWalkSpeed = targetWalkSpeed
	preFlightIsSpeedActive = isWalkSpeedActive
	if not isWalkSpeedActive then
		targetWalkSpeed = flightSpeedValue
	end
	isWalkSpeedActive = true -- El vuelo usa el sistema de velocidad
	isFlying = true
	antiGravityForce = Instance.new("BodyForce")
	antiGravityForce.Name = "FlightBuoyancy"
	antiGravityForce.Force = Vector3.new(0, hrp:GetMass() * Workspace.Gravity, 0)
	antiGravityForce.Parent = hrp
	humanoid.AutoRotate = false
	humanoid.PlatformStand = true
	hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
	hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
	if walkPos then walkPos.MaxForce = Vector3.new(0,0,0) end
	setupFlightMovementAudio()
	if not SuperStrength.GrabbedData then
		if isR6 then
			setupR6FlightAnims()
			disableDefaultAnimate()
		else
			playFlightAnimation(flightIdleAnim, 0, 1, 0.2)
		end
	end
	flyGyro = Instance.new("BodyGyro")
	flyGyro.Name = "FlyGyro"
	flyGyro.P = 30000
	flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	flyGyro.CFrame = hrp.CFrame
	flyGyro.Parent = hrp
	flyVelocity = Instance.new("BodyVelocity")
	flyVelocity.Name = "FlyVelocity"
	flyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	flyVelocity.Velocity = Vector3.new(0, 0, 0)
	flyVelocity.Parent = hrp
	lastStationaryPos = nil
	currentFlightCF = hrp.CFrame
	currentFlightVelocity = Vector3.zero
	targetFlightVelocity = Vector3.zero
	local flightUpdate = RunService.RenderStepped:Connect(function(deltaTime)
		if not isFlying or not character or not hrp then return end
		if humanoid then
			humanoid.PlatformStand = true
			humanoid.AutoRotate = false
		end

		if not isR6 then
			local animate = character:FindFirstChild("Animate")
			if animate then
				local equippedTool = character:FindFirstChildOfClass("Tool")
				local isHoldingTool = equippedTool ~= nil or false
				if not isHoldingTool then
					local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
					if rightHand then
						for _, child in ipairs(rightHand:GetChildren()) do
							if child:IsA("Weld") or child:IsA("WeldConstraint") then
								local otherPart = (child.Part0 == rightHand and child.Part1) or (child.Part1 == rightHand and child.Part0)
								if otherPart and not otherPart:IsDescendantOf(character) then
									isHoldingTool = true
									break
								end
							end
						end
					end
				end
				if isHoldingTool and animate.Disabled then
					animate.Disabled = false
				elseif not isHoldingTool and not animate.Disabled then
					animate.Disabled = true
				end
			end
		end

		local isExternal = isExternalAnimPlaying() and not character:FindFirstChildOfClass("Tool")
		if isExternal then
			if currentFlightAnimTrack then currentFlightAnimTrack:Stop(0.2) currentFlightAnimTrack = nil end
			if isR6 then stopR6FlightAnims(0.2) end
		end

		if antiGravityForce then
			local bobbingForce = math.sin(tick() * 8) * 25
			antiGravityForce.Force = Vector3.new(0, hrp:GetMass() * Workspace.Gravity + bobbingForce, 0)
		end

		local cam = Workspace.CurrentCamera
		local fwd = 0
		local side = 0
		if humanoid and humanoid.MoveDirection.Magnitude > 0 then
			local relativeMove = cam.CFrame:VectorToObjectSpace(humanoid.MoveDirection)
			fwd = -relativeMove.Z
			side = relativeMove.X
		end
		local upDown = (flightMoveState.up or 0) - (flightMoveState.down or 0)

		local direction = cam.CFrame.LookVector
		local right = cam.CFrame.RightVector
		local targetVel = (direction * fwd) + (right * side) + (Vector3.new(0, 1, 0) * upDown)
		local currentSpeed = isWalkSpeedActive and walkSpeed or 16
		if targetVel.Magnitude > 0.01 then
			targetVel = targetVel.Unit * currentSpeed
		else
			targetVel = Vector3.zero
		end

		currentFlightVelocity = currentFlightVelocity:Lerp(targetVel, flightVelocityLerp)

		local horizontalMove = Vector3.new(currentFlightVelocity.X, 0, currentFlightVelocity.Z)
		if horizontalMove.Magnitude > 0.001 then
			hrp.CFrame = hrp.CFrame + (horizontalMove * deltaTime)
		end

		if flyVelocity then
			flyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			flyVelocity.Velocity = Vector3.new(0, currentFlightVelocity.Y, 0)
		end

		if not isExternal and targetVel.Magnitude < 0.01 then
			if not lastStationaryPos then lastStationaryPos = hrp.Position end
			if flyVelocity then flyVelocity.Velocity = Vector3.zero end
			hrp.AssemblyLinearVelocity = Vector3.zero
		else
			lastStationaryPos = nil
		end

		if isR6 then
			if not SuperStrength.GrabbedData and not isExternal and not flightEmoteActive then
				for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
					local tId = track.Animation.AnimationId:match("%d+")
					if tId and not managedAnimationIds[tId] then
						if track.Looped or track.Priority.Value <= Enum.AnimationPriority.Action2.Value then
							track:Stop(0.1)
							track:AdjustWeight(0, 0.1)
						end
					end
				end
				local shouldPlayIdle = true
				if math.abs(upDown) > 0.1 then
					if not r6FlightTracks.up.IsPlaying then
						stopR6FlightAnims(0.15)
						r6FlightTracks.up:Play(0.15)
						r6FlightTracks.up:AdjustSpeed(1)
					end
					shouldPlayIdle = false
				elseif side < -0.1 then
					if not r6FlightTracks.l1.IsPlaying then
						stopR6FlightAnims(0.15)
						r6FlightTracks.l1:Play(0.15)
						r6FlightTracks.l1.TimePosition = 2.0
						r6FlightTracks.l1:AdjustSpeed(0.8)
						r6FlightTracks.l2:Play(0.15)
						r6FlightTracks.l2.TimePosition = 0.5
						r6FlightTracks.l2:AdjustSpeed(0.8)
					end
					shouldPlayIdle = false
				elseif side > 0.1 then
					if not r6FlightTracks.r1.IsPlaying then
						stopR6FlightAnims(0.15)
						r6FlightTracks.r1:Play(0.15)
						r6FlightTracks.r1.TimePosition = 1.1
						r6FlightTracks.r1:AdjustSpeed(0.8)
						r6FlightTracks.r2:Play(0.15)
						r6FlightTracks.r2.TimePosition = 0.5
						r6FlightTracks.r2:AdjustSpeed(0.8)
					end
					shouldPlayIdle = false
				elseif fwd < -0.1 then
					if not r6FlightTracks.b1.IsPlaying then
						stopR6FlightAnims(0.15)
						r6FlightTracks.b1:Play(0.15)
						r6FlightTracks.b1.TimePosition = 0.7
						r6FlightTracks.b1:AdjustSpeed(0.8)
					end
					shouldPlayIdle = false
				elseif fwd > 0.1 then
					r6ForwardHold = r6ForwardHold + deltaTime
					local currentSpeed = isWalkSpeedActive and walkSpeed or 16
					if currentSpeed <= 16 then
						if not r6FlightTracks.fLow1.IsPlaying or r6FlightTracks.fLow1.Speed == 0 then
							stopR6FlightAnims(0.15)
							r6FlightTracks.fLow1:Play(0.15, 1)
							r6FlightTracks.fLow1:AdjustSpeed(0.8)
						end
					else
						if not r6FlightTracks.fFast.IsPlaying then
							stopR6FlightAnims(0.15)
							r6FlightTracks.fFast:Play(0.15)
							r6FlightTracks.fFast:AdjustSpeed(0.05)
						end
					end
					shouldPlayIdle = false
				else
					r6ForwardHold = 0
				end
				if shouldPlayIdle then
					if not r6FlightTracks.idle.IsPlaying then
						stopR6FlightAnims(0.15)
						r6FlightTracks.idle:Play(0.15)
						if r6FlightIdleMode == 1 then
							r6FlightTracks.idle.TimePosition = 2.0
						end
						r6FlightTracks.idle:AdjustSpeed(0)
					end
				end
			end
		else
			local targetAnim = nil
			if SuperStrength.GrabbedData then
				if currentFlightAnimTrack then currentFlightAnimTrack:Stop(0.2) currentFlightAnimTrack = nil end
			elseif not isExternal and not flightEmoteActive then
				if fwd > 0.1 then
					local currentSpeed = isWalkSpeedActive and walkSpeed or 16
					if currentSpeed >= 18 then
						-- A partir de 18, la animación por defecto (modo 1) es la de velocidad media.
						-- El modo 2 activa la animación de "jet" súper rápido.
						targetAnim = (fastFlightMode == 1) and flightFastAnim or flightMidSpeedAnim
					elseif currentSpeed >= 11 then
						targetAnim = flightForwardAnim -- Para velocidades de 11 a 17, se mantiene la animación normal.
					else
						targetAnim = flightSlowAnim
					end
				elseif fwd < -0.1 then
					targetAnim = flightBackwardAnim
				elseif math.abs(side) > 0.1 then
					targetAnim = flightForwardAnim
				else
					targetAnim = flightIdleAnim
				end
				if targetAnim then
					if not currentFlightAnimTrack or currentFlightAnimTrack.Animation.AnimationId ~= "rbxassetid://" .. tostring(targetAnim) then
						playFlightAnimation(targetAnim, 0, 1, 0.15)
					end
				end
			end
		end

		local isMoving = currentFlightVelocity.Magnitude > 0.01
		if isMoving or not flightStaticRotation then
			local camRotation = CFrame.lookAt(Vector3.zero, cam.CFrame.LookVector)
			local targetRotation = camRotation * CFrame.Angles(0, 0, math.rad(flightCurrentRoll))
			if currentFlightCF then
				currentFlightCF = currentFlightCF:Lerp(targetRotation, flightRotationLerp)
			else
				currentFlightCF = targetRotation
			end
		end
		if flyGyro then
			flyGyro.CFrame = currentFlightCF
		end
		updateFlightAudios(fwd, side)
	end)
	table.insert(flightConns, flightUpdate)

	local function onFlightInputBegan(input, gameProc)
		if gameProc then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode
			if key == Enum.KeyCode.W then flightMoveState.forward = 1
			elseif key == Enum.KeyCode.S then flightMoveState.backward = 1
			elseif key == Enum.KeyCode.A then flightMoveState.left = 1
			elseif key == Enum.KeyCode.D then flightMoveState.right = 1
			end
		end
	end
	local function onFlightInputEnded(input, gameProc)
		if gameProc then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode
			if key == Enum.KeyCode.W then flightMoveState.forward = 0
			elseif key == Enum.KeyCode.S then flightMoveState.backward = 0
			elseif key == Enum.KeyCode.A then flightMoveState.left = 0
			elseif key == Enum.KeyCode.D then flightMoveState.right = 0
			end
		end
	end
	local flightBegan = UserInputService.InputBegan:Connect(onFlightInputBegan)
	local flightEnded = UserInputService.InputEnded:Connect(onFlightInputEnded)
	table.insert(flightConns, flightBegan)
	table.insert(flightConns, flightEnded)
end

local function stopFlight()
	if not isFlying then return end
	isFlying = false
	flightSpeedValue = targetWalkSpeed
	if antiGravityForce then antiGravityForce:Destroy() antiGravityForce = nil end
	if preFlightWalkSpeed ~= nil then
		targetWalkSpeed = preFlightWalkSpeed
		isWalkSpeedActive = preFlightIsSpeedActive
	end
	preFlightWalkSpeed = nil
	preFlightIsSpeedActive = nil
	humanoid.AutoRotate = true
	humanoid.PlatformStand = false
	flightEmoteActive = false
	if not humanoid.Sit and not humanoid.SeatPart then
		humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
	else
		humanoid:ChangeState(Enum.HumanoidStateType.Seated)
	end
	if hrp and not humanoid.SeatPart then
		hrp.AssemblyLinearVelocity = Vector3.new(0, -1, 0)
	end
	stopFlightAudio()
	stopFlightAnimation(0.1)
	stopR6FlightAnims(0.1)
	r6ForwardHold = 0
	if flyGyro then flyGyro:Destroy() flyGyro = nil end
	if flyVelocity then flyVelocity:Destroy() flyVelocity = nil end
	for _, conn in ipairs(flightConns) do
		if conn and conn.Connected then conn:Disconnect() end
	end
	flightConns = {}
	flightMoveState = {forward = 0, backward = 0, left = 0, right = 0, up = 0, down = 0}
	currentFlightCF = nil
	flightCurrentRoll = 0
	currentFlightVelocity = Vector3.zero
	targetFlightVelocity = Vector3.zero
end

local function toggleFlight()
	if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health <= 0 then return end
	if isFlying then stopFlight() else startFlight() end
	updateMainUI()
end

-- ============ REACCIÓN INSTANTÁNEA ============
local function performInstantDodge(attackerObject, forceBehind)
	if tick() - InstantReaction.LastDodge < InstantReaction.Cooldown or not hrp or not attackerObject then return end
	if attackerObject:IsA("Model") and attackerObject:FindFirstChild("HumanoidRootPart") then
		local attackerHrp = attackerObject.HumanoidRootPart
		local toMe = (hrp.Position - attackerHrp.Position).Unit
		if attackerHrp.CFrame.LookVector:Dot(toMe) < 0.5 then return end
	end
	InstantReaction.LastDodge = tick()
	InstantReaction.DodgeActive = true
	local enemyHrp = attackerObject:IsA("Model") and attackerObject:FindFirstChild("HumanoidRootPart") or (attackerObject:IsA("BasePart") and attackerObject)
	local enemyPos = enemyHrp and enemyHrp.Position or (hrp.Position + hrp.CFrame.LookVector * 10)
	local targetPos
	if forceBehind and enemyHrp then
		targetPos = enemyHrp.Position - (enemyHrp.CFrame.LookVector * 8) + Vector3.new(0, 2, 0)
	else
		local directions = {hrp.CFrame.RightVector, -hrp.CFrame.RightVector, -hrp.CFrame.LookVector}
		local chosenDir = directions[math.random(1, #directions)]
		targetPos = hrp.Position + (chosenDir * 22)
	end
	for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
		if track.Priority.Value >= Enum.AnimationPriority.Action.Value and track.Priority.Value < Enum.AnimationPriority.Action4.Value then
			track:Stop(0.05)
		end
	end
	local dodgeAnimId = isR6 and 248336294 or 104687069461693
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. dodgeAnimId
	local track = (humanoid:FindFirstChildOfClass("Animator") or humanoid):LoadAnimation(anim)
	track.Priority = Enum.AnimationPriority.Action4
	track:Play()
	track:AdjustSpeed(2.2)
	task.delay(0.4, function() track:Stop(0.1) anim:Destroy() InstantReaction.DodgeActive = false end)
	local sound = Instance.new("Sound", hrp)
	sound.SoundId = "rbxassetid://6831034832"
	sound.Volume = 2
	sound:Play()
	game:GetService("Debris"):AddItem(sound, 1)
	local parts = {}
	for _, p in ipairs(character:GetDescendants()) do
		if p:IsA("BasePart") then parts[p] = p.CanCollide; p.CanCollide = false end
	end
	hrp.CFrame = CFrame.lookAt(targetPos, enemyPos)
	hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	task.delay(0.1, function()
		for p, originalCollide in pairs(parts) do if p and p.Parent then p.CanCollide = originalCollide end end
	end)
end

local function updateInstantReaction()
	if not InstantReaction.Active or not hrp then return end
	local myPos = hrp.Position
	local myVel = hrp.AssemblyLinearVelocity
	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player and otherPlayer.Character then
			local char = otherPlayer.Character
			local eHum = char:FindFirstChildOfClass("Humanoid")
			local eHrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
			if eHrp and eHum then
				local ePos = eHrp.Position
				local eVel = eHrp.AssemblyLinearVelocity
				local toMe = (myPos - ePos)
				local dist = toMe.Magnitude
				if dist < 60 then
					local relativeVel = eVel
					local velocityDot = relativeVel.Unit:Dot(toMe.Unit)
					local isDashingTowardsMe = (eVel.Magnitude > 55) and (velocityDot > 0.8)
					local isComingFast = (velocityDot > 0.7) and (dist / math.max(relativeVel.Magnitude, 1) < 0.4)
					local isExecutingAction = false
					local priorityLevel = 0
					for _, track in ipairs(eHum:GetPlayingAnimationTracks()) do
						if track.Priority.Value >= Enum.AnimationPriority.Action.Value and track.WeightTarget > 0.1 then
							local animId = track.Animation.AnimationId:match("%d+")
							if not managedAnimationIds[animId] then
								isExecutingAction = true
								priorityLevel = track.Priority.Value
								break
							end
						end
					end
					if isDashingTowardsMe or (isExecutingAction and (isComingFast or dist < 14)) then
						local forceBehind = (priorityLevel >= Enum.AnimationPriority.Action3.Value) or isDashingTowardsMe
						performInstantDodge(char, forceBehind)
						return
					end
				end
			end
		end
	end
	for _, obj in ipairs(Workspace:GetChildren()) do
		if obj:IsA("BasePart") and obj.AssemblyLinearVelocity.Magnitude > 40 then
			local dist = (hrp.Position - obj.Position).Magnitude
			if dist < 30 then
				local toMe = (hrp.Position - obj.Position).Unit
				if obj.AssemblyLinearVelocity.Unit:Dot(toMe) > 0.8 then
					performInstantDodge(obj, false)
					return
				end
			end
		end
	end
end

-- ============ FUNCIONES BASE ============
local function connect(event, func)
	local conn = event:Connect(func)
	table.insert(allConnections, conn)
	return conn
end

local function startReplicationLoop()
	task.spawn(function()
		while scriptActive do
			pcall(function()
				settings().Physics.AllowSleep = false
				settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
				if sethiddenproperty then
					sethiddenproperty(Players.LocalPlayer, "SimulationRadius", math.huge)
					sethiddenproperty(Players.LocalPlayer, "MaxSimulationRadius", math.huge)
				elseif setsimulationradius then
					setsimulationradius(math.huge, math.huge)
				end
			end)
			task.wait(0.1)
		end
	end)
end

local function fadeAudio(sound, targetVolume, duration) 
	if not scriptActive or not sound then return end
	local startVolume = sound.Volume
	local startTime = tick()
	local fadeConnection
	fadeConnection = RunService.Heartbeat:Connect(function()
		if not scriptActive then fadeConnection:Disconnect() return end
		local elapsed = tick() - startTime
		local progress = math.min(elapsed / duration, 1)
		sound.Volume = startVolume + (targetVolume - startVolume) * progress
		if progress >= 1 then fadeConnection:Disconnect() end
	end)
end

local function restoreAmbientSounds()
	if not emoteMusicActive then return end
	emoteMusicActive = false -- Esto detendrá el bucle de silenciamiento
	if ambientSoundMuteThread then
		task.cancel(ambientSoundMuteThread)
		ambientSoundMuteThread = nil
	end

	for sound, originalVolume in pairs(originalAmbientVolumes) do
		if sound and sound.Parent then
			pcall(function()
				TweenService:Create(sound, TweenInfo.new(1.0), {Volume = originalVolume}):Play()
			end)
		end
	end
	originalAmbientVolumes = {}
end

local function muteAmbientSounds()
	if emoteMusicActive then return end -- El bucle ya está activo
	emoteMusicActive = true

	local function processSound(sound)
		-- Comprobaciones básicas: es un sonido, se está reproduciendo, no es nuestro propio sonido de emote.
		if not (sound and sound:IsA("Sound") and sound.IsPlaying and sound ~= currentEmoteSound) then
			return
		end
		-- Si ya lo hemos silenciado, no hacer nada.
		if originalAmbientVolumes[sound] then return end

		local soundName = sound.Name:lower()
		
		-- Un sonido se considera música ambiental si es largo, O es un bucle largo, O su nombre sugiere que es música.
		local isLikelyMusic = (sound.TimeLength > 25) or (sound.Looped and sound.TimeLength > 5) or (soundName:match("music") or soundName:match("ambien") or soundName:match("radio") or soundName:match("soundtrack") or soundName:match("song") or soundName:match("bgm") or soundName:match("theme") or soundName:match("boombox") or soundName:match("ambiance"))

		if isLikelyMusic then
			-- Es música ambiental y aún no hemos guardado su volumen.
			originalAmbientVolumes[sound] = sound.Volume
			TweenService:Create(sound, TweenInfo.new(0.5), {Volume = 0}):Play()
		end
	end

	-- Iniciar un hilo para manejar el bucle de silenciamiento
	ambientSoundMuteThread = task.spawn(function()
		while emoteMusicActive and scriptActive do
			pcall(function()
				-- Escanear periódicamente en busca de nuevos sonidos para silenciar
				for _, service in ipairs({Workspace, SoundService, Lighting, player and player.PlayerGui, game:GetService("ReplicatedStorage")}) do
					if service then
						for _, descendant in ipairs(service:GetDescendants()) do if descendant:IsA("Sound") then processSound(descendant) end end
					end
				end
			end)
			task.wait(5) -- Reducir aún más la frecuencia para minimizar el lag al usar emotes.
		end
	end)
end

-- ============ VIBRACIÓN MOLECULAR ============
startMolecularVibration = function()
	if isMolecularVibrationActive then return end
	isMolecularVibrationActive = true
	molecularVibrationOriginalCollisions = {}
	if character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				molecularVibrationOriginalCollisions[part] = part.CanCollide
				part.CanCollide = false
			end
		end
	end
	molecularVibrationConn = RunService.Stepped:Connect(function()
		if not scriptActive or not isMolecularVibrationActive or not character or not character.Parent then
			if molecularVibrationConn then molecularVibrationConn:Disconnect() molecularVibrationConn = nil end
			return
		end
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
		if humanoid then
			humanoid.CameraOffset = Vector3.new(math.random(-15, 15)/100, math.random(-15, 15)/100, math.random(-15, 15)/100)
		end
	end)
	table.insert(allConnections, molecularVibrationConn)
end

stopMolecularVibration = function()
	if not isMolecularVibrationActive then return end
	isMolecularVibrationActive = false
	if molecularVibrationConn then molecularVibrationConn:Disconnect() molecularVibrationConn = nil end
	if humanoid then pcall(function() humanoid.CameraOffset = Vector3.new(0,0,0) end) end
	if character then
		for part, canCollide in pairs(molecularVibrationOriginalCollisions) do
			if part and part.Parent then pcall(function() part.CanCollide = canCollide end) end
		end
	end
	molecularVibrationOriginalCollisions = {}
end

updateMolecularVibrationState = function()
	local shouldBeActive = molecularVibrationRequesters.mirage or molecularVibrationRequesters.speed
	if shouldBeActive and not isMolecularVibrationActive then
		startMolecularVibration()
	elseif not shouldBeActive and isMolecularVibrationActive then
		stopMolecularVibration()
	end
end

-- ============ ANIMACIONES ============
playAnimation = function(animId, startTime, speed, loop)
	if not scriptActive then return end
	if not character or not humanoid then return end
	local animIdStr = "rbxassetid://" .. tostring(animId)
	if currentAnimTrack and currentAnimTrack.Animation.AnimationId == animIdStr then
		if speed then currentAnimTrack:AdjustSpeed(speed) end
		if not currentAnimTrack.IsPlaying then currentAnimTrack:Play(0.1) end
		return
	end
	if currentAnimTrack then currentAnimTrack:Stop(0.2) end
	local track = animationTracks[animId]
	if not track then
		local anim = Instance.new("Animation")
		anim.AnimationId = animIdStr
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if animator then track = animator:LoadAnimation(anim) else track = humanoid:LoadAnimation(anim) end
		track.Priority = Enum.AnimationPriority.Action
		animationTracks[animId] = track
	end
	currentAnimTrack = track
	currentAnimTrack.Looped = (loop == nil and true or loop)
	currentAnimTrack.Priority = Enum.AnimationPriority.Action
	for _, t in ipairs(humanoid:GetPlayingAnimationTracks()) do
		local id = t.Animation.AnimationId:match("%d+")
		if t ~= currentAnimTrack and t ~= SuperStrength.AnimTrack and t ~= mirageSpeedEmoteTrack and id and managedAnimationIds[id] then
			t:Stop(0.1)
		end
	end
	currentAnimTrack:Play(0.1, 1, speed or 1)
	if startTime and startTime > 0 then currentAnimTrack.TimePosition = startTime end
	
	if hrp and tostring(animId) ~= tostring(hurtAnimId) and tostring(animId) ~= tostring(exhaustedWalkAnimId) then
		hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		lastWalkStationaryPos = hrp.Position
	end

	if currentEmoteSound then currentEmoteSound:Stop() currentEmoteSound:Destroy() currentEmoteSound = nil end
	local animIdNum = tostring(animId)
	local soundId = nil
	local duration = nil
	if animIdNum == "124200992648318" then soundId = "105607698428277" duration = 6.6
	elseif animIdNum == "113375965758912" then soundId = "93810693712746"
	elseif animIdNum == "83766124558950" then soundId = "80707664193361"
	elseif animIdNum == "133394554631338" then soundId = "132792243719690"
	elseif animIdNum == "122599479076921" then soundId = "140733597017773"
	elseif animIdNum == "117722192552703" then soundId = "131562947723376"
	elseif animIdNum == "138316142522795" then soundId = "91403331416927"
	elseif animIdNum == "126644738448952" then soundId = "86062491573397"
	end
	local sound = nil
	if soundId then
		if not muteEmotes or animIdNum == "124200992648318" then
			muteAmbientSounds()
			sound = Instance.new("Sound")
			sound.Name = "SpecialEmoteSound"
			sound.SoundId = "rbxassetid://" .. soundId
			sound.Volume = 1
			sound.Looped = true
			sound.Parent = hrp or character
			sound:Play()
			currentEmoteSound = sound
			sound.Ended:Once(function() if currentEmoteSound == sound then sound:Destroy() currentEmoteSound = nil end end)
		end
	end
	if duration then
		task.delay(duration, function()
			if currentAnimTrack and currentAnimTrack.Animation.AnimationId == animIdStr then
				currentAnimTrack:Stop(0.5)
				currentAnimTrack = nil
			end
			if sound and currentEmoteSound == sound then sound:Destroy(); currentEmoteSound = nil end
			restoreAmbientSounds()
		end)
	end
end

local function stopAnimation()
	if not humanoid then return end
	if currentAnimTrack then currentAnimTrack:Stop(0.1) currentAnimTrack = nil end
	if currentEmoteSound then currentEmoteSound:Stop() currentEmoteSound:Destroy() currentEmoteSound = nil end
	restoreAmbientSounds()
end

-- ============ OTRAS FUNCIONES ============
local function stopNoclip()
	if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
end

local function startNoclip()
	stopNoclip()
	noclipConnection = RunService.Stepped:Connect(function()
		if not scriptActive or not isInvisibilityActive or not character or not character.Parent then stopNoclip() return end
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
		end
	end)
	table.insert(allConnections, noclipConnection)
end

local function stopAntiFall()
	for _, conn in ipairs(antiFallConnections) do if conn then conn:Disconnect() end end
	antiFallConnections = {}
end

local function stopAntiFling()
	if antiFlingConnection then antiFlingConnection:Disconnect() antiFlingConnection = nil end
end

local function disableFootstepSounds()
	if not character then return end
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("Sound") then
			local soundName = descendant.Name:lower()
			if soundName:find("foot") or soundName:find("step") or soundName:find("walk") or soundName:find("run") then
				if not originalSoundProperties[descendant] then
					originalSoundProperties[descendant] = {Volume = descendant.Volume, Playing = descendant.Playing, Looped = descendant.Looped}
				end
				descendant.Volume = 0
				if descendant.Playing then descendant:Stop() end
			end
		end
	end
	if humanoid then
		local animateScript = character:FindFirstChild("Animate")
		if animateScript then
			for _, child in ipairs(animateScript:GetDescendants()) do
				if child:IsA("Sound") then
					if not originalSoundProperties[child] then
						originalSoundProperties[child] = {Volume = child.Volume, Playing = child.Playing, Looped = child.Looped}
					end
					child.Volume = 0
					if child.Playing then child:Stop() end
				end
			end
		end
	end
end

local function hideIdentity()
	if not scriptActive then return end
	task.spawn(function()
		pcall(function()
			if character then 
				character.Name = "NPC"
				if humanoid then humanoid.DisplayName = "    " end
				for _, v in ipairs(character:GetDescendants()) do
					if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then v:Destroy() end
				end
			end
		end)
	end)
end

local function disableGameAntiCheats()
    pcall(function()
        for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
            if v:IsA("LocalScript") then
                local scriptName = v.Name:lower()
                if scriptName:find("anti") or scriptName:find("cheat") or scriptName:find("kick") or scriptName:find("exploit") or scriptName:find("ban") then
                    v.Disabled = true
                end
            end
        end
        for i, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("LocalScript") then
                local scriptName = v.Name:lower()
                if scriptName:find("anti") or scriptName:find("cheat") or scriptName:find("kick") or scriptName:find("exploit") or scriptName:find("ban") then
                    v.Disabled = true
                end
            end
        end
    end)
end

-- ============ HABILIDADES SECUNDARIAS ============
local function cleanupMirageSpeed()
	if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop(0.1) mirageSpeedEmoteTrack = nil end
	isMirageSpeedActive = false
end

local function playMirageSpeedEmote()
	if not scriptActive or not humanoid then return end
	if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop(0.1) mirageSpeedEmoteTrack = nil end
	if currentAnimTrack then currentAnimTrack:Stop(0.1) currentAnimTrack = nil end
	local emoteId
	if mirageSpeedValue == 0.5 then
		emoteId = 84043660421785
	else
		emoteId = 96731289267640
	end
	local anim = Instance.new("Animation")	
	anim.AnimationId = "rbxassetid://" .. tostring(emoteId)
	mirageSpeedEmoteTrack = humanoid:LoadAnimation(anim)
	mirageSpeedEmoteTrack.Priority = Enum.AnimationPriority.Action4
	mirageSpeedEmoteTrack.Looped = true
	mirageSpeedEmoteTrack:Play()
	mirageSpeedEmoteTrack:AdjustSpeed(mirageSpeedValue)
	animationTracks["mirage_speed"] = mirageSpeedEmoteTrack
end

local function stopMirageSpeedEmote()
	if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop(0.1) mirageSpeedEmoteTrack = nil animationTracks["mirage_speed"] = nil end
end

local function toggleMirageSpeed()
	if not scriptActive then return end
	isMirageSpeedActive = not isMirageSpeedActive
	if isMirageSpeedActive then
		playMirageSpeedEmote()
	else
		stopMirageSpeedEmote()
	end
	molecularVibrationRequesters.mirage = isMirageSpeedActive
	updateMolecularVibrationState()
end

local function startSuperJump()
	if not scriptActive or not humanoid then return end
	isSuperJumpActive = true
	humanoid.UseJumpPower = true
	humanoid.JumpPower = superJumpPower
end

local function startSuperSaltoCharge()
	if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health <= 0 then return end
	if not humanoid or isSuperSaltoCharged then return end
	if battery < 10 then return end
	isSuperSaltoCharged = true
	superSaltoChargeTime = tick()
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://121288138217304"
	superSaltoTrack = humanoid:LoadAnimation(anim)
	superSaltoTrack.Priority = Enum.AnimationPriority.Action4
	superSaltoTrack:Play()
end

local function releaseSuperSalto()
	if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health <= 0 then return end
	if not isSuperSaltoCharged then return end
	local duration = tick() - superSaltoChargeTime
	isSuperSaltoCharged = false
	if superSaltoTrack then superSaltoTrack:Stop(0.1) superSaltoTrack = nil end
	local force = math.min(180, 50 + (duration * 65))
	if hrp then
		hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, force, hrp.AssemblyLinearVelocity.Z)
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	battery = battery - 15
	if battery < 0 then battery = 0 end
	updateBatteryUI()
	isSuperJumpActive = true
	if jumpAnimTrack then jumpAnimTrack:Play(0.1)
	else
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. ANIMATIONS.Jump
		jumpAnimTrack = humanoid:LoadAnimation(anim)
		jumpAnimTrack.Priority = Enum.AnimationPriority.Action4
		jumpAnimTrack.Looped = false
		jumpAnimTrack:Play(0.1)
	end
end

local function stopSuperJump()
	isSuperJumpActive = false
	if humanoid then humanoid.JumpPower = originalJumpPower end
end

local function setupSuperHearingAudio()
	if SuperHearing.Sound then pcall(function() SuperHearing.Sound:Stop() SuperHearing.Sound:Destroy() end) end
	SuperHearing.Sound = Instance.new("Sound")
	SuperHearing.Sound.SoundId = "rbxassetid://1846354746"
	SuperHearing.Sound.Name = "SuperHearingSound"
	SuperHearing.Sound.Looped = true
	SuperHearing.Sound.Volume = 0
	SuperHearing.Sound.Parent = hrp or character or SoundService
end

local function ensureSuperHearingHighlight(char, nameText, isNPC, active)
	if not char or not char.Parent then return end
	local dict = isNPC and SuperHearing.NPCHighlights or SuperHearing.PlayerHighlights
	local cacheDict = isNPC and SuperHearing.NPCCache or SuperHearing.PlayerCache
	local data = dict[char]
	if not data and active then
		local highlight = Instance.new("Highlight")
		highlight.Name = isNPC and "SuperHearingNPCHighlight" or "SuperHearingPlayerHighlight"
		highlight.FillColor = Color3.fromRGB(0, 120, 255)
		highlight.OutlineColor = Color3.fromRGB(0, 255, 255)
		highlight.FillTransparency = 0.15
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = char
		local billboard = Instance.new("BillboardGui")
		billboard.Name = isNPC and "SuperHearingNPCName" or "SuperHearingPlayerName"
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.StudsOffset = Vector3.new(0, 3, 0)
		billboard.AlwaysOnTop = true
		local adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildWhichIsA("BasePart")
		billboard.Adornee = adornee
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = nameText
		textLabel.TextColor3 = isNPC and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(0, 150, 255)
		textLabel.TextSize = 14
		textLabel.Font = Enum.Font.GothamBold
		textLabel.Parent = billboard
		billboard.Parent = char
		data = {highlight = highlight, billboard = billboard}
		dict[char] = data
		cacheDict[char] = true
		if isNPC then SuperHearing.ActiveNPCs[char] = true end
	elseif data then
		data.highlight.Enabled = active
		data.billboard.Enabled = active
		cacheDict[char] = active
		if isNPC then SuperHearing.ActiveNPCs[char] = active end
	end
end

local function characterIsNoisy(char, hum, root)
	if not root then return false end
	return (hum and hum.Health > 0 and hum.MoveDirection.Magnitude > 0.1) or root.AssemblyLinearVelocity.Magnitude > 1
end

local function updateSuperHearing()
	if not scriptActive or not SuperHearing.Active then return end
	if not character or not hrp then return end
	local now = tick()
	if now - SuperHearing.LastUpdate < 0.1 then return end
	SuperHearing.LastUpdate = now
	local detectedAny = false
	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player then
			local otherChar = otherPlayer.Character
			if otherChar then
				local hum = otherChar:FindFirstChild("Humanoid")
				local root = otherChar:FindFirstChild("HumanoidRootPart") or otherChar:FindFirstChildWhichIsA("BasePart")
				if hum and hum.Health > 0 and root then
					local noisy = characterIsNoisy(otherChar, hum, root)
					if noisy then detectedAny = true end
					ensureSuperHearingHighlight(otherChar, otherPlayer.Name, false, noisy)
				else
					if SuperHearing.PlayerHighlights[otherChar] then
						local d = SuperHearing.PlayerHighlights[otherChar]
						if d.highlight then d.highlight:Destroy() end
						if d.billboard then d.billboard:Destroy() end
						SuperHearing.PlayerHighlights[otherChar] = nil
					end
				end
			end
		end
	end
	if now - SuperHearing.LastNPCScanTime > 8 then
		SuperHearing.LastNPCScanTime = now
		SuperHearing.CachedNPCList = {}
		local seekIsActive = false
		local correctDoor = nil
		for _, desc in ipairs(Workspace:GetDescendants()) do
			if desc:IsA("Humanoid") and desc.Parent and desc.Parent:IsA("Model") then
				local model = desc.Parent
				if not Players:GetPlayerFromCharacter(model) and model:FindFirstChildWhichIsA("BasePart") then
					table.insert(SuperHearing.CachedNPCList, model)
					if not seekIsActive and model.Name:lower():find("seek") then
						seekIsActive = true
					end
				end
			end
			if not correctDoor and desc:IsA("Model") and desc.Name:lower():find("door") then
				local light = desc:FindFirstChildWhichIsA("PointLight", true)
				if light and light.Enabled and light.Color.B > 0.5 and light.Color.G > 0.5 and light.Color.R < 0.3 then
					correctDoor = desc
				end
			end
		end
		if seekIsActive and correctDoor then
			ensureSuperHearingHighlight(correctDoor, "CAMINO CORRECTO", true, true)
			detectedAny = true
		end
	end
	for _, model in ipairs(SuperHearing.CachedNPCList) do
		if model and model.Parent then
			local hum = model:FindFirstChild("Humanoid")
			local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
			if hum and hum.Health > 0 and root then
				local noisy = characterIsNoisy(model, hum, root)
				if noisy then detectedAny = true end
				ensureSuperHearingHighlight(model, "NPC", true, noisy)
			else
				if SuperHearing.NPCHighlights[model] then
					local d = SuperHearing.NPCHighlights[model]
					if d.highlight then d.highlight:Destroy() end
					if d.billboard then d.billboard:Destroy() end
					SuperHearing.NPCHighlights[model] = nil
				end
			end
		end
	end
	if SuperHearing.Sound then
		if detectedAny then
			if not SuperHearing.Sound.Playing then SuperHearing.Sound:Play() end
			if SuperHearing.Sound.Volume < 1 then fadeAudio(SuperHearing.Sound, 1, 0.15) end
		else
			if SuperHearing.Sound.Volume > 0 then fadeAudio(SuperHearing.Sound, 0, 0.3) end
		end
	end
end

local function cleanupSuperHearing()
	if SuperHearing.CleanupTimer then task.cancel(SuperHearing.CleanupTimer) end
	if SuperHearing.Timer then task.cancel(SuperHearing.Timer) end
	if SuperHearing.Blur then SuperHearing.Blur:Destroy() end
	if SuperHearing.ColorCorrection then SuperHearing.ColorCorrection:Destroy() end
	if SuperHearing.Echo then SuperHearing.Echo:Destroy() end
	if SuperHearing.Reverb then SuperHearing.Reverb:Destroy() end
	if SuperHearing.Heartbeat then pcall(function() SuperHearing.Heartbeat:Disconnect() end) SuperHearing.Heartbeat = nil end
	if SuperHearing.Sound then pcall(function() SuperHearing.Sound:Stop() SuperHearing.Sound:Destroy() end) end
	for char, data in pairs(SuperHearing.PlayerHighlights) do pcall(function() data.highlight:Destroy() data.billboard:Destroy() end) end
	for char, data in pairs(SuperHearing.NPCHighlights) do pcall(function() data.highlight:Destroy() data.billboard:Destroy() end) end
	SuperHearing.PlayerHighlights = {}
	SuperHearing.NPCHighlights = {}
	SuperHearing.PlayerCache = {}
	SuperHearing.NPCCache = {}
	SuperHearing.ActiveNPCs = {}
end

local function stopSuperHearing()
	if not SuperHearing.Active then return end
	SuperHearing.Active = false
	for _, data in pairs(SuperHearing.PlayerHighlights) do
		if data.highlight then data.highlight.Enabled = false end
		if data.billboard then data.billboard.Enabled = false end
	end
	for _, data in pairs(SuperHearing.NPCHighlights) do
		if data.highlight then data.highlight.Enabled = false end
		if data.billboard then data.billboard.Enabled = false end
	end
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	if SuperHearing.Blur then TweenService:Create(SuperHearing.Blur, tweenInfo, {Size = 0}):Play() end
	if SuperHearing.ColorCorrection then TweenService:Create(SuperHearing.ColorCorrection, tweenInfo, {Saturation = 0, Contrast = 0}):Play() end
	if SuperHearing.Echo then TweenService:Create(SuperHearing.Echo, tweenInfo, {WetLevel = -80}):Play() end
	if SuperHearing.Reverb then SuperHearing.Reverb.Enabled = false end
	if SuperHearing.Sound then fadeAudio(SuperHearing.Sound, 0, 0.5) end
	if SuperHearing.CleanupTimer then task.cancel(SuperHearing.CleanupTimer) end
	SuperHearing.CleanupTimer = task.delay(0.5, cleanupSuperHearing)
end

local function startSuperHearing()
	if not scriptActive or not character then return end
	if SuperHearing.Active then return end
	if SuperHearing.CleanupTimer then task.cancel(SuperHearing.CleanupTimer) end
	SuperHearing.Active = true
	setupSuperHearingAudio()
	if not SuperHearing.Blur then
		SuperHearing.Blur = Instance.new("BlurEffect")
		SuperHearing.Blur.Name = "SuperHearingBlur"
		SuperHearing.Blur.Parent = Lighting
	end
	SuperHearing.Blur.Size = 0
	SuperHearing.Blur.Enabled = true
	if not SuperHearing.ColorCorrection then
		SuperHearing.ColorCorrection = Instance.new("ColorCorrectionEffect")
		SuperHearing.ColorCorrection.Name = "SuperHearingCC"
		SuperHearing.ColorCorrection.Parent = Lighting
	end
	SuperHearing.ColorCorrection.Saturation = 0
	SuperHearing.ColorCorrection.Contrast = 0
	SuperHearing.ColorCorrection.Enabled = true
	if not SuperHearing.Echo then
		SuperHearing.Echo = Instance.new("EchoSoundEffect")
		SuperHearing.Echo.Name = "SuperHearingEcho"
		SuperHearing.Echo.Parent = SoundService
		SuperHearing.Echo.Delay = 0.4
		SuperHearing.Echo.Feedback = 0.5
		SuperHearing.Echo.WetLevel = -80
	end
	SuperHearing.Echo.Enabled = true
	if not SuperHearing.Reverb then
		SuperHearing.Reverb = Instance.new("ReverbSoundEffect")
		SuperHearing.Reverb.Name = "SuperHearingReverb"
		SuperHearing.Reverb.Parent = SoundService
		SuperHearing.Reverb.DecayTime = 2
		SuperHearing.Reverb.Density = 0.7
	end
	SuperHearing.Reverb.Enabled = true
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(SuperHearing.Blur, tweenInfo, {Size = 9}):Play()
	TweenService:Create(SuperHearing.ColorCorrection, tweenInfo, {Saturation = -0.5, Contrast = 0.2}):Play()
	TweenService:Create(SuperHearing.Echo, tweenInfo, {WetLevel = 0}):Play()
	SuperHearing.Heartbeat = RunService.Heartbeat:Connect(updateSuperHearing)
	table.insert(allConnections, SuperHearing.Heartbeat)
	if SuperHearing.Timer then task.cancel(SuperHearing.Timer) end
	SuperHearing.Timer = task.delay(60, function() SuperHearing.Timer = nil stopSuperHearing() end)
end
 
local function ensureXRayHighlight(char, nameText)
	if not char or not char.Parent then return end
	local data = XRayVision.Highlights[char]
	if data and data.highlight and data.highlight.Parent then
		data.highlight.Enabled = true
		if data.billboard then data.billboard.Enabled = true end
		return
	end
	if data then
		if data.highlight then data.highlight:Destroy() end
		if data.billboard then data.billboard:Destroy() end
	end
	local highlight = Instance.new("Highlight")
	highlight.Name = "XRayVisionHighlight"
	highlight.FillColor = Color3.fromRGB(0, 150, 255)
	highlight.OutlineColor = Color3.fromRGB(200, 220, 255)
	highlight.FillTransparency = 0.2
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = char
	local billboard = nil
	if nameText then
		billboard = Instance.new("BillboardGui")
		billboard.Name = "XRayVisionName"
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.StudsOffset = Vector3.new(0, 3, 0)
		billboard.AlwaysOnTop = true
		local adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildWhichIsA("BasePart")
		billboard.Adornee = adornee
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = nameText
		textLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
		textLabel.TextSize = 14
		textLabel.Font = Enum.Font.GothamBold
		textLabel.Parent = billboard
		billboard.Parent = char
	end
	XRayVision.Highlights[char] = {highlight = highlight, billboard = billboard}
end

local function updateXRayVision()
	if not scriptActive or not XRayVision.Active or not hrp then return end
	local now = tick()

	-- Se reduce la frecuencia de escaneo para evitar tirones.
	if now - XRayVision.LastScanTime > 5 then
		XRayVision.LastScanTime = now
		XRayVision.CachedItemList = {}
		XRayVision.CachedNPCList = {}
		local itemWhitelist = {
			"key", "livehintbook", "lever", "switch", "breaker", "breakerbank", "fuse", "fuseitem", "livefuse",
			"breakerbox", "electricalbox", "gold", "goldpile", "lighter", "flashlight", "crucifix", "lockpick",
			"candle", "battery", "shears", "vitamins", "bandage", "bandages", "medkit", "present", "gift"
		}
		local itemWhitelistSet = {}
		for _, v in ipairs(itemWhitelist) do itemWhitelistSet[v] = true end

		for _, v in ipairs(Workspace:GetDescendants()) do
			local n = v.Name:lower()
			if v:IsA("Humanoid") and v.Parent and v.Parent:IsA("Model") then
				if not Players:GetPlayerFromCharacter(v.Parent) then
					table.insert(XRayVision.CachedNPCList, v.Parent)
				end
			elseif v:IsA("Model") and (n:find("rush") or n:find("ambush") or n:find("seek") or
				n:find("figure") or n:find("halt") or n:find("eyes") or n:find("screech") or n:find("dupe") or
				n:find("guiding") or n:find("a-60") or n:find("a-90") or n:find("a-120")) then
				table.insert(XRayVision.CachedNPCList, v)
			else
				local prompt = v:FindFirstChildOfClass("ProximityPrompt")
				local promptMatch = prompt and prompt.ObjectText and (prompt.ObjectText:lower():find("gift") or prompt.ObjectText:lower():find("present") or prompt.ObjectText:lower():find("regalo"))
				if promptMatch or itemWhitelistSet[n] or n:find("fuse") or n:find("breaker") or n:find("gift") or n:find("present") or n:find("regalo") then
					local target = v:IsA("Tool") and v:FindFirstChild("Handle") or v
					if target and (target:IsA("BasePart") or target:IsA("Model")) then
						table.insert(XRayVision.CachedItemList, target)
					end
				end
			end
		end
	end

	for _, model in ipairs(XRayVision.CachedNPCList) do if model and model.Parent then ensureXRayHighlight(model) end end
	for _, item in ipairs(XRayVision.CachedItemList) do if item and item.Parent then ensureXRayHighlight(item) end end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then ensureXRayHighlight(p.Character, p.Name) end
	end

	-- Se reduce la frecuencia de la actualización de transparencia para mejorar el rendimiento.
	if now - XRayVision.LastTransparencyUpdateTime > 0.5 then
		XRayVision.LastTransparencyUpdateTime = now
		for part, _ in pairs(XRayVision.TransparentParts) do
			if part and part.Parent then part.LocalTransparencyModifier = 0 end
		end
		XRayVision.TransparentParts = {}

		local params = OverlapParams.new()
		params.FilterDescendantsInstances = {character}
		params.FilterType = Enum.RaycastFilterType.Exclude
		local nearbyParts = Workspace:GetPartBoundsInRadius(hrp.Position, 60, params)
		for _, part in ipairs(nearbyParts) do
			if part and part.Parent and part:IsA("BasePart") and not part:IsA("Terrain") and part.CanCollide and part.Transparency < 0.5 then
				local model = part:FindFirstAncestorOfClass("Model")
				if not (model and XRayVision.Highlights[model]) and not XRayVision.Highlights[part] then
					part.LocalTransparencyModifier = 0.85
					XRayVision.TransparentParts[part] = true
				end
			end
		end
	end
end

local function cleanupXRayVision()
	-- Limpia incluso si no está activo, en caso de destrucción del script
	if not XRayVision.Active and scriptActive then return end
	if XRayVision.ColorCorrection then XRayVision.ColorCorrection:Destroy() XRayVision.ColorCorrection = nil end
	if XRayVision.Heartbeat then XRayVision.Heartbeat:Disconnect() XRayVision.Heartbeat = nil end
	for char, data in pairs(XRayVision.Highlights) do
		if data.highlight then data.highlight:Destroy() end
		if data.billboard then data.billboard:Destroy() end
	end
	XRayVision.Highlights = {}
	for part, _ in pairs(XRayVision.TransparentParts) do
		if part and part.Parent then part.LocalTransparencyModifier = 0 end
	end
	XRayVision.TransparentParts = {}
	XRayVision.CachedItemList = {}
	XRayVision.CachedNPCList = {}
	XRayVision.Active = false
end

local function toggleXRayVision()
	if not scriptActive then return end
	if XRayVision.Active then
		cleanupXRayVision()
	else
		XRayVision.Active = true
		local cc = Instance.new("ColorCorrectionEffect")
		cc.Name = "XRayVisionCC"
		cc.TintColor = Color3.fromRGB(0, 100, 255)
		cc.Contrast = 0.1
		cc.Saturation = -0.5
		cc.Parent = Lighting
		XRayVision.ColorCorrection = cc
		XRayVision.Heartbeat = RunService.Heartbeat:Connect(updateXRayVision)
	end
end

local function toggleInvisibility()
	if not scriptActive then return end
	isInvisibilityActive = not isInvisibilityActive
	local char = player.Character
	if not char then isInvisibilityActive = false return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	if isInvisibilityActive then
		local currentPos = root.CFrame
		startNoclip()
		invisibilitySeat = {saved = {}}
		for _, v in ipairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				invisibilitySeat.saved[v] = {Transparency = v.Transparency, CanCollide = v.CanCollide}
				v.Transparency = 1
				v.CanCollide = false
			end
		end
		task.spawn(function()
			while isInvisibilityActive and scriptActive do
				if humanoid then
					humanoid.CameraOffset = Vector3.new(math.random(-15, 15)/100, math.random(-15, 15)/100, math.random(-15, 15)/100)
				end
				task.wait(0.1)
			end
		end)
	else
		if invisibilitySeat and invisibilitySeat.saved then
			for inst, st in pairs(invisibilitySeat.saved) do
				if inst and inst.Parent then
					pcall(function() inst.Transparency = st.Transparency inst.CanCollide = st.CanCollide end)
				end
			end
		end
		if humanoid then pcall(function() humanoid.CameraOffset = Vector3.new(0,0,0) end) end
		if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
		invisibilitySeat = nil
	end
end

local function startAntiFall()
	stopAntiFall()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")
	if not hrp or not humanoid then return end
	local lastGroundPosition = hrp.CFrame
	local lastGroundY = hrp.Position.Y
	local conn1 = RunService.Heartbeat:Connect(function()
		if humanoid.Health > 0 then
			local currentY = hrp.Position.Y
			if humanoid.FloorMaterial ~= Enum.Material.Air then
				lastGroundPosition = hrp.CFrame
				lastGroundY = currentY
			end
			if not isFlying and (lastGroundY - currentY > 15) then
				antiFallTeleporting = true
				hrp.CFrame = lastGroundPosition
				hrp.AssemblyLinearVelocity = Vector3.zero
				task.delay(0.1, function() antiFallTeleporting = false end)
			end
		end
	end)
	table.insert(antiFallConnections, conn1)
	table.insert(allConnections, conn1)
end

local function startAntiFling()
	stopAntiFling()
	local lastVelocity = Vector3.zero
	antiFlingConnection = RunService.Heartbeat:Connect(function(dt)
		if not scriptActive or not hrp or not hrp.Parent or isFlying then return end

		local currentVelocity = hrp.AssemblyLinearVelocity
		local acceleration = (currentVelocity - lastVelocity) / dt
		lastVelocity = currentVelocity

		if acceleration.Magnitude > 1000 and humanoid.FloorMaterial == Enum.Material.Air then
			hrp.AssemblyLinearVelocity = Vector3.new(0, currentVelocity.Y, 0)
			hrp.AssemblyAngularVelocity = Vector3.zero
		end
	end)
	table.insert(allConnections, antiFlingConnection)
end

local function playSprintAnimation()
	if not scriptActive or not humanoid or not isSprintActive or isCrouching or isMirageSpeedActive or isWalkSpeedActive then return end
	if sprintAnimTrack and sprintAnimTrack.IsPlaying then return end
	if sprintAnimTrack then sprintAnimTrack:Stop(0.1) end
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://138992096476836"
	sprintAnimTrack = humanoid:LoadAnimation(anim)
	sprintAnimTrack.Looped = true
	sprintAnimTrack.Priority = Enum.AnimationPriority.Action2
	sprintAnimTrack:Play()
	animationTracks["sprint_active"] = sprintAnimTrack
end

local function stopSprintAnimation()
	if sprintAnimTrack then sprintAnimTrack:Stop(0.1) sprintAnimTrack = nil animationTracks["sprint_active"] = nil end
end

local function toggleSprint()
	if not scriptActive then return end
	isSprintActive = not isSprintActive
	if isSprintActive then
		if humanoid then humanoid.WalkSpeed = 22 end
	else
		if humanoid then humanoid.WalkSpeed = isWalkSpeedActive and walkSpeed or 8 end
		stopSprintAnimation()
	end
end

-- ============ BATERÍA KRYPTONIANA (SIN GANANCIA PASIVA) ============
local function updateBatteryUI()
	if not UI.batteryText then return end
	
	local currentBatteryValue = math.floor(battery)
	if currentBatteryValue < 0 then currentBatteryValue = 0 end
	if currentBatteryValue > maxBattery then currentBatteryValue = maxBattery end

	local emoji = "🔋"
	local color = Color3.fromRGB(0, 255, 0) -- Verde por defecto

	if currentBatteryValue <= 30 and currentBatteryValue > 0 then
		emoji = "🪫" -- Batería baja
		color = Color3.fromRGB(255, 0, 0) -- Rojo si la batería está baja
	elseif currentBatteryValue == 0 then
		emoji = "⚠️" -- Emoji de advertencia en 0%
		color = Color3.fromRGB(255, 255, 0) -- Amarillo para la advertencia
	end

	UI.batteryText.Text = emoji .. " " .. currentBatteryValue .. "%"
	UI.batteryText.TextColor3 = color
end

local function updateBattery(deltaTime)
	if not scriptActive then return end

	local gainRate = 0

	-- Carga por luz solar directa (lógica mejorada)
	local sunDirection = Lighting:GetSunDirection()
	-- Solo intentar cargar si es de día (sol por encima del horizonte)
	if sunDirection.Y > 0.05 and hrp then
		local rayOrigin = hrp.Position + Vector3.new(0, 2, 0) -- Empezar un poco por encima del centro del personaje
		local rayDirection = sunDirection * 2000 -- Un rayo largo en la dirección del sol
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = {character}
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		local raycastResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)

		-- Si el rayo no golpea nada, el jugador está en luz solar directa.
		if not raycastResult then
			gainRate = gainRate + 1.5 -- Tasa de carga bajo el sol
		end
	end

	-- Lógica para la opción VUELO+BATERIA
	if flightRegenEnabled then
		-- 1. Regenera batería al volar y moverse (comportamiento original)
		if isFlying then
			local isMoving = (humanoid and humanoid.MoveDirection.Magnitude > 0.1) or flightMoveState.up > 0 or flightMoveState.down > 0
			if isMoving then gainRate = gainRate + 5 end
		end
		-- 2. Funciona como recarga de emergencia para que la batería no se quede en 0%
		if battery < 5 then gainRate = gainRate + 1 end
	end

	local costRate = 0
	-- Habilidades con consumo continuo (temporal)
	if isMirageSpeedActive then
		costRate = costRate + 1
	end
	if XRayVision.Active then
		costRate = costRate + 0.2
	end
	if isGravJumpActive then
		costRate = costRate + 2
	end
	-- A partir de 31, consume 1 de batería constantemente, solo si se está moviendo.
	if isWalkSpeedActive and targetWalkSpeed >= 31 and humanoid and humanoid.MoveDirection.Magnitude > 0.1 then
		costRate = costRate + 1
	end

	battery = battery + (gainRate * deltaTime) - (costRate * deltaTime)
	if battery > maxBattery then battery = maxBattery end
	if battery < 0 then battery = 0 end

	updateBatteryUI()

	-- Manejo del estado de batería agotada
	-- Se usa un umbral para entrar y salir del modo agotamiento para evitar parpadeos de estado.
	if battery <= 0 and not isBatteryDepleted then
		battery = 0 -- Asegurarse de que no sea un valor negativo
		-- Desactivar todas las habilidades
		if isMirageSpeedActive then toggleAbility("miragespeed", 1) end
		if isGravJumpActive then toggleAbility("gravjump", 1) end
		if SuperHearing.Active then toggleAbility("superhearing", 1) end
		if XRayVision.Active then toggleAbility("xrayvision", 1) end
		if isFlying then toggleAbility("flight", 1) end
		if SuperStrength.Active or SuperStrength.GrabbedData then releaseGrabbedObject(false) end
		if InstantReaction.Active then toggleAbility("instantreaction", 1) end
		if isWalkSpeedActive then toggleAbility("walkspeed", 1) end

		isBatteryDepleted = true

		-- Detener animaciones activas para dar paso a las de agotamiento
		if walkAnimTrack then walkAnimTrack:Stop(0.1) end
		if currentAnimTrack then currentAnimTrack:Stop(0.1) end
		stopSprintAnimation()

		-- Forzar la detención de todas las animaciones en bucle y refrescar el estado del personaje
		-- para asegurar que las animaciones de agotamiento se muestren correctamente.
		for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
			if track.Looped and track.Animation and managedAnimationIds[track.Animation.AnimationId:match("%d+")] then
				track:Stop(0.1)
			end
		end
		humanoid:ChangeState(Enum.HumanoidStateType.Landed)

		-- Activar efecto de visión borrosa
		if not batteryDepletedBlur then
			batteryDepletedBlur = Instance.new("BlurEffect")
			batteryDepletedBlur.Name = "BatteryDepletedBlur"
			batteryDepletedBlur.Size = 0
			batteryDepletedBlur.Parent = Lighting
		end
		batteryDepletedBlur.Enabled = true
		TweenService:Create(batteryDepletedBlur, TweenInfo.new(1), {Size = 8}):Play()

		-- Restaurar velocidad a la normal del juego
		humanoid.WalkSpeed = originalWalkSpeed
		updateMainUI()
	-- Se necesita al menos 5% de batería para salir del modo agotamiento.
	elseif battery > 5 and isBatteryDepleted then
		isBatteryDepleted = false
		-- Desactivar visión borrosa
		if batteryDepletedBlur then
			TweenService:Create(batteryDepletedBlur, TweenInfo.new(1), {Size = 0}):Play()
			task.delay(1, function() if batteryDepletedBlur then batteryDepletedBlur.Enabled = false end end)
		end
		if exhaustedWalkTrack then exhaustedWalkTrack:Stop(0.1); exhaustedWalkTrack = nil end
		if exhaustedIdleTrack then exhaustedIdleTrack:Stop(0.1); exhaustedIdleTrack = nil end
		-- Restaurar velocidad a la original
		humanoid.WalkSpeed = originalWalkSpeed
		updateMainUI()
	end
end

-- ============ MENÚ SELECTOR UI ============
local function updateMainUI()
	if not UI.modeText or not UI.abilityText then return end
	UI.modeText.Text = (isR6 and currentMode == MODES.EMOTES) and "HABILIDADES" or modeNames[currentMode]
	local ability = abilities[currentAbilityIndex]	
	local isSpeedType = (currentMode == MODES.ABILITIES and ability and (ability.key == "walkspeed" or ability.key == "gravjump" or ability.key == "miragespeed"))
	if UI.plusBtn and UI.minusBtn then
		UI.plusBtn.Visible = isSpeedType and not isBatteryDepleted
		UI.minusBtn.Visible = isSpeedType and not isBatteryDepleted
	end
	local newText = "    "
	if currentMode == MODES.ABILITIES and ability then
		local isActive = false
		if ability.key == "walkspeed" then isActive = isWalkSpeedActive
		elseif ability.key == "miragespeed" then isActive = isMirageSpeedActive
		elseif ability.key == "gravjump" then isActive = isGravJumpActive
		elseif ability.key == "supersalto" then isActive = (abilities[currentAbilityIndex].key == "supersalto" and isSuperSaltoCharged)
		elseif ability.key == "superhearing" then isActive = SuperHearing.Active		
		elseif ability.key == "xrayvision" then isActive = XRayVision.Active
		elseif ability.key == "flight" then isActive = isFlying
		elseif ability.key == "superstrength" then isActive = SuperStrength.Active
		elseif ability.key == "instantreaction" then isActive = InstantReaction.Active
		end
		local suffix = "    "
		newText = ability.name .. suffix .. (isActive and " ✓" or "   ")
		UI.abilityText.TextColor3 = (ability.key == "superstrength" and isActive) and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 255, 255)
	elseif currentMode == MODES.EMOTES then
		if isFlying then newText = "Fly Emote " .. currentFlightEmoteIndex .. "/" .. #FLIGHT_EMOTES
		else newText = "Emote " .. currentAnimationIndex .. "/" .. #selectableAnimations end
	elseif currentMode == MODES.SETTINGS then
		newText = settingOptions[currentSettingIndex] or ""
	end
	UI.abilityText.Text = newText
end

local function startBatteryLoop()
	if batteryUpdateConn then batteryUpdateConn:Disconnect() end
	battery = maxBattery
	batteryUpdateConn = RunService.Heartbeat:Connect(function(deltaTime)
		updateBattery(deltaTime)
	end)
	table.insert(allConnections, batteryUpdateConn)
end

local function nextSelection()
	if currentMode == MODES.ABILITIES then
		repeat
			currentAbilityIndex = currentAbilityIndex + 1
			if currentAbilityIndex > #abilities then currentAbilityIndex = 1 end
		until isAbilityAvailable(abilities[currentAbilityIndex].key)
	elseif currentMode == MODES.EMOTES then
		if isFlying then
			currentFlightEmoteIndex = currentFlightEmoteIndex + 1
			if currentFlightEmoteIndex > #FLIGHT_EMOTES then currentFlightEmoteIndex = 1 end
		else
			currentAnimationIndex = currentAnimationIndex + 1
			if currentAnimationIndex > #selectableAnimations then currentAnimationIndex = 1 end
		end
	elseif currentMode == MODES.SETTINGS then
		repeat
			currentSettingIndex = currentSettingIndex + 1
			if currentSettingIndex > #settingOptions then currentSettingIndex = 1 end
		until not ((not isR6 and settingOptions[currentSettingIndex]:find("R6 FLY")) or (isR6 and settingOptions[currentSettingIndex]:find("VUELO RAPIDO")))
	end
	updateMainUI()
	local originalColor = UI.abilityText.TextColor3
	UI.abilityText.TextColor3 = Color3.fromRGB(255, 255, 100)
	task.wait(0.08)
	UI.abilityText.TextColor3 = originalColor
end 

local function previousSelection()
	if currentMode == MODES.ABILITIES then
		repeat
			currentAbilityIndex = currentAbilityIndex - 1
			if currentAbilityIndex < 1 then currentAbilityIndex = #abilities end
		until isAbilityAvailable(abilities[currentAbilityIndex].key)
	elseif currentMode == MODES.EMOTES then
		if isFlying then
			currentFlightEmoteIndex = currentFlightEmoteIndex - 1
			if currentFlightEmoteIndex < 1 then currentFlightEmoteIndex = #FLIGHT_EMOTES end
		else
			currentAnimationIndex = currentAnimationIndex - 1
			if currentAnimationIndex < 1 then currentAnimationIndex = #selectableAnimations end
		end
	elseif currentMode == MODES.SETTINGS then
		repeat
			currentSettingIndex = currentSettingIndex - 1
			if currentSettingIndex < 1 then currentSettingIndex = #settingOptions end
		until not ((not isR6 and settingOptions[currentSettingIndex]:find("R6 FLY")) or (isR6 and settingOptions[currentSettingIndex]:find("VUELO RAPIDO")))
	end
	updateMainUI()
	local originalColor = UI.abilityText.TextColor3
	UI.abilityText.TextColor3 = Color3.fromRGB(255, 200, 100)
	task.wait(0.08)
	UI.abilityText.TextColor3 = originalColor
end 

local function nextMode()
	if currentMode == MODES.ABILITIES then currentMode = MODES.EMOTES
	elseif currentMode == MODES.EMOTES then currentMode = MODES.ABILITIES
	else currentMode = MODES.ABILITIES
	end
	updateMainUI()
	local originalColor = UI.modeText.TextColor3
	UI.modeText.TextColor3 = Color3.fromRGB(255, 255, 100)
	if UI.settingsPanel then
		if currentMode == MODES.SETTINGS then
			UI.settingsPanel.Visible = true
			TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
		else
			TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
			task.wait(0.2)
			UI.settingsPanel.Visible = false
		end
	end
	task.wait(0.08)
	UI.modeText.TextColor3 = originalColor
end

local function previousMode()
	if currentMode == MODES.EMOTES then currentMode = MODES.ABILITIES
	elseif currentMode == MODES.ABILITIES then currentMode = MODES.EMOTES
	else currentMode = MODES.ABILITIES
	end
	updateMainUI()
	local originalColor = UI.modeText.TextColor3
	UI.modeText.TextColor3 = Color3.fromRGB(255, 255, 100)
	if UI.settingsPanel then
		if currentMode == MODES.SETTINGS then
			UI.settingsPanel.Visible = true
			TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
		else
			TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
			task.wait(0.2)
			UI.settingsPanel.Visible = false
		end
	end
	task.wait(0.08)
	UI.modeText.TextColor3 = originalColor
end

local function activateCurrent()
	if currentMode == MODES.ABILITIES then
		local ability = abilities[currentAbilityIndex]
		if ability and toggleAbility then
			if ability.key == "superstrength" and SuperStrength.GrabbedData then
				releaseGrabbedObject(true)
			else
				toggleAbility(ability.key, 1)
			end
		end
	elseif currentMode == MODES.EMOTES then
		if isFlying then
			local animId = FLIGHT_EMOTES[currentFlightEmoteIndex]
			local animIdStr = "rbxassetid://" .. tostring(animId)
			if flightEmoteActive and currentFlightAnimTrack and currentFlightAnimTrack.Animation.AnimationId == animIdStr then
				flightEmoteActive = false
			else
				flightEmoteActive = true
				playFlightAnimation(animId, 0, 1)
			end
		else
			local animId = selectableAnimations[currentAnimationIndex]
			local animIdStr = "rbxassetid://" .. tostring(animId)
			if currentAnimTrack and currentAnimTrack.IsPlaying and currentAnimTrack.Animation.AnimationId == animIdStr then
				stopAnimation()
			else
				playAnimation(animId, 0, 1, true)
			end
		end
	elseif currentMode == MODES.SETTINGS then
		local option = settingOptions[currentSettingIndex]
		if option:find("ESTATICO") then
			flightStaticRotation = not flightStaticRotation
			settingOptions[currentSettingIndex] = "ESTATICO: " .. (flightStaticRotation and "ON" or "OFF")
		elseif option:find("SILENCIAR") then
			muteEmotes = not muteEmotes
			settingOptions[currentSettingIndex] = "SILENCIAR: " .. (muteEmotes and "ON" or "OFF")
		elseif option:find("NOSIT") then
			noSitActive = not noSitActive
			settingOptions[currentSettingIndex] = "NOSIT: " .. (noSitActive and "ON" or "OFF")
			if humanoid then
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, not noSitActive)
				if noSitActive then humanoid.Sit = false end
			end
		elseif option:find("VUELO%+BATERIA") then
			flightRegenEnabled = not flightRegenEnabled
			settingOptions[currentSettingIndex] = "VUELO+BATERIA: " .. (flightRegenEnabled and "ON" or "OFF")
		elseif option:find("VUELO RAPIDO") then
			fastFlightMode = (fastFlightMode == 1) and 2 or 1
			settingOptions[currentSettingIndex] = "VUELO RAPIDO: " .. fastFlightMode
		elseif option:find("R6 FLY") then
			r6FlightIdleMode = (r6FlightIdleMode == 1) and 2 or 1
			settingOptions[currentSettingIndex] = "R6 FLY: " .. r6FlightIdleMode
			if isFlying and isR6 then setupR6FlightAnims() end
		elseif option == "DESTRUIR" then
			scriptActive = false
			cleanupEverything(true)
		end
	end
	updateMainUI()
	local originalColor = UI.logoImage.ImageColor3
	TweenService:Create(UI.logoImage, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(0, 162, 255)}):Play()
	task.wait(0.1)
	TweenService:Create(UI.logoImage, TweenInfo.new(0.1), {ImageColor3 = originalColor}):Play()
end

local function openMenu()
	if menuOpen then return end
	menuOpen = true
	if UI.mainPanel then
		UI.mainPanel.Visible = true
		TweenService:Create(UI.mainPanel, TweenInfo.new(0.2), {BackgroundTransparency = 0.3, Position = UDim2.new(1, -210, 0, 10)}):Play()
	end
end

local function closeMenu()
	if not menuOpen then return end
	menuOpen = false
	if UI.settingsPanel then UI.settingsPanel.Visible = false end
	if UI.mainPanel then
		TweenService:Create(UI.mainPanel, TweenInfo.new(0.2), {BackgroundTransparency = 1, Position = UDim2.new(1, -210, 0, -60)}):Play()
		task.wait(0.2)
		UI.mainPanel.Visible = false
	end 
end

local function createUI()
	if UI.screenGui then UI.screenGui:Destroy() end
	UI.screenGui = Instance.new("ScreenGui")
	UI.screenGui.Name = "SuperGirlUI"
	UI.screenGui.ResetOnSpawn = false
	UI.screenGui.IgnoreGuiInset = true
	UI.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	UI.screenGui.Parent = CoreGui
	UI.mainPanel = Instance.new("Frame")
	UI.mainPanel.Name = "MainPanel"
	UI.mainPanel.Size = UDim2.new(0, 220, 0, 105)
	UI.mainPanel.Position = UDim2.new(1, -210, 0, -60)
	UI.mainPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	UI.mainPanel.BackgroundTransparency = 1
	UI.mainPanel.BorderSizePixel = 0
	UI.mainPanel.Visible = false
	UI.mainPanel.Parent = UI.screenGui
	local panelCorner = Instance.new("UICorner")
	panelCorner.CornerRadius = UDim.new(0, 12)
	panelCorner.Parent = UI.mainPanel
	local panelStroke = Instance.new("UIStroke")
	panelStroke.Thickness = 2
	panelStroke.Color = Color3.fromRGB(255, 215, 0)
	panelStroke.Parent = UI.mainPanel
	local closeX = Instance.new("TextLabel")
	closeX.Name = "CloseVisual"
	closeX.Size = UDim2.new(0, 20, 0, 20)
	closeX.Position = UDim2.new(1, -25, 0, 5)
	closeX.BackgroundTransparency = 1
	closeX.Text = "X"
	closeX.TextColor3 = Color3.fromRGB(255, 100, 100)
	closeX.Font = Enum.Font.GothamBold
	closeX.TextSize = 12
	closeX.ZIndex = 10
	closeX.Parent = UI.mainPanel
	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "CloseButton"
	closeBtn.Size = UDim2.new(0, 30, 0, 30)
	closeBtn.Position = UDim2.new(1, -30, 0, 0)
	closeBtn.BackgroundTransparency = 1
	closeBtn.Text = " "
	closeBtn.ZIndex = 11
	closeBtn.Parent = UI.mainPanel
	closeBtn.Activated:Connect(function() closeMenu() end)

	UI.logoImage = Instance.new("ImageButton")
	UI.logoImage.Size = UDim2.new(0, 40, 0, 40)
	UI.logoImage.Position = UDim2.new(0, 10, 0.5, -20)
	UI.logoImage.Image = "rbxassetid://2942400020"
	UI.logoImage.BackgroundTransparency = 1
	UI.logoImage.AutoButtonColor = false
	UI.logoImage.Parent = UI.mainPanel
	local logoHoldTimer = nil
	local wasLongPress = false
	UI.logoImage.MouseButton1Down:Connect(function()
		wasLongPress = false
		local isTouchSpeedHold = UserInputService.TouchEnabled and menuOpen and currentMode == MODES.ABILITIES and abilities[currentAbilityIndex].key == "walkspeed"
		local holdDuration = isTouchSpeedHold and 1.5 or 1
		logoHoldTimer = task.delay(holdDuration, function()
			if not menuOpen then return end
			logoHoldTimer = nil
			wasLongPress = true
			if isTouchSpeedHold then
				if not isWalkSpeedActive then toggleAbility("walkspeed", 1) end
				walkSpeed = 21
				updateMainUI()
				if UI.speedIndicatorLabel then
					UI.speedIndicatorLabel.Text = "Super Velocidad: (21)"
					UI.speedIndicatorLabel.TextTransparency = 0
					task.delay(1.5, function() TweenService:Create(UI.speedIndicatorLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play() end)
				end
			else
				if SuperStrength.Active and SuperStrength.GrabbedData then
					releaseGrabbedObject(false)
					toggleAbility("superstrength", 1)
				elseif abilities[currentAbilityIndex].key == "supersalto" then
				else
					closeMenu()
				end
			end
		end)
		if menuOpen and abilities[currentAbilityIndex].key == "supersalto" then startSuperSaltoCharge() end
	end)
	UI.logoImage.MouseButton1Up:Connect(function()
		if logoHoldTimer then task.cancel(logoHoldTimer); logoHoldTimer = nil end
		if abilities[currentAbilityIndex].key == "supersalto" then releaseSuperSalto() end
	end)
	UI.logoImage.Activated:Connect(function()
		if wasLongPress or not menuOpen then return end
		-- Si se tiene un objeto agarrado, el toque lanza el objeto.
		if currentMode == MODES.ABILITIES and abilities[currentAbilityIndex].key == "superstrength" and SuperStrength.GrabbedData then
			releaseGrabbedObject(true)
		else
			if abilities[currentAbilityIndex].key == "supersalto" then return end
			activateCurrent()
		end
	end)
	UI.modeText = Instance.new("TextButton")
	UI.modeText.Size = UDim2.new(1, -60, 0, 20)
	UI.modeText.Position = UDim2.new(0, 55, 0, 5)
	UI.modeText.BackgroundTransparency = 1
	UI.modeText.Font = Enum.Font.GothamBold
	UI.modeText.TextSize = 9
	UI.modeText.TextColor3 = Color3.fromRGB(255, 200, 100)
	UI.modeText.TextXAlignment = Enum.TextXAlignment.Left
	UI.modeText.AutoButtonColor = false
	local modeLongPressActive = false
	local modeHoldTimer = nil
	UI.modeText.MouseButton1Down:Connect(function()
		if UserInputService:GetLastInputType() ~= Enum.UserInputType.Touch then return end
		modeLongPressActive = false
		modeHoldTimer = task.delay(1, function()
			modeLongPressActive = true
			currentMode = MODES.SETTINGS
			updateMainUI()
			if UI.settingsPanel then
				UI.settingsPanel.Visible = true
				TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
			end
			updateMainUI()
			local originalColor = UI.modeText.TextColor3
			UI.modeText.TextColor3 = Color3.fromRGB(255, 100, 100)
			task.wait(0.2)
			UI.modeText.TextColor3 = originalColor
			modeHoldTimer = nil
		end)
	end)
	UI.modeText.MouseButton1Up:Connect(function()
		if modeHoldTimer then task.cancel(modeHoldTimer) modeHoldTimer = nil end
	end)
	UI.modeText.Activated:Connect(function()
		if modeLongPressActive then modeLongPressActive = false return end
		if currentMode == MODES.ABILITIES then currentMode = MODES.EMOTES
		elseif currentMode == MODES.EMOTES then currentMode = MODES.ABILITIES
		else currentMode = MODES.ABILITIES
		end

		if UI.settingsPanel and UI.settingsPanel.Visible then
			TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
			task.delay(0.2, function() UI.settingsPanel.Visible = false end)
		end
		updateMainUI()
		local originalColor = UI.modeText.TextColor3
		UI.modeText.TextColor3 = Color3.fromRGB(255, 255, 100)
		task.wait(0.08)
		UI.modeText.TextColor3 = originalColor
	end)
	UI.modeText.Parent = UI.mainPanel
	UI.abilityText = Instance.new("TextButton")
	UI.abilityText.Size = UDim2.new(1, -60, 0, 25)
	UI.abilityText.Position = UDim2.new(0, 55, 0, 25)
	UI.abilityText.BackgroundTransparency = 1
	UI.abilityText.Font = Enum.Font.GothamBold
	UI.abilityText.TextSize = 14
	UI.abilityText.TextColor3 = Color3.fromRGB(255, 255, 255)
	UI.abilityText.TextXAlignment = Enum.TextXAlignment.Left
	UI.abilityText.AutoButtonColor = false
	local abilityLongPressActive = false
	local abilityHoldTimer = nil
	UI.abilityText.MouseButton1Down:Connect(function()
		if currentMode ~= MODES.ABILITIES or abilities[currentAbilityIndex].key ~= "walkspeed" then return end
		abilityLongPressActive = false
		abilityHoldTimer = task.delay(1, function()
			abilityLongPressActive = true
			if not isWalkSpeedActive then toggleAbility("walkspeed", 1) end
			walkSpeed = 21
			updateMainUI()
			if UI.speedIndicatorLabel then
				UI.speedIndicatorLabel.Text = "Super Velocidad:(21)"
				UI.speedIndicatorLabel.TextTransparency = 0
				task.delay(1.5, function() TweenService:Create(UI.speedIndicatorLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play() end)
			end
			abilityHoldTimer = nil
		end)
	end)
	UI.abilityText.MouseButton1Up:Connect(function()
		if abilityHoldTimer then task.cancel(abilityHoldTimer) abilityHoldTimer = nil end
	end)
	UI.abilityText.Activated:Connect(function()
		if abilityLongPressActive then abilityLongPressActive = false return end
		local now = tick()
		if now - lastAbilityTap < 0.25 then
			if abilityTapThread then task.cancel(abilityTapThread) abilityTapThread = nil end
			previousSelection()
		else
			abilityTapThread = task.delay(0.26, function() nextSelection() abilityTapThread = nil end)
		end
		lastAbilityTap = now
	end)
	UI.abilityText.Parent = UI.mainPanel
	UI.minusBtn = Instance.new("TextButton")
	UI.minusBtn.Size = UDim2.new(0, 25, 0, 25)
	UI.minusBtn.Position = UDim2.new(0, 55, 0, 53)
	UI.minusBtn.BackgroundTransparency = 1
	UI.minusBtn.Text = "-"
	UI.minusBtn.TextColor3 = Color3.new(1,1,1)
	UI.minusBtn.Font = Enum.Font.GothamBold
	UI.minusBtn.Parent = UI.mainPanel
	Instance.new("UICorner", UI.minusBtn).CornerRadius = UDim.new(0, 6)
	UI.minusBtn.Activated:Connect(function() adjustSpeed(false) end)
	UI.plusBtn = Instance.new("TextButton")
	UI.plusBtn.Size = UDim2.new(0, 25, 0, 25)
	UI.plusBtn.Position = UDim2.new(0, 85, 0, 53)
	UI.plusBtn.BackgroundTransparency = 1
	UI.plusBtn.Text = "+"
	UI.plusBtn.TextColor3 = Color3.new(1,1,1)
	UI.plusBtn.Font = Enum.Font.GothamBold
	UI.plusBtn.Parent = UI.mainPanel
	Instance.new("UICorner", UI.plusBtn).CornerRadius = UDim.new(0, 6)
	UI.plusBtn.Activated:Connect(function() adjustSpeed(true) end)

	UI.batteryText = Instance.new("TextLabel")
	UI.batteryText.Size = UDim2.new(0, 100, 0, 16)
	UI.batteryText.Position = UDim2.new(0, 55, 1, -18)
	UI.batteryText.BackgroundTransparency = 1
	UI.batteryText.Font = Enum.Font.GothamBold
	UI.batteryText.TextSize = 12
	UI.batteryText.TextColor3 = Color3.fromRGB(0, 255, 0)
	UI.batteryText.Text = "🔋 100%"
	UI.batteryText.TextXAlignment = Enum.TextXAlignment.Left
	UI.batteryText.Parent = UI.mainPanel

	UI.settingsPanel = Instance.new("Frame")
	UI.settingsPanel.Name = "SettingsIndicator"
	UI.settingsPanel.Size = UDim2.new(0, 200, 0, 50)
	UI.settingsPanel.Position = UDim2.new(0.5, -100, 0.7, 0)
	UI.settingsPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	UI.settingsPanel.BackgroundTransparency = 1
	UI.settingsPanel.BorderSizePixel = 0
	UI.settingsPanel.Visible = false
	UI.settingsPanel.Parent = UI.screenGui
	local settingsCorner = Instance.new("UICorner")
	settingsCorner.CornerRadius = UDim.new(0, 12)
	settingsCorner.Parent = UI.settingsPanel
	local settingsStroke = Instance.new("UIStroke")
	settingsStroke.Thickness = 2
	settingsStroke.Color = Color3.fromRGB(255, 215, 0)
	settingsStroke.Parent = UI.settingsPanel
	local settingsHint = Instance.new("TextLabel")
	settingsHint.Size = UDim2.new(1, 0, 1, 0)
	settingsHint.BackgroundTransparency = 1
	settingsHint.Font = Enum.Font.GothamBold
	settingsHint.TextSize = 12
	settingsHint.TextColor3 = Color3.fromRGB(255, 255, 255)
	settingsHint.Text = "← → cambiar | tocar = ejecutar"
	settingsHint.Parent = UI.settingsPanel
	UI.speedIndicatorLabel = Instance.new("TextLabel")
	UI.speedIndicatorLabel.Size = UDim2.new(0, 150, 0, 30)
	UI.speedIndicatorLabel.Position = UDim2.new(0.5, -75, 0.85, 0)
	UI.speedIndicatorLabel.BackgroundTransparency = 1
	UI.speedIndicatorLabel.Font = Enum.Font.GothamBold
	UI.speedIndicatorLabel.TextSize = 14
	UI.speedIndicatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	UI.speedIndicatorLabel.TextStrokeTransparency = 0.5
	UI.speedIndicatorLabel.TextTransparency = 1
	UI.speedIndicatorLabel.Text = " "
	UI.speedIndicatorLabel.Parent = UI.screenGui
	updateMainUI()
end

local function setupGestures()
	local menuSwipeStart = nil
	local longPressTimer = nil
	local swipedElement = nil
	local lastLeftClickTime = 0
	local lastRightClickTime = 0
	local leftClickTask = nil
	local rightClickTask = nil
	local DOUBLE_CLICK_THRESHOLD = 0.25
	local m3StartTime = 0
	local l2Pressed = false
	local doubleATimer = nil
	local aPressCount = 0
	local r3DownStartTime = 0
	local thumbstickDebounce = {x=false, y=false}
	local function isInside(pos, gui)
		if not gui or not gui.Visible then return false end
		local absPos = gui.AbsolutePosition
		local absSize = gui.AbsoluteSize
		return pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y
	end
	local keyboardMenu = UserInputService.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == Enum.KeyCode.Comma then
			if menuOpen then closeMenu() else openMenu() end
		elseif input.KeyCode == Enum.KeyCode.Home then
			if menuOpen then nextMode() end
		elseif input.KeyCode == Enum.KeyCode.PageUp then
			if menuOpen then previousSelection() end
		elseif input.KeyCode == Enum.KeyCode.PageDown then
			if menuOpen then nextSelection() end
		elseif input.KeyCode == Enum.KeyCode.Delete then
			if menuOpen then
				if currentMode == MODES.SETTINGS then
					currentMode = MODES.ABILITIES
					if UI.settingsPanel then
						TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
						task.delay(0.2, function() UI.settingsPanel.Visible = false end)
					end
				else
					currentMode = MODES.SETTINGS
					updateMainUI()
					if UI.settingsPanel then
						UI.settingsPanel.Visible = true
						TweenService:Create(UI.settingsPanel, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
					end
				end
			end
		elseif input.KeyCode == Enum.KeyCode.Equals or input.KeyCode == Enum.KeyCode.KeypadPlus then
			adjustSpeed(true)
		elseif input.KeyCode == Enum.KeyCode.Minus or input.KeyCode == Enum.KeyCode.KeypadMinus then
			adjustSpeed(false)
		elseif input.KeyCode == Enum.KeyCode.End then
			if menuOpen and currentMode == MODES.ABILITIES and abilities[currentAbilityIndex].key == "supersalto" then
				startSuperSaltoCharge()
			else
				activateCurrent()
			end
		elseif input.KeyCode == Enum.KeyCode.KeypadMultiply or input.KeyCode == Enum.KeyCode.Asterisk then
			if lockedPlayer then lockedPlayer = nil else lockedPlayer = getTargetFromCamera() end
		end
	end)
	table.insert(persistentConnections, keyboardMenu)
	local keyboardEndRelease = UserInputService.InputEnded:Connect(function(input, gp)
		if gp then return end
		if input.KeyCode == Enum.KeyCode.End then
			if currentMode == MODES.ABILITIES and abilities[currentAbilityIndex].key == "supersalto" then releaseSuperSalto() end
		end
	end)
	table.insert(persistentConnections, keyboardEndRelease)
	local mouseMenuControl = UserInputService.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.UserInputType == Enum.UserInputType.MouseButton3 then m3StartTime = tick() return end
		if menuOpen then
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local now = tick()
				if now - lastLeftClickTime < DOUBLE_CLICK_THRESHOLD then
					if leftClickTask then task.cancel(leftClickTask); leftClickTask = nil end
					activateCurrent()
					lastLeftClickTime = 0
				else
					lastLeftClickTime = now
					leftClickTask = task.delay(DOUBLE_CLICK_THRESHOLD, function() previousSelection() leftClickTask = nil end)
				end
			elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
				local now = tick()
				if now - lastRightClickTime < DOUBLE_CLICK_THRESHOLD then
					if rightClickTask then task.cancel(rightClickTask); rightClickTask = nil end
					if currentMode == MODES.ABILITIES then currentMode = MODES.EMOTES
					elseif currentMode == MODES.EMOTES then currentMode = MODES.ABILITIES
					else currentMode = MODES.ABILITIES
					end

					if UI.settingsPanel then UI.settingsPanel.Visible = false; UI.settingsPanel.BackgroundTransparency = 1 end
					updateMainUI()
					local originalColor = UI.modeText.TextColor3
					UI.modeText.TextColor3 = Color3.fromRGB(255, 255, 100)
					task.delay(0.08, function() UI.modeText.TextColor3 = originalColor end)
					lastRightClickTime = 0
				else
					lastRightClickTime = now 
					rightClickTask = task.delay(DOUBLE_CLICK_THRESHOLD, function() nextSelection() rightClickTask = nil end)
				end
			end
		end
	end)
	table.insert(persistentConnections, mouseMenuControl)
	local mouseMenuControlEnded = UserInputService.InputEnded:Connect(function(input, gp)
		if input.UserInputType == Enum.UserInputType.MouseButton3 then
			if m3StartTime > 0 then
				local duration = tick() - m3StartTime
				m3StartTime = 0
				if duration >= 1 then
					if isWalkSpeedActive then
						toggleAbility("walkspeed", 1)
						if UI.speedIndicatorLabel then
							UI.speedIndicatorLabel.Text = "Super Velocidad: OFF"
							UI.speedIndicatorLabel.TextTransparency = 0
							task.delay(1.5, function() TweenService:Create(UI.speedIndicatorLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play() end)
						end
					else
						if not isWalkSpeedActive then toggleAbility("walkspeed", 1) end
						walkSpeed = 17
						targetWalkSpeed = 17
						updateMainUI()
						if UI.speedIndicatorLabel then
							UI.speedIndicatorLabel.Text = "Super Velocidad: (17)"
							UI.speedIndicatorLabel.TextTransparency = 0
							task.delay(1.5, function() TweenService:Create(UI.speedIndicatorLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play() end)
						end
					end
				else
					if menuOpen then closeMenu() else openMenu() end
				end
			end
		end
	end)
	table.insert(persistentConnections, mouseMenuControlEnded)
	local gamepadL2Began = UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonL2 then
			l2Pressed = true
		end
	end)
	table.insert(persistentConnections, gamepadL2Began)
	local gamepadL2Ended = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonL2 then
			l2Pressed = false
		end
	end)
	table.insert(persistentConnections, gamepadL2Ended)
	local r3DownBegan = UserInputService.InputBegan:Connect(function(input, gp)
		if gp or l2Pressed then return end
		if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR3 then
			r3DownStartTime = tick()
		end
	end)
	table.insert(persistentConnections, r3DownBegan)
	local r3DownEnded = UserInputService.InputEnded:Connect(function(input, gp)
		if gp or l2Pressed then return end
		if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR3 then
			if r3DownStartTime > 0 then
				local duration = tick() - r3DownStartTime
				r3DownStartTime = 0
				if duration >= 1 then
					if isWalkSpeedActive then
						toggleAbility("walkspeed", 1)
						if UI.speedIndicatorLabel then
							UI.speedIndicatorLabel.Text = "Super Velocidad: OFF"
							UI.speedIndicatorLabel.TextTransparency = 0
							task.delay(1.5, function() TweenService:Create(UI.speedIndicatorLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play() end)
						end
					else
						if not isWalkSpeedActive then toggleAbility("walkspeed", 1) end
						walkSpeed = 17
						targetWalkSpeed = 17
						updateMainUI()
						if UI.speedIndicatorLabel then
							UI.speedIndicatorLabel.Text = "Super Velocidad: (17)"
							UI.speedIndicatorLabel.TextTransparency = 0
							task.delay(1.5, function() TweenService:Create(UI.speedIndicatorLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play() end)
						end
					end
				end
			end
		end
	end)
	table.insert(persistentConnections, r3DownEnded)
	local gamepadMenuNavigate = UserInputService.InputChanged:Connect(function(input, gp)
		if gp or input.UserInputType ~= Enum.UserInputType.Gamepad1 or input.KeyCode ~= Enum.KeyCode.Thumbstick2 then return end
		if not l2Pressed or not menuOpen then return end
		local x = input.Position.X
		local y = input.Position.Y
		local threshold = 0.6
		if math.abs(x) > threshold then
			if not thumbstickDebounce.x then
				if x > 0 then nextMode() else previousMode() end
				thumbstickDebounce.x = true
			end
		else
			thumbstickDebounce.x = false
		end
		if math.abs(y) > threshold then
			if not thumbstickDebounce.y then
				if y > 0 then previousSelection() else nextSelection() end
				thumbstickDebounce.y = true
			end
		else
			thumbstickDebounce.y = false
		end
	end)
	table.insert(persistentConnections, gamepadMenuNavigate)
	local gamepadActions = UserInputService.InputBegan:Connect(function(input, gp)
		if gp or input.UserInputType ~= Enum.UserInputType.Gamepad1 or not l2Pressed then return end
		if input.KeyCode == Enum.KeyCode.ButtonSelect then
			if menuOpen then closeMenu() else openMenu() end
		elseif menuOpen then
			if input.KeyCode == Enum.KeyCode.ButtonA then
				activateCurrent()
			end
		end
	end)
	table.insert(persistentConnections, gamepadActions)
	local strengthInput = UserInputService.InputBegan:Connect(function(input, gp)
		if gp or not SuperStrength.Active or menuOpen then return end
		if input.UserInputType == Enum.UserInputType.Touch then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if tick() - SuperStrength.LastActionTime < 0.3 then return end
			if SuperStrength.GrabbedData then releaseGrabbedObject(true) end
		end
	end)
	table.insert(persistentConnections, strengthInput)
	local touchStrengthInput = UserInputService.TouchTap:Connect(function(touchPos, gp)
		if not SuperStrength.Active or menuOpen then return end
		if tick() - SuperStrength.LastActionTime < 0.3 then return end
		if SuperStrength.GrabbedData then releaseGrabbedObject(true) end
	end)
	table.insert(persistentConnections, touchStrengthInput)
	local touchBegan = UserInputService.TouchStarted:Connect(function(input)
		local pos = input.Position
		if menuOpen then
			if isInside(pos, UI.modeText) then menuSwipeStart = pos swipedElement = "mode"
			elseif isInside(pos, UI.abilityText) then menuSwipeStart = pos swipedElement = "ability"
			elseif isInside(pos, UI.mainPanel) then menuSwipeStart = pos swipedElement = "panel" end
		else
			local viewportSize = camera.ViewportSize
			local touchX = pos.X / viewportSize.X
			local touchY = pos.Y / viewportSize.Y
			if touchX > 0.35 and touchX < 0.65 and touchY > 0.3 and touchY < 0.7 then menuSwipeStart = pos end
		end
	end)
	table.insert(persistentConnections, touchBegan)
	local touchMoved = UserInputService.TouchMoved:Connect(function(input)
		if not menuSwipeStart then return end
		local delta = input.Position - menuSwipeStart
		if menuOpen then
		elseif delta.Y > 100 and math.abs(delta.Y) > math.abs(delta.X) * 2 then
			openMenu()
			menuSwipeStart = nil
		end
	end)
	table.insert(persistentConnections, touchMoved)
	local touchEnded = UserInputService.TouchEnded:Connect(function(input)
		menuSwipeStart = nil
		swipedElement = nil
	end)
	table.insert(persistentConnections, touchEnded)
	local doubleSpaceTimer = nil
	local spacePressCount = 0
	local doubleSpaceConn = UserInputService.InputBegan:Connect(function(input, gp)
		if gp then return end
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
			spacePressCount = spacePressCount + 1
			if doubleSpaceTimer then task.cancel(doubleSpaceTimer) end
			doubleSpaceTimer = task.delay(0.3, function() spacePressCount = 0 doubleSpaceTimer = nil end)
			if spacePressCount == 2 then
				spacePressCount = 0
				if doubleSpaceTimer then task.cancel(doubleSpaceTimer) end
				doubleSpaceTimer = nil
				toggleFlight()
			end
		elseif input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonA then
			if l2Pressed and menuOpen then return end
			aPressCount = aPressCount + 1
			if doubleATimer then task.cancel(doubleATimer) end
			doubleATimer = task.delay(0.3, function() aPressCount = 0 doubleATimer = nil end)
			if aPressCount == 2 then
				aPressCount = 0
				if doubleATimer then task.cancel(doubleATimer) end
				doubleATimer = nil
				toggleFlight()
			end
		end
	end)
	table.insert(persistentConnections, doubleSpaceConn)
end

-- ============ LOAD ANIMATIONS ============
local function waitForCharacter()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid", 10)
	return character, humanoid
end

local function waitForAnimate(character, timeout)
	timeout = timeout or 2
	local startTime = tick()
	while tick() - startTime < timeout do
		local animate = character:FindFirstChild("Animate")
		if animate and animate:FindFirstChild("run") and animate:FindFirstChild("idle") and animate:FindFirstChild("jump") and animate:FindFirstChild("fall") then
			return animate
		end
		task.wait()
	end
	return nil
end

local function setAnimation(animationType, animationId, animate)
	if not animate or not animationId then return false end
	pcall(function()
		local idStr = "rbxassetid://" .. tostring(animationId)
		local function findChild(parent, name)
			return parent:FindFirstChild(name) or parent:FindFirstChild(name:lower()) or parent:FindFirstChild(name:upper())
		end
		if animationType == "Idle" then
			local idle = findChild(animate, "idle")
			if idle then
				local anim1 = idle:FindFirstChild("Animation1")
				local anim2 = idle:FindFirstChild("Animation2")
				if anim1 then anim1.AnimationId = idStr end
				if anim2 then anim2.AnimationId = idStr end
			end
		elseif animationType == "Walk" then
			local walk = findChild(animate, "walk")
			local walkAnim = walk and (walk:FindFirstChild("WalkAnim") or walk:FindFirstChild("Walk"))
			if walkAnim then walkAnim.AnimationId = idStr end
		elseif animationType == "Run" then
			local run = findChild(animate, "run")
			local runAnim = run and (run:FindFirstChild("RunAnim") or run:FindFirstChild("Run"))
			if runAnim then runAnim.AnimationId = idStr end
		elseif animationType == "Jump" then
			local jump = findChild(animate, "jump")
			local jumpAnim = jump and (jump:FindFirstChild("JumpAnim") or jump:FindFirstChild("Jump"))
			if jumpAnim then jumpAnim.AnimationId = idStr end
			if jump then
				for _, child in ipairs(jump:GetChildren()) do
					if child:IsA("Animation") then child.AnimationId = idStr end
				end
			end
		elseif animationType == "Fall" then
			local fall = findChild(animate, "fall")
			local fallAnim = fall and (fall:FindFirstChild("FallAnim") or fall:FindFirstChild("Fall"))
			if fallAnim then fallAnim.AnimationId = idStr end
			if fall then
				for _, child in ipairs(fall:GetChildren()) do
					if child:IsA("Animation") then child.AnimationId = idStr end
				end
			end
		elseif animationType == "Climb" then
			local climb = findChild(animate, "climb")
			local climbAnim = climb and (climb:FindFirstChild("ClimbAnim") or climb:FindFirstChild("Climb"))
			if climbAnim then climbAnim.AnimationId = idStr end
		elseif animationType == "Swim" then
			local swim = findChild(animate, "swim")
			local swimAnim = swim and (swim:FindFirstChild("Swim") or swim:FindFirstChild("SwimAnim"))
			if swimAnim then swimAnim.AnimationId = idStr end
		elseif animationType == "SwimIdle" then
			local swimIdle = findChild(animate, "swimidle")
			local swimIdleAnim = swimIdle and (swimIdle:FindFirstChild("SwimIdle") or swimIdle:FindFirstChild("SwimIdleAnim"))
			if swimIdleAnim then swimIdleAnim.AnimationId = idStr end
		end
	end)
	return true
end

local function saveOriginalAnimations(animate)
	if not animate then return end
	originalAnimations = {Idle1 = nil, Idle2 = nil, Walk = nil, Run = nil, Jump = nil, Fall = nil, Climb = nil, Swim = nil, SwimIdle = nil}
	if animate.idle then
		local anim1 = animate.idle:FindFirstChild("Animation1")
		local anim2 = animate.idle:FindFirstChild("Animation2")
		if anim1 then originalAnimations.Idle1 = anim1.AnimationId end
		if anim2 then originalAnimations.Idle2 = anim2.AnimationId end
	end
	if animate.walk then
		local walkAnim = animate.walk:FindFirstChild("WalkAnim")
		if walkAnim then originalAnimations.Walk = walkAnim.AnimationId end
	end
	if animate.run then
		local runAnim = animate.run:FindFirstChild("RunAnim")
		if runAnim then originalAnimations.Run = runAnim.AnimationId end
	end
	if animate.jump then
		local jumpAnim = animate.jump:FindFirstChild("JumpAnim")
		if jumpAnim then originalAnimations.Jump = jumpAnim.AnimationId end
	end
	if animate.fall then
		local fallAnim = animate.fall:FindFirstChild("FallAnim")
		if fallAnim then originalAnimations.Fall = fallAnim.AnimationId end
	end
	if animate.climb then
		local climbAnim = animate.climb:FindFirstChild("ClimbAnim")
		if climbAnim then originalAnimations.Climb = climbAnim.AnimationId end
	end
	if animate:FindFirstChild("swim") then
		local swimAnim = animate.swim:FindFirstChild("Swim")
		if swimAnim then originalAnimations.Swim = swimAnim.AnimationId end
	end
	if animate:FindFirstChild("swimidle") then
		local swimIdleAnim = animate.swimidle:FindFirstChild("SwimIdle")
		if swimIdleAnim then originalAnimations.SwimIdle = swimIdleAnim.AnimationId end
	end
end

local function restoreOriginalAnimations()
	local character = player.Character
	if not character then return end
	local humanoid = character:WaitForChild("Humanoid", 5)
	local animate = waitForAnimate(character, 3) -- Esperar a que el script Animate esté listo
	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator")
		local target = animator or humanoid
		for _, track in ipairs(target:GetPlayingAnimationTracks()) do track:Stop(0) end
	end
	if currentAnimTrack then currentAnimTrack:Stop(0) currentAnimTrack = nil end
	if walkAnimTrack then walkAnimTrack:Stop(0) walkAnimTrack = nil end
	for _, track in pairs(animationTracks) do if track then track:Stop(0) end end
	animationTracks = {}
	if not animate then customAnimationsLoaded = false return end
	if originalAnimations.Idle1 then
		local anim1 = animate.idle:FindFirstChild("Animation1")
		if anim1 then anim1.AnimationId = originalAnimations.Idle1 end
	end
	if originalAnimations.Idle2 then
		local anim2 = animate.idle:FindFirstChild("Animation2")
		if anim2 then anim2.AnimationId = originalAnimations.Idle2 end
	end
	if originalAnimations.Walk then
		local walkAnim = animate.walk:FindFirstChild("WalkAnim")
		if walkAnim then walkAnim.AnimationId = originalAnimations.Walk end
	end
	if originalAnimations.Run then
		local runAnim = animate.run:FindFirstChild("RunAnim")
		if runAnim then runAnim.AnimationId = originalAnimations.Run end
	end
	if originalAnimations.Jump then
		local jumpAnim = animate.jump:FindFirstChild("JumpAnim")
		if jumpAnim then jumpAnim.AnimationId = originalAnimations.Jump end
	end
	if originalAnimations.Fall then
		local fallAnim = animate.fall:FindFirstChild("FallAnim")
		if fallAnim then fallAnim.AnimationId = originalAnimations.Fall end
	end
	if originalAnimations.Climb then
		local climbAnim = animate.climb:FindFirstChild("ClimbAnim")
		if climbAnim then climbAnim.AnimationId = originalAnimations.Climb end
	end
	if originalAnimations.Swim then
		local swimAnim = animate.swim:FindFirstChild("Swim")
		if swimAnim then swimAnim.AnimationId = originalAnimations.Swim end
	end
	if originalAnimations.SwimIdle then
		local swimIdleAnim = animate.swimidle:FindFirstChild("SwimIdle")
		if swimIdleAnim then swimIdleAnim.AnimationId = originalAnimations.SwimIdle end
	end
	animate.Disabled = true
	task.wait(0.1)
	animate.Disabled = false
	customAnimationsLoaded = false
end

loadAnimations = function()
	local character, humanoid = waitForCharacter()
	if not character or not humanoid then return false end
	if isR6 then return true end
	local animate = waitForAnimate(character)
	if not animate then return false end
	animationTracks = {}
	walkAnimTrack = nil
	if not customAnimationsLoaded then saveOriginalAnimations(animate) end
	local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid
	local animTypes = {"Idle", "Walk", "Run", "Jump", "Fall", "Climb", "Swim", "SwimIdle"}
	for _, animType in ipairs(animTypes) do
		if ANIMATIONS[animType] then setAnimation(animType, ANIMATIONS[animType], animate) end
	end
	animate.Disabled = true
	task.wait(0.1)
	animate.Disabled = false
	for _, id in pairs(ANIMATIONS) do
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. id
		pcall(function()
			local track = animator:LoadAnimation(anim)
			track.Priority = Enum.AnimationPriority.Movement
			animationTracks[id] = track
		end)
		task.wait()
	end
	customAnimationsLoaded = true
	return true
end

local function forceInitialLoad()
	task.spawn(function()
		for i = 1, 5 do
			if loadAnimations() then
				if humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Landed)
					task.wait(0.1)
					humanoid:ChangeState(Enum.HumanoidStateType.Running)
				end
				break
			end
			task.wait(0.5)
		end
	end)
end

-- ============ CLEANUP (DESTRUCCIÓN TOTAL) ============
cleanupEverything = function(isFullDestruction)
	if isFullDestruction then
		scriptActive = false 
	end

	-- Limpieza completa de habilidades
	cleanupSuperHearing()
	cleanupXRayVision()
	stopMolecularVibration()
	molecularVibrationRequesters.mirage = false
	molecularVibrationRequesters.speed = false
	releaseGrabbedObject(false)
	cleanupMirageSpeed()
	restoreAmbientSounds()

	if flyGyro then flyGyro:Destroy() flyGyro = nil end
	if flyVelocity then flyVelocity:Destroy() flyVelocity = nil end
	if invisibilitySeat then invisibilitySeat:Destroy() invisibilitySeat = nil end
	if batteryDepletedBlur then batteryDepletedBlur:Destroy() batteryDepletedBlur = nil end
	if exhaustedWalkTrack then exhaustedWalkTrack:Stop(0); exhaustedWalkTrack = nil end
	if exhaustedIdleTrack then exhaustedIdleTrack:Stop(0); exhaustedIdleTrack = nil end
	isBatteryDepleted = false
	if walkPos then walkPos:Destroy() walkPos = nil end
	stopFlightAudio()
	stopFlightAnimation(0.1)
	stopAntiFall()
	stopNoclip()
	stopAntiFling()
	if lockOnConn and lockOnConn.Connected then pcall(function() lockOnConn:Disconnect() end) end
	lockOnConn = nil
	lockedPlayer = nil
	if SuperStrength.Connection then SuperStrength.Connection:Disconnect() SuperStrength.Connection = nil end
	if isFullDestruction then
		isFlying = false
		isWalkSpeedActive = false
		isMirageSpeedActive = false
		isSuperJumpActive = false
		SuperHearing.Active = false
		isInvisibilityActive = false
		XRayVision.Active = false
		SuperStrength.Active = false
		isAntiFallActive = false
		isSprintActive = false
		if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop() mirageSpeedEmoteTrack = nil end
		lockedPlayer = nil
		if currentEmoteSound then currentEmoteSound:Stop() currentEmoteSound:Destroy() currentEmoteSound = nil end
		if character then
			for _, v in ipairs(character:GetDescendants()) do
				if v:IsA("Sound") and v.Name == "SpecialEmoteSound" then pcall(function() v:Stop() v:Destroy() end) end
			end
		end
		for _, conn in ipairs(persistentConnections) do
			if conn and conn.Connected then pcall(function() conn:Disconnect() end) end
		end
		persistentConnections = {}
		if UI.screenGui then UI.screenGui:Destroy() UI.screenGui = nil end
		UI = {}
		for sound, properties in pairs(originalSoundProperties) do
			if sound and sound.Parent then
				sound.Volume = properties.Volume
				if properties.Playing and not sound.Playing then sound:Play() end
				sound.Looped = properties.Looped
			end
		end
		originalSoundProperties = {}
		if humanoid then
			pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end)
			local animate = character:FindFirstChild("Animate")
			if animate then animate.Disabled = false end
			if customAnimationsLoaded then restoreOriginalAnimations() end
		end
	end
	if humanoid then
		humanoid.Jump = true
		humanoid.WalkSpeed = originalWalkSpeed
		humanoid.JumpPower = originalJumpPower
		humanoid.UseJumpPower = true
		humanoid.PlatformStand = false
		humanoid.AutoRotate = true
		if isFullDestruction then
			pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end)
			local animate = character:FindFirstChild("Animate")
			if animate then animate.Disabled = false end
			if customAnimationsLoaded then restoreOriginalAnimations() end
		end
	end
	originalSoundProperties = {}
	if humanoid then
		humanoid.Jump = true
		humanoid.WalkSpeed = originalWalkSpeed
		humanoid.JumpPower = originalJumpPower
		humanoid.UseJumpPower = true
		humanoid.PlatformStand = false
		humanoid.AutoRotate = true
		pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end)
		local animate = character:FindFirstChild("Animate")
		if animate then animate.Disabled = false end
		if customAnimationsLoaded then restoreOriginalAnimations() end
	end
	for _, conn in ipairs(allConnections) do
		if conn and conn.Connected then pcall(function() conn:Disconnect() end) end
	end
	allConnections = {}
	stopNoclip()
	for _, track in pairs(animationTracks) do if track then pcall(function() track:Stop() end) end end
	if jumpAnimTrack then jumpAnimTrack:Stop() jumpAnimTrack = nil end
	if fallAnimTrack then fallAnimTrack:Stop() fallAnimTrack = nil end
	if sitAnimTrack then sitAnimTrack:Stop() sitAnimTrack = nil end
	if swimAnimTrack then swimAnimTrack:Stop() swimAnimTrack = nil end
	if swimIdleAnimTrack then swimIdleAnimTrack:Stop() swimIdleAnimTrack = nil end
	if climbAnimTrack then climbAnimTrack:Stop() climbAnimTrack = nil end
	animationTracks = {}
	if walkAnimTrack then walkAnimTrack:Stop() walkAnimTrack = nil end
	if hurtOverlayTrack then hurtOverlayTrack:Stop() hurtOverlayTrack = nil end
end

-- ============ TOGGLE ABILITY ============
local function toggleSuperStrength()
	if not scriptActive then return end

	local function playGrabAnim()
		if not humanoid or SuperStrength.AnimTrack then return end
		local grabId = isR6 and 56146409 or 87088218490918
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. tostring(grabId)
		SuperStrength.AnimTrack = humanoid:LoadAnimation(anim)
		SuperStrength.AnimTrack.Priority = Enum.AnimationPriority.Action4
		SuperStrength.AnimTrack.Looped = true
		SuperStrength.AnimTrack:Play()
		SuperStrength.AnimTrack:AdjustSpeed(0)
	end

	local function prepareVehicleForGrab(model)
		local savedStates = {}
		for _, seat in ipairs(model:GetDescendants()) do
			if seat:IsA("VehicleSeat") or seat:IsA("Seat") then
				-- Guardar el estado original del asiento
				savedStates[seat] = {Disabled = seat.Disabled}
				-- Desactivar el asiento para que el conductor no pueda controlarlo mientras es transportado
				seat.Disabled = true
				-- NO establecemos hum.Sit = false, para mantener a los jugadores sentados.
			end
		end
		return savedStates
	end

	if not SuperStrength.Active then -- Costo de activación
		battery = battery - 2
		if battery < 0 then battery = 0 end
		updateBatteryUI()
	end
	SuperStrength.Active = not SuperStrength.Active
	SuperStrength.ActivationTime = tick()
	local grabAnimId = isR6 and 56146409 or 87088218490918
	if not SuperStrength.Active then
		releaseGrabbedObject(false)
		if humanoid then pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, not noSitActive) end) end
		if SuperStrength.Connection then SuperStrength.Connection:Disconnect() SuperStrength.Connection = nil end
	else
		SuperStrength.Connection = RunService.Heartbeat:Connect(function()
			if not SuperStrength.Active or not hrp then return end
			if SuperStrength.GrabbedData then
				if humanoid then humanoid.Sit = false end
				local d = SuperStrength.GrabbedData
				if not d.root or not d.root:IsDescendantOf(game) then releaseGrabbedObject(false) return end
				if humanoid then pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end) end
				if d.root.Anchored then pcall(function() d.root.Anchored = false end) end
				local currentOffset = d.isVehicle and 12 or 6
				local headTop = hrp.Position + Vector3.new(0, hrp.Size.Y / 2 + currentOffset, 0)
				d.att1.WorldCFrame = CFrame.new(headTop) * (camera.CFrame - camera.CFrame.Position)
				if not SuperStrength.AnimTrack then playGrabAnim() end
				pcall(function() d.root:SetNetworkOwner(player) end)
			else
				if humanoid then pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, not noSitActive) end) end
				if tick() - SuperStrength.ActivationTime < 0.8 then return end
				if tick() - SuperStrength.LastActionTime < 1.5 then return end
				local params = OverlapParams.new()
				params.FilterDescendantsInstances = {character}
				params.FilterType = Enum.RaycastFilterType.Exclude
				local detectionCenter = hrp.Position + Vector3.new(0, 2, 0)
				local nearbyParts = Workspace:GetPartBoundsInRadius(detectionCenter, 10, params)
				for _, part in ipairs(nearbyParts) do
					local toPart = (part.Position - hrp.Position).Unit
					if hrp.CFrame.LookVector:Dot(toPart) < 0.4 then continue end
					if part.Position.Y < hrp.Position.Y - 1.5 and not part.Name:lower():find("car") then continue end
					local can, mainPart, model, isV = canGrabObject(part)
					if can then
						local saved = isV and prepareVehicleForGrab(model) or {}
						local att0 = Instance.new("Attachment", mainPart)
						local att1 = Instance.new("Attachment", hrp)
						local ap = Instance.new("AlignPosition", mainPart)
						ap.Attachment0 = att0
						ap.Attachment1 = att1
						ap.Responsiveness = 200
						ap.MaxForce = math.huge
						local ao = Instance.new("AlignOrientation", mainPart)
						ao.Attachment0 = att0
						ao.Attachment1 = att1
						ao.Responsiveness = 50
						ao.MaxTorque = math.huge
						local savedPhysics = {}
						local targetModel = model or mainPart
						for _, v in ipairs(targetModel:GetDescendants()) do
							if v:IsA("BasePart") then
								savedPhysics[v] = {Massless = v.Massless, CanCollide = v.CanCollide}
								v.Massless = true
								v.CanCollide = false
								local nc = Instance.new("NoCollisionConstraint", v)
								nc.Name = "SuperGrabNC"
								nc.Part0 = v; nc.Part1 = hrp
							end
						end
						pcall(function() mainPart.Anchored = false end)
						pcall(function() mainPart.AssemblyLinearVelocity = Vector3.zero end)
						pcall(function() mainPart.AssemblyAngularVelocity = Vector3.zero end)
						pcall(function() mainPart:SetNetworkOwner(player) end)
						SuperStrength.GrabbedData = {
							root = mainPart, model = model, isVehicle = isV, savedStates = saved,
							alignPos = ap, alignOrient = ao, att0 = att0, att1 = att1,
							savedPhysics = savedPhysics
						}
						SuperStrength.LastActionTime = tick()
						break
					end
				end
			end
		end)
		table.insert(allConnections, SuperStrength.Connection)
	end
end

toggleAbility = function(key, mode)
	if not scriptActive then return end

	if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health <= 0 then return end
	
	if isBatteryDepleted then
		-- Si la batería está agotada, solo se permite DESACTIVAR habilidades.
		-- Se comprueba si la habilidad está activa. Si no lo está, significa que se intenta ACTIVAR.
		local is_currently_active = false
		if key == "walkspeed" and isWalkSpeedActive then is_currently_active = true
		elseif key == "miragespeed" and isMirageSpeedActive then is_currently_active = true
		elseif key == "gravjump" and isGravJumpActive then is_currently_active = true
		elseif key == "superhearing" and SuperHearing.Active then is_currently_active = true
		elseif key == "xrayvision" and XRayVision.Active then is_currently_active = true
		elseif key == "flight" and isFlying then is_currently_active = true
		elseif key == "superstrength" and SuperStrength.Active then is_currently_active = true
		elseif key == "instantreaction" and InstantReaction.Active then is_currently_active = true
		end

		if not is_currently_active then return end -- No permitir ACTIVAR si la batería está agotada.
	end
	if key == "walkspeed" and humanoid then
		isWalkSpeedActive = not isWalkSpeedActive
		if isWalkSpeedActive then
			if isBatteryDepleted then
				-- Activar modo velocidad en agotamiento
				targetWalkSpeed = 17
				walkSpeed = 17
			else
				-- Activar modo velocidad normal
				walkSpeed = 16
				targetWalkSpeed = 16
			end
		end

		-- El sistema de impulso de velocidad solo funciona cuando no está agotado
		if not isBatteryDepleted then
			humanoid.WalkSpeed = originalWalkSpeed
			if isWalkSpeedActive then
				if not walkPos then
					walkPos = Instance.new("BodyPosition")
					walkPos.Name = "WalkAnchor"
					walkPos.MaxForce = Vector3.new(0, 0, 0)
					walkPos.D = 500
					walkPos.P = 10000
					walkPos.Position = hrp.Position
					walkPos.Parent = hrp
				end
				lastWalkStationaryPos = hrp.Position
				hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
			else
				if walkPos then pcall(function() walkPos:Destroy() end) walkPos = nil end
				lastWalkStationaryPos = nil
				if hrp then hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0) end
			end
		end
	elseif key == "miragespeed" then
		toggleMirageSpeed()
	elseif key == "gravjump" then
		isGravJumpActive = not isGravJumpActive
		targetGravity = originalGravity
		if not isGravJumpActive then
			Workspace.Gravity = originalGravity
		end
	elseif key == "supersalto" then
		-- no hace nada directamente
	elseif key == "superhearing" then
		if not SuperHearing.Active then -- Costo de activación
			battery = battery - 2
			if battery < 0 then battery = 0 end
			updateBatteryUI()
		end
		if SuperHearing.Active then stopSuperHearing() else startSuperHearing() end	
	elseif key == "xrayvision" then
		toggleXRayVision()
	elseif key == "flight" then
		toggleFlight()
	elseif key == "superstrength" then
		toggleSuperStrength()
	elseif key == "instantreaction" then
		if isR6 then
			if not InstantReaction.Active then -- Costo de activación
				battery = battery - 1
				if battery < 0 then battery = 0 end
				updateBatteryUI()
			end
			InstantReaction.Active = not InstantReaction.Active
			if InstantReaction.Active then
				InstantReaction.Connection = RunService.RenderStepped:Connect(updateInstantReaction)
			else
				if InstantReaction.Connection then InstantReaction.Connection:Disconnect() InstantReaction.Connection = nil end
			end
		end
	end
	updateMainUI()
end

adjustSpeed = function(increase)
	local msg = " "
	if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health <= 0 then return end

	if isWalkSpeedActive then
		if isBatteryDepleted then
			-- Ajuste de velocidad en modo agotamiento
			if increase then
				targetWalkSpeed = math.min(targetWalkSpeed + 1, 17)
			else
				targetWalkSpeed = math.max(targetWalkSpeed - 1, 17)
			end
			msg = "Velocidad: " .. targetWalkSpeed
		else
			-- Ajuste de velocidad normal
			if battery == 0 then return end
			if increase then
				if targetWalkSpeed < 21 then targetWalkSpeed = targetWalkSpeed + 1 else targetWalkSpeed = math.min(targetWalkSpeed + 10, maxWalkSpeed) end
			else
				if targetWalkSpeed <= 21 then targetWalkSpeed = math.max(11, targetWalkSpeed - 1) else targetWalkSpeed = math.max(21, targetWalkSpeed - 10) end
			end
			msg = "Velocidad: " .. targetWalkSpeed
		end
	elseif isGravJumpActive then
		if isBatteryDepleted then return end
		local gravityStep = 5
		local minGravity = -100
		local maxGravity = 100
		if increase then
			targetGravity = math.min(targetGravity + gravityStep, maxGravity)
		else
			targetGravity = math.max(targetGravity - gravityStep, minGravity)
		end
		msg = "Gravedad: " .. math.floor(targetGravity)
	elseif isMirageSpeedActive then
		if isBatteryDepleted then return end
		if increase then
			mirageSpeedValue = math.min(mirageSpeedValue + mirageSpeedStep, maxMirageSpeed)
		else
			mirageSpeedValue = math.max(mirageSpeedValue - mirageSpeedStep, minMirageSpeed)
		end
		
		local newEmoteId = (mirageSpeedValue == 0.5) and 84043660421785 or 90584560149153
		local currentEmoteIdStr = mirageSpeedEmoteTrack and mirageSpeedEmoteTrack.Animation.AnimationId or ""
		local currentEmoteId = currentEmoteIdStr:match("%d+")

		if tostring(newEmoteId) ~= currentEmoteId or not mirageSpeedEmoteTrack or not mirageSpeedEmoteTrack.IsPlaying then
			playMirageSpeedEmote()
		else
			mirageSpeedEmoteTrack:AdjustSpeed(mirageSpeedValue)
		end

		msg = "Velocidad Espejismo: " .. string.format("%.1f", mirageSpeedValue)
	end
	if msg ~= " " and UI.speedIndicatorLabel then
		UI.speedIndicatorLabel.Text = msg
		UI.speedIndicatorLabel.TextTransparency = 0
		task.spawn(function()
			task.wait(1.5)
			if UI.speedIndicatorLabel.Text == msg then
				TweenService:Create(UI.speedIndicatorLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
			end
		end)
	end
end

-- ============ EVENTOS ============
startMainAnimationLoop = function()
	local conn = RunService.Heartbeat:Connect(function(deltaTime)
		if not scriptActive then return end
		
		if not isBatteryDepleted and hurtState ~= 2 then
			if isWalkSpeedActive then
				walkSpeed = walkSpeed + (targetWalkSpeed - walkSpeed) * walkSpeedLerpFactor
				humanoid.WalkSpeed = originalWalkSpeed
				molecularVibrationRequesters.speed = (walkSpeed >= 150)
				updateMolecularVibrationState()
			else
				humanoid.WalkSpeed = originalWalkSpeed
				if molecularVibrationRequesters.speed then
					molecularVibrationRequesters.speed = false
					updateMolecularVibrationState()
				end
			end
		end

		if InstantReaction.Active and InstantReaction.DodgeActive then return end
		if isGravJumpActive then
			Workspace.Gravity = targetGravity
		elseif Workspace.Gravity ~= originalGravity then
			Workspace.Gravity = originalGravity
		end
		local healthPercent = (humanoid and humanoid.MaxHealth > 0) and (humanoid.Health / humanoid.MaxHealth) or 1
		local hurtState = 0
		if healthPercent <= 0.5 then
			hurtState = 2
		elseif healthPercent <= 0.6 then
			hurtState = 1
		end
		local isHurt = hurtState > 0
		local moveMag = humanoid and humanoid.MoveDirection.Magnitude or 0
		local hasKeyInput = UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.D)
		local isMoving = moveMag > 0.1
		local isEmotePlaying = false

		if humanoid and hrp then
			isCrouching = character:GetAttribute("Crouching") == true or (humanoid.WalkSpeed < 9)
			local state = humanoid:GetState()
			local isSeated = (state == Enum.HumanoidStateType.Seated) or (humanoid.Sit == true) or (humanoid.SeatPart ~= nil)
			local isClimbing = (state == Enum.HumanoidStateType.Climbing)
			local isSwimming = (state == Enum.HumanoidStateType.Swimming)
			
			local isStunned = (state == Enum.HumanoidStateType.Physics) or (hrp and hrp.Anchored)
			if isStunned then lastStunTime = tick() end
			
			local animate = character:FindFirstChild("Animate")
			local equippedTool = character:FindFirstChildOfClass("Tool")
			local isHoldingTool = equippedTool ~= nil or false

			-- Añadimos una comprobación más robusta para items que no son "Tool", como los de Brookhaven.
			-- Esto busca objetos soldados a la mano del personaje que no formen parte del propio personaje.
			if not isHoldingTool then
				local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
				if rightHand then
					for _, child in ipairs(rightHand:GetChildren()) do
						if child:IsA("Weld") or child:IsA("WeldConstraint") then
							local otherPart = (child.Part0 == rightHand and child.Part1) or (child.Part1 == rightHand and child.Part0)
							if otherPart and not otherPart:IsDescendantOf(character) then
								isHoldingTool = true
								break
							end
						end
					end
				end
			end
			
			local wasRecentlyStunned = (tick() - lastStunTime < 1)
			local isExternal = (isExternalAnimPlaying() and not isHoldingTool and not isStunned and not wasRecentlyStunned) or (humanoid.PlatformStand and not isFlying) or (state == Enum.HumanoidStateType.None)

			if not isWalkSpeedActive and humanoid then
				humanoid.WalkSpeed = originalWalkSpeed
			end

			if isSeated or isClimbing or isSwimming or isExternal or isCrouching then
				if isFlying then stopFlight() end
				
				if (isExternal or isCrouching) and animate and not isStunned then 
					animate.Disabled = false 
				elseif isStunned and animate then
					animate.Disabled = true
				end

				if isExternal and humanoid and not isWalkSpeedActive then
					humanoid.WalkSpeed = originalWalkSpeed
				end

				if walkPos then walkPos.MaxForce = Vector3.new(0, 0, 0) end
				lastWalkStationaryPos = nil
				if currentAnimTrack then currentAnimTrack:Stop(0.2) currentAnimTrack = nil end
				if walkAnimTrack then walkAnimTrack:Stop(0.2) walkAnimTrack = nil end
				stopSprintAnimation()
				if jumpAnimTrack then jumpAnimTrack:Stop(0.2) jumpAnimTrack = nil end
				if fallAnimTrack then fallAnimTrack:Stop(0.2) fallAnimTrack = nil end
				if isSeated then
					local sitIdStr = "rbxassetid://" .. ANIMATIONS.Sit
					if not sitAnimTrack or sitAnimTrack.Animation.AnimationId ~= sitIdStr then
						if sitAnimTrack then sitAnimTrack:Stop(0.1) end
						local anim = Instance.new("Animation")
						anim.AnimationId = sitIdStr
						sitAnimTrack = humanoid:LoadAnimation(anim)
						sitAnimTrack.Priority = Enum.AnimationPriority.Action
						sitAnimTrack.Looped = true
						sitAnimTrack:Play(0.2)
					elseif not sitAnimTrack.IsPlaying then
						sitAnimTrack:Play(0.2)
					end
				else
					if sitAnimTrack then sitAnimTrack:Stop(0.2) sitAnimTrack = nil end
				end
				if isSwimming then
					local isSwimmingMoving = humanoid.MoveDirection.Magnitude > 0.1
					local targetSwimAnimId = isSwimmingMoving and ANIMATIONS.Swim or ANIMATIONS.SwimIdle
					local swimIdStr = "rbxassetid://" .. tostring(targetSwimAnimId)
					if isSwimmingMoving then
						if swimIdleAnimTrack then swimIdleAnimTrack:Stop(0.2) swimIdleAnimTrack = nil end
					else
						if swimAnimTrack then swimAnimTrack:Stop(0.2) swimAnimTrack = nil end
					end
					local activeTrack = isSwimmingMoving and swimAnimTrack or swimIdleAnimTrack
					if not activeTrack or activeTrack.Animation.AnimationId ~= swimIdStr then
						if activeTrack then activeTrack:Stop(0.1) end
						local anim = Instance.new("Animation")
						anim.AnimationId = swimIdStr
						activeTrack = humanoid:LoadAnimation(anim)
						activeTrack.Priority = Enum.AnimationPriority.Action
						activeTrack.Looped = true
						activeTrack:Play(0.2)
						if isSwimmingMoving then swimAnimTrack = activeTrack else swimIdleAnimTrack = activeTrack end
					elseif not activeTrack.IsPlaying then
						activeTrack:Play(0.2)
					end
					if isSwimmingMoving then
						local targetSwimSpeed = isWalkSpeedActive and walkSpeed or 35
						local moveDir = humanoid.MoveDirection
						local serverLimit = (targetSwimSpeed > 50) and 21.5 or 17.8
						local boost = math.max(0, targetSwimSpeed - serverLimit)
						humanoid.WalkSpeed = serverLimit + (math.random(-5, 5) / 20)
						hrp.CFrame = hrp.CFrame + (moveDir * boost * deltaTime)
						hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * serverLimit, hrp.AssemblyLinearVelocity.Y, moveDir.Z * serverLimit)
					end
				else
					if swimAnimTrack then swimAnimTrack:Stop(0.2) swimAnimTrack = nil end
					if swimIdleAnimTrack then swimIdleAnimTrack:Stop(0.2) swimIdleAnimTrack = nil end
				end
				if isClimbing then
					local climbIdStr = "rbxassetid://" .. tostring(ANIMATIONS.Climb)
					if not climbAnimTrack or climbAnimTrack.Animation.AnimationId ~= climbIdStr then
						if climbAnimTrack then climbAnimTrack:Stop(0.1) end
						local anim = Instance.new("Animation")
						anim.AnimationId = climbIdStr
						climbAnimTrack = humanoid:LoadAnimation(anim)
						climbAnimTrack.Priority = Enum.AnimationPriority.Action
						climbAnimTrack.Looped = true
						climbAnimTrack:Play(0.2)
					elseif not climbAnimTrack.IsPlaying then
						climbAnimTrack:Play(0.2)
					end
					local verticalVel = math.abs(hrp.AssemblyLinearVelocity.Y)
					climbAnimTrack:AdjustSpeed(verticalVel > 0.1 and (verticalVel / 5) or 0)
				else
					if climbAnimTrack then climbAnimTrack:Stop(0.2) climbAnimTrack = nil end
				end
				
				if not isHoldingTool then
					if not isCrouching then
						for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
							local anim = track.Animation
							local animId = anim and anim.AnimationId or " "
							local numId = tostring(animId):match("%d+")
							local name = track.Name:lower()
							local isStateAnim = (isClimbing and (name:find("climb") or numId == tostring(ANIMATIONS.Climb))) or
								(isSwimming and (name:find("swim") or numId == tostring(ANIMATIONS.Swim) or numId == tostring(ANIMATIONS.SwimIdle))) or
								(isSeated and (track == sitAnimTrack or name:find("sit") or name:find("seat")))
							if not isStateAnim and ((numId and managedAnimationIds[numId]) or name:find("idle")) then
								track:Stop(0.1)
							end
						end
						return
					end
				end
			end
			if isExternal then
				if currentAnimTrack and managedAnimationIds[currentAnimTrack.Animation.AnimationId:match("%d+") or " "] then
					currentAnimTrack:Stop(0.3)
					currentAnimTrack = nil
				end
			end
			if sitAnimTrack then sitAnimTrack:Stop(0.2) sitAnimTrack = nil end
			if swimAnimTrack then swimAnimTrack:Stop(0.2) swimAnimTrack = nil end
			if swimIdleAnimTrack then swimIdleAnimTrack:Stop(0.2) swimIdleAnimTrack = nil end
			if climbAnimTrack then climbAnimTrack:Stop(0.2) climbAnimTrack = nil end
		end
		if isFlying then return end
		if humanoid and hrp then
			local animate = character:FindFirstChild("Animate")

			if isBatteryDepleted then
				-- Detener cualquier otra animación personalizada que se esté ejecutando
				if currentAnimTrack then currentAnimTrack:Stop(0.1); currentAnimTrack = nil end
				stopSprintAnimation()
				if walkAnimTrack then walkAnimTrack:Stop(0.1); walkAnimTrack = nil end
				if hurtOverlayTrack then hurtOverlayTrack:Stop(0.1); hurtOverlayTrack = nil end
				
				-- Control de velocidad en estado agotado
				if isWalkSpeedActive then
					-- Si "Correr" está activo, ajusta la velocidad
					walkSpeed = walkSpeed + (targetWalkSpeed - walkSpeed) * walkSpeedLerpFactor
					humanoid.WalkSpeed = walkSpeed
				else
					humanoid.WalkSpeed = 8 -- Velocidad base de agotamiento
				end

				if isMoving then
					-- El personaje se está moviendo
					if exhaustedIdleTrack and exhaustedIdleTrack.IsPlaying then exhaustedIdleTrack:Stop(0.2) end
					
					if not exhaustedWalkTrack then
						local anim = Instance.new("Animation")
						anim.AnimationId = "rbxassetid://" .. exhaustedWalkAnimId
						exhaustedWalkTrack = humanoid:LoadAnimation(anim)
						exhaustedWalkTrack.Looped = true
						exhaustedWalkTrack.Priority = Enum.AnimationPriority.Action
					end

					if not exhaustedWalkTrack.IsPlaying then
						exhaustedWalkTrack:Play(0.2)
					end
				else
					-- El personaje está quieto
					if exhaustedWalkTrack and exhaustedWalkTrack.IsPlaying then exhaustedWalkTrack:Stop(0.2) end

					if not exhaustedIdleTrack then
						local anim = Instance.new("Animation")
						anim.AnimationId = "rbxassetid://" .. exhaustedIdleAnimId
						exhaustedIdleTrack = humanoid:LoadAnimation(anim)
						exhaustedIdleTrack.Looped = true
						exhaustedIdleTrack.Priority = Enum.AnimationPriority.Action
					end

					if not exhaustedIdleTrack.IsPlaying then
						exhaustedIdleTrack:Play(0.2)
					end
				end
				return
			end
			local equippedTool = character:FindFirstChildOfClass("Tool")
			local isHoldingTool = equippedTool ~= nil or false

			-- Añadimos una comprobación más robusta para items que no son "Tool".
			if not isHoldingTool then
				local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
				if rightHand then
					for _, child in ipairs(rightHand:GetChildren()) do
						if child:IsA("Weld") or child:IsA("WeldConstraint") then
							local otherPart = (child.Part0 == rightHand and child.Part1) or (child.Part1 == rightHand and child.Part0)
							if otherPart and not otherPart:IsDescendantOf(character) then
								isHoldingTool = true
								break
							end
						end
					end
				end
			end

			if not isR6 and animate and not animate.Disabled and not isCrouching then
				animate.Disabled = true
			end
			if isR6 and not isFlying then
				local currentState = humanoid:GetState()
				local isJumpingState = (currentState == Enum.HumanoidStateType.Jumping)
				local velY = hrp.AssemblyLinearVelocity.Y
				
				local inAir = false
				if humanoid.FloorMaterial == Enum.Material.Air then
					if isJumpingState or velY > 2 then
						inAir = true
					elseif currentState == Enum.HumanoidStateType.Freefall and velY < -8 then
						inAir = true
					else
						inAir = false 
					end
				end
				
				if inAir then
					local jumpId = 97171309
					local fallId = 97170520
					
					if not jumpAnimTrack then
						local anim = Instance.new("Animation")
						anim.AnimationId = "rbxassetid://" .. jumpId
						jumpAnimTrack = humanoid:LoadAnimation(anim)
						jumpAnimTrack.Looped = false
						jumpAnimTrack.Priority = Enum.AnimationPriority.Action4
					end
					if not fallAnimTrack then
						local anim = Instance.new("Animation")
						anim.AnimationId = "rbxassetid://" .. fallId
						fallAnimTrack = humanoid:LoadAnimation(anim)
						fallAnimTrack.Looped = true
						fallAnimTrack.Priority = Enum.AnimationPriority.Action4
					end
					
					if velY > 0 then
						if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0) end
						if jumpAnimTrack and not jumpAnimTrack.IsPlaying and jumpAnimTrack.TimePosition == 0 then
							jumpAnimTrack:Play(0)
						end
					else
						if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0) end
						if fallAnimTrack and not fallAnimTrack.IsPlaying then 
							fallAnimTrack:Play(0)
						end
					end
				else
					if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0) end
					if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0) end
				end
				
				if isMoving then
					lastWalkStationaryPos = nil
					if walkPos then walkPos.MaxForce = Vector3.new(0, 0, 0) end
					if isWalkSpeedActive then
						local moveDir = humanoid.MoveDirection
						local boost = math.max(0, walkSpeed - humanoid.WalkSpeed)
						local jitter = (walkSpeed > 100) and 0.04 or 0.01
						hrp.CFrame = hrp.CFrame + (moveDir * (boost + (math.random(-1, 1) * jitter)) * deltaTime)
						hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * originalWalkSpeed, hrp.AssemblyLinearVelocity.Y, moveDir.Z * originalWalkSpeed)
					else
						humanoid.WalkSpeed = originalWalkSpeed
					end
				else
					if not lastWalkStationaryPos and hrp then lastWalkStationaryPos = hrp.Position end
					if walkPos and lastWalkStationaryPos and (humanoid.FloorMaterial ~= Enum.Material.Air) then
						if (hrp.Position - lastWalkStationaryPos).Magnitude > 50 then
							lastWalkStationaryPos = hrp.Position
							walkPos.MaxForce = Vector3.new(0,0,0)
						else
						end
					elseif walkPos then
						walkPos.MaxForce = Vector3.new(0,0,0)
					end
				end
				return
			end
			if currentEmoteSound then currentEmoteSound.Volume = (isMoving) and 0 or 1 end
			local currentState = humanoid:GetState()
			local isJumpingState = (currentState == Enum.HumanoidStateType.Jumping)
			local velY = hrp.AssemblyLinearVelocity.Y
			
			-- Detección de caída usando estados (evita animación en escaleras)
			local inAir = false
			if humanoid.FloorMaterial == Enum.Material.Air then
				if isJumpingState or currentState == Enum.HumanoidStateType.Freefall then
					inAir = true
				else
					inAir = false
				end
			end
			
			if humanoid:GetState() == Enum.HumanoidStateType.Landed then
				if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1) end
				if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1) end
				if isSuperJumpActive then isSuperJumpActive = false end
			end

			if not inAir and jumpAnimTrack then jumpAnimTrack.TimePosition = 0 end
			if isMoving then
				if hurtOverlayTrack then hurtOverlayTrack:Stop(0.4) hurtOverlayTrack = nil end
			end
			local currentActiveId = currentAnimTrack and currentAnimTrack.Animation.AnimationId:match("%d+")
			if currentActiveId and managedAnimationIds[currentActiveId] and currentActiveId ~= string.format("%.0f", idleAnimId) and currentActiveId ~= string.format("%.0f", hurtAnimId) then
				isEmotePlaying = true
			end
			if isEmotePlaying and moveMag > 0.5 then stopAnimation() isEmotePlaying = false end

			if not inAir and not isSeated and not isClimbing and not isSwimming and not isExternal then
				if isMoving and humanoid.MoveDirection.Magnitude > 0 then
					lastWalkStationaryPos = nil
					if walkPos then walkPos.MaxForce = Vector3.new(0, 0, 0) end
					local moveDir = humanoid.MoveDirection
					local currentY = hrp.AssemblyLinearVelocity.Y
					local finalSpeed = originalWalkSpeed
					if isWalkSpeedActive then finalSpeed = walkSpeed end
					local targetVel = moveDir * finalSpeed
					local lerpWeight = isWalkSpeedActive and 0.12 or 0.25
					currentImpulseVelocity = currentImpulseVelocity:Lerp(targetVel, lerpWeight)
					if isWalkSpeedActive then
						humanoid.WalkSpeed = originalWalkSpeed
						local boost = finalSpeed - originalWalkSpeed
						local jitterIntensity = (finalSpeed > 100) and 0.04 or 0.01
						local moveStep = (moveDir * (boost + (math.random(-1, 1) * jitterIntensity)) * deltaTime)
						hrp.CFrame = hrp.CFrame + moveStep
						hrp.AssemblyLinearVelocity = Vector3.new(moveDir.X * originalWalkSpeed, hrp.AssemblyLinearVelocity.Y, moveDir.Z * originalWalkSpeed)
					else
						humanoid.WalkSpeed = finalSpeed
						hrp.AssemblyLinearVelocity = Vector3.new(currentImpulseVelocity.X, currentY, currentImpulseVelocity.Z)
					end
					if isInvisibilityActive and invisibilitySeat then invisibilitySeat.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity end
				else
					currentImpulseVelocity = currentImpulseVelocity:Lerp(Vector3.new(0,0,0), 0.15)
					if (isJumpingState or inAir) and walkPos then
						walkPos.MaxForce = Vector3.new(0, 0, 0)
						walkPos.Position = hrp.Position
					end
					if not lastWalkStationaryPos and hrp then lastWalkStationaryPos = hrp.Position end
					if not walkPos and hrp then
						walkPos = Instance.new("BodyPosition")
						walkPos.Name = "WalkAnchor"
						walkPos.MaxForce = Vector3.new(0, 0, 0)
						walkPos.D = 500
						walkPos.P = 10000
						walkPos.Parent = hrp
					end
					
					if not isWalkSpeedActive then
						humanoid.WalkSpeed = originalWalkSpeed
					end
					
					if walkPos and lastWalkStationaryPos and not isJumpingState and not inAir and not isExternal then
						if (hrp.Position - lastWalkStationaryPos).Magnitude > 50 then
							lastWalkStationaryPos = hrp.Position
							walkPos.MaxForce = Vector3.new(0,0,0)
						else
							walkPos.Position = lastWalkStationaryPos
							walkPos.MaxForce = Vector3.new(40000, 0, 40000)
						end
					elseif walkPos and (isJumpingState or inAir or isExternal) then
						walkPos.MaxForce = Vector3.new(0, 0, 0)
					end
					if isInvisibilityActive and invisibilitySeat then invisibilitySeat.AssemblyLinearVelocity = Vector3.zero end
				end
			end

			local canPlayWalk = not isCrouching and not isSprintActive and not isMirageSpeedActive and not isEmotePlaying and not inAir
			local canSprint = isSprintActive and not isCrouching and not isMirageSpeedActive and not isEmotePlaying and not inAir
			if (isClimbing or isSwimming) and not isEmotePlaying then
				if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.2) end
				stopSprintAnimation()
				if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.2) end
				if jumpAnimTrack then jumpAnimTrack:Stop(0.2) end
				if fallAnimTrack then fallAnimTrack:Stop(0.2) end
			elseif isSeated then
				stopSprintAnimation()
				if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.1) end
				if jumpAnimTrack then jumpAnimTrack:Stop(0.1) end
				if fallAnimTrack then fallAnimTrack:Stop(0.1) end
			elseif inAir and not isExternal and not SuperStrength.GrabbedData then
				lastWalkStationaryPos = nil
				if isEmotePlaying then
					if math.abs(velY) > 20 or moveMag > 0.5 then
						stopAnimation()
						isEmotePlaying = false
					else
						return
					end
				end
				if isBatteryDepleted then
					playAnimation(exhaustedFlyAnimId, 0, 1, true)
					return
				end

				if isWalkSpeedActive and isMoving then
					local moveDir = humanoid.MoveDirection
					local targetVel = Vector3.new(moveDir.X * walkSpeed, hrp.AssemblyLinearVelocity.Y, moveDir.Z * walkSpeed)
					hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity:Lerp(targetVel, 0.12)
				end
				if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.2) currentAnimTrack = nil end
				stopSprintAnimation()
				if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.2) end
				
				if not jumpAnimTrack then
					local anim = Instance.new("Animation")
					anim.AnimationId = "rbxassetid://" .. ANIMATIONS.Jump
					jumpAnimTrack = humanoid:LoadAnimation(anim)
					jumpAnimTrack.Looped = false 
					jumpAnimTrack.Priority = Enum.AnimationPriority.Action4
				end
				if not fallAnimTrack then
					local anim = Instance.new("Animation")
					anim.AnimationId = "rbxassetid://" .. ANIMATIONS.Fall
					fallAnimTrack = humanoid:LoadAnimation(anim)
					fallAnimTrack.Looped = true 
					fallAnimTrack.Priority = Enum.AnimationPriority.Action4
				end

				-- Usar estados para animación
				if currentState == Enum.HumanoidStateType.Jumping then
					if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1) end
					if jumpAnimTrack and not jumpAnimTrack.IsPlaying then
						jumpAnimTrack:Play(0.1)
					end
				elseif currentState == Enum.HumanoidStateType.Freefall then
					if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1) end
					if fallAnimTrack and not fallAnimTrack.IsPlaying then
						fallAnimTrack:Play(0.1)
					end
				else
					if velY > 0 then
						if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1) end
						if jumpAnimTrack and not jumpAnimTrack.IsPlaying and jumpAnimTrack.TimePosition == 0 then
							jumpAnimTrack:Play(0.1)
						end
					else
						if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1) end
						if fallAnimTrack and not fallAnimTrack.IsPlaying then fallAnimTrack:Play(0.1) end
					end
				end
			elseif isMoving and canSprint then
				if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.2) currentAnimTrack = nil end
				playSprintAnimation()
				if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.2) end
				if jumpAnimTrack then jumpAnimTrack:Stop(0.2) end
				if fallAnimTrack then fallAnimTrack:Stop(0.2) end
			elseif isMoving and canPlayWalk then
				if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.1) currentAnimTrack = nil end
				stopSprintAnimation()
				if jumpAnimTrack then jumpAnimTrack:Stop(0.2) end
				if fallAnimTrack then fallAnimTrack:Stop(0.2) end
				local currentSpeed = isWalkSpeedActive and walkSpeed or humanoid.WalkSpeed
				local effectiveSpeed = isWalkSpeedActive and walkSpeed or originalWalkSpeed
				local animIdToUse = ANIMATIONS.Walk
				if hurtState > 0 then
					animIdToUse = hurtWalkAnimId
					humanoid.WalkSpeed = 10
				elseif effectiveSpeed >= 50 then
					animIdToUse = 77128372412361
				elseif effectiveSpeed >= 21 then
					animIdToUse = "129768396663808"
				elseif effectiveSpeed > 16 then
					animIdToUse = "117251315086498"
				else animIdToUse = ANIMATIONS.Walk end
				local animIdStr = "rbxassetid://" .. animIdToUse
				if not walkAnimTrack or walkAnimTrack.Animation.AnimationId ~= animIdStr then
					if walkAnimTrack then walkAnimTrack:Stop() end
					walkAnimTrack = animationTracks[animIdToUse] or (function()
						local a = Instance.new("Animation") a.AnimationId = animIdStr
						local t = humanoid:LoadAnimation(a)
						if animIdToUse == 83860986564910 then
							t.Priority = Enum.AnimationPriority.Action2
						elseif animIdToUse == 78510387198062 then
							t.Priority = Enum.AnimationPriority.Action2
						else
							-- Aumentamos la prioridad para que anule las animaciones de caminar por defecto del juego al sostener un item.
							t.Priority = Enum.AnimationPriority.Action
						end
						t.Looped = true
						animationTracks[animIdToUse] = t return t
					end)()
					walkAnimTrack:Play(0.05)
				elseif not walkAnimTrack.IsPlaying then
					walkAnimTrack:Play(0.05)
				end
				local animSpeedMultiplier = 1
				local baseSpeedForAnim = originalWalkSpeed -- Velocidad base para caminar (11)
				local boostFactor = 1.0 -- Multiplicador de velocidad base
				local currentAnimId = tostring(animIdToUse)
				
				if currentAnimId == tostring(hurtWalkAnimId) then
					animSpeedMultiplier = 2.5
				else
					if currentAnimId == tostring(ANIMATIONS.Walk) then
						-- Aumenta la velocidad de la animación de caminar.
						boostFactor = 1.0
						baseSpeedForAnim = originalWalkSpeed
					elseif currentAnimId == "117251315086498" then
						-- Aumenta la velocidad de la primera animación de correr.
						boostFactor = 1.9
						baseSpeedForAnim = 17
					elseif currentAnimId == "129768396663808" then
						-- Aumenta la velocidad de la animación de correr final.
						boostFactor = 1.2
						baseSpeedForAnim = 21
					elseif currentAnimId == "77128372412361" then
						boostFactor = 1.3
						baseSpeedForAnim = 50
					end
					if effectiveSpeed > 0 and baseSpeedForAnim > 0 then
						animSpeedMultiplier = (effectiveSpeed / baseSpeedForAnim) * boostFactor
					end
				end
				
				-- Detectar si el personaje se mueve hacia atrás
				local lookVector = hrp.CFrame.LookVector
				local moveVector = humanoid.MoveDirection
				if lookVector:Dot(moveVector) < -0.1 then
					animSpeedMultiplier = -animSpeedMultiplier -- Reproducir la animación en reversa
				end
				walkAnimTrack:AdjustSpeed(math.clamp(animSpeedMultiplier, -10, 10))
			else
				stopSprintAnimation()
				if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.1) end
				if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1) end
				if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1) end

				if hurtState > 0 and not isEmotePlaying and not isCrouching then
					local hurtIdStr
					if hurtState == 2 then
						hurtIdStr = "rbxassetid://128406664848479"
					else
						hurtIdStr = "rbxassetid://140704739422954"
					end
					if not hurtOverlayTrack or hurtOverlayTrack.Animation.AnimationId ~= hurtIdStr then
						if hurtOverlayTrack then hurtOverlayTrack:Stop(0.1) end
						local anim = Instance.new("Animation")
						anim.AnimationId = hurtIdStr
						hurtOverlayTrack = humanoid:LoadAnimation(anim)
						hurtOverlayTrack.Priority = Enum.AnimationPriority.Action3
						hurtOverlayTrack.Looped = true
						hurtOverlayTrack:Play(0.2)
					elseif not hurtOverlayTrack.IsPlaying then
						hurtOverlayTrack:Play(0.2)
					end
				else
					if hurtOverlayTrack then hurtOverlayTrack:Stop(0.4) hurtOverlayTrack = nil end
					if not isEmotePlaying and not isCrouching and not isMirageSpeedActive and not isExternal then
						if isExternal then
							if currentAnimTrack and currentAnimTrack.Animation and currentAnimTrack.Animation.AnimationId == "rbxassetid://" .. idleAnimId then
								currentAnimTrack:Stop(0.3)
								currentAnimTrack = nil
							end
						elseif not (currentAnimTrack and currentAnimTrack.IsPlaying and currentAnimTrack.Animation and currentAnimTrack.Animation.AnimationId == "rbxassetid://" .. idleAnimId) then
							playAnimation(idleAnimId, 0, 1, true)
							-- La prioridad se establece en 'Action' dentro de playAnimation, lo que es suficiente
							-- para anular la animación de inactividad por defecto. Al no ejecutarse con un item,
							-- permite que la animación del item se muestre.
						end
					end
				end
			end
			for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
				if track.Animation then
					local animId = track.Animation.AnimationId
					if LOOP_ANIMATION_IDS[animId] and not track.Looped then track.Looped = true end
					if animId == "rbxassetid://16738340646" then track:AdjustSpeed(1) end
				end
			end
		end
	end)
	table.insert(allConnections, conn)
end

-- LOOP DE LOCK-ON
local lockOnConn = nil
lockOnConn = RunService.RenderStepped:Connect(function()
	if scriptActive and lockedPlayer then
		if lockedPlayer.Parent and lockedPlayer.Character and lockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local targetHrp = lockedPlayer.Character.HumanoidRootPart
			local hum = lockedPlayer.Character:FindFirstChild("Humanoid")
			if hum and hum.Health > 0 then
				local targetPos = targetHrp.Position
				camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPos)
			else
				lockedPlayer = nil
			end
		else
			lockedPlayer = nil
		end
	end
end)

player.CharacterAdded:Connect(function(newChar)
	if not scriptActive then return end
	cleanupEverything(false)
	if not lockOnConn or not lockOnConn.Connected then
		lockOnConn = RunService.RenderStepped:Connect(function()
			if scriptActive and lockedPlayer then
				if lockedPlayer.Parent and lockedPlayer.Character and lockedPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local targetHrp = lockedPlayer.Character.HumanoidRootPart
					local hum = lockedPlayer.Character:FindFirstChild("Humanoid")
					if hum and hum.Health > 0 then
						local targetPos = targetHrp.Position
						camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPos)
					else
						lockedPlayer = nil
					end
				else
					lockedPlayer = nil
				end
			end
		end)
	end
	character = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	isR6 = (humanoid.RigType == Enum.HumanoidRigType.R6)
	humanoid.WalkSpeed = originalWalkSpeed
	hrp = newChar:FindFirstChild("HumanoidRootPart")
	scriptActive = true
	hideIdentity()
	local reloadSuccess = loadAnimations()
	startMainAnimationLoop()
	startReplicationLoop()
	startBatteryLoop()
	if reloadSuccess then
		task.wait(0.2)
		if isSuperJumpActive then startSuperJump() end
		if SuperHearing.Active then startSuperHearing() end
		if isMirageSpeedActive then playMirageSpeedEmote() end
		if isInvisibilityActive then toggleInvisibility() end		
		if XRayVision.Active then toggleXRayVision() end
		if isFlying then startFlight() end
		if noSitActive and humanoid then pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end) end
	end
end)

if not isAbilityAvailable(abilities[currentAbilityIndex].key) then currentAbilityIndex = 1 end
if isR6 and (currentMode == MODES.EMOTES or (currentMode == MODES.SETTINGS and settingOptions[currentSettingIndex]:find("VUELO RAPIDO"))) then currentMode = MODES.ABILITIES end
if (not isR6 and settingOptions[currentSettingIndex]:find("R6 FLY")) or (isR6 and settingOptions[currentSettingIndex]:find("VUELO RAPIDO")) then currentSettingIndex = 1 end
updateMainUI()

-- INICIALIZACIÓN
disableGameAntiCheats()
createUI()
setupGestures()
forceInitialLoad()
startMainAnimationLoop()
startReplicationLoop()
startBatteryLoop()
startAntiFling()
