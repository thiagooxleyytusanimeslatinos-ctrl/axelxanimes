local Players=game:GetService("\x50\x6c\x61\x79\x65\x72\x73")
local UserInputService=game:GetService("\x55\x73\x65\x72\x49\x6e\x70\x75\x74\x53\x65\x72\x76\x69\x63\x65")
local Lighting=game:GetService("\x4c\x69\x67\x68\x74\x69\x6e\x67")
local RunService=game:GetService("\x52\x75\x6e\x53\x65\x72\x76\x69\x63\x65")
local Workspace=game:GetService("\x57\x6f\x72\x6b\x73\x70\x61\x63\x65")
local CoreGui=game:GetService("\x43\x6f\x72\x65\x47\x75\x69")
local TweenService=game:GetService("\x54\x77\x65\x65\x6e\x53\x65\x72\x76\x69\x63\x65")
var _dead=function(_a,_b){return _a===_b;};
local SoundService=game:GetService("\x53\x6f\x75\x6e\x64\x53\x65\x72\x76\x69\x63\x65")
local VirtualUser=game:GetService("\x56\x69\x72\x74\x75\x61\x6c\x55\x73\x65\x72")
local player=Players.LocalPlayer
local character=player.Character or player.CharacterAdded:Wait()
local humanoid=character:WaitForChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
local hrp=character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")
if(false){var _nop=function(_x){return _x;};}
local mouse=player:GetMouse()
local camera=Workspace.CurrentCamera
local allConnections={}
local persistentConnections={}
local originalGravity=(Workspace.Gravity>0)and Workspace.Gravity or 196.2
local antiGravityForce=nil
var _dead=function(_a,_b){return _a===_b;};
local lockedPlayer=nil
local isR6=(humanoid.RigType==Enum.HumanoidRigType.R6)
local R6_FLIGHT_ANIMS={
Idle=0x5CABA25,Idle2=0x14A186A,Forward=0x2C0E655,Fast=0x10D7BE68,
Back=0x2EB06DC,Up=0x56A9ADB,Down=0xDE839A4
}
if(false){var _nop=function(_x){return _x;};}
--FLIGHT VARIABLES
local isFlying=false
local r6FlightIdleMode=1
local fastFlightMode=1
local flightSpeedValue=0x10
local flightIdleAnim="\x31\x31\x39\x39\x34\x33\x35\x37\x34\x32\x36\x38\x36\x31\x34"
var _dead=function(_a,_b){return _a===_b;};
local flightForwardAnim="\x31\x30\x30\x37\x38\x33\x36\x36\x36\x32\x37\x35\x38\x39\x32"
local flightFastAnim="\x38\x38\x39\x34\x39\x37\x36\x33\x36\x30\x38\x38\x30\x37"
local flightMidSpeedAnim="\x31\x33\x33\x34\x37\x39\x30\x33\x30\x34\x38\x33\x35\x32\x30"
local flightSlowAnim="\x31\x32\x31\x36\x35\x32\x34\x36\x38\x32\x39\x38\x33\x37\x37"
local flightBackwardAnim="\x37\x38\x36\x38\x34\x33\x33\x37\x39\x32\x37\x30\x35\x32"
local currentFlightAnimTrack=nil
if(false){var _nop=function(_x){return _x;};}
local currentAnimTrack=nil
local currentEmoteSound=nil
local flyGyro=nil
local flyVelocity=nil
local flightMoveState={forward=0,backward=0,left=0,right=0,up=0,down=0}
local flightConns={}
var _dead=function(_a,_b){return _a===_b;};
local r6FlightTracks={}
local r6ForwardHold=0
local currentFlightCF=nil
local flightCurrentRoll=0
local flightEmoteActive=false
local lastStationaryPos=nil
if(false){var _nop=function(_x){return _x;};}
local flightStaticRotation=true
local flightRegenEnabled=false
local currentImpulseVelocity=Vector3.new(0,0,0)
local walkPos=nil
local lastWalkStationaryPos=nil
local FLIGHT_EMOTES=isR6 and{0x3F9D252,0x33FCE6A}or{
var _dead=function(_a,_b){return _a===_b;};
0x64767022B5C5,0x5D552BD7CFA8,0x5F631E9F12AB,0x6B94E9BBF061,0x6DCAE411E203,
0x711D132CE946,0x511A6D67297E,0x792FAF32AC47,0x419AACFE0B52,
0x7BF237091FC6,0x682976352AA9,0x461F3AFAD505,0x739CD45299C5,
0x51F613EDDFB5
}
local currentFlightEmoteIndex=1
if(false){var _nop=function(_x){return _x;};}
--ANIMACIONES
local ANIMATIONS={
Idle=0x7AFEE71E5E98,Walk=0x3E5AECF26,Run=0x403E4ABF07CD,
Jump=0x5EE21D2FB34E,Fall=0x3E5AEB1F3,Climb=0x28AF52A40,
Swim=0x28AF4F1A8,SwimIdle=0x28AF54A22,Sit=0x9562D2E7
}
var _dead=function(_a,_b){return _a===_b;};
local idleAnimId=0x7AFEE71E5E98
local hurtAnimId=0x7FF86002F2EA
local exhaustedIdleAnimId="\x37\x38\x33\x32\x38\x32\x38\x32\x32\x39\x38\x39\x35\x33"
local exhaustedWalkAnimId="\x39\x39\x34\x39\x38\x33\x30\x39\x37\x39\x36\x35\x38\x30"
local exhaustedFlyAnimId="\x31\x32\x32\x38\x31\x30\x39\x38\x34\x38\x34\x37\x32\x33\x35"
local hurtWalkAnimId="\x31\x33\x38\x35\x36\x32\x36\x36\x32\x30\x30\x34\x31\x30\x39"
if(false){var _nop=function(_x){return _x;};}
local managedAnimationIds={}
local LOOP_ANIMATION_IDS={}
local selectableAnimations
do
local function _0x0000(id)
var _dead=function(_a,_b){return _a===_b;};
if not id then return end
local numId=typeof(id)=="\x6e\x75\x6d\x62\x65\x72" and string.format("\x25\x2e\x30\x66",id)or tostring(id):match("\x25\x64\x2b")
if numId then managedAnimationIds[numId]=true end
end
for _,id in pairs(ANIMATIONS)do
if(false){var _nop=function(_x){return _x;};}
LOOP_ANIMATION_IDS["\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. id]=true
_0x0000(id)
end
local extraIds={flightIdleAnim,"\x39\x33\x30\x33\x32\x30\x35\x31\x36\x34\x36\x39\x36\x35",flightForwardAnim,flightFastAnim,flightSlowAnim,flightBackwardAnim,"\x31\x33\x38\x39\x39\x32\x30\x39\x36\x34\x37\x36\x38\x33\x36","\x38\x34\x30\x34\x33\x36\x36\x30\x34\x32\x31\x37\x38\x35","\x39\x36\x37\x33\x31\x32\x38\x39\x32\x36\x37\x36\x34\x30","\x31\x31\x31\x36\x39\x30\x39\x36\x33\x35\x38\x38\x34\x39\x36","\x31\x32\x38\x34\x30\x36\x36\x36\x34\x38\x34\x38\x34\x37\x39","\x31\x34\x30\x37\x30\x34\x37\x33\x39\x34\x32\x32\x39\x35\x34","\x38\x33\x38\x36\x30\x39\x38\x36\x35\x36\x34\x39\x31\x30","\x31\x30\x33\x31\x34\x35\x35\x39\x33\x36\x39\x30\x32\x38\x35","\x31\x32\x38\x35\x37\x38\x37\x38\x35\x36\x31\x30\x30\x35\x32","\x37\x37\x31\x32\x38\x33\x37\x32\x34\x31\x32\x33\x36\x31","\x37\x32\x33\x30\x31\x35\x39\x39\x34\x34\x31\x36\x38\x30","\x38\x37\x30\x38\x38\x32\x31\x38\x34\x39\x30\x39\x31\x38","\x31\x30\x34\x36\x38\x37\x30\x36\x39\x34\x36\x31\x36\x39\x33","\x31\x34\x32\x34\x39\x35\x32\x35\x35","\x32\x34\x38\x33\x33\x36\x32\x39\x34","\x35\x34\x35\x31\x33\x32\x35\x38","\x39\x35\x34\x32\x34\x30\x37\x37","\x39\x37\x31\x37\x30\x35\x32\x30","\x39\x37\x31\x37\x32\x30\x30\x35","\x32\x31\x36\x33\x33\x31\x33\x30","\x34\x38\x39\x35\x37\x31\x34\x38","\x35\x36\x31\x34\x36\x34\x30\x39","\x36\x36\x37\x30\x33\x39\x35\x34","\x37\x33\x30\x33\x33\x36\x33\x33","\x39\x37\x31\x37\x31\x33\x30\x39","\x31\x33\x33\x34\x37\x39\x30\x33\x30\x34\x38\x33\x35\x32\x30","\x31\x31\x37\x32\x35\x31\x33\x31\x35\x30\x38\x36\x34\x39\x38","\x31\x32\x39\x37\x36\x38\x33\x39\x36\x36\x36\x33\x38\x30\x38",
exhaustedIdleAnimId,exhaustedWalkAnimId,exhaustedFlyAnimId,hurtWalkAnimId
}
var _dead=function(_a,_b){return _a===_b;};
for _,id in ipairs(extraIds)do
LOOP_ANIMATION_IDS["\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. id]=true
_0x0000(id)
end
_0x0000(idleAnimId)
selectableAnimations=isR6 and{0x45A67A1,0x7ACFEF5,0x7AE256D,0x7B6D71B}or{
if(false){var _nop=function(_x){return _x;};}
0x6B11557822FF,0x70F5CC0C2C7E,0x671D662A45C0,0x4C2F52193A66,--Emotes 1-4
0x7952570B34AA,0x7DCC3C8AB1AB,0x732EC6A5DE38,0x58E77C823AE8,--Emotes 5-8
0x6D346B44FCA8,0x56DA104D5FE8,0x5D04BE6B9DCF,0x7C510BD6385D,--Emotes 9-0xC
0x6609CF0715E5,0x53204C373285,0x5D2B1746DDFA,0x552DF86A307C,--Emotes 0xD-0x10
0x6F80EA666839,--Emote 0x11
--Emotes agregados
var _dead=function(_a,_b){return _a===_b;};
0x4B33179976B4,0x544CFEF42C79,0x5F365B967CBD,0x5F7EEBFF5103,
0x60E06A3F434C,0x45462BB1C4F6,0x756E185EF841,0x60C3D339F9E8,
0x79DA879DEE90,0x48F6490B7F64,0x40147F0F4721,0x78F45A60825F,
0x7669C5385431,0x7FB38CCFAB51,0x419359ABEB27,0x6CFA560511A8,
0x7438B43ABD35,0x75920140204F,0x767996476532,0x5AD5A706CB7C,
0x5C3B25D4DC34,0x4ACBA51858C6,0x7FD123D0BF6E,0x454841C2F570,
if(false){var _nop=function(_x){return _x;};}
0x7D66E25858FC,0x6B3DDD46C6CE,0x41C7F1192A93,0x4D016FFBDD62,
0x44518DA2F20C,0x6498F5C2EDD2,0x62DD84289F0C,0x77C196A9E1B5,
0x46E4EE3EC244
}
for _,id in ipairs(selectableAnimations)do _0x0000(id)end
for _,id in ipairs(FLIGHT_EMOTES)do _0x0000(id)end
var _dead=function(_a,_b){return _a===_b;};
local r6ExtraIds={0x56A9ADB,0x8276EAC,0x87E4E17,0x5CAAE7B,0x2C0E655,0x10D7BE68,0x65D3885,0x281F31A,0xCCCBD5C,0xDE839A4,0x5CAB76D,0xECD4FA6,0x33FCE6A,0x5B00E4D,0x5CAB458,0x5CABA25,0x14A186A}
for _,id in ipairs(r6ExtraIds)do _0x0000(id)end
end
local currentAnimationIndex=1
local muteEmotes=false
local noSitActive=false
if(false){var _nop=function(_x){return _x;};}
local MOVEMENT_AUDIO_VOLUME=0.7
local originalSoundProperties={}
local originalAmbientVolumes={}
local emoteMusicActive=false
local ambientSoundMuteThread=nil
--OTRAS HABILIDADES
var _dead=function(_a,_b){return _a===_b;};
local isWalkSpeedActive=false
local walkSpeed=0x10
local targetWalkSpeed=0x10
local walkSpeedLerpFactor=0.08
local maxWalkSpeed=0x1F4
local preFlightWalkSpeed=nil
if(false){var _nop=function(_x){return _x;};}
local preFlightIsSpeedActive=nil
local originalWalkSpeed=0xB
local originalJumpPower=0x32
local walkAnimTrack=nil
local hurtOverlayTrack=nil
local sitAnimTrack=nil
var _dead=function(_a,_b){return _a===_b;};
local swimAnimTrack=nil
local swimIdleAnimTrack=nil
local climbAnimTrack=nil
local jumpAnimTrack=nil
local fallAnimTrack=nil
local exhaustedIdleTrack=nil
if(false){var _nop=function(_x){return _x;};}
local exhaustedWalkTrack=nil
local isMirageSpeedActive=false
local mirageSpeedEmoteTrack=nil
local mirageSpeedValue=0xA
local minMirageSpeed=0.5
local maxMirageSpeed=0x1E
var _dead=function(_a,_b){return _a===_b;};
local mirageSpeedStep=9.5
local isSuperJumpActive=false
local superJumpPower=0x46
local isSuperSaltoCharged=false
local superSaltoChargeTime=0
local superSaltoTrack=nil
if(false){var _nop=function(_x){return _x;};}
local isGravJumpActive=false
local targetGravity=196.2
local SuperStrength={
Active=false,GrabbedData=nil,Distance=0x1F4,Connection=nil,
ThrowForce=0x3E7,AnimTrack=nil,LastActionTime=0,ActivationTime=0
}
var _dead=function(_a,_b){return _a===_b;};
local SuperHearing={
Active=false,Heartbeat=nil,PlayerHighlights={},NPCHighlights={},
Sound=nil,LastUpdate=0,PlayerCache={},NPCCache={},ActiveNPCs={},
Timer=nil,Blur=nil,ColorCorrection=nil,CleanupTimer=nil,
CachedNPCList={},ActiveNPCs={},LastNPCScanTime=0,Echo=nil,Reverb=nil
}
if(false){var _nop=function(_x){return _x;};}
local InstantReaction={
Active=false,LastDodge=0,Cooldown=0.3,DetectionRange=0x14,
Connection=nil,DodgeActive=false
}
local XRayVision={
Active=false,ColorCorrection=nil,Heartbeat=nil,
var _dead=function(_a,_b){return _a===_b;};
Highlights={},LastScanTime=0,CachedNPCList={},
CachedItemList={},TransparentParts={},LastTransparencyUpdateTime=0
}
local isInvisibilityActive=false
local invisibilitySeat=nil
local preInvisibilityCF=nil
if(false){var _nop=function(_x){return _x;};}
local antiFallConnections={}
local antiFallTeleporting=false
local antiFlingConnection=nil
local isSprintActive=false
local sprintAnimTrack=nil
local isCrouching=false
var _dead=function(_a,_b){return _a===_b;};
local lastStunTime=0
local customAnimationsLoaded=false
local animationTracks={}
--VIBRACIÓN MOLECULAR(NOCLIP)
local isMolecularVibrationActive=false
if(false){var _nop=function(_x){return _x;};}
local molecularVibrationConn=nil
local molecularVibrationOriginalCollisions={}
local molecularVibrationRequesters={mirage=false,speed=false}
local startMolecularVibration,stopMolecularVibration,updateMolecularVibrationState--forward declare
local toggleAbility=nil
var _dead=function(_a,_b){return _a===_b;};
local cleanupEverything=nil
local adjustSpeed=nil
local startMainAnimationLoop=nil
local playAnimation=nil
local loadAnimations=nil
--BATERÍA KRYPTONIANA
local battery=0x64
local maxBattery=0x64
local batteryUpdateConn=nil
local isBatteryDepleted=false
local batteryDepletedBlur=nil
var _dead=function(_a,_b){return _a===_b;};
local function _0x0001()
if not humanoid or not character then return false end
--Detección de "\x61\x67\x61\x72\x72\x65" o interacciones externas mediante soldaduras(Welds).
--Si el torso o la raíz del personaje está soldado a algo fuera del propio personaje,
--se considera una animación externa(como ser llevado por otro jugador).
if(false){var _nop=function(_x){return _x;};}
for _,descendant in ipairs(character:GetDescendants())do
if descendant:IsA("\x57\x65\x6c\x64")or descendant:IsA("\x57\x65\x6c\x64\x43\x6f\x6e\x73\x74\x72\x61\x69\x6e\x74")then
local p0=descendant.Part0
local p1=descendant.Part1
if p0 and p1 then
local p0_in_char=p0:IsDescendantOf(character)
var _dead=function(_a,_b){return _a===_b;};
local p1_in_char=p1:IsDescendantOf(character)
if(p0_in_char and not p1_in_char)or(p1_in_char and not p0_in_char)then
local our_part=p0_in_char and p0 or p1
if our_part.Name:find("\x54\x6f\x72\x73\x6f")or our_part.Name:find("\x52\x6f\x6f\x74")then
return true--Es una interacción de agarre/llevar.
end
if(false){var _nop=function(_x){return _x;};}
end
end
end
end
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
local numId=track.Animation.AnimationId:match("\x25\x64\x2b")
var _dead=function(_a,_b){return _a===_b;};
local name=track.Name:lower()
local isBasic=name:find("\x77\x61\x6c\x6b")or name:find("\x72\x75\x6e")or name:find("\x69\x64\x6c\x65")or name:find("\x6a\x75\x6d\x70")or name:find("\x66\x61\x6c\x6c")or name:find("\x73\x74\x72\x61\x66\x65")or name:find("\x73\x77\x69\x6d\x6d\x69\x6e\x67")or name:find("\x6d\x6f\x76\x65\x6d\x65\x6e\x74")or name:find("\x64\x61\x73\x68")or name:find("\x73\x70\x72\x69\x6e\x74")or track.Looped
if track.IsPlaying and numId and not managedAnimationIds[numId]then
if not isBasic and(name:find("\x63\x75\x74\x73\x63\x65\x6e\x65")or name:find("\x73\x63\x65\x6e\x65")or name:find("\x65\x76\x65\x6e\x74")or name:find("\x65\x6c\x65\x76\x61\x74\x6f\x72")or name:find("\x69\x6e\x74\x72\x6f")or name:find("\x63\x69\x6e\x65\x6d\x61\x74\x69\x63")or name:find("\x73\x65\x61\x72\x63\x68")or name:find("\x6f\x70\x65\x6e")or track.Priority.Value>=Enum.AnimationPriority.Action3.Value)then
return true
end
if(false){var _nop=function(_x){return _x;};}
end
end
return false
end
local function _0x0002()
var _dead=function(_a,_b){return _a===_b;};
local center=camera.ViewportSize/2
local target=nil
local minDistance=0xFA
for _,p in ipairs(Players:GetPlayers())do
if p ~=player and p.Character and p.Character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")then
local hum=p.Character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
if(false){var _nop=function(_x){return _x;};}
if hum and hum.Health>0 then
local pos,onScreen=camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
if onScreen then
local dist=(Vector2.new(pos.X,pos.Y)-center).Magnitude
if dist<minDistance then
minDistance=dist
var _dead=function(_a,_b){return _a===_b;};
target=p
end
end
end
end
end
if(false){var _nop=function(_x){return _x;};}
return target
end
--============SUPER STRENGTH HELPERS============
local function _0x0003(part)
if not part or part:IsDescendantOf(character)or part:IsA("\x54\x65\x72\x72\x61\x69\x6e")then return false end
var _dead=function(_a,_b){return _a===_b;};
local rayParams=RaycastParams.new()
rayParams.FilterDescendantsInstances={character}
local groundCheck=Workspace:Raycast(hrp.Position,Vector3.new(0,-0xA,0),rayParams)
if groundCheck and(part==groundCheck.Instance or part:IsAncestorOf(groundCheck.Instance))then
return false
end
if(false){var _nop=function(_x){return _x;};}
local function _0x0004(targetPart)
local model=targetPart:FindFirstAncestorOfClass("\x4d\x6f\x64\x65\x6c")
if not model then return targetPart end
local vehicleParts={"\x4d\x61\x69\x6e\x50\x61\x72\x74","\x42\x6f\x64\x79","\x43\x68\x61\x73\x73\x69\x73","\x52\x6f\x6f\x74\x50\x61\x72\x74","\x50\x72\x69\x6d\x61\x72\x79\x50\x61\x72\x74","\x48\x61\x6e\x64\x6c\x65","\x56\x65\x68\x69\x63\x6c\x65\x53\x65\x61\x74","\x53\x65\x61\x74"}
for _,partName in ipairs(vehicleParts)do
var _dead=function(_a,_b){return _a===_b;};
local foundPart=model:FindFirstChild(partName,true)
if foundPart and foundPart:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")then return foundPart end
end
return model.PrimaryPart or targetPart
end
local model=part:FindFirstAncestorOfClass("\x4d\x6f\x64\x65\x6c")
local isVehicle=false
if model and(model:FindFirstChildWhichIsA("\x56\x65\x68\x69\x63\x6c\x65\x53\x65\x61\x74",true)or model:FindFirstChildWhichIsA("\x53\x65\x61\x74",true)or
model.Name:lower():find("\x63\x61\x72")or model.Name:lower():find("\x76\x65\x68\x69\x63")or model.Name:lower():find("\x63\x68\x61\x73\x73\x69\x73"))then
isVehicle=true
end
var _dead=function(_a,_b){return _a===_b;};
if isVehicle then
local mainPart=_0x0004(part)
--Para vehículos,permitimos el agarre incluso si están anclados,ya que la lógica de agarre los desanclará.
return true,mainPart or part,model,isVehicle
end
if(false){var _nop=function(_x){return _x;};}
if part.Anchored and part.Size.Magnitude>0x32 then return false end
local mainPart=_0x0004(part)
if mainPart and mainPart.Anchored then return false end
return true,mainPart or part,model,isVehicle
end
var _dead=function(_a,_b){return _a===_b;};
local function _0x0005(shouldThrow)
if not SuperStrength.GrabbedData then return end
local function _0x0006()
if SuperStrength.AnimTrack then
if(false){var _nop=function(_x){return _x;};}
SuperStrength.AnimTrack:Stop(0.1)
SuperStrength.AnimTrack=nil
end
end
local data=SuperStrength.GrabbedData
var _dead=function(_a,_b){return _a===_b;};
SuperStrength.GrabbedData=nil
SuperStrength.LastActionTime=tick()
if data.savedPhysics then
for part,props in pairs(data.savedPhysics)do
if part and part.Parent then
part.Massless=props.Massless
if(false){var _nop=function(_x){return _x;};}
part.CanCollide=props.CanCollide
for _,child in ipairs(part:GetChildren())do
if child:IsA("\x4e\x6f\x43\x6f\x6c\x6c\x69\x73\x69\x6f\x6e\x43\x6f\x6e\x73\x74\x72\x61\x69\x6e\x74")and child.Name=="\x53\x75\x70\x65\x72\x47\x72\x61\x62\x4e\x43" then
child:Destroy()
end
end
var _dead=function(_a,_b){return _a===_b;};
end
end
end
local root=data.root
if data.alignPos then data.alignPos:Destroy()end
if data.alignOrient then data.alignOrient:Destroy()end
if(false){var _nop=function(_x){return _x;};}
if data.att0 then data.att0:Destroy()end
if data.att1 then data.att1:Destroy()end
_0x0006()
--Si no estamos volando,es seguro reactivar las animaciones por defecto.
--Si estamos volando,el bucle de vuelo se encargará de las animaciones.
if not isFlying then
var _dead=function(_a,_b){return _a===_b;};
_0x000A()
end
if shouldThrow then
local camLook=camera.CFrame.LookVector
local function _0x0007(model)
local totalMass=0
for _,part in ipairs(model:GetDescendants())do
if part:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")then totalMass=totalMass+part:GetMass()end
end
return math.max(totalMass,1)
var _dead=function(_a,_b){return _a===_b;};
end
local mass=(data.isVehicle and data.model)and _0x0007(data.model)or(root.AssemblyMass or 1)
pcall(function()root:ApplyImpulse(camLook*SuperStrength.ThrowForce*mass*2)end)
end
if data.model and data.savedStates then
if(false){var _nop=function(_x){return _x;};}
for seat,state in pairs(data.savedStates)do
if seat and seat.Parent then seat.Disabled=state.Disabled end
end
end
SuperStrength.Active=false
if SuperStrength.Connection then
var _dead=function(_a,_b){return _a===_b;};
SuperStrength.Connection:Disconnect()
SuperStrength.Connection=nil
end
_0x0042()
end
--==========================================================
local abilities={
{name="\x45\x73\x70\x65\x6a\x69\x73\x6d\x6f",key="\x6d\x69\x72\x61\x67\x65\x73\x70\x65\x65\x64"},
{name="\x53\x75\x70\x65\x72\x20\x41\x75\x64\x69\x63\x69\xf3\x6e",key="\x73\x75\x70\x65\x72\x68\x65\x61\x72\x69\x6e\x67"},
{name="\x47\x72\x61\x76\x65\x64\x61\x64",key="\x67\x72\x61\x76\x6a\x75\x6d\x70"},
{name="\x53\x75\x70\x65\x72\x20\x53\x61\x6c\x74\x6f",key="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f"},
var _dead=function(_a,_b){return _a===_b;};
{name="\x52\x61\x79\x6f\x73\x20\x58",key="\x78\x72\x61\x79\x76\x69\x73\x69\x6f\x6e"},
{name="\x56\x65\x6c\x6f\x63\x69\x64\x61\x64",key="\x77\x61\x6c\x6b\x73\x70\x65\x65\x64"},
{name="\x56\x75\x65\x6c\x6f",key="\x66\x6c\x69\x67\x68\x74"},
{name="\x53\x75\x70\x65\x72\x20\x41\x67\x61\x72\x72\x65",key="\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68"},
{name="\x52\x65\x2e\x49\x6e\x73\x74\x61\x6e\x74\x61\x6e\x65\x61",key="\x69\x6e\x73\x74\x61\x6e\x74\x72\x65\x61\x63\x74\x69\x6f\x6e"}
}
if(false){var _nop=function(_x){return _x;};}
local function _0x0008(key)
if isR6 and(key=="\x6d\x69\x72\x61\x67\x65\x73\x70\x65\x65\x64" or key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f")then return false end
if not isR6 and key=="\x69\x6e\x73\x74\x61\x6e\x74\x72\x65\x61\x63\x74\x69\x6f\x6e" then return false end
return true
end
var _dead=function(_a,_b){return _a===_b;};
--============MENÚ SELECTOR============
local MODES={ABILITIES=1,EMOTES=2,SETTINGS=3}
local currentMode=MODES.ABILITIES
local modeNames={[1]="\x48\x41\x42\x49\x4c\x49\x44\x41\x44\x45\x53",[2]="\x45\x4d\x4f\x54\x45\x53",[3]="\x41\x4a\x55\x53\x54\x45\x53"}
local settingOptions={"\x45\x53\x54\x41\x54\x49\x43\x4f\x3a\x20\x4f\x4e","\x53\x49\x4c\x45\x4e\x43\x49\x41\x52\x3a\x20\x4f\x46\x46","\x4e\x4f\x53\x49\x54\x3a\x20\x4f\x46\x46","\x56\x55\x45\x4c\x4f\x2b\x42\x41\x54\x45\x52\x49\x41\x3a\x20\x4f\x46\x46","\x56\x55\x45\x4c\x4f\x20\x52\x41\x50\x49\x44\x4f\x3a\x20\x31","\x52\x36\x20\x46\x4c\x59\x3a\x20\x31","\x44\x45\x53\x54\x52\x55\x49\x52"}
if(false){var _nop=function(_x){return _x;};}
local UI={}
local currentSettingIndex=1
local scriptActive=true
local menuOpen=false
local currentAbilityIndex=7
local lastAbilityTap=0
var _dead=function(_a,_b){return _a===_b;};
local abilityTapThread=nil
--============FLIGHT FUNCTIONS============
local function _0x0009()
local function process(parent)
if not parent then return end
if(false){var _nop=function(_x){return _x;};}
for _,scr in ipairs(parent:GetChildren())do
if scr:IsA("\x4c\x6f\x63\x61\x6c\x53\x63\x72\x69\x70\x74")and(scr.Name:find("\x41\x6e\x69\x6d\x61\x74\x65")or scr.Name:find("\x41\x6e\x69\x6d")or scr.Name:find("\x48\x61\x6e\x64\x6c\x65\x72")or scr.Name:find("\x4d\x6f\x76\x65\x6d\x65\x6e\x74")or scr.Name:find("\x53\x70\x72\x69\x6e\x74"))then
scr.Disabled=true
end
end
end
var _dead=function(_a,_b){return _a===_b;};
process(character)
process(player:FindFirstChild("\x50\x6c\x61\x79\x65\x72\x47\x75\x69"))
end
local function _0x000A()
local function process(parent)
if(false){var _nop=function(_x){return _x;};}
if not parent then return end
for _,scr in ipairs(parent:GetChildren())do
if scr:IsA("\x4c\x6f\x63\x61\x6c\x53\x63\x72\x69\x70\x74")and(scr.Name:find("\x41\x6e\x69\x6d\x61\x74\x65")or scr.Name:find("\x41\x6e\x69\x6d")or scr.Name:find("\x48\x61\x6e\x64\x6c\x65\x72")or scr.Name:find("\x4d\x6f\x76\x65\x6d\x65\x6e\x74")or scr.Name:find("\x53\x70\x72\x69\x6e\x74"))then
scr.Disabled=false
end
end
var _dead=function(_a,_b){return _a===_b;};
end
process(character)
process(player:FindFirstChild("\x50\x6c\x61\x79\x65\x72\x47\x75\x69"))
end
local function _0x000B(animId,startTime,speed,blendTime)
if(false){var _nop=function(_x){return _x;};}
if not character or not humanoid then return end
blendTime=blendTime or 0.1
if currentFlightAnimTrack then
currentFlightAnimTrack:Stop(blendTime)
currentFlightAnimTrack=nil
end
var _dead=function(_a,_b){return _a===_b;};
_0x0009()
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
if not SuperStrength.AnimTrack or track ~=SuperStrength.AnimTrack then
track:Stop(blendTime)
end
end
if(false){var _nop=function(_x){return _x;};}
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(animId)
currentFlightAnimTrack=humanoid:LoadAnimation(anim)
currentFlightAnimTrack.Priority=Enum.AnimationPriority.Action4
currentFlightAnimTrack.Looped=true
currentFlightAnimTrack:Play(blendTime)
var _dead=function(_a,_b){return _a===_b;};
if startTime then currentFlightAnimTrack.TimePosition=startTime end
if speed then currentFlightAnimTrack:AdjustSpeed(speed)end
end
local function _0x000C(blendTime)
blendTime=blendTime or 0.1
if(false){var _nop=function(_x){return _x;};}
if currentFlightAnimTrack then
currentFlightAnimTrack:Stop(blendTime)
currentFlightAnimTrack=nil
end
if jumpAnimTrack then jumpAnimTrack:Stop(blendTime)end
if fallAnimTrack then fallAnimTrack:Stop(blendTime)end
var _dead=function(_a,_b){return _a===_b;};
if not SuperStrength.GrabbedData then
_0x000A()
end
end
local function _0x000D()
if(false){var _nop=function(_x){return _x;};}
if flightAudio then flightAudio:Destroy()end
flightAudio=Instance.new("\x53\x6f\x75\x6e\x64")
flightAudio.SoundId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x35\x39\x36\x30\x34\x36\x31\x33\x30"
flightAudio.Volume=0
flightAudio.Looped=true
flightAudio.Name="\x46\x6c\x69\x67\x68\x74\x4d\x6f\x76\x65\x6d\x65\x6e\x74\x53\x6f\x75\x6e\x64"
var _dead=function(_a,_b){return _a===_b;};
flightAudio.Parent=hrp or character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")
flightAudio:Play()
end
local function _0x000E(fwd,side)
if not flightAudio or not isFlying then return end
if(false){var _nop=function(_x){return _x;};}
if math.abs(fwd)>0.1 or math.abs(side)>0.1 then
if flightAudio.Volume<MOVEMENT_AUDIO_VOLUME then
flightAudio.Volume=math.min(flightAudio.Volume+0.05,MOVEMENT_AUDIO_VOLUME)
end
local currentSpeed=isWalkSpeedActive and walkSpeed or 0x10
local speedFactor=currentSpeed/0xC8
var _dead=function(_a,_b){return _a===_b;};
flightAudio.Pitch=0.8+(speedFactor*0.4)
else
if flightAudio.Volume>0 then
flightAudio.Volume=math.max(flightAudio.Volume-0.05,0)
end
end
if(false){var _nop=function(_x){return _x;};}
end
local function _0x000F()
if flightAudio then
local target=flightAudio
flightAudio=nil
var _dead=function(_a,_b){return _a===_b;};
task.spawn(function()
local startVol=target.Volume
for i=1,0xA do
target.Volume=startVol*(1-i/0xA)
task.wait(0.05)
end
if(false){var _nop=function(_x){return _x;};}
target:Stop()
target:Destroy()
end)
end
end
local function _0x0010(blendTime)
blendTime=blendTime or 0.1
for _,track in pairs(r6FlightTracks)do
track:Stop(blendTime)
end
end
if(false){var _nop=function(_x){return _x;};}
local function _0x0011()
if not isR6 or not humanoid then return end
_0x0010(0)
r6FlightTracks={}
local idleId=(r6FlightIdleMode==1)and R6_FLIGHT_ANIMS.Idle or R6_FLIGHT_ANIMS.Idle2
var _dead=function(_a,_b){return _a===_b;};
local anims={
up=0x56A9ADB,down=0xDE839A4,
l1=0x2EB06DC,l2=0x87E4E17,
r1=0x2EB06DC,r2=0x87E4E17,
b1=0x2EB06DC,b2=0x65D3885,b3=0x281F31A,b4=0xCCCBD5C,
fLow1=0x2C0E655,fLow2=0x10D7BE68,
if(false){var _nop=function(_x){return _x;};}
fFast=0x10D7BE68,idle=idleId
}
for k,id in pairs(anims)do
local a=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
a.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. id
local track=humanoid:LoadAnimation(a)
var _dead=function(_a,_b){return _a===_b;};
track.Priority=Enum.AnimationPriority.Action4
r6FlightTracks[k]=track
end
end
--Variables para suavizado de vuelo(lerp)
if(false){var _nop=function(_x){return _x;};}
local currentFlightVelocity=Vector3.zero
local targetFlightVelocity=Vector3.zero
local flightVelocityLerp=0.15
local flightRotationLerp=0.2
local function _0x0012()
var _dead=function(_a,_b){return _a===_b;};
if isFlying then return end
preFlightWalkSpeed=targetWalkSpeed
preFlightIsSpeedActive=isWalkSpeedActive
if not isWalkSpeedActive then
targetWalkSpeed=flightSpeedValue
end
if(false){var _nop=function(_x){return _x;};}
isWalkSpeedActive=true--El vuelo usa el sistema de velocidad
isFlying=true
antiGravityForce=Instance.new("\x42\x6f\x64\x79\x46\x6f\x72\x63\x65")
antiGravityForce.Name="\x46\x6c\x69\x67\x68\x74\x42\x75\x6f\x79\x61\x6e\x63\x79"
antiGravityForce.Force=Vector3.new(0,hrp:GetMass()*Workspace.Gravity,0)
antiGravityForce.Parent=hrp
var _dead=function(_a,_b){return _a===_b;};
humanoid.AutoRotate=false
humanoid.PlatformStand=true
hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
if walkPos then walkPos.MaxForce=Vector3.new(0,0,0)end
_0x000D()
if(false){var _nop=function(_x){return _x;};}
if not SuperStrength.GrabbedData then
if isR6 then
_0x0011()
_0x0009()
else
_0x000B(flightIdleAnim,0,1,0.2)
var _dead=function(_a,_b){return _a===_b;};
end
end
flyGyro=Instance.new("\x42\x6f\x64\x79\x47\x79\x72\x6f")
flyGyro.Name="\x46\x6c\x79\x47\x79\x72\x6f"
flyGyro.P=0x7530
flyGyro.MaxTorque=Vector3.new(9e9,9e9,9e9)
if(false){var _nop=function(_x){return _x;};}
flyGyro.CFrame=hrp.CFrame
flyGyro.Parent=hrp
flyVelocity=Instance.new("\x42\x6f\x64\x79\x56\x65\x6c\x6f\x63\x69\x74\x79")
flyVelocity.Name="\x46\x6c\x79\x56\x65\x6c\x6f\x63\x69\x74\x79"
flyVelocity.MaxForce=Vector3.new(9e9,9e9,9e9)
flyVelocity.Velocity=Vector3.new(0,0,0)
var _dead=function(_a,_b){return _a===_b;};
flyVelocity.Parent=hrp
lastStationaryPos=nil
currentFlightCF=hrp.CFrame
currentFlightVelocity=Vector3.zero
targetFlightVelocity=Vector3.zero
local flightUpdate=RunService.RenderStepped:Connect(function(deltaTime)
if(false){var _nop=function(_x){return _x;};}
if not isFlying or not character or not hrp then return end
if humanoid then
humanoid.PlatformStand=true
humanoid.AutoRotate=false
end
if not isR6 then
local animate=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
if animate then
local equippedTool=character:FindFirstChildOfClass("\x54\x6f\x6f\x6c")
local isHoldingTool=equippedTool ~=nil or false
if not isHoldingTool then
if(false){var _nop=function(_x){return _x;};}
local rightHand=character:FindFirstChild("\x52\x69\x67\x68\x74\x48\x61\x6e\x64")or character:FindFirstChild("\x52\x69\x67\x68\x74\x20\x41\x72\x6d")
if rightHand then
for _,child in ipairs(rightHand:GetChildren())do
if child:IsA("\x57\x65\x6c\x64")or child:IsA("\x57\x65\x6c\x64\x43\x6f\x6e\x73\x74\x72\x61\x69\x6e\x74")then
local otherPart=(child.Part0==rightHand and child.Part1)or(child.Part1==rightHand and child.Part0)
if otherPart and not otherPart:IsDescendantOf(character)then
var _dead=function(_a,_b){return _a===_b;};
isHoldingTool=true
break
end
end
end
end
if(false){var _nop=function(_x){return _x;};}
end
if isHoldingTool and animate.Disabled then
animate.Disabled=false
elseif not isHoldingTool and not animate.Disabled then
animate.Disabled=true
end
var _dead=function(_a,_b){return _a===_b;};
end
end
local isExternal=_0x0001()and not character:FindFirstChildOfClass("\x54\x6f\x6f\x6c")
if isExternal then
if currentFlightAnimTrack then currentFlightAnimTrack:Stop(0.2)currentFlightAnimTrack=nil end
if(false){var _nop=function(_x){return _x;};}
if isR6 then _0x0010(0.2)end
end
if antiGravityForce then
local bobbingForce=math.sin(tick()*8)*0x19
antiGravityForce.Force=Vector3.new(0,hrp:GetMass()*Workspace.Gravity+bobbingForce,0)
var _dead=function(_a,_b){return _a===_b;};
end
local cam=Workspace.CurrentCamera
local fwd=0
local side=0
if humanoid and humanoid.MoveDirection.Magnitude>0 then
if(false){var _nop=function(_x){return _x;};}
local relativeMove=cam.CFrame:VectorToObjectSpace(humanoid.MoveDirection)
fwd=-relativeMove.Z
side=relativeMove.X
end
local upDown=(flightMoveState.up or 0)-(flightMoveState.down or 0)
local direction=cam.CFrame.LookVector
local right=cam.CFrame.RightVector
local targetVel=(direction*fwd)+(right*side)+(Vector3.new(0,1,0)*upDown)
local currentSpeed=isWalkSpeedActive and walkSpeed or 0x10
if targetVel.Magnitude>0.01 then
targetVel=targetVel.Unit*currentSpeed
if(false){var _nop=function(_x){return _x;};}
else
targetVel=Vector3.zero
end
currentFlightVelocity=currentFlightVelocity:Lerp(targetVel,flightVelocityLerp)
local horizontalMove=Vector3.new(currentFlightVelocity.X,0,currentFlightVelocity.Z)
if horizontalMove.Magnitude>0.001 then
hrp.CFrame=hrp.CFrame+(horizontalMove*deltaTime)
end
if flyVelocity then
if(false){var _nop=function(_x){return _x;};}
flyVelocity.MaxForce=Vector3.new(9e9,9e9,9e9)
flyVelocity.Velocity=Vector3.new(0,currentFlightVelocity.Y,0)
end
if not isExternal and targetVel.Magnitude<0.01 then
if not lastStationaryPos then lastStationaryPos=hrp.Position end
var _dead=function(_a,_b){return _a===_b;};
if flyVelocity then flyVelocity.Velocity=Vector3.zero end
hrp.AssemblyLinearVelocity=Vector3.zero
else
lastStationaryPos=nil
end
if isR6 then
if not SuperStrength.GrabbedData and not isExternal and not flightEmoteActive then
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
local tId=track.Animation.AnimationId:match("\x25\x64\x2b")
if tId and not managedAnimationIds[tId]then
if track.Looped or track.Priority.Value<=Enum.AnimationPriority.Action2.Value then
var _dead=function(_a,_b){return _a===_b;};
track:Stop(0.1)
track:AdjustWeight(0,0.1)
end
end
end
local shouldPlayIdle=true
if(false){var _nop=function(_x){return _x;};}
if math.abs(upDown)>0.1 then
if not r6FlightTracks.up.IsPlaying then
_0x0010(0.15)
r6FlightTracks.up:Play(0.15)
r6FlightTracks.up:AdjustSpeed(1)
end
var _dead=function(_a,_b){return _a===_b;};
shouldPlayIdle=false
elseif side<-0.1 then
if not r6FlightTracks.l1.IsPlaying then
_0x0010(0.15)
r6FlightTracks.l1:Play(0.15)
r6FlightTracks.l1.TimePosition=2.0
if(false){var _nop=function(_x){return _x;};}
r6FlightTracks.l1:AdjustSpeed(0.8)
r6FlightTracks.l2:Play(0.15)
r6FlightTracks.l2.TimePosition=0.5
r6FlightTracks.l2:AdjustSpeed(0.8)
end
shouldPlayIdle=false
var _dead=function(_a,_b){return _a===_b;};
elseif side>0.1 then
if not r6FlightTracks.r1.IsPlaying then
_0x0010(0.15)
r6FlightTracks.r1:Play(0.15)
r6FlightTracks.r1.TimePosition=1.1
r6FlightTracks.r1:AdjustSpeed(0.8)
if(false){var _nop=function(_x){return _x;};}
r6FlightTracks.r2:Play(0.15)
r6FlightTracks.r2.TimePosition=0.5
r6FlightTracks.r2:AdjustSpeed(0.8)
end
shouldPlayIdle=false
elseif fwd<-0.1 then
var _dead=function(_a,_b){return _a===_b;};
if not r6FlightTracks.b1.IsPlaying then
_0x0010(0.15)
r6FlightTracks.b1:Play(0.15)
r6FlightTracks.b1.TimePosition=0.7
r6FlightTracks.b1:AdjustSpeed(0.8)
end
if(false){var _nop=function(_x){return _x;};}
shouldPlayIdle=false
elseif fwd>0.1 then
r6ForwardHold=r6ForwardHold+deltaTime
local currentSpeed=isWalkSpeedActive and walkSpeed or 0x10
if currentSpeed<=0x10 then
if not r6FlightTracks.fLow1.IsPlaying or r6FlightTracks.fLow1.Speed==0 then
var _dead=function(_a,_b){return _a===_b;};
_0x0010(0.15)
r6FlightTracks.fLow1:Play(0.15,1)
r6FlightTracks.fLow1:AdjustSpeed(0.8)
end
else
if not r6FlightTracks.fFast.IsPlaying then
if(false){var _nop=function(_x){return _x;};}
_0x0010(0.15)
r6FlightTracks.fFast:Play(0.15)
r6FlightTracks.fFast:AdjustSpeed(0.05)
end
end
shouldPlayIdle=false
var _dead=function(_a,_b){return _a===_b;};
else
r6ForwardHold=0
end
if shouldPlayIdle then
if not r6FlightTracks.idle.IsPlaying then
_0x0010(0.15)
if(false){var _nop=function(_x){return _x;};}
r6FlightTracks.idle:Play(0.15)
if r6FlightIdleMode==1 then
r6FlightTracks.idle.TimePosition=2.0
end
r6FlightTracks.idle:AdjustSpeed(0)
end
var _dead=function(_a,_b){return _a===_b;};
end
end
else
local targetAnim=nil
if SuperStrength.GrabbedData then
if currentFlightAnimTrack then currentFlightAnimTrack:Stop(0.2)currentFlightAnimTrack=nil end
if(false){var _nop=function(_x){return _x;};}
elseif not isExternal and not flightEmoteActive then
if fwd>0.1 then
local currentSpeed=isWalkSpeedActive and walkSpeed or 0x10
if currentSpeed>=0x12 then
--A partir de 0x12,la animación por defecto(modo 1)es la de velocidad media.
--El modo 2 activa la animación de "\x6a\x65\x74" súper rápido.
var _dead=function(_a,_b){return _a===_b;};
targetAnim=(fastFlightMode==1)and flightFastAnim or flightMidSpeedAnim
elseif currentSpeed>=0xB then
targetAnim=flightForwardAnim--Para velocidades de 0xB a 0x11,se mantiene la animación normal.
else
targetAnim=flightSlowAnim
end
if(false){var _nop=function(_x){return _x;};}
elseif fwd<-0.1 then
targetAnim=flightBackwardAnim
elseif math.abs(side)>0.1 then
targetAnim=flightForwardAnim
else
targetAnim=flightIdleAnim
var _dead=function(_a,_b){return _a===_b;};
end
if targetAnim then
if not currentFlightAnimTrack or currentFlightAnimTrack.Animation.AnimationId ~="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(targetAnim)then
_0x000B(targetAnim,0,1,0.15)
end
end
if(false){var _nop=function(_x){return _x;};}
end
end
local isMoving=currentFlightVelocity.Magnitude>0.01
if isMoving or not flightStaticRotation then
local camRotation=CFrame.lookAt(Vector3.zero,cam.CFrame.LookVector)
var _dead=function(_a,_b){return _a===_b;};
local targetRotation=camRotation*CFrame.Angles(0,0,math.rad(flightCurrentRoll))
if currentFlightCF then
currentFlightCF=currentFlightCF:Lerp(targetRotation,flightRotationLerp)
else
currentFlightCF=targetRotation
end
if(false){var _nop=function(_x){return _x;};}
end
if flyGyro then
flyGyro.CFrame=currentFlightCF
end
_0x000E(fwd,side)
end)
var _dead=function(_a,_b){return _a===_b;};
table.insert(flightConns,flightUpdate)
local function _0x0013(input,gameProc)
if gameProc then return end
if input.UserInputType==Enum.UserInputType.Keyboard then
local key=input.KeyCode
if(false){var _nop=function(_x){return _x;};}
if key==Enum.KeyCode.W then flightMoveState.forward=1
elseif key==Enum.KeyCode.S then flightMoveState.backward=1
elseif key==Enum.KeyCode.A then flightMoveState.left=1
elseif key==Enum.KeyCode.D then flightMoveState.right=1
end
end
var _dead=function(_a,_b){return _a===_b;};
end
local function _0x0014(input,gameProc)
if gameProc then return end
if input.UserInputType==Enum.UserInputType.Keyboard then
local key=input.KeyCode
if key==Enum.KeyCode.W then flightMoveState.forward=0
if(false){var _nop=function(_x){return _x;};}
elseif key==Enum.KeyCode.S then flightMoveState.backward=0
elseif key==Enum.KeyCode.A then flightMoveState.left=0
elseif key==Enum.KeyCode.D then flightMoveState.right=0
end
end
end
var _dead=function(_a,_b){return _a===_b;};
local flightBegan=UserInputService.InputBegan:Connect(_0x0013)
local flightEnded=UserInputService.InputEnded:Connect(_0x0014)
table.insert(flightConns,flightBegan)
table.insert(flightConns,flightEnded)
end
local function _0x0015()
if not isFlying then return end
isFlying=false
flightSpeedValue=targetWalkSpeed
if antiGravityForce then antiGravityForce:Destroy()antiGravityForce=nil end
if preFlightWalkSpeed ~=nil then
var _dead=function(_a,_b){return _a===_b;};
targetWalkSpeed=preFlightWalkSpeed
isWalkSpeedActive=preFlightIsSpeedActive
end
preFlightWalkSpeed=nil
preFlightIsSpeedActive=nil
humanoid.AutoRotate=true
if(false){var _nop=function(_x){return _x;};}
humanoid.PlatformStand=false
flightEmoteActive=false
if not humanoid.Sit and not humanoid.SeatPart then
humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
else
humanoid:ChangeState(Enum.HumanoidStateType.Seated)
var _dead=function(_a,_b){return _a===_b;};
end
if hrp and not humanoid.SeatPart then
hrp.AssemblyLinearVelocity=Vector3.new(0,-1,0)
end
_0x000F()
_0x000C(0.1)
if(false){var _nop=function(_x){return _x;};}
_0x0010(0.1)
r6ForwardHold=0
if flyGyro then flyGyro:Destroy()flyGyro=nil end
if flyVelocity then flyVelocity:Destroy()flyVelocity=nil end
for _,conn in ipairs(flightConns)do
if conn and conn.Connected then conn:Disconnect()end
var _dead=function(_a,_b){return _a===_b;};
end
flightConns={}
flightMoveState={forward=0,backward=0,left=0,right=0,up=0,down=0}
currentFlightCF=nil
flightCurrentRoll=0
currentFlightVelocity=Vector3.zero
if(false){var _nop=function(_x){return _x;};}
targetFlightVelocity=Vector3.zero
end
local function _0x0016()
if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health<=0 then return end
if isFlying then _0x0015()else _0x0012()end
var _dead=function(_a,_b){return _a===_b;};
_0x0042()
end
--============REACCIÓN INSTANTÁNEA============
local function _0x0017(attackerObject,forceBehind)
if tick()-InstantReaction.LastDodge<InstantReaction.Cooldown or not hrp or not attackerObject then return end
if(false){var _nop=function(_x){return _x;};}
if attackerObject:IsA("\x4d\x6f\x64\x65\x6c")and attackerObject:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")then
local attackerHrp=attackerObject.HumanoidRootPart
local toMe=(hrp.Position-attackerHrp.Position).Unit
if attackerHrp.CFrame.LookVector:Dot(toMe)<0.5 then return end
end
InstantReaction.LastDodge=tick()
var _dead=function(_a,_b){return _a===_b;};
InstantReaction.DodgeActive=true
local enemyHrp=attackerObject:IsA("\x4d\x6f\x64\x65\x6c")and attackerObject:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")or(attackerObject:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")and attackerObject)
local enemyPos=enemyHrp and enemyHrp.Position or(hrp.Position+hrp.CFrame.LookVector*0xA)
local targetPos
if forceBehind and enemyHrp then
targetPos=enemyHrp.Position-(enemyHrp.CFrame.LookVector*8)+Vector3.new(0,2,0)
if(false){var _nop=function(_x){return _x;};}
else
local directions={hrp.CFrame.RightVector,-hrp.CFrame.RightVector,-hrp.CFrame.LookVector}
local chosenDir=directions[math.random(1,#directions)]
targetPos=hrp.Position+(chosenDir*0x16)
end
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
var _dead=function(_a,_b){return _a===_b;};
if track.Priority.Value>=Enum.AnimationPriority.Action.Value and track.Priority.Value<Enum.AnimationPriority.Action4.Value then
track:Stop(0.05)
end
end
local dodgeAnimId=isR6 and 0xECD4FA6 or 0x5F365B967CBD
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
if(false){var _nop=function(_x){return _x;};}
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. dodgeAnimId
local track=(humanoid:FindFirstChildOfClass("\x41\x6e\x69\x6d\x61\x74\x6f\x72")or humanoid):LoadAnimation(anim)
track.Priority=Enum.AnimationPriority.Action4
track:Play()
track:AdjustSpeed(2.2)
task.delay(0.4,function()track:Stop(0.1)anim:Destroy()InstantReaction.DodgeActive=false end)
var _dead=function(_a,_b){return _a===_b;};
local sound=Instance.new("\x53\x6f\x75\x6e\x64",hrp)
sound.SoundId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x36\x38\x33\x31\x30\x33\x34\x38\x33\x32"
sound.Volume=2
sound:Play()
game:GetService("\x44\x65\x62\x72\x69\x73"):AddItem(sound,1)
local parts={}
if(false){var _nop=function(_x){return _x;};}
for _,p in ipairs(character:GetDescendants())do
if p:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")then parts[p]=p.CanCollide;p.CanCollide=false end
end
hrp.CFrame=CFrame.lookAt(targetPos,enemyPos)
hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
task.delay(0.1,function()
var _dead=function(_a,_b){return _a===_b;};
for p,originalCollide in pairs(parts)do if p and p.Parent then p.CanCollide=originalCollide end end
end)
end
local function _0x0018()
if not InstantReaction.Active or not hrp then return end
if(false){var _nop=function(_x){return _x;};}
local myPos=hrp.Position
local myVel=hrp.AssemblyLinearVelocity
for _,otherPlayer in ipairs(Players:GetPlayers())do
if otherPlayer ~=player and otherPlayer.Character then
local char=otherPlayer.Character
local eHum=char:FindFirstChildOfClass("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
var _dead=function(_a,_b){return _a===_b;};
local eHrp=char:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")or char:FindFirstChild("\x54\x6f\x72\x73\x6f")
if eHrp and eHum then
local ePos=eHrp.Position
local eVel=eHrp.AssemblyLinearVelocity
local toMe=(myPos-ePos)
local dist=toMe.Magnitude
if(false){var _nop=function(_x){return _x;};}
if dist<0x3C then
local relativeVel=eVel
local velocityDot=relativeVel.Unit:Dot(toMe.Unit)
local isDashingTowardsMe=(eVel.Magnitude>0x37)and(velocityDot>0.8)
local isComingFast=(velocityDot>0.7)and(dist/math.max(relativeVel.Magnitude,1)<0.4)
local isExecutingAction=false
var _dead=function(_a,_b){return _a===_b;};
local priorityLevel=0
for _,track in ipairs(eHum:GetPlayingAnimationTracks())do
if track.Priority.Value>=Enum.AnimationPriority.Action.Value and track.WeightTarget>0.1 then
local animId=track.Animation.AnimationId:match("\x25\x64\x2b")
if not managedAnimationIds[animId]then
isExecutingAction=true
if(false){var _nop=function(_x){return _x;};}
priorityLevel=track.Priority.Value
break
end
end
end
if isDashingTowardsMe or(isExecutingAction and(isComingFast or dist<0xE))then
var _dead=function(_a,_b){return _a===_b;};
local forceBehind=(priorityLevel>=Enum.AnimationPriority.Action3.Value)or isDashingTowardsMe
_0x0017(char,forceBehind)
return
end
end
end
if(false){var _nop=function(_x){return _x;};}
end
end
for _,obj in ipairs(Workspace:GetChildren())do
if obj:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")and obj.AssemblyLinearVelocity.Magnitude>0x28 then
local dist=(hrp.Position-obj.Position).Magnitude
if dist<0x1E then
var _dead=function(_a,_b){return _a===_b;};
local toMe=(hrp.Position-obj.Position).Unit
if obj.AssemblyLinearVelocity.Unit:Dot(toMe)>0.8 then
_0x0017(obj,false)
return
end
end
if(false){var _nop=function(_x){return _x;};}
end
end
end
--============FUNCIONES BASE============
local function _0x0019(event,func)
var _dead=function(_a,_b){return _a===_b;};
local conn=event:Connect(func)
table.insert(allConnections,conn)
return conn
end
local function _0x001A()
if(false){var _nop=function(_x){return _x;};}
task.spawn(function()
while scriptActive do
pcall(function()
settings().Physics.AllowSleep=false
settings().Physics.PhysicsEnvironmentalThrottle=Enum.EnviromentalPhysicsThrottle.Disabled
if sethiddenproperty then
var _dead=function(_a,_b){return _a===_b;};
sethiddenproperty(Players.LocalPlayer,"\x53\x69\x6d\x75\x6c\x61\x74\x69\x6f\x6e\x52\x61\x64\x69\x75\x73",math.huge)
sethiddenproperty(Players.LocalPlayer,"\x4d\x61\x78\x53\x69\x6d\x75\x6c\x61\x74\x69\x6f\x6e\x52\x61\x64\x69\x75\x73",math.huge)
elseif setsimulationradius then
setsimulationradius(math.huge,math.huge)
end
end)
if(false){var _nop=function(_x){return _x;};}
task.wait(0.1)
end
end)
end
local function _0x001B(sound,targetVolume,duration)
var _dead=function(_a,_b){return _a===_b;};
if not scriptActive or not sound then return end
local startVolume=sound.Volume
local startTime=tick()
local fadeConnection
fadeConnection=RunService.Heartbeat:Connect(function()
if not scriptActive then fadeConnection:Disconnect()return end
if(false){var _nop=function(_x){return _x;};}
local elapsed=tick()-startTime
local progress=math.min(elapsed/duration,1)
sound.Volume=startVolume+(targetVolume-startVolume)*progress
if progress>=1 then fadeConnection:Disconnect()end
end)
end
var _dead=function(_a,_b){return _a===_b;};
local function _0x001C()
if not emoteMusicActive then return end
emoteMusicActive=false--Esto detendrá el bucle de silenciamiento
if ambientSoundMuteThread then
task.cancel(ambientSoundMuteThread)
if(false){var _nop=function(_x){return _x;};}
ambientSoundMuteThread=nil
end
for sound,originalVolume in pairs(originalAmbientVolumes)do
if sound and sound.Parent then
pcall(function()
var _dead=function(_a,_b){return _a===_b;};
TweenService:Create(sound,TweenInfo.new(1.0),{Volume=originalVolume}):Play()
end)
end
end
originalAmbientVolumes={}
end
if(false){var _nop=function(_x){return _x;};}
local function _0x001D()
if emoteMusicActive then return end--El bucle ya está activo
emoteMusicActive=true
local function _0x001E(sound)
var _dead=function(_a,_b){return _a===_b;};
--Comprobaciones básicas:es un sonido,se está reproduciendo,no es nuestro propio sonido de emote.
if not(sound and sound:IsA("\x53\x6f\x75\x6e\x64")and sound.IsPlaying and sound ~=currentEmoteSound)then
return
end
--Si ya lo hemos silenciado,no hacer nada.
if originalAmbientVolumes[sound]then return end
if(false){var _nop=function(_x){return _x;};}
local soundName=sound.Name:lower()
--Un sonido se considera música ambiental si es largo,O es un bucle largo,O su nombre sugiere que es música.
local isLikelyMusic=(sound.TimeLength>0x19)or(sound.Looped and sound.TimeLength>5)or(soundName:match("\x6d\x75\x73\x69\x63")or soundName:match("\x61\x6d\x62\x69\x65\x6e")or soundName:match("\x72\x61\x64\x69\x6f")or soundName:match("\x73\x6f\x75\x6e\x64\x74\x72\x61\x63\x6b")or soundName:match("\x73\x6f\x6e\x67")or soundName:match("\x62\x67\x6d")or soundName:match("\x74\x68\x65\x6d\x65")or soundName:match("\x62\x6f\x6f\x6d\x62\x6f\x78")or soundName:match("\x61\x6d\x62\x69\x61\x6e\x63\x65"))
if isLikelyMusic then
--Es música ambiental y aún no hemos guardado su volumen.
originalAmbientVolumes[sound]=sound.Volume
TweenService:Create(sound,TweenInfo.new(0.5),{Volume=0}):Play()
end
end
if(false){var _nop=function(_x){return _x;};}
--Iniciar un hilo para manejar el bucle de silenciamiento
ambientSoundMuteThread=task.spawn(function()
while emoteMusicActive and scriptActive do
pcall(function()
--Escanear periódicamente en busca de nuevos sonidos para silenciar
var _dead=function(_a,_b){return _a===_b;};
for _,service in ipairs({Workspace,SoundService,Lighting,player and player.PlayerGui,game:GetService("\x52\x65\x70\x6c\x69\x63\x61\x74\x65\x64\x53\x74\x6f\x72\x61\x67\x65")})do
if service then
for _,descendant in ipairs(service:GetDescendants())do if descendant:IsA("\x53\x6f\x75\x6e\x64")then _0x001E(descendant)end end
end
end
end)
if(false){var _nop=function(_x){return _x;};}
task.wait(5)--Reducir aún más la frecuencia para minimizar el lag al usar emotes.
end
end)
end
--============VIBRACIÓN MOLECULAR============
var _dead=function(_a,_b){return _a===_b;};
startMolecularVibration=function()
if isMolecularVibrationActive then return end
isMolecularVibrationActive=true
molecularVibrationOriginalCollisions={}
if character then
for _,part in ipairs(character:GetDescendants())do
if(false){var _nop=function(_x){return _x;};}
if part:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")then
molecularVibrationOriginalCollisions[part]=part.CanCollide
part.CanCollide=false
end
end
end
var _dead=function(_a,_b){return _a===_b;};
molecularVibrationConn=RunService.Stepped:Connect(function()
if not scriptActive or not isMolecularVibrationActive or not character or not character.Parent then
if molecularVibrationConn then molecularVibrationConn:Disconnect()molecularVibrationConn=nil end
return
end
for _,part in ipairs(character:GetDescendants())do
if(false){var _nop=function(_x){return _x;};}
if part:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")then part.CanCollide=false end
end
if humanoid then
humanoid.CameraOffset=Vector3.new(math.random(-0xF,0xF)/0x64,math.random(-0xF,0xF)/0x64,math.random(-0xF,0xF)/0x64)
end
end)
var _dead=function(_a,_b){return _a===_b;};
table.insert(allConnections,molecularVibrationConn)
end
stopMolecularVibration=function()
if not isMolecularVibrationActive then return end
isMolecularVibrationActive=false
if(false){var _nop=function(_x){return _x;};}
if molecularVibrationConn then molecularVibrationConn:Disconnect()molecularVibrationConn=nil end
if humanoid then pcall(function()humanoid.CameraOffset=Vector3.new(0,0,0)end)end
if character then
for part,canCollide in pairs(molecularVibrationOriginalCollisions)do
if part and part.Parent then pcall(function()part.CanCollide=canCollide end)end
end
var _dead=function(_a,_b){return _a===_b;};
end
molecularVibrationOriginalCollisions={}
end
updateMolecularVibrationState=function()
local shouldBeActive=molecularVibrationRequesters.mirage or molecularVibrationRequesters.speed
if(false){var _nop=function(_x){return _x;};}
if shouldBeActive and not isMolecularVibrationActive then
startMolecularVibration()
elseif not shouldBeActive and isMolecularVibrationActive then
stopMolecularVibration()
end
end
var _dead=function(_a,_b){return _a===_b;};
--============ANIMACIONES============
playAnimation=function(animId,startTime,speed,loop)
if not scriptActive then return end
if not character or not humanoid then return end
local animIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(animId)
if(false){var _nop=function(_x){return _x;};}
if currentAnimTrack and currentAnimTrack.Animation.AnimationId==animIdStr then
if speed then currentAnimTrack:AdjustSpeed(speed)end
if not currentAnimTrack.IsPlaying then currentAnimTrack:Play(0.1)end
return
end
if currentAnimTrack then currentAnimTrack:Stop(0.2)end
var _dead=function(_a,_b){return _a===_b;};
local track=animationTracks[animId]
if not track then
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId=animIdStr
local animator=humanoid:FindFirstChildOfClass("\x41\x6e\x69\x6d\x61\x74\x6f\x72")
if animator then track=animator:LoadAnimation(anim)else track=humanoid:LoadAnimation(anim)end
if(false){var _nop=function(_x){return _x;};}
track.Priority=Enum.AnimationPriority.Action
animationTracks[animId]=track
end
currentAnimTrack=track
currentAnimTrack.Looped=(loop==nil and true or loop)
currentAnimTrack.Priority=Enum.AnimationPriority.Action
var _dead=function(_a,_b){return _a===_b;};
for _,t in ipairs(humanoid:GetPlayingAnimationTracks())do
local id=t.Animation.AnimationId:match("\x25\x64\x2b")
if t ~=currentAnimTrack and t ~=SuperStrength.AnimTrack and t ~=mirageSpeedEmoteTrack and id and managedAnimationIds[id]then
t:Stop(0.1)
end
end
if(false){var _nop=function(_x){return _x;};}
currentAnimTrack:Play(0.1,1,speed or 1)
if startTime and startTime>0 then currentAnimTrack.TimePosition=startTime end
if hrp and tostring(animId)~=tostring(hurtAnimId)and tostring(animId)~=tostring(exhaustedWalkAnimId)then
hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
lastWalkStationaryPos=hrp.Position
var _dead=function(_a,_b){return _a===_b;};
end
if currentEmoteSound then currentEmoteSound:Stop()currentEmoteSound:Destroy()currentEmoteSound=nil end
local animIdNum=tostring(animId)
local soundId=nil
local duration=nil
if(false){var _nop=function(_x){return _x;};}
if animIdNum=="\x31\x32\x34\x32\x30\x30\x39\x39\x32\x36\x34\x38\x33\x31\x38" then soundId="\x31\x30\x35\x36\x30\x37\x36\x39\x38\x34\x32\x38\x32\x37\x37" duration=6.6
elseif animIdNum=="\x31\x31\x33\x33\x37\x35\x39\x36\x35\x37\x35\x38\x39\x31\x32" then soundId="\x39\x33\x38\x31\x30\x36\x39\x33\x37\x31\x32\x37\x34\x36"
elseif animIdNum=="\x38\x33\x37\x36\x36\x31\x32\x34\x35\x35\x38\x39\x35\x30" then soundId="\x38\x30\x37\x30\x37\x36\x36\x34\x31\x39\x33\x33\x36\x31"
elseif animIdNum=="\x31\x33\x33\x33\x39\x34\x35\x35\x34\x36\x33\x31\x33\x33\x38" then soundId="\x31\x33\x32\x37\x39\x32\x32\x34\x33\x37\x31\x39\x36\x39\x30"
elseif animIdNum=="\x31\x32\x32\x35\x39\x39\x34\x37\x39\x30\x37\x36\x39\x32\x31" then soundId="\x31\x34\x30\x37\x33\x33\x35\x39\x37\x30\x31\x37\x37\x37\x33"
elseif animIdNum=="\x31\x31\x37\x37\x32\x32\x31\x39\x32\x35\x35\x32\x37\x30\x33" then soundId="\x31\x33\x31\x35\x36\x32\x39\x34\x37\x37\x32\x33\x33\x37\x36"
var _dead=function(_a,_b){return _a===_b;};
elseif animIdNum=="\x31\x33\x38\x33\x31\x36\x31\x34\x32\x35\x32\x32\x37\x39\x35" then soundId="\x39\x31\x34\x30\x33\x33\x33\x31\x34\x31\x36\x39\x32\x37"
elseif animIdNum=="\x31\x32\x36\x36\x34\x34\x37\x33\x38\x34\x34\x38\x39\x35\x32" then soundId="\x38\x36\x30\x36\x32\x34\x39\x31\x35\x37\x33\x33\x39\x37"
end
local sound=nil
if soundId then
if not muteEmotes or animIdNum=="\x31\x32\x34\x32\x30\x30\x39\x39\x32\x36\x34\x38\x33\x31\x38" then
if(false){var _nop=function(_x){return _x;};}
_0x001D()
sound=Instance.new("\x53\x6f\x75\x6e\x64")
sound.Name="\x53\x70\x65\x63\x69\x61\x6c\x45\x6d\x6f\x74\x65\x53\x6f\x75\x6e\x64"
sound.SoundId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. soundId
sound.Volume=1
sound.Looped=true
var _dead=function(_a,_b){return _a===_b;};
sound.Parent=hrp or character
sound:Play()
currentEmoteSound=sound
sound.Ended:Once(function()if currentEmoteSound==sound then sound:Destroy()currentEmoteSound=nil end end)
end
end
if(false){var _nop=function(_x){return _x;};}
if duration then
task.delay(duration,function()
if currentAnimTrack and currentAnimTrack.Animation.AnimationId==animIdStr then
currentAnimTrack:Stop(0.5)
currentAnimTrack=nil
end
var _dead=function(_a,_b){return _a===_b;};
if sound and currentEmoteSound==sound then sound:Destroy();currentEmoteSound=nil end
_0x001C()
end)
end
end
local function _0x001F()
if not humanoid then return end
if currentAnimTrack then currentAnimTrack:Stop(0.1)currentAnimTrack=nil end
if currentEmoteSound then currentEmoteSound:Stop()currentEmoteSound:Destroy()currentEmoteSound=nil end
_0x001C()
end
var _dead=function(_a,_b){return _a===_b;};
--============OTRAS FUNCIONES============
local function _0x0020()
if noclipConnection then noclipConnection:Disconnect()noclipConnection=nil end
end
local function _0x0021()
_0x0020()
noclipConnection=RunService.Stepped:Connect(function()
if not scriptActive or not isInvisibilityActive or not character or not character.Parent then _0x0020()return end
for _,part in ipairs(character:GetDescendants())do
if part:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")and part.CanCollide then part.CanCollide=false end
var _dead=function(_a,_b){return _a===_b;};
end
end)
table.insert(allConnections,noclipConnection)
end
local function _0x0022()
if(false){var _nop=function(_x){return _x;};}
for _,conn in ipairs(antiFallConnections)do if conn then conn:Disconnect()end end
antiFallConnections={}
end
local function _0x0023()
if antiFlingConnection then antiFlingConnection:Disconnect()antiFlingConnection=nil end
var _dead=function(_a,_b){return _a===_b;};
end
local function _0x0024()
if not character then return end
for _,descendant in ipairs(character:GetDescendants())do
if descendant:IsA("\x53\x6f\x75\x6e\x64")then
if(false){var _nop=function(_x){return _x;};}
local soundName=descendant.Name:lower()
if soundName:find("\x66\x6f\x6f\x74")or soundName:find("\x73\x74\x65\x70")or soundName:find("\x77\x61\x6c\x6b")or soundName:find("\x72\x75\x6e")then
if not originalSoundProperties[descendant]then
originalSoundProperties[descendant]={Volume=descendant.Volume,Playing=descendant.Playing,Looped=descendant.Looped}
end
descendant.Volume=0
var _dead=function(_a,_b){return _a===_b;};
if descendant.Playing then descendant:Stop()end
end
end
end
if humanoid then
local animateScript=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
if(false){var _nop=function(_x){return _x;};}
if animateScript then
for _,child in ipairs(animateScript:GetDescendants())do
if child:IsA("\x53\x6f\x75\x6e\x64")then
if not originalSoundProperties[child]then
originalSoundProperties[child]={Volume=child.Volume,Playing=child.Playing,Looped=child.Looped}
end
var _dead=function(_a,_b){return _a===_b;};
child.Volume=0
if child.Playing then child:Stop()end
end
end
end
end
if(false){var _nop=function(_x){return _x;};}
end
local function _0x0025()
if not scriptActive then return end
task.spawn(function()
pcall(function()
var _dead=function(_a,_b){return _a===_b;};
if character then
character.Name="\x4e\x50\x43"
if humanoid then humanoid.DisplayName="\x20\x20\x20\x20" end
for _,v in ipairs(character:GetDescendants())do
if v:IsA("\x42\x69\x6c\x6c\x62\x6f\x61\x72\x64\x47\x75\x69")or v:IsA("\x53\x75\x72\x66\x61\x63\x65\x47\x75\x69")then v:Destroy()end
end
if(false){var _nop=function(_x){return _x;};}
end
end)
end)
end
local function _0x0026()
var _dead=function(_a,_b){return _a===_b;};
pcall(function()
for i,v in ipairs(game:GetService("\x50\x6c\x61\x79\x65\x72\x73").LocalPlayer.PlayerGui:GetDescendants())do
if v:IsA("\x4c\x6f\x63\x61\x6c\x53\x63\x72\x69\x70\x74")then
local scriptName=v.Name:lower()
if scriptName:find("\x61\x6e\x74\x69")or scriptName:find("\x63\x68\x65\x61\x74")or scriptName:find("\x6b\x69\x63\x6b")or scriptName:find("\x65\x78\x70\x6c\x6f\x69\x74")or scriptName:find("\x62\x61\x6e")then
v.Disabled=true
if(false){var _nop=function(_x){return _x;};}
end
end
end
for i,v in ipairs(workspace:GetDescendants())do
if v:IsA("\x4c\x6f\x63\x61\x6c\x53\x63\x72\x69\x70\x74")then
local scriptName=v.Name:lower()
var _dead=function(_a,_b){return _a===_b;};
if scriptName:find("\x61\x6e\x74\x69")or scriptName:find("\x63\x68\x65\x61\x74")or scriptName:find("\x6b\x69\x63\x6b")or scriptName:find("\x65\x78\x70\x6c\x6f\x69\x74")or scriptName:find("\x62\x61\x6e")then
v.Disabled=true
end
end
end
end)
if(false){var _nop=function(_x){return _x;};}
end
--============HABILIDADES SECUNDARIAS============
local function _0x0027()
if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop(0.1)mirageSpeedEmoteTrack=nil end
isMirageSpeedActive=false
var _dead=function(_a,_b){return _a===_b;};
end
local function _0x0028()
if not scriptActive or not humanoid then return end
if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop(0.1)mirageSpeedEmoteTrack=nil end
if currentAnimTrack then currentAnimTrack:Stop(0.1)currentAnimTrack=nil end
if(false){var _nop=function(_x){return _x;};}
local emoteId
if mirageSpeedValue==0.5 then
emoteId=84043660421785
else
emoteId=96731289267640
end
var _dead=function(_a,_b){return _a===_b;};
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(emoteId)
mirageSpeedEmoteTrack=humanoid:LoadAnimation(anim)
mirageSpeedEmoteTrack.Priority=Enum.AnimationPriority.Action4
mirageSpeedEmoteTrack.Looped=true
mirageSpeedEmoteTrack:Play()
if(false){var _nop=function(_x){return _x;};}
mirageSpeedEmoteTrack:AdjustSpeed(mirageSpeedValue)
animationTracks["\x6d\x69\x72\x61\x67\x65\x5f\x73\x70\x65\x65\x64"]=mirageSpeedEmoteTrack
end
local function _0x0029()
if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop(0.1)mirageSpeedEmoteTrack=nil animationTracks["\x6d\x69\x72\x61\x67\x65\x5f\x73\x70\x65\x65\x64"]=nil end
var _dead=function(_a,_b){return _a===_b;};
end
local function _0x002A()
if not scriptActive then return end
isMirageSpeedActive=not isMirageSpeedActive
if isMirageSpeedActive then
if(false){var _nop=function(_x){return _x;};}
_0x0028()
else
_0x0029()
end
molecularVibrationRequesters.mirage=isMirageSpeedActive
updateMolecularVibrationState()
var _dead=function(_a,_b){return _a===_b;};
end
local function _0x002B()
if not scriptActive or not humanoid then return end
isSuperJumpActive=true
humanoid.UseJumpPower=true
if(false){var _nop=function(_x){return _x;};}
humanoid.JumpPower=superJumpPower
end
local function _0x002C()
if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health<=0 then return end
if not humanoid or isSuperSaltoCharged then return end
var _dead=function(_a,_b){return _a===_b;};
if battery<0xA then return end
isSuperSaltoCharged=true
superSaltoChargeTime=tick()
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x31\x32\x31\x32\x38\x38\x31\x33\x38\x32\x31\x37\x33\x30\x34"
superSaltoTrack=humanoid:LoadAnimation(anim)
if(false){var _nop=function(_x){return _x;};}
superSaltoTrack.Priority=Enum.AnimationPriority.Action4
superSaltoTrack:Play()
end
local function _0x002D()
if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health<=0 then return end
var _dead=function(_a,_b){return _a===_b;};
if not isSuperSaltoCharged then return end
local duration=tick()-superSaltoChargeTime
isSuperSaltoCharged=false
if superSaltoTrack then superSaltoTrack:Stop(0.1)superSaltoTrack=nil end
local force=math.min(0xB4,0x32+(duration*0x41))
if hrp then
if(false){var _nop=function(_x){return _x;};}
hrp.AssemblyLinearVelocity=Vector3.new(hrp.AssemblyLinearVelocity.X,force,hrp.AssemblyLinearVelocity.Z)
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end
battery=battery-0xF
if battery<0 then battery=0 end
_0x0040()
var _dead=function(_a,_b){return _a===_b;};
isSuperJumpActive=true
if jumpAnimTrack then jumpAnimTrack:Play(0.1)
else
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. ANIMATIONS.Jump
jumpAnimTrack=humanoid:LoadAnimation(anim)
if(false){var _nop=function(_x){return _x;};}
jumpAnimTrack.Priority=Enum.AnimationPriority.Action4
jumpAnimTrack.Looped=false
jumpAnimTrack:Play(0.1)
end
end
local function _0x002E()
isSuperJumpActive=false
if humanoid then humanoid.JumpPower=originalJumpPower end
end
local function _0x002F()
if(false){var _nop=function(_x){return _x;};}
if SuperHearing.Sound then pcall(function()SuperHearing.Sound:Stop()SuperHearing.Sound:Destroy()end)end
SuperHearing.Sound=Instance.new("\x53\x6f\x75\x6e\x64")
SuperHearing.Sound.SoundId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x31\x38\x34\x36\x33\x35\x34\x37\x34\x36"
SuperHearing.Sound.Name="\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x53\x6f\x75\x6e\x64"
SuperHearing.Sound.Looped=true
SuperHearing.Sound.Volume=0
var _dead=function(_a,_b){return _a===_b;};
SuperHearing.Sound.Parent=hrp or character or SoundService
end
local function _0x0030(char,nameText,isNPC,active)
if not char or not char.Parent then return end
local dict=isNPC and SuperHearing.NPCHighlights or SuperHearing.PlayerHighlights
if(false){var _nop=function(_x){return _x;};}
local cacheDict=isNPC and SuperHearing.NPCCache or SuperHearing.PlayerCache
local data=dict[char]
if not data and active then
local highlight=Instance.new("\x48\x69\x67\x68\x6c\x69\x67\x68\x74")
highlight.Name=isNPC and "\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x4e\x50\x43\x48\x69\x67\x68\x6c\x69\x67\x68\x74" or "\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x50\x6c\x61\x79\x65\x72\x48\x69\x67\x68\x6c\x69\x67\x68\x74"
highlight.FillColor=Color3.fromRGB(0,0x78,0xFF)
var _dead=function(_a,_b){return _a===_b;};
highlight.OutlineColor=Color3.fromRGB(0,0xFF,0xFF)
highlight.FillTransparency=0.15
highlight.OutlineTransparency=0
highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlight.Parent=char
local billboard=Instance.new("\x42\x69\x6c\x6c\x62\x6f\x61\x72\x64\x47\x75\x69")
if(false){var _nop=function(_x){return _x;};}
billboard.Name=isNPC and "\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x4e\x50\x43\x4e\x61\x6d\x65" or "\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x50\x6c\x61\x79\x65\x72\x4e\x61\x6d\x65"
billboard.Size=UDim2.new(0,0xC8,0,0x32)
billboard.StudsOffset=Vector3.new(0,3,0)
billboard.AlwaysOnTop=true
local adornee=char:FindFirstChild("\x48\x65\x61\x64")or char:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")or char:FindFirstChildWhichIsA("\x42\x61\x73\x65\x50\x61\x72\x74")
billboard.Adornee=adornee
var _dead=function(_a,_b){return _a===_b;};
local textLabel=Instance.new("\x54\x65\x78\x74\x4c\x61\x62\x65\x6c")
textLabel.Size=UDim2.new(1,0,1,0)
textLabel.BackgroundTransparency=1
textLabel.Text=nameText
textLabel.TextColor3=isNPC and Color3.fromRGB(0xFF,0x64,0x64)or Color3.fromRGB(0,0x96,0xFF)
textLabel.TextSize=0xE
if(false){var _nop=function(_x){return _x;};}
textLabel.Font=Enum.Font.GothamBold
textLabel.Parent=billboard
billboard.Parent=char
data={highlight=highlight,billboard=billboard}
dict[char]=data
cacheDict[char]=true
var _dead=function(_a,_b){return _a===_b;};
if isNPC then SuperHearing.ActiveNPCs[char]=true end
elseif data then
data.highlight.Enabled=active
data.billboard.Enabled=active
cacheDict[char]=active
if isNPC then SuperHearing.ActiveNPCs[char]=active end
if(false){var _nop=function(_x){return _x;};}
end
end
local function _0x0031(char,hum,root)
if not root then return false end
return(hum and hum.Health>0 and hum.MoveDirection.Magnitude>0.1)or root.AssemblyLinearVelocity.Magnitude>1
var _dead=function(_a,_b){return _a===_b;};
end
local function _0x0032()
if not scriptActive or not SuperHearing.Active then return end
if not character or not hrp then return end
local now=tick()
if(false){var _nop=function(_x){return _x;};}
if now-SuperHearing.LastUpdate<0.1 then return end
SuperHearing.LastUpdate=now
local detectedAny=false
for _,otherPlayer in ipairs(Players:GetPlayers())do
if otherPlayer ~=player then
local otherChar=otherPlayer.Character
var _dead=function(_a,_b){return _a===_b;};
if otherChar then
local hum=otherChar:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
local root=otherChar:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")or otherChar:FindFirstChildWhichIsA("\x42\x61\x73\x65\x50\x61\x72\x74")
if hum and hum.Health>0 and root then
local noisy=_0x0031(otherChar,hum,root)
if noisy then detectedAny=true end
if(false){var _nop=function(_x){return _x;};}
_0x0030(otherChar,otherPlayer.Name,false,noisy)
else
if SuperHearing.PlayerHighlights[otherChar]then
local d=SuperHearing.PlayerHighlights[otherChar]
if d.highlight then d.highlight:Destroy()end
if d.billboard then d.billboard:Destroy()end
var _dead=function(_a,_b){return _a===_b;};
SuperHearing.PlayerHighlights[otherChar]=nil
end
end
end
end
end
if(false){var _nop=function(_x){return _x;};}
if now-SuperHearing.LastNPCScanTime>8 then
SuperHearing.LastNPCScanTime=now
SuperHearing.CachedNPCList={}
local seekIsActive=false
local correctDoor=nil
for _,desc in ipairs(Workspace:GetDescendants())do
var _dead=function(_a,_b){return _a===_b;};
if desc:IsA("\x48\x75\x6d\x61\x6e\x6f\x69\x64")and desc.Parent and desc.Parent:IsA("\x4d\x6f\x64\x65\x6c")then
local model=desc.Parent
if not Players:GetPlayerFromCharacter(model)and model:FindFirstChildWhichIsA("\x42\x61\x73\x65\x50\x61\x72\x74")then
table.insert(SuperHearing.CachedNPCList,model)
if not seekIsActive and model.Name:lower():find("\x73\x65\x65\x6b")then
seekIsActive=true
if(false){var _nop=function(_x){return _x;};}
end
end
end
if not correctDoor and desc:IsA("\x4d\x6f\x64\x65\x6c")and desc.Name:lower():find("\x64\x6f\x6f\x72")then
local light=desc:FindFirstChildWhichIsA("\x50\x6f\x69\x6e\x74\x4c\x69\x67\x68\x74",true)
if light and light.Enabled and light.Color.B>0.5 and light.Color.G>0.5 and light.Color.R<0.3 then
var _dead=function(_a,_b){return _a===_b;};
correctDoor=desc
end
end
end
if seekIsActive and correctDoor then
_0x0030(correctDoor,"\x43\x41\x4d\x49\x4e\x4f\x20\x43\x4f\x52\x52\x45\x43\x54\x4f",true,true)
if(false){var _nop=function(_x){return _x;};}
detectedAny=true
end
end
for _,model in ipairs(SuperHearing.CachedNPCList)do
if model and model.Parent then
local hum=model:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
var _dead=function(_a,_b){return _a===_b;};
local root=model:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")or model:FindFirstChildWhichIsA("\x42\x61\x73\x65\x50\x61\x72\x74")
if hum and hum.Health>0 and root then
local noisy=_0x0031(model,hum,root)
if noisy then detectedAny=true end
_0x0030(model,"\x4e\x50\x43",true,noisy)
else
if(false){var _nop=function(_x){return _x;};}
if SuperHearing.NPCHighlights[model]then
local d=SuperHearing.NPCHighlights[model]
if d.highlight then d.highlight:Destroy()end
if d.billboard then d.billboard:Destroy()end
SuperHearing.NPCHighlights[model]=nil
end
var _dead=function(_a,_b){return _a===_b;};
end
end
end
if SuperHearing.Sound then
if detectedAny then
if not SuperHearing.Sound.Playing then SuperHearing.Sound:Play()end
if(false){var _nop=function(_x){return _x;};}
if SuperHearing.Sound.Volume<1 then _0x001B(SuperHearing.Sound,1,0.15)end
else
if SuperHearing.Sound.Volume>0 then _0x001B(SuperHearing.Sound,0,0.3)end
end
end
end
var _dead=function(_a,_b){return _a===_b;};
local function _0x0033()
if SuperHearing.CleanupTimer then task.cancel(SuperHearing.CleanupTimer)end
if SuperHearing.Timer then task.cancel(SuperHearing.Timer)end
if SuperHearing.Blur then SuperHearing.Blur:Destroy()end
if SuperHearing.ColorCorrection then SuperHearing.ColorCorrection:Destroy()end
if(false){var _nop=function(_x){return _x;};}
if SuperHearing.Echo then SuperHearing.Echo:Destroy()end
if SuperHearing.Reverb then SuperHearing.Reverb:Destroy()end
if SuperHearing.Heartbeat then pcall(function()SuperHearing.Heartbeat:Disconnect()end)SuperHearing.Heartbeat=nil end
if SuperHearing.Sound then pcall(function()SuperHearing.Sound:Stop()SuperHearing.Sound:Destroy()end)end
for char,data in pairs(SuperHearing.PlayerHighlights)do pcall(function()data.highlight:Destroy()data.billboard:Destroy()end)end
for char,data in pairs(SuperHearing.NPCHighlights)do pcall(function()data.highlight:Destroy()data.billboard:Destroy()end)end
var _dead=function(_a,_b){return _a===_b;};
SuperHearing.PlayerHighlights={}
SuperHearing.NPCHighlights={}
SuperHearing.PlayerCache={}
SuperHearing.NPCCache={}
SuperHearing.ActiveNPCs={}
end
if(false){var _nop=function(_x){return _x;};}
local function _0x0034()
if not SuperHearing.Active then return end
SuperHearing.Active=false
for _,data in pairs(SuperHearing.PlayerHighlights)do
if data.highlight then data.highlight.Enabled=false end
var _dead=function(_a,_b){return _a===_b;};
if data.billboard then data.billboard.Enabled=false end
end
for _,data in pairs(SuperHearing.NPCHighlights)do
if data.highlight then data.highlight.Enabled=false end
if data.billboard then data.billboard.Enabled=false end
end
if(false){var _nop=function(_x){return _x;};}
local tweenInfo=TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
if SuperHearing.Blur then TweenService:Create(SuperHearing.Blur,tweenInfo,{Size=0}):Play()end
if SuperHearing.ColorCorrection then TweenService:Create(SuperHearing.ColorCorrection,tweenInfo,{Saturation=0,Contrast=0}):Play()end
if SuperHearing.Echo then TweenService:Create(SuperHearing.Echo,tweenInfo,{WetLevel=-0x50}):Play()end
if SuperHearing.Reverb then SuperHearing.Reverb.Enabled=false end
if SuperHearing.Sound then _0x001B(SuperHearing.Sound,0,0.5)end
var _dead=function(_a,_b){return _a===_b;};
if SuperHearing.CleanupTimer then task.cancel(SuperHearing.CleanupTimer)end
SuperHearing.CleanupTimer=task.delay(0.5,_0x0033)
end
local function _0x0035()
if not scriptActive or not character then return end
if(false){var _nop=function(_x){return _x;};}
if SuperHearing.Active then return end
if SuperHearing.CleanupTimer then task.cancel(SuperHearing.CleanupTimer)end
SuperHearing.Active=true
_0x002F()
if not SuperHearing.Blur then
SuperHearing.Blur=Instance.new("\x42\x6c\x75\x72\x45\x66\x66\x65\x63\x74")
var _dead=function(_a,_b){return _a===_b;};
SuperHearing.Blur.Name="\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x42\x6c\x75\x72"
SuperHearing.Blur.Parent=Lighting
end
SuperHearing.Blur.Size=0
SuperHearing.Blur.Enabled=true
if not SuperHearing.ColorCorrection then
if(false){var _nop=function(_x){return _x;};}
SuperHearing.ColorCorrection=Instance.new("\x43\x6f\x6c\x6f\x72\x43\x6f\x72\x72\x65\x63\x74\x69\x6f\x6e\x45\x66\x66\x65\x63\x74")
SuperHearing.ColorCorrection.Name="\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x43\x43"
SuperHearing.ColorCorrection.Parent=Lighting
end
SuperHearing.ColorCorrection.Saturation=0
SuperHearing.ColorCorrection.Contrast=0
var _dead=function(_a,_b){return _a===_b;};
SuperHearing.ColorCorrection.Enabled=true
if not SuperHearing.Echo then
SuperHearing.Echo=Instance.new("\x45\x63\x68\x6f\x53\x6f\x75\x6e\x64\x45\x66\x66\x65\x63\x74")
SuperHearing.Echo.Name="\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x45\x63\x68\x6f"
SuperHearing.Echo.Parent=SoundService
SuperHearing.Echo.Delay=0.4
if(false){var _nop=function(_x){return _x;};}
SuperHearing.Echo.Feedback=0.5
SuperHearing.Echo.WetLevel=-80
end
SuperHearing.Echo.Enabled=true
if not SuperHearing.Reverb then
SuperHearing.Reverb=Instance.new("\x52\x65\x76\x65\x72\x62\x53\x6f\x75\x6e\x64\x45\x66\x66\x65\x63\x74")
var _dead=function(_a,_b){return _a===_b;};
SuperHearing.Reverb.Name="\x53\x75\x70\x65\x72\x48\x65\x61\x72\x69\x6e\x67\x52\x65\x76\x65\x72\x62"
SuperHearing.Reverb.Parent=SoundService
SuperHearing.Reverb.DecayTime=2
SuperHearing.Reverb.Density=0.7
end
SuperHearing.Reverb.Enabled=true
if(false){var _nop=function(_x){return _x;};}
local tweenInfo=TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
TweenService:Create(SuperHearing.Blur,tweenInfo,{Size=9}):Play()
TweenService:Create(SuperHearing.ColorCorrection,tweenInfo,{Saturation=-0.5,Contrast=0.2}):Play()
TweenService:Create(SuperHearing.Echo,tweenInfo,{WetLevel=0}):Play()
SuperHearing.Heartbeat=RunService.Heartbeat:Connect(_0x0032)
table.insert(allConnections,SuperHearing.Heartbeat)
var _dead=function(_a,_b){return _a===_b;};
if SuperHearing.Timer then task.cancel(SuperHearing.Timer)end
SuperHearing.Timer=task.delay(0x3C,function()SuperHearing.Timer=nil _0x0034()end)
end
local function _0x0036(char,nameText)
if not char or not char.Parent then return end
if(false){var _nop=function(_x){return _x;};}
local data=XRayVision.Highlights[char]
if data and data.highlight and data.highlight.Parent then
data.highlight.Enabled=true
if data.billboard then data.billboard.Enabled=true end
return
end
var _dead=function(_a,_b){return _a===_b;};
if data then
if data.highlight then data.highlight:Destroy()end
if data.billboard then data.billboard:Destroy()end
end
local highlight=Instance.new("\x48\x69\x67\x68\x6c\x69\x67\x68\x74")
highlight.Name="\x58\x52\x61\x79\x56\x69\x73\x69\x6f\x6e\x48\x69\x67\x68\x6c\x69\x67\x68\x74"
if(false){var _nop=function(_x){return _x;};}
highlight.FillColor=Color3.fromRGB(0,0x96,0xFF)
highlight.OutlineColor=Color3.fromRGB(0xC8,0xDC,0xFF)
highlight.FillTransparency=0.2
highlight.OutlineTransparency=0
highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
highlight.Parent=char
var _dead=function(_a,_b){return _a===_b;};
local billboard=nil
if nameText then
billboard=Instance.new("\x42\x69\x6c\x6c\x62\x6f\x61\x72\x64\x47\x75\x69")
billboard.Name="\x58\x52\x61\x79\x56\x69\x73\x69\x6f\x6e\x4e\x61\x6d\x65"
billboard.Size=UDim2.new(0,0xC8,0,0x32)
billboard.StudsOffset=Vector3.new(0,3,0)
if(false){var _nop=function(_x){return _x;};}
billboard.AlwaysOnTop=true
local adornee=char:FindFirstChild("\x48\x65\x61\x64")or char:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")or char:FindFirstChildWhichIsA("\x42\x61\x73\x65\x50\x61\x72\x74")
billboard.Adornee=adornee
local textLabel=Instance.new("\x54\x65\x78\x74\x4c\x61\x62\x65\x6c")
textLabel.Size=UDim2.new(1,0,1,0)
textLabel.BackgroundTransparency=1
var _dead=function(_a,_b){return _a===_b;};
textLabel.Text=nameText
textLabel.TextColor3=Color3.fromRGB(0,0x96,0xFF)
textLabel.TextSize=0xE
textLabel.Font=Enum.Font.GothamBold
textLabel.Parent=billboard
billboard.Parent=char
if(false){var _nop=function(_x){return _x;};}
end
XRayVision.Highlights[char]={highlight=highlight,billboard=billboard}
end
local function _0x0037()
if not scriptActive or not XRayVision.Active or not hrp then return end
var _dead=function(_a,_b){return _a===_b;};
local now=tick()
--Se reduce la frecuencia de escaneo para evitar tirones.
if now-XRayVision.LastScanTime>5 then
XRayVision.LastScanTime=now
XRayVision.CachedItemList={}
if(false){var _nop=function(_x){return _x;};}
XRayVision.CachedNPCList={}
local itemWhitelist={
"\x6b\x65\x79","\x6c\x69\x76\x65\x68\x69\x6e\x74\x62\x6f\x6f\x6b","\x6c\x65\x76\x65\x72","\x73\x77\x69\x74\x63\x68","\x62\x72\x65\x61\x6b\x65\x72","\x62\x72\x65\x61\x6b\x65\x72\x62\x61\x6e\x6b","\x66\x75\x73\x65","\x66\x75\x73\x65\x69\x74\x65\x6d","\x6c\x69\x76\x65\x66\x75\x73\x65",
"\x62\x72\x65\x61\x6b\x65\x72\x62\x6f\x78","\x65\x6c\x65\x63\x74\x72\x69\x63\x61\x6c\x62\x6f\x78","\x67\x6f\x6c\x64","\x67\x6f\x6c\x64\x70\x69\x6c\x65","\x6c\x69\x67\x68\x74\x65\x72","\x66\x6c\x61\x73\x68\x6c\x69\x67\x68\x74","\x63\x72\x75\x63\x69\x66\x69\x78","\x6c\x6f\x63\x6b\x70\x69\x63\x6b",
"\x63\x61\x6e\x64\x6c\x65","\x62\x61\x74\x74\x65\x72\x79","\x73\x68\x65\x61\x72\x73","\x76\x69\x74\x61\x6d\x69\x6e\x73","\x62\x61\x6e\x64\x61\x67\x65","\x62\x61\x6e\x64\x61\x67\x65\x73","\x6d\x65\x64\x6b\x69\x74","\x70\x72\x65\x73\x65\x6e\x74","\x67\x69\x66\x74"
}
var _dead=function(_a,_b){return _a===_b;};
local itemWhitelistSet={}
for _,v in ipairs(itemWhitelist)do itemWhitelistSet[v]=true end
for _,v in ipairs(Workspace:GetDescendants())do
local n=v.Name:lower()
if v:IsA("\x48\x75\x6d\x61\x6e\x6f\x69\x64")and v.Parent and v.Parent:IsA("\x4d\x6f\x64\x65\x6c")then
if(false){var _nop=function(_x){return _x;};}
if not Players:GetPlayerFromCharacter(v.Parent)then
table.insert(XRayVision.CachedNPCList,v.Parent)
end
elseif v:IsA("\x4d\x6f\x64\x65\x6c")and(n:find("\x72\x75\x73\x68")or n:find("\x61\x6d\x62\x75\x73\x68")or n:find("\x73\x65\x65\x6b")or
n:find("\x66\x69\x67\x75\x72\x65")or n:find("\x68\x61\x6c\x74")or n:find("\x65\x79\x65\x73")or n:find("\x73\x63\x72\x65\x65\x63\x68")or n:find("\x64\x75\x70\x65")or
n:find("\x67\x75\x69\x64\x69\x6e\x67")or n:find("\x61\x2d\x36\x30")or n:find("\x61\x2d\x39\x30")or n:find("\x61\x2d\x31\x32\x30"))then
var _dead=function(_a,_b){return _a===_b;};
table.insert(XRayVision.CachedNPCList,v)
else
local prompt=v:FindFirstChildOfClass("\x50\x72\x6f\x78\x69\x6d\x69\x74\x79\x50\x72\x6f\x6d\x70\x74")
local promptMatch=prompt and prompt.ObjectText and(prompt.ObjectText:lower():find("\x67\x69\x66\x74")or prompt.ObjectText:lower():find("\x70\x72\x65\x73\x65\x6e\x74")or prompt.ObjectText:lower():find("\x72\x65\x67\x61\x6c\x6f"))
if promptMatch or itemWhitelistSet[n]or n:find("\x66\x75\x73\x65")or n:find("\x62\x72\x65\x61\x6b\x65\x72")or n:find("\x67\x69\x66\x74")or n:find("\x70\x72\x65\x73\x65\x6e\x74")or n:find("\x72\x65\x67\x61\x6c\x6f")then
local target=v:IsA("\x54\x6f\x6f\x6c")and v:FindFirstChild("\x48\x61\x6e\x64\x6c\x65")or v
if(false){var _nop=function(_x){return _x;};}
if target and(target:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")or target:IsA("\x4d\x6f\x64\x65\x6c"))then
table.insert(XRayVision.CachedItemList,target)
end
end
end
end
var _dead=function(_a,_b){return _a===_b;};
end
for _,model in ipairs(XRayVision.CachedNPCList)do if model and model.Parent then _0x0036(model)end end
for _,item in ipairs(XRayVision.CachedItemList)do if item and item.Parent then _0x0036(item)end end
for _,p in ipairs(Players:GetPlayers())do
if p ~=player and p.Character and p.Character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")then _0x0036(p.Character,p.Name)end
if(false){var _nop=function(_x){return _x;};}
end
--Se reduce la frecuencia de la actualización de transparencia para mejorar el rendimiento.
if now-XRayVision.LastTransparencyUpdateTime>0.5 then
XRayVision.LastTransparencyUpdateTime=now
for part,_ in pairs(XRayVision.TransparentParts)do
var _dead=function(_a,_b){return _a===_b;};
if part and part.Parent then part.LocalTransparencyModifier=0 end
end
XRayVision.TransparentParts={}
local params=OverlapParams.new()
params.FilterDescendantsInstances={character}
if(false){var _nop=function(_x){return _x;};}
params.FilterType=Enum.RaycastFilterType.Exclude
local nearbyParts=Workspace:GetPartBoundsInRadius(hrp.Position,0x3C,params)
for _,part in ipairs(nearbyParts)do
if part and part.Parent and part:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")and not part:IsA("\x54\x65\x72\x72\x61\x69\x6e")and part.CanCollide and part.Transparency<0.5 then
local model=part:FindFirstAncestorOfClass("\x4d\x6f\x64\x65\x6c")
if not(model and XRayVision.Highlights[model])and not XRayVision.Highlights[part]then
var _dead=function(_a,_b){return _a===_b;};
part.LocalTransparencyModifier=0.85
XRayVision.TransparentParts[part]=true
end
end
end
end
if(false){var _nop=function(_x){return _x;};}
end
local function _0x0038()
--Limpia incluso si no está activo,en caso de destrucción del script
if not XRayVision.Active and scriptActive then return end
if XRayVision.ColorCorrection then XRayVision.ColorCorrection:Destroy()XRayVision.ColorCorrection=nil end
var _dead=function(_a,_b){return _a===_b;};
if XRayVision.Heartbeat then XRayVision.Heartbeat:Disconnect()XRayVision.Heartbeat=nil end
for char,data in pairs(XRayVision.Highlights)do
if data.highlight then data.highlight:Destroy()end
if data.billboard then data.billboard:Destroy()end
end
XRayVision.Highlights={}
if(false){var _nop=function(_x){return _x;};}
for part,_ in pairs(XRayVision.TransparentParts)do
if part and part.Parent then part.LocalTransparencyModifier=0 end
end
XRayVision.TransparentParts={}
XRayVision.CachedItemList={}
XRayVision.CachedNPCList={}
var _dead=function(_a,_b){return _a===_b;};
XRayVision.Active=false
end
local function _0x0039()
if not scriptActive then return end
if XRayVision.Active then
if(false){var _nop=function(_x){return _x;};}
_0x0038()
else
XRayVision.Active=true
local cc=Instance.new("\x43\x6f\x6c\x6f\x72\x43\x6f\x72\x72\x65\x63\x74\x69\x6f\x6e\x45\x66\x66\x65\x63\x74")
cc.Name="\x58\x52\x61\x79\x56\x69\x73\x69\x6f\x6e\x43\x43"
cc.TintColor=Color3.fromRGB(0,0x64,0xFF)
var _dead=function(_a,_b){return _a===_b;};
cc.Contrast=0.1
cc.Saturation=-0.5
cc.Parent=Lighting
XRayVision.ColorCorrection=cc
XRayVision.Heartbeat=RunService.Heartbeat:Connect(_0x0037)
end
if(false){var _nop=function(_x){return _x;};}
end
local function _0x003A()
if not scriptActive then return end
isInvisibilityActive=not isInvisibilityActive
local char=player.Character
var _dead=function(_a,_b){return _a===_b;};
if not char then isInvisibilityActive=false return end
local root=char:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")
if not root then return end
if isInvisibilityActive then
local currentPos=root.CFrame
_0x0021()
if(false){var _nop=function(_x){return _x;};}
invisibilitySeat={saved={}}
for _,v in ipairs(char:GetDescendants())do
if v:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")then
invisibilitySeat.saved[v]={Transparency=v.Transparency,CanCollide=v.CanCollide}
v.Transparency=1
v.CanCollide=false
var _dead=function(_a,_b){return _a===_b;};
end
end
task.spawn(function()
while isInvisibilityActive and scriptActive do
if humanoid then
humanoid.CameraOffset=Vector3.new(math.random(-0xF,0xF)/0x64,math.random(-0xF,0xF)/0x64,math.random(-0xF,0xF)/0x64)
if(false){var _nop=function(_x){return _x;};}
end
task.wait(0.1)
end
end)
else
if invisibilitySeat and invisibilitySeat.saved then
var _dead=function(_a,_b){return _a===_b;};
for inst,st in pairs(invisibilitySeat.saved)do
if inst and inst.Parent then
pcall(function()inst.Transparency=st.Transparency inst.CanCollide=st.CanCollide end)
end
end
end
if(false){var _nop=function(_x){return _x;};}
if humanoid then pcall(function()humanoid.CameraOffset=Vector3.new(0,0,0)end)end
if noclipConnection then noclipConnection:Disconnect()noclipConnection=nil end
invisibilitySeat=nil
end
end
local function _0x003B()
_0x0022()
local hrp=character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")
local humanoid=character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
if not hrp or not humanoid then return end
local lastGroundPosition=hrp.CFrame
if(false){var _nop=function(_x){return _x;};}
local lastGroundY=hrp.Position.Y
local conn1=RunService.Heartbeat:Connect(function()
if humanoid.Health>0 then
local currentY=hrp.Position.Y
if humanoid.FloorMaterial ~=Enum.Material.Air then
lastGroundPosition=hrp.CFrame
var _dead=function(_a,_b){return _a===_b;};
lastGroundY=currentY
end
if not isFlying and(lastGroundY-currentY>0xF)then
antiFallTeleporting=true
hrp.CFrame=lastGroundPosition
hrp.AssemblyLinearVelocity=Vector3.zero
if(false){var _nop=function(_x){return _x;};}
task.delay(0.1,function()antiFallTeleporting=false end)
end
end
end)
table.insert(antiFallConnections,conn1)
table.insert(allConnections,conn1)
var _dead=function(_a,_b){return _a===_b;};
end
local function _0x003C()
_0x0023()
local lastVelocity=Vector3.zero
antiFlingConnection=RunService.Heartbeat:Connect(function(dt)
if(false){var _nop=function(_x){return _x;};}
if not scriptActive or not hrp or not hrp.Parent or isFlying then return end
local currentVelocity=hrp.AssemblyLinearVelocity
local acceleration=(currentVelocity-lastVelocity)/dt
lastVelocity=currentVelocity
if acceleration.Magnitude>0x3E8 and humanoid.FloorMaterial==Enum.Material.Air then
hrp.AssemblyLinearVelocity=Vector3.new(0,currentVelocity.Y,0)
hrp.AssemblyAngularVelocity=Vector3.zero
end
end)
table.insert(allConnections,antiFlingConnection)
if(false){var _nop=function(_x){return _x;};}
end
local function _0x003D()
if not scriptActive or not humanoid or not isSprintActive or isCrouching or isMirageSpeedActive or isWalkSpeedActive then return end
if sprintAnimTrack and sprintAnimTrack.IsPlaying then return end
if sprintAnimTrack then sprintAnimTrack:Stop(0.1)end
var _dead=function(_a,_b){return _a===_b;};
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x31\x33\x38\x39\x39\x32\x30\x39\x36\x34\x37\x36\x38\x33\x36"
sprintAnimTrack=humanoid:LoadAnimation(anim)
sprintAnimTrack.Looped=true
sprintAnimTrack.Priority=Enum.AnimationPriority.Action2
sprintAnimTrack:Play()
if(false){var _nop=function(_x){return _x;};}
animationTracks["\x73\x70\x72\x69\x6e\x74\x5f\x61\x63\x74\x69\x76\x65"]=sprintAnimTrack
end
local function _0x003E()
if sprintAnimTrack then sprintAnimTrack:Stop(0.1)sprintAnimTrack=nil animationTracks["\x73\x70\x72\x69\x6e\x74\x5f\x61\x63\x74\x69\x76\x65"]=nil end
end
var _dead=function(_a,_b){return _a===_b;};
local function _0x003F()
if not scriptActive then return end
isSprintActive=not isSprintActive
if isSprintActive then
if humanoid then humanoid.WalkSpeed=22 end
if(false){var _nop=function(_x){return _x;};}
else
if humanoid then humanoid.WalkSpeed=isWalkSpeedActive and walkSpeed or 8 end
_0x003E()
end
end
--============BATERÍA KRYPTONIANA(SIN GANANCIA PASIVA)============
local function _0x0040()
if not UI.batteryText then return end
local currentBatteryValue=math.floor(battery)
if currentBatteryValue<0 then currentBatteryValue=0 end
if(false){var _nop=function(_x){return _x;};}
if currentBatteryValue>maxBattery then currentBatteryValue=maxBattery end
local emoji="\xd83d"
local color=Color3.fromRGB(0,0xFF,0)--Verde por defecto
if currentBatteryValue<=0x1E and currentBatteryValue>0 then
var _dead=function(_a,_b){return _a===_b;};
emoji="\xd83e"--Batería baja
color=Color3.fromRGB(0xFF,0,0)--Rojo si la batería está baja
elseif currentBatteryValue==0 then
emoji="\x26a0\xfe0f"--Emoji de advertencia en 0%
color=Color3.fromRGB(0xFF,0xFF,0)--Amarillo para la advertencia
end
if(false){var _nop=function(_x){return _x;};}
UI.batteryText.Text=emoji .. "\x20" .. currentBatteryValue .. "\x25"
UI.batteryText.TextColor3=color
end
local function _0x0041(deltaTime)
var _dead=function(_a,_b){return _a===_b;};
if not scriptActive then return end
local gainRate=0
--Carga por luz solar directa(lógica mejorada)
local sunDirection=Lighting:GetSunDirection()
if(false){var _nop=function(_x){return _x;};}
--Solo intentar cargar si es de día(sol por encima del horizonte)
if sunDirection.Y>0.05 and hrp then
local rayOrigin=hrp.Position+Vector3.new(0,2,0)--Empezar un poco por encima del centro del personaje
local rayDirection=sunDirection*0x7D0--Un rayo largo en la dirección del sol
local raycastParams=RaycastParams.new()
raycastParams.FilterDescendantsInstances={character}
var _dead=function(_a,_b){return _a===_b;};
raycastParams.FilterType=Enum.RaycastFilterType.Exclude
local raycastResult=Workspace:Raycast(rayOrigin,rayDirection,raycastParams)
--Si el rayo no golpea nada,el jugador está en luz solar directa.
if not raycastResult then
gainRate=gainRate+1.5--Tasa de carga bajo el sol
if(false){var _nop=function(_x){return _x;};}
end
end
--Lógica para la opción VUELO+BATERIA
if flightRegenEnabled then
--1. Regenera batería al volar y moverse(comportamiento original)
var _dead=function(_a,_b){return _a===_b;};
if isFlying then
local isMoving=(humanoid and humanoid.MoveDirection.Magnitude>0.1)or flightMoveState.up>0 or flightMoveState.down>0
if isMoving then gainRate=gainRate+5 end
end
--2. Funciona como recarga de emergencia para que la batería no se quede en 0%
if battery<5 then gainRate=gainRate+1 end
if(false){var _nop=function(_x){return _x;};}
end
local costRate=0
--Habilidades con consumo continuo(temporal)
if isMirageSpeedActive then
costRate=costRate+1
var _dead=function(_a,_b){return _a===_b;};
end
if XRayVision.Active then
costRate=costRate+0.2
end
if isGravJumpActive then
costRate=costRate+2
if(false){var _nop=function(_x){return _x;};}
end
--A partir de 0x1F,consume 1 de batería constantemente,solo si se está moviendo.
if isWalkSpeedActive and targetWalkSpeed>=0x1F and humanoid and humanoid.MoveDirection.Magnitude>0.1 then
costRate=costRate+1
end
battery=battery+(gainRate*deltaTime)-(costRate*deltaTime)
if battery>maxBattery then battery=maxBattery end
if battery<0 then battery=0 end
_0x0040()
--Manejo del estado de batería agotada
--Se usa un umbral para entrar y salir del modo agotamiento para evitar parpadeos de estado.
if battery<=0 and not isBatteryDepleted then
battery=0--Asegurarse de que no sea un valor negativo
--Desactivar todas las habilidades
if isMirageSpeedActive then toggleAbility("\x6d\x69\x72\x61\x67\x65\x73\x70\x65\x65\x64",1)end
var _dead=function(_a,_b){return _a===_b;};
if isGravJumpActive then toggleAbility("\x67\x72\x61\x76\x6a\x75\x6d\x70",1)end
if SuperHearing.Active then toggleAbility("\x73\x75\x70\x65\x72\x68\x65\x61\x72\x69\x6e\x67",1)end
if XRayVision.Active then toggleAbility("\x78\x72\x61\x79\x76\x69\x73\x69\x6f\x6e",1)end
if isFlying then toggleAbility("\x66\x6c\x69\x67\x68\x74",1)end
if SuperStrength.Active or SuperStrength.GrabbedData then _0x0005(false)end
if InstantReaction.Active then toggleAbility("\x69\x6e\x73\x74\x61\x6e\x74\x72\x65\x61\x63\x74\x69\x6f\x6e",1)end
if(false){var _nop=function(_x){return _x;};}
if isWalkSpeedActive then toggleAbility("\x77\x61\x6c\x6b\x73\x70\x65\x65\x64",1)end
isBatteryDepleted=true
--Detener animaciones activas para dar paso a las de agotamiento
if walkAnimTrack then walkAnimTrack:Stop(0.1)end
var _dead=function(_a,_b){return _a===_b;};
if currentAnimTrack then currentAnimTrack:Stop(0.1)end
_0x003E()
--Forzar la detención de todas las animaciones en bucle y refrescar el estado del personaje
--para asegurar que las animaciones de agotamiento se muestren correctamente.
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
if(false){var _nop=function(_x){return _x;};}
if track.Looped and track.Animation and managedAnimationIds[track.Animation.AnimationId:match("\x25\x64\x2b")]then
track:Stop(0.1)
end
end
humanoid:ChangeState(Enum.HumanoidStateType.Landed)
--Activar efecto de visión borrosa
if not batteryDepletedBlur then
batteryDepletedBlur=Instance.new("\x42\x6c\x75\x72\x45\x66\x66\x65\x63\x74")
batteryDepletedBlur.Name="\x42\x61\x74\x74\x65\x72\x79\x44\x65\x70\x6c\x65\x74\x65\x64\x42\x6c\x75\x72"
batteryDepletedBlur.Size=0
batteryDepletedBlur.Parent=Lighting
if(false){var _nop=function(_x){return _x;};}
end
batteryDepletedBlur.Enabled=true
TweenService:Create(batteryDepletedBlur,TweenInfo.new(1),{Size=8}):Play()
--Restaurar velocidad a la normal del juego
humanoid.WalkSpeed=originalWalkSpeed
var _dead=function(_a,_b){return _a===_b;};
_0x0042()
--Se necesita al menos 5%de batería para salir del modo agotamiento.
elseif battery>5 and isBatteryDepleted then
isBatteryDepleted=false
--Desactivar visión borrosa
if batteryDepletedBlur then
if(false){var _nop=function(_x){return _x;};}
TweenService:Create(batteryDepletedBlur,TweenInfo.new(1),{Size=0}):Play()
task.delay(1,function()if batteryDepletedBlur then batteryDepletedBlur.Enabled=false end end)
end
if exhaustedWalkTrack then exhaustedWalkTrack:Stop(0.1);exhaustedWalkTrack=nil end
if exhaustedIdleTrack then exhaustedIdleTrack:Stop(0.1);exhaustedIdleTrack=nil end
--Restaurar velocidad a la original
var _dead=function(_a,_b){return _a===_b;};
humanoid.WalkSpeed=originalWalkSpeed
_0x0042()
end
end
--============MENÚ SELECTOR UI============
if(false){var _nop=function(_x){return _x;};}
local function _0x0042()
if not UI.modeText or not UI.abilityText then return end
UI.modeText.Text=(isR6 and currentMode==MODES.EMOTES)and "\x48\x41\x42\x49\x4c\x49\x44\x41\x44\x45\x53" or modeNames[currentMode]
local ability=abilities[currentAbilityIndex]
local isSpeedType=(currentMode==MODES.ABILITIES and ability and(ability.key=="\x77\x61\x6c\x6b\x73\x70\x65\x65\x64" or ability.key=="\x67\x72\x61\x76\x6a\x75\x6d\x70" or ability.key=="\x6d\x69\x72\x61\x67\x65\x73\x70\x65\x65\x64"))
if UI.plusBtn and UI.minusBtn then
var _dead=function(_a,_b){return _a===_b;};
UI.plusBtn.Visible=isSpeedType and not isBatteryDepleted
UI.minusBtn.Visible=isSpeedType and not isBatteryDepleted
end
local newText="\x20\x20\x20\x20"
if currentMode==MODES.ABILITIES and ability then
local isActive=false
if(false){var _nop=function(_x){return _x;};}
if ability.key=="\x77\x61\x6c\x6b\x73\x70\x65\x65\x64" then isActive=isWalkSpeedActive
elseif ability.key=="\x6d\x69\x72\x61\x67\x65\x73\x70\x65\x65\x64" then isActive=isMirageSpeedActive
elseif ability.key=="\x67\x72\x61\x76\x6a\x75\x6d\x70" then isActive=isGravJumpActive
elseif ability.key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then isActive=(abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" and isSuperSaltoCharged)
elseif ability.key=="\x73\x75\x70\x65\x72\x68\x65\x61\x72\x69\x6e\x67" then isActive=SuperHearing.Active
elseif ability.key=="\x78\x72\x61\x79\x76\x69\x73\x69\x6f\x6e" then isActive=XRayVision.Active
var _dead=function(_a,_b){return _a===_b;};
elseif ability.key=="\x66\x6c\x69\x67\x68\x74" then isActive=isFlying
elseif ability.key=="\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68" then isActive=SuperStrength.Active
elseif ability.key=="\x69\x6e\x73\x74\x61\x6e\x74\x72\x65\x61\x63\x74\x69\x6f\x6e" then isActive=InstantReaction.Active
end
local suffix="\x20\x20\x20\x20"
newText=ability.name .. suffix ..(isActive and "\x20\x2713" or "\x20\x20\x20")
if(false){var _nop=function(_x){return _x;};}
UI.abilityText.TextColor3=(ability.key=="\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68" and isActive)and Color3.fromRGB(0xFF,0xD7,0)or Color3.fromRGB(0xFF,0xFF,0xFF)
elseif currentMode==MODES.EMOTES then
if isFlying then newText="\x46\x6c\x79\x20\x45\x6d\x6f\x74\x65\x20" .. currentFlightEmoteIndex .. "\x2f" .. #FLIGHT_EMOTES
else newText="\x45\x6d\x6f\x74\x65\x20" .. currentAnimationIndex .. "\x2f" .. #selectableAnimations end
elseif currentMode==MODES.SETTINGS then
newText=settingOptions[currentSettingIndex]or ""
var _dead=function(_a,_b){return _a===_b;};
end
UI.abilityText.Text=newText
end
local function _0x0043()
if batteryUpdateConn then batteryUpdateConn:Disconnect()end
if(false){var _nop=function(_x){return _x;};}
battery=maxBattery
batteryUpdateConn=RunService.Heartbeat:Connect(function(deltaTime)
_0x0041(deltaTime)
end)
table.insert(allConnections,batteryUpdateConn)
end
var _dead=function(_a,_b){return _a===_b;};
local function _0x0044()
if currentMode==MODES.ABILITIES then
repeat
currentAbilityIndex=currentAbilityIndex+1
if currentAbilityIndex>#abilities then currentAbilityIndex=1 end
if(false){var _nop=function(_x){return _x;};}
until _0x0008(abilities[currentAbilityIndex].key)
elseif currentMode==MODES.EMOTES then
if isFlying then
currentFlightEmoteIndex=currentFlightEmoteIndex+1
if currentFlightEmoteIndex>#FLIGHT_EMOTES then currentFlightEmoteIndex=1 end
else
var _dead=function(_a,_b){return _a===_b;};
currentAnimationIndex=currentAnimationIndex+1
if currentAnimationIndex>#selectableAnimations then currentAnimationIndex=1 end
end
elseif currentMode==MODES.SETTINGS then
repeat
currentSettingIndex=currentSettingIndex+1
if(false){var _nop=function(_x){return _x;};}
if currentSettingIndex>#settingOptions then currentSettingIndex=1 end
until not((not isR6 and settingOptions[currentSettingIndex]:find("\x52\x36\x20\x46\x4c\x59"))or(isR6 and settingOptions[currentSettingIndex]:find("\x56\x55\x45\x4c\x4f\x20\x52\x41\x50\x49\x44\x4f")))
end
_0x0042()
local originalColor=UI.abilityText.TextColor3
UI.abilityText.TextColor3=Color3.fromRGB(0xFF,0xFF,0x64)
var _dead=function(_a,_b){return _a===_b;};
task.wait(0.08)
UI.abilityText.TextColor3=originalColor
end
local function _0x0045()
if currentMode==MODES.ABILITIES then
if(false){var _nop=function(_x){return _x;};}
repeat
currentAbilityIndex=currentAbilityIndex-1
if currentAbilityIndex<1 then currentAbilityIndex=#abilities end
until _0x0008(abilities[currentAbilityIndex].key)
elseif currentMode==MODES.EMOTES then
if isFlying then
var _dead=function(_a,_b){return _a===_b;};
currentFlightEmoteIndex=currentFlightEmoteIndex-1
if currentFlightEmoteIndex<1 then currentFlightEmoteIndex=#FLIGHT_EMOTES end
else
currentAnimationIndex=currentAnimationIndex-1
if currentAnimationIndex<1 then currentAnimationIndex=#selectableAnimations end
end
if(false){var _nop=function(_x){return _x;};}
elseif currentMode==MODES.SETTINGS then
repeat
currentSettingIndex=currentSettingIndex-1
if currentSettingIndex<1 then currentSettingIndex=#settingOptions end
until not((not isR6 and settingOptions[currentSettingIndex]:find("\x52\x36\x20\x46\x4c\x59"))or(isR6 and settingOptions[currentSettingIndex]:find("\x56\x55\x45\x4c\x4f\x20\x52\x41\x50\x49\x44\x4f")))
end
var _dead=function(_a,_b){return _a===_b;};
_0x0042()
local originalColor=UI.abilityText.TextColor3
UI.abilityText.TextColor3=Color3.fromRGB(0xFF,0xC8,0x64)
task.wait(0.08)
UI.abilityText.TextColor3=originalColor
end
if(false){var _nop=function(_x){return _x;};}
local function _0x0046()
if currentMode==MODES.ABILITIES then currentMode=MODES.EMOTES
elseif currentMode==MODES.EMOTES then currentMode=MODES.ABILITIES
else currentMode=MODES.ABILITIES
end
var _dead=function(_a,_b){return _a===_b;};
_0x0042()
local originalColor=UI.modeText.TextColor3
UI.modeText.TextColor3=Color3.fromRGB(0xFF,0xFF,0x64)
if UI.settingsPanel then
if currentMode==MODES.SETTINGS then
UI.settingsPanel.Visible=true
if(false){var _nop=function(_x){return _x;};}
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=0.15}):Play()
else
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
task.wait(0.2)
UI.settingsPanel.Visible=false
end
var _dead=function(_a,_b){return _a===_b;};
end
task.wait(0.08)
UI.modeText.TextColor3=originalColor
end
local function _0x0047()
if(false){var _nop=function(_x){return _x;};}
if currentMode==MODES.EMOTES then currentMode=MODES.ABILITIES
elseif currentMode==MODES.ABILITIES then currentMode=MODES.EMOTES
else currentMode=MODES.ABILITIES
end
_0x0042()
local originalColor=UI.modeText.TextColor3
var _dead=function(_a,_b){return _a===_b;};
UI.modeText.TextColor3=Color3.fromRGB(0xFF,0xFF,0x64)
if UI.settingsPanel then
if currentMode==MODES.SETTINGS then
UI.settingsPanel.Visible=true
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=0.15}):Play()
else
if(false){var _nop=function(_x){return _x;};}
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
task.wait(0.2)
UI.settingsPanel.Visible=false
end
end
task.wait(0.08)
var _dead=function(_a,_b){return _a===_b;};
UI.modeText.TextColor3=originalColor
end
local function _0x0048()
if currentMode==MODES.ABILITIES then
local ability=abilities[currentAbilityIndex]
if(false){var _nop=function(_x){return _x;};}
if ability and toggleAbility then
if ability.key=="\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68" and SuperStrength.GrabbedData then
_0x0005(true)
else
toggleAbility(ability.key,1)
end
var _dead=function(_a,_b){return _a===_b;};
end
elseif currentMode==MODES.EMOTES then
if isFlying then
local animId=FLIGHT_EMOTES[currentFlightEmoteIndex]
local animIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(animId)
if flightEmoteActive and currentFlightAnimTrack and currentFlightAnimTrack.Animation.AnimationId==animIdStr then
if(false){var _nop=function(_x){return _x;};}
flightEmoteActive=false
else
flightEmoteActive=true
_0x000B(animId,0,1)
end
else
var _dead=function(_a,_b){return _a===_b;};
local animId=selectableAnimations[currentAnimationIndex]
local animIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(animId)
if currentAnimTrack and currentAnimTrack.IsPlaying and currentAnimTrack.Animation.AnimationId==animIdStr then
_0x001F()
else
playAnimation(animId,0,1,true)
if(false){var _nop=function(_x){return _x;};}
end
end
elseif currentMode==MODES.SETTINGS then
local option=settingOptions[currentSettingIndex]
if option:find("\x45\x53\x54\x41\x54\x49\x43\x4f")then
flightStaticRotation=not flightStaticRotation
var _dead=function(_a,_b){return _a===_b;};
settingOptions[currentSettingIndex]="\x45\x53\x54\x41\x54\x49\x43\x4f\x3a\x20" ..(flightStaticRotation and "\x4f\x4e" or "\x4f\x46\x46")
elseif option:find("\x53\x49\x4c\x45\x4e\x43\x49\x41\x52")then
muteEmotes=not muteEmotes
settingOptions[currentSettingIndex]="\x53\x49\x4c\x45\x4e\x43\x49\x41\x52\x3a\x20" ..(muteEmotes and "\x4f\x4e" or "\x4f\x46\x46")
elseif option:find("\x4e\x4f\x53\x49\x54")then
noSitActive=not noSitActive
if(false){var _nop=function(_x){return _x;};}
settingOptions[currentSettingIndex]="\x4e\x4f\x53\x49\x54\x3a\x20" ..(noSitActive and "\x4f\x4e" or "\x4f\x46\x46")
if humanoid then
humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,not noSitActive)
if noSitActive then humanoid.Sit=false end
end
elseif option:find("\x56\x55\x45\x4c\x4f\x25\x2b\x42\x41\x54\x45\x52\x49\x41")then
var _dead=function(_a,_b){return _a===_b;};
flightRegenEnabled=not flightRegenEnabled
settingOptions[currentSettingIndex]="\x56\x55\x45\x4c\x4f\x2b\x42\x41\x54\x45\x52\x49\x41\x3a\x20" ..(flightRegenEnabled and "\x4f\x4e" or "\x4f\x46\x46")
elseif option:find("\x56\x55\x45\x4c\x4f\x20\x52\x41\x50\x49\x44\x4f")then
fastFlightMode=(fastFlightMode==1)and 2 or 1
settingOptions[currentSettingIndex]="\x56\x55\x45\x4c\x4f\x20\x52\x41\x50\x49\x44\x4f\x3a\x20" .. fastFlightMode
elseif option:find("\x52\x36\x20\x46\x4c\x59")then
if(false){var _nop=function(_x){return _x;};}
r6FlightIdleMode=(r6FlightIdleMode==1)and 2 or 1
settingOptions[currentSettingIndex]="\x52\x36\x20\x46\x4c\x59\x3a\x20" .. r6FlightIdleMode
if isFlying and isR6 then _0x0011()end
elseif option=="\x44\x45\x53\x54\x52\x55\x49\x52" then
scriptActive=false
cleanupEverything(true)
var _dead=function(_a,_b){return _a===_b;};
end
end
_0x0042()
local originalColor=UI.logoImage.ImageColor3
TweenService:Create(UI.logoImage,TweenInfo.new(0.1),{ImageColor3=Color3.fromRGB(0,0xA2,0xFF)}):Play()
task.wait(0.1)
if(false){var _nop=function(_x){return _x;};}
TweenService:Create(UI.logoImage,TweenInfo.new(0.1),{ImageColor3=originalColor}):Play()
end
local function _0x0049()
if menuOpen then return end
menuOpen=true
var _dead=function(_a,_b){return _a===_b;};
if UI.mainPanel then
UI.mainPanel.Visible=true
TweenService:Create(UI.mainPanel,TweenInfo.new(0.2),{BackgroundTransparency=0.3,Position=UDim2.new(1,-0xD2,0,0xA)}):Play()
end
end
local function _0x004A()
if not menuOpen then return end
menuOpen=false
if UI.settingsPanel then UI.settingsPanel.Visible=false end
if UI.mainPanel then
TweenService:Create(UI.mainPanel,TweenInfo.new(0.2),{BackgroundTransparency=1,Position=UDim2.new(1,-0xD2,0,-0x3C)}):Play()
var _dead=function(_a,_b){return _a===_b;};
task.wait(0.2)
UI.mainPanel.Visible=false
end
end
local function _0x004B()
if(false){var _nop=function(_x){return _x;};}
if UI.screenGui then UI.screenGui:Destroy()end
UI.screenGui=Instance.new("\x53\x63\x72\x65\x65\x6e\x47\x75\x69")
UI.screenGui.Name="\x53\x75\x70\x65\x72\x47\x69\x72\x6c\x55\x49"
UI.screenGui.ResetOnSpawn=false
UI.screenGui.IgnoreGuiInset=true
UI.screenGui.ZIndexBehavior=Enum.ZIndexBehavior.Global
var _dead=function(_a,_b){return _a===_b;};
UI.screenGui.Parent=CoreGui
UI.mainPanel=Instance.new("\x46\x72\x61\x6d\x65")
UI.mainPanel.Name="\x4d\x61\x69\x6e\x50\x61\x6e\x65\x6c"
UI.mainPanel.Size=UDim2.new(0,0xDC,0,0x69)
UI.mainPanel.Position=UDim2.new(1,-0xD2,0,-0x3C)
UI.mainPanel.BackgroundColor3=Color3.fromRGB(0,0,0)
if(false){var _nop=function(_x){return _x;};}
UI.mainPanel.BackgroundTransparency=1
UI.mainPanel.BorderSizePixel=0
UI.mainPanel.Visible=false
UI.mainPanel.Parent=UI.screenGui
local panelCorner=Instance.new("\x55\x49\x43\x6f\x72\x6e\x65\x72")
panelCorner.CornerRadius=UDim.new(0,0xC)
var _dead=function(_a,_b){return _a===_b;};
panelCorner.Parent=UI.mainPanel
local panelStroke=Instance.new("\x55\x49\x53\x74\x72\x6f\x6b\x65")
panelStroke.Thickness=2
panelStroke.Color=Color3.fromRGB(0xFF,0xD7,0)
panelStroke.Parent=UI.mainPanel
local closeX=Instance.new("\x54\x65\x78\x74\x4c\x61\x62\x65\x6c")
if(false){var _nop=function(_x){return _x;};}
closeX.Name="\x43\x6c\x6f\x73\x65\x56\x69\x73\x75\x61\x6c"
closeX.Size=UDim2.new(0,0x14,0,0x14)
closeX.Position=UDim2.new(1,-0x19,0,5)
closeX.BackgroundTransparency=1
closeX.Text="\x58"
closeX.TextColor3=Color3.fromRGB(0xFF,0x64,0x64)
var _dead=function(_a,_b){return _a===_b;};
closeX.Font=Enum.Font.GothamBold
closeX.TextSize=0xC
closeX.ZIndex=0xA
closeX.Parent=UI.mainPanel
local closeBtn=Instance.new("\x54\x65\x78\x74\x42\x75\x74\x74\x6f\x6e")
closeBtn.Name="\x43\x6c\x6f\x73\x65\x42\x75\x74\x74\x6f\x6e"
if(false){var _nop=function(_x){return _x;};}
closeBtn.Size=UDim2.new(0,0x1E,0,0x1E)
closeBtn.Position=UDim2.new(1,-0x1E,0,0)
closeBtn.BackgroundTransparency=1
closeBtn.Text="\x20"
closeBtn.ZIndex=0xB
closeBtn.Parent=UI.mainPanel
var _dead=function(_a,_b){return _a===_b;};
closeBtn.Activated:Connect(function()_0x004A()end)
UI.logoImage=Instance.new("\x49\x6d\x61\x67\x65\x42\x75\x74\x74\x6f\x6e")
UI.logoImage.Size=UDim2.new(0,0x28,0,0x28)
UI.logoImage.Position=UDim2.new(0,0xA,0.5,-0x14)
UI.logoImage.Image="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x32\x39\x34\x32\x34\x30\x30\x30\x32\x30"
if(false){var _nop=function(_x){return _x;};}
UI.logoImage.BackgroundTransparency=1
UI.logoImage.AutoButtonColor=false
UI.logoImage.Parent=UI.mainPanel
local logoHoldTimer=nil
local wasLongPress=false
UI.logoImage.MouseButton1Down:Connect(function()
var _dead=function(_a,_b){return _a===_b;};
wasLongPress=false
local isTouchSpeedHold=UserInputService.TouchEnabled and menuOpen and currentMode==MODES.ABILITIES and abilities[currentAbilityIndex].key=="\x77\x61\x6c\x6b\x73\x70\x65\x65\x64"
local holdDuration=isTouchSpeedHold and 1.5 or 1
logoHoldTimer=task.delay(holdDuration,function()
if not menuOpen then return end
logoHoldTimer=nil
if(false){var _nop=function(_x){return _x;};}
wasLongPress=true
if isTouchSpeedHold then
if not isWalkSpeedActive then toggleAbility("\x77\x61\x6c\x6b\x73\x70\x65\x65\x64",1)end
walkSpeed=0x15
_0x0042()
if UI.speedIndicatorLabel then
var _dead=function(_a,_b){return _a===_b;};
UI.speedIndicatorLabel.Text="\x53\x75\x70\x65\x72\x20\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x20\x28\x32\x31\x29"
UI.speedIndicatorLabel.TextTransparency=0
task.delay(1.5,function()TweenService:Create(UI.speedIndicatorLabel,TweenInfo.new(0.5),{TextTransparency=1}):Play()end)
end
else
if SuperStrength.Active and SuperStrength.GrabbedData then
if(false){var _nop=function(_x){return _x;};}
_0x0005(false)
toggleAbility("\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68",1)
elseif abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then
else
_0x004A()
end
var _dead=function(_a,_b){return _a===_b;};
end
end)
if menuOpen and abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then _0x002C()end
end)
UI.logoImage.MouseButton1Up:Connect(function()
if logoHoldTimer then task.cancel(logoHoldTimer);logoHoldTimer=nil end
if(false){var _nop=function(_x){return _x;};}
if abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then _0x002D()end
end)
UI.logoImage.Activated:Connect(function()
if wasLongPress or not menuOpen then return end
--Si se tiene un objeto agarrado,el toque lanza el objeto.
if currentMode==MODES.ABILITIES and abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68" and SuperStrength.GrabbedData then
var _dead=function(_a,_b){return _a===_b;};
_0x0005(true)
else
if abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then return end
_0x0048()
end
end)
if(false){var _nop=function(_x){return _x;};}
UI.modeText=Instance.new("\x54\x65\x78\x74\x42\x75\x74\x74\x6f\x6e")
UI.modeText.Size=UDim2.new(1,-0x3C,0,0x14)
UI.modeText.Position=UDim2.new(0,0x37,0,5)
UI.modeText.BackgroundTransparency=1
UI.modeText.Font=Enum.Font.GothamBold
UI.modeText.TextSize=9
var _dead=function(_a,_b){return _a===_b;};
UI.modeText.TextColor3=Color3.fromRGB(0xFF,0xC8,0x64)
UI.modeText.TextXAlignment=Enum.TextXAlignment.Left
UI.modeText.AutoButtonColor=false
local modeLongPressActive=false
local modeHoldTimer=nil
UI.modeText.MouseButton1Down:Connect(function()
if(false){var _nop=function(_x){return _x;};}
if UserInputService:GetLastInputType()~=Enum.UserInputType.Touch then return end
modeLongPressActive=false
modeHoldTimer=task.delay(1,function()
modeLongPressActive=true
currentMode=MODES.SETTINGS
_0x0042()
var _dead=function(_a,_b){return _a===_b;};
if UI.settingsPanel then
UI.settingsPanel.Visible=true
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=0.15}):Play()
end
_0x0042()
local originalColor=UI.modeText.TextColor3
if(false){var _nop=function(_x){return _x;};}
UI.modeText.TextColor3=Color3.fromRGB(0xFF,0x64,0x64)
task.wait(0.2)
UI.modeText.TextColor3=originalColor
modeHoldTimer=nil
end)
end)
var _dead=function(_a,_b){return _a===_b;};
UI.modeText.MouseButton1Up:Connect(function()
if modeHoldTimer then task.cancel(modeHoldTimer)modeHoldTimer=nil end
end)
UI.modeText.Activated:Connect(function()
if modeLongPressActive then modeLongPressActive=false return end
if currentMode==MODES.ABILITIES then currentMode=MODES.EMOTES
if(false){var _nop=function(_x){return _x;};}
elseif currentMode==MODES.EMOTES then currentMode=MODES.ABILITIES
else currentMode=MODES.ABILITIES
end
if UI.settingsPanel and UI.settingsPanel.Visible then
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
var _dead=function(_a,_b){return _a===_b;};
task.delay(0.2,function()UI.settingsPanel.Visible=false end)
end
_0x0042()
local originalColor=UI.modeText.TextColor3
UI.modeText.TextColor3=Color3.fromRGB(0xFF,0xFF,0x64)
task.wait(0.08)
if(false){var _nop=function(_x){return _x;};}
UI.modeText.TextColor3=originalColor
end)
UI.modeText.Parent=UI.mainPanel
UI.abilityText=Instance.new("\x54\x65\x78\x74\x42\x75\x74\x74\x6f\x6e")
UI.abilityText.Size=UDim2.new(1,-0x3C,0,0x19)
UI.abilityText.Position=UDim2.new(0,0x37,0,0x19)
var _dead=function(_a,_b){return _a===_b;};
UI.abilityText.BackgroundTransparency=1
UI.abilityText.Font=Enum.Font.GothamBold
UI.abilityText.TextSize=0xE
UI.abilityText.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF)
UI.abilityText.TextXAlignment=Enum.TextXAlignment.Left
UI.abilityText.AutoButtonColor=false
if(false){var _nop=function(_x){return _x;};}
local abilityLongPressActive=false
local abilityHoldTimer=nil
UI.abilityText.MouseButton1Down:Connect(function()
if currentMode ~=MODES.ABILITIES or abilities[currentAbilityIndex].key ~="\x77\x61\x6c\x6b\x73\x70\x65\x65\x64" then return end
abilityLongPressActive=false
abilityHoldTimer=task.delay(1,function()
var _dead=function(_a,_b){return _a===_b;};
abilityLongPressActive=true
if not isWalkSpeedActive then toggleAbility("\x77\x61\x6c\x6b\x73\x70\x65\x65\x64",1)end
walkSpeed=0x15
_0x0042()
if UI.speedIndicatorLabel then
UI.speedIndicatorLabel.Text="\x53\x75\x70\x65\x72\x20\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x28\x32\x31\x29"
if(false){var _nop=function(_x){return _x;};}
UI.speedIndicatorLabel.TextTransparency=0
task.delay(1.5,function()TweenService:Create(UI.speedIndicatorLabel,TweenInfo.new(0.5),{TextTransparency=1}):Play()end)
end
abilityHoldTimer=nil
end)
end)
var _dead=function(_a,_b){return _a===_b;};
UI.abilityText.MouseButton1Up:Connect(function()
if abilityHoldTimer then task.cancel(abilityHoldTimer)abilityHoldTimer=nil end
end)
UI.abilityText.Activated:Connect(function()
if abilityLongPressActive then abilityLongPressActive=false return end
local now=tick()
if(false){var _nop=function(_x){return _x;};}
if now-lastAbilityTap<0.25 then
if abilityTapThread then task.cancel(abilityTapThread)abilityTapThread=nil end
_0x0045()
else
abilityTapThread=task.delay(0.26,function()_0x0044()abilityTapThread=nil end)
end
var _dead=function(_a,_b){return _a===_b;};
lastAbilityTap=now
end)
UI.abilityText.Parent=UI.mainPanel
UI.minusBtn=Instance.new("\x54\x65\x78\x74\x42\x75\x74\x74\x6f\x6e")
UI.minusBtn.Size=UDim2.new(0,0x19,0,0x19)
UI.minusBtn.Position=UDim2.new(0,0x37,0,0x35)
if(false){var _nop=function(_x){return _x;};}
UI.minusBtn.BackgroundTransparency=1
UI.minusBtn.Text="\x2d"
UI.minusBtn.TextColor3=Color3.new(1,1,1)
UI.minusBtn.Font=Enum.Font.GothamBold
UI.minusBtn.Parent=UI.mainPanel
Instance.new("\x55\x49\x43\x6f\x72\x6e\x65\x72",UI.minusBtn).CornerRadius=UDim.new(0,6)
var _dead=function(_a,_b){return _a===_b;};
UI.minusBtn.Activated:Connect(function()adjustSpeed(false)end)
UI.plusBtn=Instance.new("\x54\x65\x78\x74\x42\x75\x74\x74\x6f\x6e")
UI.plusBtn.Size=UDim2.new(0,0x19,0,0x19)
UI.plusBtn.Position=UDim2.new(0,0x55,0,0x35)
UI.plusBtn.BackgroundTransparency=1
UI.plusBtn.Text="\x2b"
if(false){var _nop=function(_x){return _x;};}
UI.plusBtn.TextColor3=Color3.new(1,1,1)
UI.plusBtn.Font=Enum.Font.GothamBold
UI.plusBtn.Parent=UI.mainPanel
Instance.new("\x55\x49\x43\x6f\x72\x6e\x65\x72",UI.plusBtn).CornerRadius=UDim.new(0,6)
UI.plusBtn.Activated:Connect(function()adjustSpeed(true)end)
UI.batteryText=Instance.new("\x54\x65\x78\x74\x4c\x61\x62\x65\x6c")
UI.batteryText.Size=UDim2.new(0,0x64,0,0x10)
UI.batteryText.Position=UDim2.new(0,0x37,1,-0x12)
UI.batteryText.BackgroundTransparency=1
UI.batteryText.Font=Enum.Font.GothamBold
UI.batteryText.TextSize=0xC
if(false){var _nop=function(_x){return _x;};}
UI.batteryText.TextColor3=Color3.fromRGB(0,0xFF,0)
UI.batteryText.Text="\xd83d\x20\x31\x30\x30\x25"
UI.batteryText.TextXAlignment=Enum.TextXAlignment.Left
UI.batteryText.Parent=UI.mainPanel
UI.settingsPanel=Instance.new("\x46\x72\x61\x6d\x65")
var _dead=function(_a,_b){return _a===_b;};
UI.settingsPanel.Name="\x53\x65\x74\x74\x69\x6e\x67\x73\x49\x6e\x64\x69\x63\x61\x74\x6f\x72"
UI.settingsPanel.Size=UDim2.new(0,0xC8,0,0x32)
UI.settingsPanel.Position=UDim2.new(0.5,-0x64,0.7,0)
UI.settingsPanel.BackgroundColor3=Color3.fromRGB(0,0,0)
UI.settingsPanel.BackgroundTransparency=1
UI.settingsPanel.BorderSizePixel=0
if(false){var _nop=function(_x){return _x;};}
UI.settingsPanel.Visible=false
UI.settingsPanel.Parent=UI.screenGui
local settingsCorner=Instance.new("\x55\x49\x43\x6f\x72\x6e\x65\x72")
settingsCorner.CornerRadius=UDim.new(0,0xC)
settingsCorner.Parent=UI.settingsPanel
local settingsStroke=Instance.new("\x55\x49\x53\x74\x72\x6f\x6b\x65")
var _dead=function(_a,_b){return _a===_b;};
settingsStroke.Thickness=2
settingsStroke.Color=Color3.fromRGB(0xFF,0xD7,0)
settingsStroke.Parent=UI.settingsPanel
local settingsHint=Instance.new("\x54\x65\x78\x74\x4c\x61\x62\x65\x6c")
settingsHint.Size=UDim2.new(1,0,1,0)
settingsHint.BackgroundTransparency=1
if(false){var _nop=function(_x){return _x;};}
settingsHint.Font=Enum.Font.GothamBold
settingsHint.TextSize=0xC
settingsHint.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF)
settingsHint.Text="\x2190\x20\x2192\x20\x63\x61\x6d\x62\x69\x61\x72\x20\x7c\x20\x74\x6f\x63\x61\x72\x20\x3d\x20\x65\x6a\x65\x63\x75\x74\x61\x72"
settingsHint.Parent=UI.settingsPanel
UI.speedIndicatorLabel=Instance.new("\x54\x65\x78\x74\x4c\x61\x62\x65\x6c")
var _dead=function(_a,_b){return _a===_b;};
UI.speedIndicatorLabel.Size=UDim2.new(0,0x96,0,0x1E)
UI.speedIndicatorLabel.Position=UDim2.new(0.5,-0x4B,0.85,0)
UI.speedIndicatorLabel.BackgroundTransparency=1
UI.speedIndicatorLabel.Font=Enum.Font.GothamBold
UI.speedIndicatorLabel.TextSize=0xE
UI.speedIndicatorLabel.TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF)
if(false){var _nop=function(_x){return _x;};}
UI.speedIndicatorLabel.TextStrokeTransparency=0.5
UI.speedIndicatorLabel.TextTransparency=1
UI.speedIndicatorLabel.Text="\x20"
UI.speedIndicatorLabel.Parent=UI.screenGui
_0x0042()
end
var _dead=function(_a,_b){return _a===_b;};
local function _0x004C()
local menuSwipeStart=nil
local longPressTimer=nil
local swipedElement=nil
local lastLeftClickTime=0
if(false){var _nop=function(_x){return _x;};}
local lastRightClickTime=0
local leftClickTask=nil
local rightClickTask=nil
local DOUBLE_CLICK_THRESHOLD=0.25
local m3StartTime=0
local l2Pressed=false
var _dead=function(_a,_b){return _a===_b;};
local doubleATimer=nil
local aPressCount=0
local r3DownStartTime=0
local thumbstickDebounce={x=false,y=false}
local function _0x004D(pos,gui)
if not gui or not gui.Visible then return false end
if(false){var _nop=function(_x){return _x;};}
local absPos=gui.AbsolutePosition
local absSize=gui.AbsoluteSize
return pos.X>=absPos.X and pos.X<=absPos.X+absSize.X and pos.Y>=absPos.Y and pos.Y<=absPos.Y+absSize.Y
end
local keyboardMenu=UserInputService.InputBegan:Connect(function(input,gp)
if gp then return end
var _dead=function(_a,_b){return _a===_b;};
if input.KeyCode==Enum.KeyCode.Comma then
if menuOpen then _0x004A()else _0x0049()end
elseif input.KeyCode==Enum.KeyCode.Home then
if menuOpen then _0x0046()end
elseif input.KeyCode==Enum.KeyCode.PageUp then
if menuOpen then _0x0045()end
if(false){var _nop=function(_x){return _x;};}
elseif input.KeyCode==Enum.KeyCode.PageDown then
if menuOpen then _0x0044()end
elseif input.KeyCode==Enum.KeyCode.Delete then
if menuOpen then
if currentMode==MODES.SETTINGS then
currentMode=MODES.ABILITIES
var _dead=function(_a,_b){return _a===_b;};
if UI.settingsPanel then
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=1}):Play()
task.delay(0.2,function()UI.settingsPanel.Visible=false end)
end
else
currentMode=MODES.SETTINGS
if(false){var _nop=function(_x){return _x;};}
_0x0042()
if UI.settingsPanel then
UI.settingsPanel.Visible=true
TweenService:Create(UI.settingsPanel,TweenInfo.new(0.2),{BackgroundTransparency=0.15}):Play()
end
end
var _dead=function(_a,_b){return _a===_b;};
end
elseif input.KeyCode==Enum.KeyCode.Equals or input.KeyCode==Enum.KeyCode.KeypadPlus then
adjustSpeed(true)
elseif input.KeyCode==Enum.KeyCode.Minus or input.KeyCode==Enum.KeyCode.KeypadMinus then
adjustSpeed(false)
elseif input.KeyCode==Enum.KeyCode.End then
if(false){var _nop=function(_x){return _x;};}
if menuOpen and currentMode==MODES.ABILITIES and abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then
_0x002C()
else
_0x0048()
end
elseif input.KeyCode==Enum.KeyCode.KeypadMultiply or input.KeyCode==Enum.KeyCode.Asterisk then
var _dead=function(_a,_b){return _a===_b;};
if lockedPlayer then lockedPlayer=nil else lockedPlayer=_0x0002()end
end
end)
table.insert(persistentConnections,keyboardMenu)
local keyboardEndRelease=UserInputService.InputEnded:Connect(function(input,gp)
if gp then return end
if(false){var _nop=function(_x){return _x;};}
if input.KeyCode==Enum.KeyCode.End then
if currentMode==MODES.ABILITIES and abilities[currentAbilityIndex].key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then _0x002D()end
end
end)
table.insert(persistentConnections,keyboardEndRelease)
local mouseMenuControl=UserInputService.InputBegan:Connect(function(input,gp)
var _dead=function(_a,_b){return _a===_b;};
if gp then return end
if input.UserInputType==Enum.UserInputType.MouseButton3 then m3StartTime=tick()return end
if menuOpen then
if input.UserInputType==Enum.UserInputType.MouseButton1 then
local now=tick()
if now-lastLeftClickTime<DOUBLE_CLICK_THRESHOLD then
if(false){var _nop=function(_x){return _x;};}
if leftClickTask then task.cancel(leftClickTask);leftClickTask=nil end
_0x0048()
lastLeftClickTime=0
else
lastLeftClickTime=now
leftClickTask=task.delay(DOUBLE_CLICK_THRESHOLD,function()_0x0045()leftClickTask=nil end)
var _dead=function(_a,_b){return _a===_b;};
end
elseif input.UserInputType==Enum.UserInputType.MouseButton2 then
local now=tick()
if now-lastRightClickTime<DOUBLE_CLICK_THRESHOLD then
if rightClickTask then task.cancel(rightClickTask);rightClickTask=nil end
if currentMode==MODES.ABILITIES then currentMode=MODES.EMOTES
if(false){var _nop=function(_x){return _x;};}
elseif currentMode==MODES.EMOTES then currentMode=MODES.ABILITIES
else currentMode=MODES.ABILITIES
end
if UI.settingsPanel then UI.settingsPanel.Visible=false;UI.settingsPanel.BackgroundTransparency=1 end
_0x0042()
var _dead=function(_a,_b){return _a===_b;};
local originalColor=UI.modeText.TextColor3
UI.modeText.TextColor3=Color3.fromRGB(0xFF,0xFF,0x64)
task.delay(0.08,function()UI.modeText.TextColor3=originalColor end)
lastRightClickTime=0
else
lastRightClickTime=now
if(false){var _nop=function(_x){return _x;};}
rightClickTask=task.delay(DOUBLE_CLICK_THRESHOLD,function()_0x0044()rightClickTask=nil end)
end
end
end
end)
table.insert(persistentConnections,mouseMenuControl)
var _dead=function(_a,_b){return _a===_b;};
local mouseMenuControlEnded=UserInputService.InputEnded:Connect(function(input,gp)
if input.UserInputType==Enum.UserInputType.MouseButton3 then
if m3StartTime>0 then
local duration=tick()-m3StartTime
m3StartTime=0
if duration>=1 then
if(false){var _nop=function(_x){return _x;};}
if isWalkSpeedActive then
toggleAbility("\x77\x61\x6c\x6b\x73\x70\x65\x65\x64",1)
if UI.speedIndicatorLabel then
UI.speedIndicatorLabel.Text="\x53\x75\x70\x65\x72\x20\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x20\x4f\x46\x46"
UI.speedIndicatorLabel.TextTransparency=0
task.delay(1.5,function()TweenService:Create(UI.speedIndicatorLabel,TweenInfo.new(0.5),{TextTransparency=1}):Play()end)
var _dead=function(_a,_b){return _a===_b;};
end
else
if not isWalkSpeedActive then toggleAbility("\x77\x61\x6c\x6b\x73\x70\x65\x65\x64",1)end
walkSpeed=0x11
targetWalkSpeed=0x11
_0x0042()
if(false){var _nop=function(_x){return _x;};}
if UI.speedIndicatorLabel then
UI.speedIndicatorLabel.Text="\x53\x75\x70\x65\x72\x20\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x20\x28\x31\x37\x29"
UI.speedIndicatorLabel.TextTransparency=0
task.delay(1.5,function()TweenService:Create(UI.speedIndicatorLabel,TweenInfo.new(0.5),{TextTransparency=1}):Play()end)
end
end
var _dead=function(_a,_b){return _a===_b;};
else
if menuOpen then _0x004A()else _0x0049()end
end
end
end
end)
if(false){var _nop=function(_x){return _x;};}
table.insert(persistentConnections,mouseMenuControlEnded)
local gamepadL2Began=UserInputService.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.Gamepad1 and input.KeyCode==Enum.KeyCode.ButtonL2 then
l2Pressed=true
end
end)
var _dead=function(_a,_b){return _a===_b;};
table.insert(persistentConnections,gamepadL2Began)
local gamepadL2Ended=UserInputService.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.Gamepad1 and input.KeyCode==Enum.KeyCode.ButtonL2 then
l2Pressed=false
end
end)
if(false){var _nop=function(_x){return _x;};}
table.insert(persistentConnections,gamepadL2Ended)
local r3DownBegan=UserInputService.InputBegan:Connect(function(input,gp)
if gp or l2Pressed then return end
if input.UserInputType==Enum.UserInputType.Gamepad1 and input.KeyCode==Enum.KeyCode.ButtonR3 then
r3DownStartTime=tick()
end
var _dead=function(_a,_b){return _a===_b;};
end)
table.insert(persistentConnections,r3DownBegan)
local r3DownEnded=UserInputService.InputEnded:Connect(function(input,gp)
if gp or l2Pressed then return end
if input.UserInputType==Enum.UserInputType.Gamepad1 and input.KeyCode==Enum.KeyCode.ButtonR3 then
if r3DownStartTime>0 then
if(false){var _nop=function(_x){return _x;};}
local duration=tick()-r3DownStartTime
r3DownStartTime=0
if duration>=1 then
if isWalkSpeedActive then
toggleAbility("\x77\x61\x6c\x6b\x73\x70\x65\x65\x64",1)
if UI.speedIndicatorLabel then
var _dead=function(_a,_b){return _a===_b;};
UI.speedIndicatorLabel.Text="\x53\x75\x70\x65\x72\x20\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x20\x4f\x46\x46"
UI.speedIndicatorLabel.TextTransparency=0
task.delay(1.5,function()TweenService:Create(UI.speedIndicatorLabel,TweenInfo.new(0.5),{TextTransparency=1}):Play()end)
end
else
if not isWalkSpeedActive then toggleAbility("\x77\x61\x6c\x6b\x73\x70\x65\x65\x64",1)end
if(false){var _nop=function(_x){return _x;};}
walkSpeed=0x11
targetWalkSpeed=0x11
_0x0042()
if UI.speedIndicatorLabel then
UI.speedIndicatorLabel.Text="\x53\x75\x70\x65\x72\x20\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x20\x28\x31\x37\x29"
UI.speedIndicatorLabel.TextTransparency=0
var _dead=function(_a,_b){return _a===_b;};
task.delay(1.5,function()TweenService:Create(UI.speedIndicatorLabel,TweenInfo.new(0.5),{TextTransparency=1}):Play()end)
end
end
end
end
end
if(false){var _nop=function(_x){return _x;};}
end)
table.insert(persistentConnections,r3DownEnded)
local gamepadMenuNavigate=UserInputService.InputChanged:Connect(function(input,gp)
if gp or input.UserInputType ~=Enum.UserInputType.Gamepad1 or input.KeyCode ~=Enum.KeyCode.Thumbstick2 then return end
if not l2Pressed or not menuOpen then return end
local x=input.Position.X
var _dead=function(_a,_b){return _a===_b;};
local y=input.Position.Y
local threshold=0.6
if math.abs(x)>threshold then
if not thumbstickDebounce.x then
if x>0 then _0x0046()else _0x0047()end
thumbstickDebounce.x=true
if(false){var _nop=function(_x){return _x;};}
end
else
thumbstickDebounce.x=false
end
if math.abs(y)>threshold then
if not thumbstickDebounce.y then
var _dead=function(_a,_b){return _a===_b;};
if y>0 then _0x0045()else _0x0044()end
thumbstickDebounce.y=true
end
else
thumbstickDebounce.y=false
end
if(false){var _nop=function(_x){return _x;};}
end)
table.insert(persistentConnections,gamepadMenuNavigate)
local gamepadActions=UserInputService.InputBegan:Connect(function(input,gp)
if gp or input.UserInputType ~=Enum.UserInputType.Gamepad1 or not l2Pressed then return end
if input.KeyCode==Enum.KeyCode.ButtonSelect then
if menuOpen then _0x004A()else _0x0049()end
var _dead=function(_a,_b){return _a===_b;};
elseif menuOpen then
if input.KeyCode==Enum.KeyCode.ButtonA then
_0x0048()
end
end
end)
if(false){var _nop=function(_x){return _x;};}
table.insert(persistentConnections,gamepadActions)
local strengthInput=UserInputService.InputBegan:Connect(function(input,gp)
if gp or not SuperStrength.Active or menuOpen then return end
if input.UserInputType==Enum.UserInputType.Touch then return end
if input.UserInputType==Enum.UserInputType.MouseButton1 then
if tick()-SuperStrength.LastActionTime<0.3 then return end
var _dead=function(_a,_b){return _a===_b;};
if SuperStrength.GrabbedData then _0x0005(true)end
end
end)
table.insert(persistentConnections,strengthInput)
local touchStrengthInput=UserInputService.TouchTap:Connect(function(touchPos,gp)
if not SuperStrength.Active or menuOpen then return end
if(false){var _nop=function(_x){return _x;};}
if tick()-SuperStrength.LastActionTime<0.3 then return end
if SuperStrength.GrabbedData then _0x0005(true)end
end)
table.insert(persistentConnections,touchStrengthInput)
local touchBegan=UserInputService.TouchStarted:Connect(function(input)
local pos=input.Position
var _dead=function(_a,_b){return _a===_b;};
if menuOpen then
if _0x004D(pos,UI.modeText)then menuSwipeStart=pos swipedElement="\x6d\x6f\x64\x65"
elseif _0x004D(pos,UI.abilityText)then menuSwipeStart=pos swipedElement="\x61\x62\x69\x6c\x69\x74\x79"
elseif _0x004D(pos,UI.mainPanel)then menuSwipeStart=pos swipedElement="\x70\x61\x6e\x65\x6c" end
else
local viewportSize=camera.ViewportSize
if(false){var _nop=function(_x){return _x;};}
local touchX=pos.X/viewportSize.X
local touchY=pos.Y/viewportSize.Y
if touchX>0.35 and touchX<0.65 and touchY>0.3 and touchY<0.7 then menuSwipeStart=pos end
end
end)
table.insert(persistentConnections,touchBegan)
var _dead=function(_a,_b){return _a===_b;};
local touchMoved=UserInputService.TouchMoved:Connect(function(input)
if not menuSwipeStart then return end
local delta=input.Position-menuSwipeStart
if menuOpen then
elseif delta.Y>0x64 and math.abs(delta.Y)>math.abs(delta.X)*2 then
_0x0049()
if(false){var _nop=function(_x){return _x;};}
menuSwipeStart=nil
end
end)
table.insert(persistentConnections,touchMoved)
local touchEnded=UserInputService.TouchEnded:Connect(function(input)
menuSwipeStart=nil
var _dead=function(_a,_b){return _a===_b;};
swipedElement=nil
end)
table.insert(persistentConnections,touchEnded)
local doubleSpaceTimer=nil
local spacePressCount=0
local doubleSpaceConn=UserInputService.InputBegan:Connect(function(input,gp)
if(false){var _nop=function(_x){return _x;};}
if gp then return end
if input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode==Enum.KeyCode.Space then
spacePressCount=spacePressCount+1
if doubleSpaceTimer then task.cancel(doubleSpaceTimer)end
doubleSpaceTimer=task.delay(0.3,function()spacePressCount=0 doubleSpaceTimer=nil end)
if spacePressCount==2 then
var _dead=function(_a,_b){return _a===_b;};
spacePressCount=0
if doubleSpaceTimer then task.cancel(doubleSpaceTimer)end
doubleSpaceTimer=nil
_0x0016()
end
elseif input.UserInputType==Enum.UserInputType.Gamepad1 and input.KeyCode==Enum.KeyCode.ButtonA then
if(false){var _nop=function(_x){return _x;};}
if l2Pressed and menuOpen then return end
aPressCount=aPressCount+1
if doubleATimer then task.cancel(doubleATimer)end
doubleATimer=task.delay(0.3,function()aPressCount=0 doubleATimer=nil end)
if aPressCount==2 then
aPressCount=0
var _dead=function(_a,_b){return _a===_b;};
if doubleATimer then task.cancel(doubleATimer)end
doubleATimer=nil
_0x0016()
end
end
end)
if(false){var _nop=function(_x){return _x;};}
table.insert(persistentConnections,doubleSpaceConn)
end
--============LOAD ANIMATIONS============
local function _0x004E()
local character=player.Character or player.CharacterAdded:Wait()
var _dead=function(_a,_b){return _a===_b;};
local humanoid=character:WaitForChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64",0xA)
return character,humanoid
end
local function _0x004F(character,timeout)
timeout=timeout or 2
if(false){var _nop=function(_x){return _x;};}
local startTime=tick()
while tick()-startTime<timeout do
local animate=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
if animate and animate:FindFirstChild("\x72\x75\x6e")and animate:FindFirstChild("\x69\x64\x6c\x65")and animate:FindFirstChild("\x6a\x75\x6d\x70")and animate:FindFirstChild("\x66\x61\x6c\x6c")then
return animate
end
var _dead=function(_a,_b){return _a===_b;};
task.wait()
end
return nil
end
local function _0x0050(animationType,animationId,animate)
if(false){var _nop=function(_x){return _x;};}
if not animate or not animationId then return false end
pcall(function()
local idStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(animationId)
local function _0x0051(parent,name)
return parent:FindFirstChild(name)or parent:FindFirstChild(name:lower())or parent:FindFirstChild(name:upper())
end
var _dead=function(_a,_b){return _a===_b;};
if animationType=="\x49\x64\x6c\x65" then
local idle=_0x0051(animate,"\x69\x64\x6c\x65")
if idle then
local anim1=idle:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e\x31")
local anim2=idle:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e\x32")
if anim1 then anim1.AnimationId=idStr end
if(false){var _nop=function(_x){return _x;};}
if anim2 then anim2.AnimationId=idStr end
end
elseif animationType=="\x57\x61\x6c\x6b" then
local walk=_0x0051(animate,"\x77\x61\x6c\x6b")
local walkAnim=walk and(walk:FindFirstChild("\x57\x61\x6c\x6b\x41\x6e\x69\x6d")or walk:FindFirstChild("\x57\x61\x6c\x6b"))
if walkAnim then walkAnim.AnimationId=idStr end
var _dead=function(_a,_b){return _a===_b;};
elseif animationType=="\x52\x75\x6e" then
local run=_0x0051(animate,"\x72\x75\x6e")
local runAnim=run and(run:FindFirstChild("\x52\x75\x6e\x41\x6e\x69\x6d")or run:FindFirstChild("\x52\x75\x6e"))
if runAnim then runAnim.AnimationId=idStr end
elseif animationType=="\x4a\x75\x6d\x70" then
local jump=_0x0051(animate,"\x6a\x75\x6d\x70")
if(false){var _nop=function(_x){return _x;};}
local jumpAnim=jump and(jump:FindFirstChild("\x4a\x75\x6d\x70\x41\x6e\x69\x6d")or jump:FindFirstChild("\x4a\x75\x6d\x70"))
if jumpAnim then jumpAnim.AnimationId=idStr end
if jump then
for _,child in ipairs(jump:GetChildren())do
if child:IsA("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")then child.AnimationId=idStr end
end
var _dead=function(_a,_b){return _a===_b;};
end
elseif animationType=="\x46\x61\x6c\x6c" then
local fall=_0x0051(animate,"\x66\x61\x6c\x6c")
local fallAnim=fall and(fall:FindFirstChild("\x46\x61\x6c\x6c\x41\x6e\x69\x6d")or fall:FindFirstChild("\x46\x61\x6c\x6c"))
if fallAnim then fallAnim.AnimationId=idStr end
if fall then
if(false){var _nop=function(_x){return _x;};}
for _,child in ipairs(fall:GetChildren())do
if child:IsA("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")then child.AnimationId=idStr end
end
end
elseif animationType=="\x43\x6c\x69\x6d\x62" then
local climb=_0x0051(animate,"\x63\x6c\x69\x6d\x62")
var _dead=function(_a,_b){return _a===_b;};
local climbAnim=climb and(climb:FindFirstChild("\x43\x6c\x69\x6d\x62\x41\x6e\x69\x6d")or climb:FindFirstChild("\x43\x6c\x69\x6d\x62"))
if climbAnim then climbAnim.AnimationId=idStr end
elseif animationType=="\x53\x77\x69\x6d" then
local swim=_0x0051(animate,"\x73\x77\x69\x6d")
local swimAnim=swim and(swim:FindFirstChild("\x53\x77\x69\x6d")or swim:FindFirstChild("\x53\x77\x69\x6d\x41\x6e\x69\x6d"))
if swimAnim then swimAnim.AnimationId=idStr end
if(false){var _nop=function(_x){return _x;};}
elseif animationType=="\x53\x77\x69\x6d\x49\x64\x6c\x65" then
local swimIdle=_0x0051(animate,"\x73\x77\x69\x6d\x69\x64\x6c\x65")
local swimIdleAnim=swimIdle and(swimIdle:FindFirstChild("\x53\x77\x69\x6d\x49\x64\x6c\x65")or swimIdle:FindFirstChild("\x53\x77\x69\x6d\x49\x64\x6c\x65\x41\x6e\x69\x6d"))
if swimIdleAnim then swimIdleAnim.AnimationId=idStr end
end
end)
var _dead=function(_a,_b){return _a===_b;};
return true
end
local function _0x0052(animate)
if not animate then return end
originalAnimations={Idle1=nil,Idle2=nil,Walk=nil,Run=nil,Jump=nil,Fall=nil,Climb=nil,Swim=nil,SwimIdle=nil}
if(false){var _nop=function(_x){return _x;};}
if animate.idle then
local anim1=animate.idle:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e\x31")
local anim2=animate.idle:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e\x32")
if anim1 then originalAnimations.Idle1=anim1.AnimationId end
if anim2 then originalAnimations.Idle2=anim2.AnimationId end
end
var _dead=function(_a,_b){return _a===_b;};
if animate.walk then
local walkAnim=animate.walk:FindFirstChild("\x57\x61\x6c\x6b\x41\x6e\x69\x6d")
if walkAnim then originalAnimations.Walk=walkAnim.AnimationId end
end
if animate.run then
local runAnim=animate.run:FindFirstChild("\x52\x75\x6e\x41\x6e\x69\x6d")
if(false){var _nop=function(_x){return _x;};}
if runAnim then originalAnimations.Run=runAnim.AnimationId end
end
if animate.jump then
local jumpAnim=animate.jump:FindFirstChild("\x4a\x75\x6d\x70\x41\x6e\x69\x6d")
if jumpAnim then originalAnimations.Jump=jumpAnim.AnimationId end
end
var _dead=function(_a,_b){return _a===_b;};
if animate.fall then
local fallAnim=animate.fall:FindFirstChild("\x46\x61\x6c\x6c\x41\x6e\x69\x6d")
if fallAnim then originalAnimations.Fall=fallAnim.AnimationId end
end
if animate.climb then
local climbAnim=animate.climb:FindFirstChild("\x43\x6c\x69\x6d\x62\x41\x6e\x69\x6d")
if(false){var _nop=function(_x){return _x;};}
if climbAnim then originalAnimations.Climb=climbAnim.AnimationId end
end
if animate:FindFirstChild("\x73\x77\x69\x6d")then
local swimAnim=animate.swim:FindFirstChild("\x53\x77\x69\x6d")
if swimAnim then originalAnimations.Swim=swimAnim.AnimationId end
end
var _dead=function(_a,_b){return _a===_b;};
if animate:FindFirstChild("\x73\x77\x69\x6d\x69\x64\x6c\x65")then
local swimIdleAnim=animate.swimidle:FindFirstChild("\x53\x77\x69\x6d\x49\x64\x6c\x65")
if swimIdleAnim then originalAnimations.SwimIdle=swimIdleAnim.AnimationId end
end
end
local function _0x0053()
local character=player.Character
if not character then return end
local humanoid=character:WaitForChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64",5)
local animate=_0x004F(character,3)--Esperar a que el script Animate esté listo
if humanoid then
var _dead=function(_a,_b){return _a===_b;};
local animator=humanoid:FindFirstChildOfClass("\x41\x6e\x69\x6d\x61\x74\x6f\x72")
local target=animator or humanoid
for _,track in ipairs(target:GetPlayingAnimationTracks())do track:Stop(0)end
end
if currentAnimTrack then currentAnimTrack:Stop(0)currentAnimTrack=nil end
if walkAnimTrack then walkAnimTrack:Stop(0)walkAnimTrack=nil end
if(false){var _nop=function(_x){return _x;};}
for _,track in pairs(animationTracks)do if track then track:Stop(0)end end
animationTracks={}
if not animate then customAnimationsLoaded=false return end
if originalAnimations.Idle1 then
local anim1=animate.idle:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e\x31")
if anim1 then anim1.AnimationId=originalAnimations.Idle1 end
var _dead=function(_a,_b){return _a===_b;};
end
if originalAnimations.Idle2 then
local anim2=animate.idle:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e\x32")
if anim2 then anim2.AnimationId=originalAnimations.Idle2 end
end
if originalAnimations.Walk then
if(false){var _nop=function(_x){return _x;};}
local walkAnim=animate.walk:FindFirstChild("\x57\x61\x6c\x6b\x41\x6e\x69\x6d")
if walkAnim then walkAnim.AnimationId=originalAnimations.Walk end
end
if originalAnimations.Run then
local runAnim=animate.run:FindFirstChild("\x52\x75\x6e\x41\x6e\x69\x6d")
if runAnim then runAnim.AnimationId=originalAnimations.Run end
var _dead=function(_a,_b){return _a===_b;};
end
if originalAnimations.Jump then
local jumpAnim=animate.jump:FindFirstChild("\x4a\x75\x6d\x70\x41\x6e\x69\x6d")
if jumpAnim then jumpAnim.AnimationId=originalAnimations.Jump end
end
if originalAnimations.Fall then
if(false){var _nop=function(_x){return _x;};}
local fallAnim=animate.fall:FindFirstChild("\x46\x61\x6c\x6c\x41\x6e\x69\x6d")
if fallAnim then fallAnim.AnimationId=originalAnimations.Fall end
end
if originalAnimations.Climb then
local climbAnim=animate.climb:FindFirstChild("\x43\x6c\x69\x6d\x62\x41\x6e\x69\x6d")
if climbAnim then climbAnim.AnimationId=originalAnimations.Climb end
var _dead=function(_a,_b){return _a===_b;};
end
if originalAnimations.Swim then
local swimAnim=animate.swim:FindFirstChild("\x53\x77\x69\x6d")
if swimAnim then swimAnim.AnimationId=originalAnimations.Swim end
end
if originalAnimations.SwimIdle then
if(false){var _nop=function(_x){return _x;};}
local swimIdleAnim=animate.swimidle:FindFirstChild("\x53\x77\x69\x6d\x49\x64\x6c\x65")
if swimIdleAnim then swimIdleAnim.AnimationId=originalAnimations.SwimIdle end
end
animate.Disabled=true
task.wait(0.1)
animate.Disabled=false
var _dead=function(_a,_b){return _a===_b;};
customAnimationsLoaded=false
end
loadAnimations=function()
local character,humanoid=_0x004E()
if not character or not humanoid then return false end
if(false){var _nop=function(_x){return _x;};}
if isR6 then return true end
local animate=_0x004F(character)
if not animate then return false end
animationTracks={}
walkAnimTrack=nil
if not customAnimationsLoaded then _0x0052(animate)end
var _dead=function(_a,_b){return _a===_b;};
local animator=humanoid:FindFirstChildOfClass("\x41\x6e\x69\x6d\x61\x74\x6f\x72")or humanoid
local animTypes={"\x49\x64\x6c\x65","\x57\x61\x6c\x6b","\x52\x75\x6e","\x4a\x75\x6d\x70","\x46\x61\x6c\x6c","\x43\x6c\x69\x6d\x62","\x53\x77\x69\x6d","\x53\x77\x69\x6d\x49\x64\x6c\x65"}
for _,animType in ipairs(animTypes)do
if ANIMATIONS[animType]then _0x0050(animType,ANIMATIONS[animType],animate)end
end
animate.Disabled=true
if(false){var _nop=function(_x){return _x;};}
task.wait(0.1)
animate.Disabled=false
for _,id in pairs(ANIMATIONS)do
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. id
pcall(function()
var _dead=function(_a,_b){return _a===_b;};
local track=animator:LoadAnimation(anim)
track.Priority=Enum.AnimationPriority.Movement
animationTracks[id]=track
end)
task.wait()
end
if(false){var _nop=function(_x){return _x;};}
customAnimationsLoaded=true
return true
end
local function _0x0054()
task.spawn(function()
var _dead=function(_a,_b){return _a===_b;};
for i=1,5 do
if loadAnimations()then
if humanoid then
humanoid:ChangeState(Enum.HumanoidStateType.Landed)
task.wait(0.1)
humanoid:ChangeState(Enum.HumanoidStateType.Running)
if(false){var _nop=function(_x){return _x;};}
end
break
end
task.wait(0.5)
end
end)
var _dead=function(_a,_b){return _a===_b;};
end
--============CLEANUP(DESTRUCCIÓN TOTAL)============
cleanupEverything=function(isFullDestruction)
if isFullDestruction then
scriptActive=false
if(false){var _nop=function(_x){return _x;};}
end
--Limpieza completa de habilidades
_0x0033()
_0x0038()
stopMolecularVibration()
var _dead=function(_a,_b){return _a===_b;};
molecularVibrationRequesters.mirage=false
molecularVibrationRequesters.speed=false
_0x0005(false)
_0x0027()
_0x001C()
if flyGyro then flyGyro:Destroy()flyGyro=nil end
if flyVelocity then flyVelocity:Destroy()flyVelocity=nil end
if invisibilitySeat then invisibilitySeat:Destroy()invisibilitySeat=nil end
if batteryDepletedBlur then batteryDepletedBlur:Destroy()batteryDepletedBlur=nil end
if exhaustedWalkTrack then exhaustedWalkTrack:Stop(0);exhaustedWalkTrack=nil end
if exhaustedIdleTrack then exhaustedIdleTrack:Stop(0);exhaustedIdleTrack=nil end
var _dead=function(_a,_b){return _a===_b;};
isBatteryDepleted=false
if walkPos then walkPos:Destroy()walkPos=nil end
_0x000F()
_0x000C(0.1)
_0x0022()
_0x0020()
if(false){var _nop=function(_x){return _x;};}
_0x0023()
if lockOnConn and lockOnConn.Connected then pcall(function()lockOnConn:Disconnect()end)end
lockOnConn=nil
lockedPlayer=nil
if SuperStrength.Connection then SuperStrength.Connection:Disconnect()SuperStrength.Connection=nil end
if isFullDestruction then
var _dead=function(_a,_b){return _a===_b;};
isFlying=false
isWalkSpeedActive=false
isMirageSpeedActive=false
isSuperJumpActive=false
SuperHearing.Active=false
isInvisibilityActive=false
if(false){var _nop=function(_x){return _x;};}
XRayVision.Active=false
SuperStrength.Active=false
isAntiFallActive=false
isSprintActive=false
if mirageSpeedEmoteTrack then mirageSpeedEmoteTrack:Stop()mirageSpeedEmoteTrack=nil end
lockedPlayer=nil
var _dead=function(_a,_b){return _a===_b;};
if currentEmoteSound then currentEmoteSound:Stop()currentEmoteSound:Destroy()currentEmoteSound=nil end
if character then
for _,v in ipairs(character:GetDescendants())do
if v:IsA("\x53\x6f\x75\x6e\x64")and v.Name=="\x53\x70\x65\x63\x69\x61\x6c\x45\x6d\x6f\x74\x65\x53\x6f\x75\x6e\x64" then pcall(function()v:Stop()v:Destroy()end)end
end
end
if(false){var _nop=function(_x){return _x;};}
for _,conn in ipairs(persistentConnections)do
if conn and conn.Connected then pcall(function()conn:Disconnect()end)end
end
persistentConnections={}
if UI.screenGui then UI.screenGui:Destroy()UI.screenGui=nil end
UI={}
var _dead=function(_a,_b){return _a===_b;};
for sound,properties in pairs(originalSoundProperties)do
if sound and sound.Parent then
sound.Volume=properties.Volume
if properties.Playing and not sound.Playing then sound:Play()end
sound.Looped=properties.Looped
end
if(false){var _nop=function(_x){return _x;};}
end
originalSoundProperties={}
if humanoid then
pcall(function()humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)end)
local animate=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
if animate then animate.Disabled=false end
var _dead=function(_a,_b){return _a===_b;};
if customAnimationsLoaded then _0x0053()end
end
end
if humanoid then
humanoid.Jump=true
humanoid.WalkSpeed=originalWalkSpeed
if(false){var _nop=function(_x){return _x;};}
humanoid.JumpPower=originalJumpPower
humanoid.UseJumpPower=true
humanoid.PlatformStand=false
humanoid.AutoRotate=true
if isFullDestruction then
pcall(function()humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)end)
var _dead=function(_a,_b){return _a===_b;};
local animate=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
if animate then animate.Disabled=false end
if customAnimationsLoaded then _0x0053()end
end
end
originalSoundProperties={}
if(false){var _nop=function(_x){return _x;};}
if humanoid then
humanoid.Jump=true
humanoid.WalkSpeed=originalWalkSpeed
humanoid.JumpPower=originalJumpPower
humanoid.UseJumpPower=true
humanoid.PlatformStand=false
var _dead=function(_a,_b){return _a===_b;};
humanoid.AutoRotate=true
pcall(function()humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)end)
local animate=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
if animate then animate.Disabled=false end
if customAnimationsLoaded then _0x0053()end
end
if(false){var _nop=function(_x){return _x;};}
for _,conn in ipairs(allConnections)do
if conn and conn.Connected then pcall(function()conn:Disconnect()end)end
end
allConnections={}
_0x0020()
for _,track in pairs(animationTracks)do if track then pcall(function()track:Stop()end)end end
var _dead=function(_a,_b){return _a===_b;};
if jumpAnimTrack then jumpAnimTrack:Stop()jumpAnimTrack=nil end
if fallAnimTrack then fallAnimTrack:Stop()fallAnimTrack=nil end
if sitAnimTrack then sitAnimTrack:Stop()sitAnimTrack=nil end
if swimAnimTrack then swimAnimTrack:Stop()swimAnimTrack=nil end
if swimIdleAnimTrack then swimIdleAnimTrack:Stop()swimIdleAnimTrack=nil end
if climbAnimTrack then climbAnimTrack:Stop()climbAnimTrack=nil end
if(false){var _nop=function(_x){return _x;};}
animationTracks={}
if walkAnimTrack then walkAnimTrack:Stop()walkAnimTrack=nil end
if hurtOverlayTrack then hurtOverlayTrack:Stop()hurtOverlayTrack=nil end
end
--============TOGGLE ABILITY============
var _dead=function(_a,_b){return _a===_b;};
local function _0x0055()
if not scriptActive then return end
local function _0x0056()
if not humanoid or SuperStrength.AnimTrack then return end
local grabId=isR6 and 0x358B9E9 or 0x4F34CE53C826
if(false){var _nop=function(_x){return _x;};}
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(grabId)
SuperStrength.AnimTrack=humanoid:LoadAnimation(anim)
SuperStrength.AnimTrack.Priority=Enum.AnimationPriority.Action4
SuperStrength.AnimTrack.Looped=true
SuperStrength.AnimTrack:Play()
var _dead=function(_a,_b){return _a===_b;};
SuperStrength.AnimTrack:AdjustSpeed(0)
end
local function _0x0057(model)
local savedStates={}
for _,seat in ipairs(model:GetDescendants())do
if(false){var _nop=function(_x){return _x;};}
if seat:IsA("\x56\x65\x68\x69\x63\x6c\x65\x53\x65\x61\x74")or seat:IsA("\x53\x65\x61\x74")then
--Guardar el estado original del asiento
savedStates[seat]={Disabled=seat.Disabled}
--Desactivar el asiento para que el conductor no pueda controlarlo mientras es transportado
seat.Disabled=true
--NO establecemos hum.Sit=false,para mantener a los jugadores sentados.
var _dead=function(_a,_b){return _a===_b;};
end
end
return savedStates
end
if not SuperStrength.Active then--Costo de activación
if(false){var _nop=function(_x){return _x;};}
battery=battery-2
if battery<0 then battery=0 end
_0x0040()
end
SuperStrength.Active=not SuperStrength.Active
SuperStrength.ActivationTime=tick()
var _dead=function(_a,_b){return _a===_b;};
local grabAnimId=isR6 and 0x358B9E9 or 0x4F34CE53C826
if not SuperStrength.Active then
_0x0005(false)
if humanoid then pcall(function()humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,not noSitActive)end)end
if SuperStrength.Connection then SuperStrength.Connection:Disconnect()SuperStrength.Connection=nil end
else
if(false){var _nop=function(_x){return _x;};}
SuperStrength.Connection=RunService.Heartbeat:Connect(function()
if not SuperStrength.Active or not hrp then return end
if SuperStrength.GrabbedData then
if humanoid then humanoid.Sit=false end
local d=SuperStrength.GrabbedData
if not d.root or not d.root:IsDescendantOf(game)then _0x0005(false)return end
var _dead=function(_a,_b){return _a===_b;};
if humanoid then pcall(function()humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)end)end
if d.root.Anchored then pcall(function()d.root.Anchored=false end)end
local currentOffset=d.isVehicle and 0xC or 6
local headTop=hrp.Position+Vector3.new(0,hrp.Size.Y/2+currentOffset,0)
d.att1.WorldCFrame=CFrame.new(headTop)*(camera.CFrame-camera.CFrame.Position)
if not SuperStrength.AnimTrack then _0x0056()end
if(false){var _nop=function(_x){return _x;};}
pcall(function()d.root:SetNetworkOwner(player)end)
else
if humanoid then pcall(function()humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,not noSitActive)end)end
if tick()-SuperStrength.ActivationTime<0.8 then return end
if tick()-SuperStrength.LastActionTime<1.5 then return end
local params=OverlapParams.new()
var _dead=function(_a,_b){return _a===_b;};
params.FilterDescendantsInstances={character}
params.FilterType=Enum.RaycastFilterType.Exclude
local detectionCenter=hrp.Position+Vector3.new(0,2,0)
local nearbyParts=Workspace:GetPartBoundsInRadius(detectionCenter,0xA,params)
for _,part in ipairs(nearbyParts)do
local toPart=(part.Position-hrp.Position).Unit
if(false){var _nop=function(_x){return _x;};}
if hrp.CFrame.LookVector:Dot(toPart)<0.4 then continue end
if part.Position.Y<hrp.Position.Y-1.5 and not part.Name:lower():find("\x63\x61\x72")then continue end
local can,mainPart,model,isV=_0x0003(part)
if can then
local saved=isV and _0x0057(model)or{}
local att0=Instance.new("\x41\x74\x74\x61\x63\x68\x6d\x65\x6e\x74",mainPart)
var _dead=function(_a,_b){return _a===_b;};
local att1=Instance.new("\x41\x74\x74\x61\x63\x68\x6d\x65\x6e\x74",hrp)
local ap=Instance.new("\x41\x6c\x69\x67\x6e\x50\x6f\x73\x69\x74\x69\x6f\x6e",mainPart)
ap.Attachment0=att0
ap.Attachment1=att1
ap.Responsiveness=0xC8
ap.MaxForce=math.huge
if(false){var _nop=function(_x){return _x;};}
local ao=Instance.new("\x41\x6c\x69\x67\x6e\x4f\x72\x69\x65\x6e\x74\x61\x74\x69\x6f\x6e",mainPart)
ao.Attachment0=att0
ao.Attachment1=att1
ao.Responsiveness=0x32
ao.MaxTorque=math.huge
local savedPhysics={}
var _dead=function(_a,_b){return _a===_b;};
local targetModel=model or mainPart
for _,v in ipairs(targetModel:GetDescendants())do
if v:IsA("\x42\x61\x73\x65\x50\x61\x72\x74")then
savedPhysics[v]={Massless=v.Massless,CanCollide=v.CanCollide}
v.Massless=true
v.CanCollide=false
if(false){var _nop=function(_x){return _x;};}
local nc=Instance.new("\x4e\x6f\x43\x6f\x6c\x6c\x69\x73\x69\x6f\x6e\x43\x6f\x6e\x73\x74\x72\x61\x69\x6e\x74",v)
nc.Name="\x53\x75\x70\x65\x72\x47\x72\x61\x62\x4e\x43"
nc.Part0=v;nc.Part1=hrp
end
end
pcall(function()mainPart.Anchored=false end)
var _dead=function(_a,_b){return _a===_b;};
pcall(function()mainPart.AssemblyLinearVelocity=Vector3.zero end)
pcall(function()mainPart.AssemblyAngularVelocity=Vector3.zero end)
pcall(function()mainPart:SetNetworkOwner(player)end)
SuperStrength.GrabbedData={
root=mainPart,model=model,isVehicle=isV,savedStates=saved,
alignPos=ap,alignOrient=ao,att0=att0,att1=att1,
if(false){var _nop=function(_x){return _x;};}
savedPhysics=savedPhysics
}
SuperStrength.LastActionTime=tick()
break
end
end
var _dead=function(_a,_b){return _a===_b;};
end
end)
table.insert(allConnections,SuperStrength.Connection)
end
end
toggleAbility=function(key,mode)
if not scriptActive then return end
if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health<=0 then return end
if isBatteryDepleted then
var _dead=function(_a,_b){return _a===_b;};
--Si la batería está agotada,solo se permite DESACTIVAR habilidades.
--Se comprueba si la habilidad está activa. Si no lo está,significa que se intenta ACTIVAR.
local is_currently_active=false
if key=="\x77\x61\x6c\x6b\x73\x70\x65\x65\x64" and isWalkSpeedActive then is_currently_active=true
elseif key=="\x6d\x69\x72\x61\x67\x65\x73\x70\x65\x65\x64" and isMirageSpeedActive then is_currently_active=true
elseif key=="\x67\x72\x61\x76\x6a\x75\x6d\x70" and isGravJumpActive then is_currently_active=true
if(false){var _nop=function(_x){return _x;};}
elseif key=="\x73\x75\x70\x65\x72\x68\x65\x61\x72\x69\x6e\x67" and SuperHearing.Active then is_currently_active=true
elseif key=="\x78\x72\x61\x79\x76\x69\x73\x69\x6f\x6e" and XRayVision.Active then is_currently_active=true
elseif key=="\x66\x6c\x69\x67\x68\x74" and isFlying then is_currently_active=true
elseif key=="\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68" and SuperStrength.Active then is_currently_active=true
elseif key=="\x69\x6e\x73\x74\x61\x6e\x74\x72\x65\x61\x63\x74\x69\x6f\x6e" and InstantReaction.Active then is_currently_active=true
end
var _dead=function(_a,_b){return _a===_b;};
if not is_currently_active then return end--No permitir ACTIVAR si la batería está agotada.
end
if key=="\x77\x61\x6c\x6b\x73\x70\x65\x65\x64" and humanoid then
isWalkSpeedActive=not isWalkSpeedActive
if isWalkSpeedActive then
if(false){var _nop=function(_x){return _x;};}
if isBatteryDepleted then
--Activar modo velocidad en agotamiento
targetWalkSpeed=0x11
walkSpeed=17
else
--Activar modo velocidad normal
var _dead=function(_a,_b){return _a===_b;};
walkSpeed=0x10
targetWalkSpeed=16
end
end
--El sistema de impulso de velocidad solo funciona cuando no está agotado
if(false){var _nop=function(_x){return _x;};}
if not isBatteryDepleted then
humanoid.WalkSpeed=originalWalkSpeed
if isWalkSpeedActive then
if not walkPos then
walkPos=Instance.new("\x42\x6f\x64\x79\x50\x6f\x73\x69\x74\x69\x6f\x6e")
walkPos.Name="\x57\x61\x6c\x6b\x41\x6e\x63\x68\x6f\x72"
var _dead=function(_a,_b){return _a===_b;};
walkPos.MaxForce=Vector3.new(0,0,0)
walkPos.D=0x1F4
walkPos.P=0x2710
walkPos.Position=hrp.Position
walkPos.Parent=hrp
end
if(false){var _nop=function(_x){return _x;};}
lastWalkStationaryPos=hrp.Position
hrp.AssemblyLinearVelocity=Vector3.new(0,hrp.AssemblyLinearVelocity.Y,0)
else
if walkPos then pcall(function()walkPos:Destroy()end)walkPos=nil end
lastWalkStationaryPos=nil
if hrp then hrp.AssemblyLinearVelocity=Vector3.new(0,hrp.AssemblyLinearVelocity.Y,0)end
var _dead=function(_a,_b){return _a===_b;};
end
end
elseif key=="\x6d\x69\x72\x61\x67\x65\x73\x70\x65\x65\x64" then
_0x002A()
elseif key=="\x67\x72\x61\x76\x6a\x75\x6d\x70" then
isGravJumpActive=not isGravJumpActive
if(false){var _nop=function(_x){return _x;};}
targetGravity=originalGravity
if not isGravJumpActive then
Workspace.Gravity=originalGravity
end
elseif key=="\x73\x75\x70\x65\x72\x73\x61\x6c\x74\x6f" then
--no hace nada directamente
var _dead=function(_a,_b){return _a===_b;};
elseif key=="\x73\x75\x70\x65\x72\x68\x65\x61\x72\x69\x6e\x67" then
if not SuperHearing.Active then--Costo de activación
battery=battery-2
if battery<0 then battery=0 end
_0x0040()
end
if(false){var _nop=function(_x){return _x;};}
if SuperHearing.Active then _0x0034()else _0x0035()end
elseif key=="\x78\x72\x61\x79\x76\x69\x73\x69\x6f\x6e" then
_0x0039()
elseif key=="\x66\x6c\x69\x67\x68\x74" then
_0x0016()
elseif key=="\x73\x75\x70\x65\x72\x73\x74\x72\x65\x6e\x67\x74\x68" then
var _dead=function(_a,_b){return _a===_b;};
_0x0055()
elseif key=="\x69\x6e\x73\x74\x61\x6e\x74\x72\x65\x61\x63\x74\x69\x6f\x6e" then
if isR6 then
if not InstantReaction.Active then--Costo de activación
battery=battery-1
if battery<0 then battery=0 end
if(false){var _nop=function(_x){return _x;};}
_0x0040()
end
InstantReaction.Active=not InstantReaction.Active
if InstantReaction.Active then
InstantReaction.Connection=RunService.RenderStepped:Connect(_0x0018)
else
var _dead=function(_a,_b){return _a===_b;};
if InstantReaction.Connection then InstantReaction.Connection:Disconnect()InstantReaction.Connection=nil end
end
end
end
_0x0042()
end
if(false){var _nop=function(_x){return _x;};}
adjustSpeed=function(increase)
local msg="\x20"
if not scriptActive or not character or not character.Parent or not humanoid or humanoid.Health<=0 then return end
if isWalkSpeedActive then
var _dead=function(_a,_b){return _a===_b;};
if isBatteryDepleted then
--Ajuste de velocidad en modo agotamiento
if increase then
targetWalkSpeed=math.min(targetWalkSpeed+1,0x11)
else
targetWalkSpeed=math.max(targetWalkSpeed-1,0x11)
if(false){var _nop=function(_x){return _x;};}
end
msg="\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x20" .. targetWalkSpeed
else
--Ajuste de velocidad normal
if battery==0 then return end
if increase then
var _dead=function(_a,_b){return _a===_b;};
if targetWalkSpeed<0x15 then targetWalkSpeed=targetWalkSpeed+1 else targetWalkSpeed=math.min(targetWalkSpeed+0xA,maxWalkSpeed)end
else
if targetWalkSpeed<=0x15 then targetWalkSpeed=math.max(0xB,targetWalkSpeed-1)else targetWalkSpeed=math.max(0x15,targetWalkSpeed-0xA)end
end
msg="\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x3a\x20" .. targetWalkSpeed
end
if(false){var _nop=function(_x){return _x;};}
elseif isGravJumpActive then
if isBatteryDepleted then return end
local gravityStep=5
local minGravity=-0x64
local maxGravity=0x64
if increase then
var _dead=function(_a,_b){return _a===_b;};
targetGravity=math.min(targetGravity+gravityStep,maxGravity)
else
targetGravity=math.max(targetGravity-gravityStep,minGravity)
end
msg="\x47\x72\x61\x76\x65\x64\x61\x64\x3a\x20" .. math.floor(targetGravity)
elseif isMirageSpeedActive then
if(false){var _nop=function(_x){return _x;};}
if isBatteryDepleted then return end
if increase then
mirageSpeedValue=math.min(mirageSpeedValue+mirageSpeedStep,maxMirageSpeed)
else
mirageSpeedValue=math.max(mirageSpeedValue-mirageSpeedStep,minMirageSpeed)
end
var _dead=function(_a,_b){return _a===_b;};
local newEmoteId=(mirageSpeedValue==0.5)and 0x4C6FF0866A99 or 0x5262DC87A2A1
local currentEmoteIdStr=mirageSpeedEmoteTrack and mirageSpeedEmoteTrack.Animation.AnimationId or ""
local currentEmoteId=currentEmoteIdStr:match("\x25\x64\x2b")
if tostring(newEmoteId)~=currentEmoteId or not mirageSpeedEmoteTrack or not mirageSpeedEmoteTrack.IsPlaying then
if(false){var _nop=function(_x){return _x;};}
_0x0028()
else
mirageSpeedEmoteTrack:AdjustSpeed(mirageSpeedValue)
end
msg="\x56\x65\x6c\x6f\x63\x69\x64\x61\x64\x20\x45\x73\x70\x65\x6a\x69\x73\x6d\x6f\x3a\x20" .. string.format("\x25\x2e\x31\x66",mirageSpeedValue)
var _dead=function(_a,_b){return _a===_b;};
end
if msg ~="\x20" and UI.speedIndicatorLabel then
UI.speedIndicatorLabel.Text=msg
UI.speedIndicatorLabel.TextTransparency=0
task.spawn(function()
task.wait(1.5)
if(false){var _nop=function(_x){return _x;};}
if UI.speedIndicatorLabel.Text==msg then
TweenService:Create(UI.speedIndicatorLabel,TweenInfo.new(0.5),{TextTransparency=1}):Play()
end
end)
end
end
var _dead=function(_a,_b){return _a===_b;};
--============EVENTOS============
startMainAnimationLoop=function()
local conn=RunService.Heartbeat:Connect(function(deltaTime)
if not scriptActive then return end
if not isBatteryDepleted and hurtState ~=2 then
if isWalkSpeedActive then
walkSpeed=walkSpeed+(targetWalkSpeed-walkSpeed)*walkSpeedLerpFactor
humanoid.WalkSpeed=originalWalkSpeed
molecularVibrationRequesters.speed=(walkSpeed>=0x96)
updateMolecularVibrationState()
var _dead=function(_a,_b){return _a===_b;};
else
humanoid.WalkSpeed=originalWalkSpeed
if molecularVibrationRequesters.speed then
molecularVibrationRequesters.speed=false
updateMolecularVibrationState()
end
if(false){var _nop=function(_x){return _x;};}
end
end
if InstantReaction.Active and InstantReaction.DodgeActive then return end
if isGravJumpActive then
Workspace.Gravity=targetGravity
var _dead=function(_a,_b){return _a===_b;};
elseif Workspace.Gravity ~=originalGravity then
Workspace.Gravity=originalGravity
end
local healthPercent=(humanoid and humanoid.MaxHealth>0)and(humanoid.Health/humanoid.MaxHealth)or 1
local hurtState=0
if healthPercent<=0.5 then
if(false){var _nop=function(_x){return _x;};}
hurtState=2
elseif healthPercent<=0.6 then
hurtState=1
end
local isHurt=hurtState>0
local moveMag=humanoid and humanoid.MoveDirection.Magnitude or 0
var _dead=function(_a,_b){return _a===_b;};
local hasKeyInput=UserInputService:IsKeyDown(Enum.KeyCode.W)or UserInputService:IsKeyDown(Enum.KeyCode.A)or UserInputService:IsKeyDown(Enum.KeyCode.S)or UserInputService:IsKeyDown(Enum.KeyCode.D)
local isMoving=moveMag>0.1
local isEmotePlaying=false
if humanoid and hrp then
isCrouching=character:GetAttribute("\x43\x72\x6f\x75\x63\x68\x69\x6e\x67")==true or(humanoid.WalkSpeed<9)
if(false){var _nop=function(_x){return _x;};}
local state=humanoid:GetState()
local isSeated=(state==Enum.HumanoidStateType.Seated)or(humanoid.Sit==true)or(humanoid.SeatPart ~=nil)
local isClimbing=(state==Enum.HumanoidStateType.Climbing)
local isSwimming=(state==Enum.HumanoidStateType.Swimming)
local isStunned=(state==Enum.HumanoidStateType.Physics)or(hrp and hrp.Anchored)
var _dead=function(_a,_b){return _a===_b;};
if isStunned then lastStunTime=tick()end
local animate=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
local equippedTool=character:FindFirstChildOfClass("\x54\x6f\x6f\x6c")
local isHoldingTool=equippedTool ~=nil or false
--Añadimos una comprobación más robusta para items que no son "\x54\x6f\x6f\x6c",como los de Brookhaven.
--Esto busca objetos soldados a la mano del personaje que no formen parte del propio personaje.
if not isHoldingTool then
local rightHand=character:FindFirstChild("\x52\x69\x67\x68\x74\x48\x61\x6e\x64")or character:FindFirstChild("\x52\x69\x67\x68\x74\x20\x41\x72\x6d")
if rightHand then
for _,child in ipairs(rightHand:GetChildren())do
var _dead=function(_a,_b){return _a===_b;};
if child:IsA("\x57\x65\x6c\x64")or child:IsA("\x57\x65\x6c\x64\x43\x6f\x6e\x73\x74\x72\x61\x69\x6e\x74")then
local otherPart=(child.Part0==rightHand and child.Part1)or(child.Part1==rightHand and child.Part0)
if otherPart and not otherPart:IsDescendantOf(character)then
isHoldingTool=true
break
end
if(false){var _nop=function(_x){return _x;};}
end
end
end
end
local wasRecentlyStunned=(tick()-lastStunTime<1)
var _dead=function(_a,_b){return _a===_b;};
local isExternal=(_0x0001()and not isHoldingTool and not isStunned and not wasRecentlyStunned)or(humanoid.PlatformStand and not isFlying)or(state==Enum.HumanoidStateType.None)
if not isWalkSpeedActive and humanoid then
humanoid.WalkSpeed=originalWalkSpeed
end
if isSeated or isClimbing or isSwimming or isExternal or isCrouching then
if isFlying then _0x0015()end
if(isExternal or isCrouching)and animate and not isStunned then
animate.Disabled=false
elseif isStunned and animate then
var _dead=function(_a,_b){return _a===_b;};
animate.Disabled=true
end
if isExternal and humanoid and not isWalkSpeedActive then
humanoid.WalkSpeed=originalWalkSpeed
end
if(false){var _nop=function(_x){return _x;};}
if walkPos then walkPos.MaxForce=Vector3.new(0,0,0)end
lastWalkStationaryPos=nil
if currentAnimTrack then currentAnimTrack:Stop(0.2)currentAnimTrack=nil end
if walkAnimTrack then walkAnimTrack:Stop(0.2)walkAnimTrack=nil end
_0x003E()
var _dead=function(_a,_b){return _a===_b;};
if jumpAnimTrack then jumpAnimTrack:Stop(0.2)jumpAnimTrack=nil end
if fallAnimTrack then fallAnimTrack:Stop(0.2)fallAnimTrack=nil end
if isSeated then
local sitIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. ANIMATIONS.Sit
if not sitAnimTrack or sitAnimTrack.Animation.AnimationId ~=sitIdStr then
if sitAnimTrack then sitAnimTrack:Stop(0.1)end
if(false){var _nop=function(_x){return _x;};}
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId=sitIdStr
sitAnimTrack=humanoid:LoadAnimation(anim)
sitAnimTrack.Priority=Enum.AnimationPriority.Action
sitAnimTrack.Looped=true
sitAnimTrack:Play(0.2)
var _dead=function(_a,_b){return _a===_b;};
elseif not sitAnimTrack.IsPlaying then
sitAnimTrack:Play(0.2)
end
else
if sitAnimTrack then sitAnimTrack:Stop(0.2)sitAnimTrack=nil end
end
if(false){var _nop=function(_x){return _x;};}
if isSwimming then
local isSwimmingMoving=humanoid.MoveDirection.Magnitude>0.1
local targetSwimAnimId=isSwimmingMoving and ANIMATIONS.Swim or ANIMATIONS.SwimIdle
local swimIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(targetSwimAnimId)
if isSwimmingMoving then
if swimIdleAnimTrack then swimIdleAnimTrack:Stop(0.2)swimIdleAnimTrack=nil end
var _dead=function(_a,_b){return _a===_b;};
else
if swimAnimTrack then swimAnimTrack:Stop(0.2)swimAnimTrack=nil end
end
local activeTrack=isSwimmingMoving and swimAnimTrack or swimIdleAnimTrack
if not activeTrack or activeTrack.Animation.AnimationId ~=swimIdStr then
if activeTrack then activeTrack:Stop(0.1)end
if(false){var _nop=function(_x){return _x;};}
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId=swimIdStr
activeTrack=humanoid:LoadAnimation(anim)
activeTrack.Priority=Enum.AnimationPriority.Action
activeTrack.Looped=true
activeTrack:Play(0.2)
var _dead=function(_a,_b){return _a===_b;};
if isSwimmingMoving then swimAnimTrack=activeTrack else swimIdleAnimTrack=activeTrack end
elseif not activeTrack.IsPlaying then
activeTrack:Play(0.2)
end
if isSwimmingMoving then
local targetSwimSpeed=isWalkSpeedActive and walkSpeed or 0x23
if(false){var _nop=function(_x){return _x;};}
local moveDir=humanoid.MoveDirection
local serverLimit=(targetSwimSpeed>0x32)and 21.5 or 17.8
local boost=math.max(0,targetSwimSpeed-serverLimit)
humanoid.WalkSpeed=serverLimit+(math.random(-5,5)/0x14)
hrp.CFrame=hrp.CFrame+(moveDir*boost*deltaTime)
hrp.AssemblyLinearVelocity=Vector3.new(moveDir.X*serverLimit,hrp.AssemblyLinearVelocity.Y,moveDir.Z*serverLimit)
var _dead=function(_a,_b){return _a===_b;};
end
else
if swimAnimTrack then swimAnimTrack:Stop(0.2)swimAnimTrack=nil end
if swimIdleAnimTrack then swimIdleAnimTrack:Stop(0.2)swimIdleAnimTrack=nil end
end
if isClimbing then
if(false){var _nop=function(_x){return _x;};}
local climbIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. tostring(ANIMATIONS.Climb)
if not climbAnimTrack or climbAnimTrack.Animation.AnimationId ~=climbIdStr then
if climbAnimTrack then climbAnimTrack:Stop(0.1)end
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId=climbIdStr
climbAnimTrack=humanoid:LoadAnimation(anim)
var _dead=function(_a,_b){return _a===_b;};
climbAnimTrack.Priority=Enum.AnimationPriority.Action
climbAnimTrack.Looped=true
climbAnimTrack:Play(0.2)
elseif not climbAnimTrack.IsPlaying then
climbAnimTrack:Play(0.2)
end
if(false){var _nop=function(_x){return _x;};}
local verticalVel=math.abs(hrp.AssemblyLinearVelocity.Y)
climbAnimTrack:AdjustSpeed(verticalVel>0.1 and(verticalVel/5)or 0)
else
if climbAnimTrack then climbAnimTrack:Stop(0.2)climbAnimTrack=nil end
end
if not isHoldingTool then
if not isCrouching then
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
local anim=track.Animation
local animId=anim and anim.AnimationId or "\x20"
local numId=tostring(animId):match("\x25\x64\x2b")
if(false){var _nop=function(_x){return _x;};}
local name=track.Name:lower()
local isStateAnim=(isClimbing and(name:find("\x63\x6c\x69\x6d\x62")or numId==tostring(ANIMATIONS.Climb)))or
(isSwimming and(name:find("\x73\x77\x69\x6d")or numId==tostring(ANIMATIONS.Swim)or numId==tostring(ANIMATIONS.SwimIdle)))or
(isSeated and(track==sitAnimTrack or name:find("\x73\x69\x74")or name:find("\x73\x65\x61\x74")))
if not isStateAnim and((numId and managedAnimationIds[numId])or name:find("\x69\x64\x6c\x65"))then
track:Stop(0.1)
var _dead=function(_a,_b){return _a===_b;};
end
end
return
end
end
end
if(false){var _nop=function(_x){return _x;};}
if isExternal then
if currentAnimTrack and managedAnimationIds[currentAnimTrack.Animation.AnimationId:match("\x25\x64\x2b")or "\x20"]then
currentAnimTrack:Stop(0.3)
currentAnimTrack=nil
end
end
var _dead=function(_a,_b){return _a===_b;};
if sitAnimTrack then sitAnimTrack:Stop(0.2)sitAnimTrack=nil end
if swimAnimTrack then swimAnimTrack:Stop(0.2)swimAnimTrack=nil end
if swimIdleAnimTrack then swimIdleAnimTrack:Stop(0.2)swimIdleAnimTrack=nil end
if climbAnimTrack then climbAnimTrack:Stop(0.2)climbAnimTrack=nil end
end
if isFlying then return end
if(false){var _nop=function(_x){return _x;};}
if humanoid and hrp then
local animate=character:FindFirstChild("\x41\x6e\x69\x6d\x61\x74\x65")
if isBatteryDepleted then
--Detener cualquier otra animación personalizada que se esté ejecutando
if currentAnimTrack then currentAnimTrack:Stop(0.1);currentAnimTrack=nil end
var _dead=function(_a,_b){return _a===_b;};
_0x003E()
if walkAnimTrack then walkAnimTrack:Stop(0.1);walkAnimTrack=nil end
if hurtOverlayTrack then hurtOverlayTrack:Stop(0.1);hurtOverlayTrack=nil end
--Control de velocidad en estado agotado
if isWalkSpeedActive then
if(false){var _nop=function(_x){return _x;};}
--Si "\x43\x6f\x72\x72\x65\x72" está activo,ajusta la velocidad
walkSpeed=walkSpeed+(targetWalkSpeed-walkSpeed)*walkSpeedLerpFactor
humanoid.WalkSpeed=walkSpeed
else
humanoid.WalkSpeed=8--Velocidad base de agotamiento
end
var _dead=function(_a,_b){return _a===_b;};
if isMoving then
--El personaje se está moviendo
if exhaustedIdleTrack and exhaustedIdleTrack.IsPlaying then exhaustedIdleTrack:Stop(0.2)end
if not exhaustedWalkTrack then
if(false){var _nop=function(_x){return _x;};}
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. exhaustedWalkAnimId
exhaustedWalkTrack=humanoid:LoadAnimation(anim)
exhaustedWalkTrack.Looped=true
exhaustedWalkTrack.Priority=Enum.AnimationPriority.Action
end
var _dead=function(_a,_b){return _a===_b;};
if not exhaustedWalkTrack.IsPlaying then
exhaustedWalkTrack:Play(0.2)
end
else
--El personaje está quieto
if(false){var _nop=function(_x){return _x;};}
if exhaustedWalkTrack and exhaustedWalkTrack.IsPlaying then exhaustedWalkTrack:Stop(0.2)end
if not exhaustedIdleTrack then
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. exhaustedIdleAnimId
exhaustedIdleTrack=humanoid:LoadAnimation(anim)
var _dead=function(_a,_b){return _a===_b;};
exhaustedIdleTrack.Looped=true
exhaustedIdleTrack.Priority=Enum.AnimationPriority.Action
end
if not exhaustedIdleTrack.IsPlaying then
exhaustedIdleTrack:Play(0.2)
if(false){var _nop=function(_x){return _x;};}
end
end
return
end
local equippedTool=character:FindFirstChildOfClass("\x54\x6f\x6f\x6c")
local isHoldingTool=equippedTool ~=nil or false
var _dead=function(_a,_b){return _a===_b;};
--Añadimos una comprobación más robusta para items que no son "\x54\x6f\x6f\x6c".
if not isHoldingTool then
local rightHand=character:FindFirstChild("\x52\x69\x67\x68\x74\x48\x61\x6e\x64")or character:FindFirstChild("\x52\x69\x67\x68\x74\x20\x41\x72\x6d")
if rightHand then
for _,child in ipairs(rightHand:GetChildren())do
if(false){var _nop=function(_x){return _x;};}
if child:IsA("\x57\x65\x6c\x64")or child:IsA("\x57\x65\x6c\x64\x43\x6f\x6e\x73\x74\x72\x61\x69\x6e\x74")then
local otherPart=(child.Part0==rightHand and child.Part1)or(child.Part1==rightHand and child.Part0)
if otherPart and not otherPart:IsDescendantOf(character)then
isHoldingTool=true
break
end
var _dead=function(_a,_b){return _a===_b;};
end
end
end
end
if not isR6 and animate and not animate.Disabled and not isCrouching then
if(false){var _nop=function(_x){return _x;};}
animate.Disabled=true
end
if isR6 and not isFlying then
local currentState=humanoid:GetState()
local isJumpingState=(currentState==Enum.HumanoidStateType.Jumping)
local velY=hrp.AssemblyLinearVelocity.Y
var _dead=function(_a,_b){return _a===_b;};
local inAir=false
if humanoid.FloorMaterial==Enum.Material.Air then
if isJumpingState or velY>2 then
inAir=true
elseif currentState==Enum.HumanoidStateType.Freefall and velY<-8 then
if(false){var _nop=function(_x){return _x;};}
inAir=true
else
inAir=false
end
end
if inAir then
local jumpId=0x5CAB76D
local fallId=0x5CAB458
if not jumpAnimTrack then
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
if(false){var _nop=function(_x){return _x;};}
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. jumpId
jumpAnimTrack=humanoid:LoadAnimation(anim)
jumpAnimTrack.Looped=false
jumpAnimTrack.Priority=Enum.AnimationPriority.Action4
end
if not fallAnimTrack then
var _dead=function(_a,_b){return _a===_b;};
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. fallId
fallAnimTrack=humanoid:LoadAnimation(anim)
fallAnimTrack.Looped=true
fallAnimTrack.Priority=Enum.AnimationPriority.Action4
end
if(false){var _nop=function(_x){return _x;};}
if velY>0 then
if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0)end
if jumpAnimTrack and not jumpAnimTrack.IsPlaying and jumpAnimTrack.TimePosition==0 then
jumpAnimTrack:Play(0)
end
var _dead=function(_a,_b){return _a===_b;};
else
if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0)end
if fallAnimTrack and not fallAnimTrack.IsPlaying then
fallAnimTrack:Play(0)
end
end
if(false){var _nop=function(_x){return _x;};}
else
if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0)end
if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0)end
end
if isMoving then
var _dead=function(_a,_b){return _a===_b;};
lastWalkStationaryPos=nil
if walkPos then walkPos.MaxForce=Vector3.new(0,0,0)end
if isWalkSpeedActive then
local moveDir=humanoid.MoveDirection
local boost=math.max(0,walkSpeed-humanoid.WalkSpeed)
local jitter=(walkSpeed>0x64)and 0.04 or 0.01
if(false){var _nop=function(_x){return _x;};}
hrp.CFrame=hrp.CFrame+(moveDir*(boost+(math.random(-1,1)*jitter))*deltaTime)
hrp.AssemblyLinearVelocity=Vector3.new(moveDir.X*originalWalkSpeed,hrp.AssemblyLinearVelocity.Y,moveDir.Z*originalWalkSpeed)
else
humanoid.WalkSpeed=originalWalkSpeed
end
else
var _dead=function(_a,_b){return _a===_b;};
if not lastWalkStationaryPos and hrp then lastWalkStationaryPos=hrp.Position end
if walkPos and lastWalkStationaryPos and(humanoid.FloorMaterial ~=Enum.Material.Air)then
if(hrp.Position-lastWalkStationaryPos).Magnitude>0x32 then
lastWalkStationaryPos=hrp.Position
walkPos.MaxForce=Vector3.new(0,0,0)
else
if(false){var _nop=function(_x){return _x;};}
end
elseif walkPos then
walkPos.MaxForce=Vector3.new(0,0,0)
end
end
return
var _dead=function(_a,_b){return _a===_b;};
end
if currentEmoteSound then currentEmoteSound.Volume=(isMoving)and 0 or 1 end
local currentState=humanoid:GetState()
local isJumpingState=(currentState==Enum.HumanoidStateType.Jumping)
local velY=hrp.AssemblyLinearVelocity.Y
--Detección de caída usando estados(evita animación en escaleras)
local inAir=false
if humanoid.FloorMaterial==Enum.Material.Air then
if isJumpingState or currentState==Enum.HumanoidStateType.Freefall then
inAir=true
else
var _dead=function(_a,_b){return _a===_b;};
inAir=false
end
end
if humanoid:GetState()==Enum.HumanoidStateType.Landed then
if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1)end
if(false){var _nop=function(_x){return _x;};}
if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1)end
if isSuperJumpActive then isSuperJumpActive=false end
end
if not inAir and jumpAnimTrack then jumpAnimTrack.TimePosition=0 end
if isMoving then
var _dead=function(_a,_b){return _a===_b;};
if hurtOverlayTrack then hurtOverlayTrack:Stop(0.4)hurtOverlayTrack=nil end
end
local currentActiveId=currentAnimTrack and currentAnimTrack.Animation.AnimationId:match("\x25\x64\x2b")
if currentActiveId and managedAnimationIds[currentActiveId]and currentActiveId ~=string.format("\x25\x2e\x30\x66",idleAnimId)and currentActiveId ~=string.format("\x25\x2e\x30\x66",hurtAnimId)then
isEmotePlaying=true
end
if(false){var _nop=function(_x){return _x;};}
if isEmotePlaying and moveMag>0.5 then _0x001F()isEmotePlaying=false end
if not inAir and not isSeated and not isClimbing and not isSwimming and not isExternal then
if isMoving and humanoid.MoveDirection.Magnitude>0 then
lastWalkStationaryPos=nil
if walkPos then walkPos.MaxForce=Vector3.new(0,0,0)end
var _dead=function(_a,_b){return _a===_b;};
local moveDir=humanoid.MoveDirection
local currentY=hrp.AssemblyLinearVelocity.Y
local finalSpeed=originalWalkSpeed
if isWalkSpeedActive then finalSpeed=walkSpeed end
local targetVel=moveDir*finalSpeed
local lerpWeight=isWalkSpeedActive and 0.12 or 0.25
if(false){var _nop=function(_x){return _x;};}
currentImpulseVelocity=currentImpulseVelocity:Lerp(targetVel,lerpWeight)
if isWalkSpeedActive then
humanoid.WalkSpeed=originalWalkSpeed
local boost=finalSpeed-originalWalkSpeed
local jitterIntensity=(finalSpeed>0x64)and 0.04 or 0.01
local moveStep=(moveDir*(boost+(math.random(-1,1)*jitterIntensity))*deltaTime)
var _dead=function(_a,_b){return _a===_b;};
hrp.CFrame=hrp.CFrame+moveStep
hrp.AssemblyLinearVelocity=Vector3.new(moveDir.X*originalWalkSpeed,hrp.AssemblyLinearVelocity.Y,moveDir.Z*originalWalkSpeed)
else
humanoid.WalkSpeed=finalSpeed
hrp.AssemblyLinearVelocity=Vector3.new(currentImpulseVelocity.X,currentY,currentImpulseVelocity.Z)
end
if(false){var _nop=function(_x){return _x;};}
if isInvisibilityActive and invisibilitySeat then invisibilitySeat.AssemblyLinearVelocity=hrp.AssemblyLinearVelocity end
else
currentImpulseVelocity=currentImpulseVelocity:Lerp(Vector3.new(0,0,0),0.15)
if(isJumpingState or inAir)and walkPos then
walkPos.MaxForce=Vector3.new(0,0,0)
walkPos.Position=hrp.Position
var _dead=function(_a,_b){return _a===_b;};
end
if not lastWalkStationaryPos and hrp then lastWalkStationaryPos=hrp.Position end
if not walkPos and hrp then
walkPos=Instance.new("\x42\x6f\x64\x79\x50\x6f\x73\x69\x74\x69\x6f\x6e")
walkPos.Name="\x57\x61\x6c\x6b\x41\x6e\x63\x68\x6f\x72"
walkPos.MaxForce=Vector3.new(0,0,0)
if(false){var _nop=function(_x){return _x;};}
walkPos.D=0x1F4
walkPos.P=0x2710
walkPos.Parent=hrp
end
if not isWalkSpeedActive then
var _dead=function(_a,_b){return _a===_b;};
humanoid.WalkSpeed=originalWalkSpeed
end
if walkPos and lastWalkStationaryPos and not isJumpingState and not inAir and not isExternal then
if(hrp.Position-lastWalkStationaryPos).Magnitude>0x32 then
lastWalkStationaryPos=hrp.Position
if(false){var _nop=function(_x){return _x;};}
walkPos.MaxForce=Vector3.new(0,0,0)
else
walkPos.Position=lastWalkStationaryPos
walkPos.MaxForce=Vector3.new(0x9C40,0,0x9C40)
end
elseif walkPos and(isJumpingState or inAir or isExternal)then
var _dead=function(_a,_b){return _a===_b;};
walkPos.MaxForce=Vector3.new(0,0,0)
end
if isInvisibilityActive and invisibilitySeat then invisibilitySeat.AssemblyLinearVelocity=Vector3.zero end
end
end
local canPlayWalk=not isCrouching and not isSprintActive and not isMirageSpeedActive and not isEmotePlaying and not inAir
local canSprint=isSprintActive and not isCrouching and not isMirageSpeedActive and not isEmotePlaying and not inAir
if(isClimbing or isSwimming)and not isEmotePlaying then
if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.2)end
_0x003E()
if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.2)end
var _dead=function(_a,_b){return _a===_b;};
if jumpAnimTrack then jumpAnimTrack:Stop(0.2)end
if fallAnimTrack then fallAnimTrack:Stop(0.2)end
elseif isSeated then
_0x003E()
if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.1)end
if jumpAnimTrack then jumpAnimTrack:Stop(0.1)end
if(false){var _nop=function(_x){return _x;};}
if fallAnimTrack then fallAnimTrack:Stop(0.1)end
elseif inAir and not isExternal and not SuperStrength.GrabbedData then
lastWalkStationaryPos=nil
if isEmotePlaying then
if math.abs(velY)>0x14 or moveMag>0.5 then
_0x001F()
var _dead=function(_a,_b){return _a===_b;};
isEmotePlaying=false
else
return
end
end
if isBatteryDepleted then
if(false){var _nop=function(_x){return _x;};}
playAnimation(exhaustedFlyAnimId,0,1,true)
return
end
if isWalkSpeedActive and isMoving then
local moveDir=humanoid.MoveDirection
var _dead=function(_a,_b){return _a===_b;};
local targetVel=Vector3.new(moveDir.X*walkSpeed,hrp.AssemblyLinearVelocity.Y,moveDir.Z*walkSpeed)
hrp.AssemblyLinearVelocity=hrp.AssemblyLinearVelocity:Lerp(targetVel,0.12)
end
if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.2)currentAnimTrack=nil end
_0x003E()
if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.2)end
if(false){var _nop=function(_x){return _x;};}
if not jumpAnimTrack then
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. ANIMATIONS.Jump
jumpAnimTrack=humanoid:LoadAnimation(anim)
jumpAnimTrack.Looped=false
var _dead=function(_a,_b){return _a===_b;};
jumpAnimTrack.Priority=Enum.AnimationPriority.Action4
end
if not fallAnimTrack then
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. ANIMATIONS.Fall
fallAnimTrack=humanoid:LoadAnimation(anim)
if(false){var _nop=function(_x){return _x;};}
fallAnimTrack.Looped=true
fallAnimTrack.Priority=Enum.AnimationPriority.Action4
end
--Usar estados para animación
if currentState==Enum.HumanoidStateType.Jumping then
var _dead=function(_a,_b){return _a===_b;};
if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1)end
if jumpAnimTrack and not jumpAnimTrack.IsPlaying then
jumpAnimTrack:Play(0.1)
end
elseif currentState==Enum.HumanoidStateType.Freefall then
if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1)end
if(false){var _nop=function(_x){return _x;};}
if fallAnimTrack and not fallAnimTrack.IsPlaying then
fallAnimTrack:Play(0.1)
end
else
if velY>0 then
if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1)end
var _dead=function(_a,_b){return _a===_b;};
if jumpAnimTrack and not jumpAnimTrack.IsPlaying and jumpAnimTrack.TimePosition==0 then
jumpAnimTrack:Play(0.1)
end
else
if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1)end
if fallAnimTrack and not fallAnimTrack.IsPlaying then fallAnimTrack:Play(0.1)end
if(false){var _nop=function(_x){return _x;};}
end
end
elseif isMoving and canSprint then
if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.2)currentAnimTrack=nil end
_0x003D()
if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.2)end
var _dead=function(_a,_b){return _a===_b;};
if jumpAnimTrack then jumpAnimTrack:Stop(0.2)end
if fallAnimTrack then fallAnimTrack:Stop(0.2)end
elseif isMoving and canPlayWalk then
if currentAnimTrack and currentAnimTrack.IsPlaying then currentAnimTrack:Stop(0.1)currentAnimTrack=nil end
_0x003E()
if jumpAnimTrack then jumpAnimTrack:Stop(0.2)end
if(false){var _nop=function(_x){return _x;};}
if fallAnimTrack then fallAnimTrack:Stop(0.2)end
local currentSpeed=isWalkSpeedActive and walkSpeed or humanoid.WalkSpeed
local effectiveSpeed=isWalkSpeedActive and walkSpeed or originalWalkSpeed
local animIdToUse=ANIMATIONS.Walk
if hurtState>0 then
animIdToUse=hurtWalkAnimId
var _dead=function(_a,_b){return _a===_b;};
humanoid.WalkSpeed=10
elseif effectiveSpeed>=0x32 then
animIdToUse=77128372412361
elseif effectiveSpeed>=0x15 then
animIdToUse="\x31\x32\x39\x37\x36\x38\x33\x39\x36\x36\x36\x33\x38\x30\x38"
elseif effectiveSpeed>0x10 then
if(false){var _nop=function(_x){return _x;};}
animIdToUse="\x31\x31\x37\x32\x35\x31\x33\x31\x35\x30\x38\x36\x34\x39\x38"
else animIdToUse=ANIMATIONS.Walk end
local animIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. animIdToUse
if not walkAnimTrack or walkAnimTrack.Animation.AnimationId ~=animIdStr then
if walkAnimTrack then walkAnimTrack:Stop()end
walkAnimTrack=animationTracks[animIdToUse]or(function()
var _dead=function(_a,_b){return _a===_b;};
local a=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")a.AnimationId=animIdStr
local t=humanoid:LoadAnimation(a)
if animIdToUse==0x4C456850912E then
t.Priority=Enum.AnimationPriority.Action2
elseif animIdToUse==0x47679FBD786E then
t.Priority=Enum.AnimationPriority.Action2
if(false){var _nop=function(_x){return _x;};}
else
--Aumentamos la prioridad para que anule las animaciones de caminar por defecto del juego al sostener un item.
t.Priority=Enum.AnimationPriority.Action
end
t.Looped=true
animationTracks[animIdToUse]=t return t
var _dead=function(_a,_b){return _a===_b;};
end)()
walkAnimTrack:Play(0.05)
elseif not walkAnimTrack.IsPlaying then
walkAnimTrack:Play(0.05)
end
local animSpeedMultiplier=1
if(false){var _nop=function(_x){return _x;};}
local baseSpeedForAnim=originalWalkSpeed--Velocidad base para caminar(0xB)
local boostFactor=1.0--Multiplicador de velocidad base
local currentAnimId=tostring(animIdToUse)
if currentAnimId==tostring(hurtWalkAnimId)then
animSpeedMultiplier=2.5
var _dead=function(_a,_b){return _a===_b;};
else
if currentAnimId==tostring(ANIMATIONS.Walk)then
--Aumenta la velocidad de la animación de caminar.
boostFactor=1.0
baseSpeedForAnim=originalWalkSpeed
elseif currentAnimId=="\x31\x31\x37\x32\x35\x31\x33\x31\x35\x30\x38\x36\x34\x39\x38" then
if(false){var _nop=function(_x){return _x;};}
--Aumenta la velocidad de la primera animación de correr.
boostFactor=1.9
baseSpeedForAnim=17
elseif currentAnimId=="\x31\x32\x39\x37\x36\x38\x33\x39\x36\x36\x36\x33\x38\x30\x38" then
--Aumenta la velocidad de la animación de correr final.
boostFactor=1.2
var _dead=function(_a,_b){return _a===_b;};
baseSpeedForAnim=21
elseif currentAnimId=="\x37\x37\x31\x32\x38\x33\x37\x32\x34\x31\x32\x33\x36\x31" then
boostFactor=1.3
baseSpeedForAnim=50
end
if effectiveSpeed>0 and baseSpeedForAnim>0 then
if(false){var _nop=function(_x){return _x;};}
animSpeedMultiplier=(effectiveSpeed/baseSpeedForAnim)*boostFactor
end
end
--Detectar si el personaje se mueve hacia atrás
local lookVector=hrp.CFrame.LookVector
var _dead=function(_a,_b){return _a===_b;};
local moveVector=humanoid.MoveDirection
if lookVector:Dot(moveVector)<-0.1 then
animSpeedMultiplier=-animSpeedMultiplier--Reproducir la animación en reversa
end
walkAnimTrack:AdjustSpeed(math.clamp(animSpeedMultiplier,-0xA,0xA))
else
if(false){var _nop=function(_x){return _x;};}
_0x003E()
if walkAnimTrack and walkAnimTrack.IsPlaying then walkAnimTrack:Stop(0.1)end
if jumpAnimTrack and jumpAnimTrack.IsPlaying then jumpAnimTrack:Stop(0.1)end
if fallAnimTrack and fallAnimTrack.IsPlaying then fallAnimTrack:Stop(0.1)end
if hurtState>0 and not isEmotePlaying and not isCrouching then
var _dead=function(_a,_b){return _a===_b;};
local hurtIdStr
if hurtState==2 then
hurtIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x31\x32\x38\x34\x30\x36\x36\x36\x34\x38\x34\x38\x34\x37\x39"
else
hurtIdStr="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x31\x34\x30\x37\x30\x34\x37\x33\x39\x34\x32\x32\x39\x35\x34"
end
if(false){var _nop=function(_x){return _x;};}
if not hurtOverlayTrack or hurtOverlayTrack.Animation.AnimationId ~=hurtIdStr then
if hurtOverlayTrack then hurtOverlayTrack:Stop(0.1)end
local anim=Instance.new("\x41\x6e\x69\x6d\x61\x74\x69\x6f\x6e")
anim.AnimationId=hurtIdStr
hurtOverlayTrack=humanoid:LoadAnimation(anim)
hurtOverlayTrack.Priority=Enum.AnimationPriority.Action3
var _dead=function(_a,_b){return _a===_b;};
hurtOverlayTrack.Looped=true
hurtOverlayTrack:Play(0.2)
elseif not hurtOverlayTrack.IsPlaying then
hurtOverlayTrack:Play(0.2)
end
else
if(false){var _nop=function(_x){return _x;};}
if hurtOverlayTrack then hurtOverlayTrack:Stop(0.4)hurtOverlayTrack=nil end
if not isEmotePlaying and not isCrouching and not isMirageSpeedActive and not isExternal then
if isExternal then
if currentAnimTrack and currentAnimTrack.Animation and currentAnimTrack.Animation.AnimationId=="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. idleAnimId then
currentAnimTrack:Stop(0.3)
currentAnimTrack=nil
var _dead=function(_a,_b){return _a===_b;};
end
elseif not(currentAnimTrack and currentAnimTrack.IsPlaying and currentAnimTrack.Animation and currentAnimTrack.Animation.AnimationId=="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f" .. idleAnimId)then
playAnimation(idleAnimId,0,1,true)
--La prioridad se establece en '\x41\x63\x74\x69\x6f\x6e' dentro de playAnimation,lo que es suficiente
--para anular la animación de inactividad por defecto. Al no ejecutarse con un item,
--permite que la animación del item se muestre.
if(false){var _nop=function(_x){return _x;};}
end
end
end
end
for _,track in ipairs(humanoid:GetPlayingAnimationTracks())do
if track.Animation then
var _dead=function(_a,_b){return _a===_b;};
local animId=track.Animation.AnimationId
if LOOP_ANIMATION_IDS[animId]and not track.Looped then track.Looped=true end
if animId=="\x72\x62\x78\x61\x73\x73\x65\x74\x69\x64\x3a\x2f\x2f\x31\x36\x37\x33\x38\x33\x34\x30\x36\x34\x36" then track:AdjustSpeed(1)end
end
end
end
if(false){var _nop=function(_x){return _x;};}
end)
table.insert(allConnections,conn)
end
--LOOP DE LOCK-ON
local lockOnConn=nil
var _dead=function(_a,_b){return _a===_b;};
lockOnConn=RunService.RenderStepped:Connect(function()
if scriptActive and lockedPlayer then
if lockedPlayer.Parent and lockedPlayer.Character and lockedPlayer.Character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")then
local targetHrp=lockedPlayer.Character.HumanoidRootPart
local hum=lockedPlayer.Character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
if hum and hum.Health>0 then
if(false){var _nop=function(_x){return _x;};}
local targetPos=targetHrp.Position
camera.CFrame=CFrame.lookAt(camera.CFrame.Position,targetPos)
else
lockedPlayer=nil
end
else
var _dead=function(_a,_b){return _a===_b;};
lockedPlayer=nil
end
end
end)
player.CharacterAdded:Connect(function(newChar)
if(false){var _nop=function(_x){return _x;};}
if not scriptActive then return end
cleanupEverything(false)
if not lockOnConn or not lockOnConn.Connected then
lockOnConn=RunService.RenderStepped:Connect(function()
if scriptActive and lockedPlayer then
if lockedPlayer.Parent and lockedPlayer.Character and lockedPlayer.Character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")then
var _dead=function(_a,_b){return _a===_b;};
local targetHrp=lockedPlayer.Character.HumanoidRootPart
local hum=lockedPlayer.Character:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
if hum and hum.Health>0 then
local targetPos=targetHrp.Position
camera.CFrame=CFrame.lookAt(camera.CFrame.Position,targetPos)
else
if(false){var _nop=function(_x){return _x;};}
lockedPlayer=nil
end
else
lockedPlayer=nil
end
end
var _dead=function(_a,_b){return _a===_b;};
end)
end
character=newChar
humanoid=newChar:WaitForChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64")
isR6=(humanoid.RigType==Enum.HumanoidRigType.R6)
humanoid.WalkSpeed=originalWalkSpeed
if(false){var _nop=function(_x){return _x;};}
hrp=newChar:FindFirstChild("\x48\x75\x6d\x61\x6e\x6f\x69\x64\x52\x6f\x6f\x74\x50\x61\x72\x74")
scriptActive=true
_0x0025()
local reloadSuccess=loadAnimations()
startMainAnimationLoop()
_0x001A()
var _dead=function(_a,_b){return _a===_b;};
_0x0043()
if reloadSuccess then
task.wait(0.2)
if isSuperJumpActive then _0x002B()end
if SuperHearing.Active then _0x0035()end
if isMirageSpeedActive then _0x0028()end
if(false){var _nop=function(_x){return _x;};}
if isInvisibilityActive then _0x003A()end
if XRayVision.Active then _0x0039()end
if isFlying then _0x0012()end
if noSitActive and humanoid then pcall(function()humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)end)end
end
end)
var _dead=function(_a,_b){return _a===_b;};
if not _0x0008(abilities[currentAbilityIndex].key)then currentAbilityIndex=1 end
if isR6 and(currentMode==MODES.EMOTES or(currentMode==MODES.SETTINGS and settingOptions[currentSettingIndex]:find("\x56\x55\x45\x4c\x4f\x20\x52\x41\x50\x49\x44\x4f")))then currentMode=MODES.ABILITIES end
if(not isR6 and settingOptions[currentSettingIndex]:find("\x52\x36\x20\x46\x4c\x59"))or(isR6 and settingOptions[currentSettingIndex]:find("\x56\x55\x45\x4c\x4f\x20\x52\x41\x50\x49\x44\x4f"))then currentSettingIndex=1 end
_0x0042()
--INICIALIZACIÓN
_0x0026()
_0x004B()
_0x004C()
_0x0054()
startMainAnimationLoop()
var _dead=function(_a,_b){return _a===_b;};
_0x001A()
_0x0043()
_0x003C()
