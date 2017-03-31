
CHIP_OFFSET = 206012
CHIP_SIZE = 48
CHIP_MAX = 300

CHIP_NIL = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0]

CATEGORIES = {
  42 => "System",
  9  => "Max HP Up",
  29 => "Hijack Boost",
  30 => "Stun",
  7  => "Ranged Defense",
  6  => "Melee Defense",
  4  => "Ranged Attack Up",
  1  => "Weapon Attack Up",
  63 => "Auto Weapon Switch",
  62 => "Auto Program",
  61 => "Auto Evade",
  60 => "Auto Fire",
  59 => "Auto Attack",
  35 => "Item Scan",
  58 => "HUD: Fishing Spots",
  55 => "HUD: Control",
  54 => "HUD: Objectives",
  53 => "HUD: Damage Values",
  52 => "HUD: Save Points",
  51 => "HUD: EXP Gauge",
  50 => "HUD: Mini-Map",
  49 => "HUD: Text Log",
  48 => "HUD: Skill Gauge",
  41 => "HUD: Enemy Data",
  40 => "HUD: Sound Waves",
  39 => "HUD: HP Gauge",
  47 => "Auto-Collect Items",
  45 => "Continuous Combo",
  46 => "Bullet Detonation",
  44 => "Evasive System",
  38 => "Death Rattle",
   3 => "Critical Up",
  12 => "Auto Heal",
  17 => "Shock Wave",
  19 => "Damage Absorb",
  21 => "Reset",
  10 => "Offensive Heal",
  11 => "Deadly Heal",
  13 => "Evade Range Up",
  14 => "Moving Speed Up",
  18 => "Last Stand",
  20 => "Vengeance",
  22 => "Overclock",
  25 => "Taunt Up",
  27 => "Auto-Use Item",
   2 => "Down Attack Up",
  23 => "Resilience",
  24 => "Counter",
  26 => "Charge Attack",
  31 => "Combust",
}

CHIP_IDS = {
  3338 => "OS Chip",

  3073 => "Max HP Up",
  3074 => "Max HP Up +1",
  3075 => "Max HP Up +2",
  3076 => "Max HP Up +3",

  3289 => "Stun",
  3290 => "Stun +1",
  3291 => "Stun +2",

  3262 => "Hijack Boost",
  3263 => "Hijack Boost +1",
  3264 => "Hijack Boost +2",

  3055 => "Ranged Defense",
  3046 => "Melee Defense",
  3047 => "Melee Defense +1",

  3028 => "Ranged Attack Up",

  3001 => "Weapon Attack Up",

  3358 => "Auto Weapon Switch",
  3357 => "Auto Program",
  3356 => "Auto Evade",
  3355 => "Auto Fire",
  3354 => "Auto Attack",

  3208 => "Item Scan",

  3353 => "HUD: Fishing Spots",
  3350 => "HUD: Control",
  3349 => "HUD: Objectives",
  3348 => "HUD: Damage Values",
  3347 => "HUD: Save Points",
  3346 => "HUD: EXP Gauge",
  3345 => "HUD: Mini-Map",
  3344 => "HUD: Text Log",
  3343 => "HUD: Skill Gauge",
  3337 => "HUD: Enemy Data",
  3336 => "HUD: Sound Waves",
  3335 => "HUD: HP Gauge",

  3342 => "Auto-Collect Items",

  3340 => "Continuous Combo",

  3341 => "Bullet Detonation",

  3339 => "Evasive System",

  3334 => "Death Rattle",

  3019 => "Critical Up",
  3100 => "Auto Heal",
  3145 => "Shock Wave",
  3163 => "Damage Absorb",
  3181 => "Reset",

  3082 => "Offensive Heal",
  3091 => "Deadly Heal",
  3109 => "Evade Range Up",
  3118 => "Moving Speed Up",
  3154 => "Last Stand",
  3172 => "Vengeance",
  3190 => "Overclock",
  3226 => "Taunt Up",
  3244 => "Auto-Use Item",
  3010 => "Down Attack Up",
  3199 => "Resilience",
  3217 => "Counter",
  3235 => "Charge Attack",
  3298 => "Combust",

}

# File.open("SlotData_nil.dat","rb") do |f|
File.open("SlotData_overclock_+1_5s.dat","rb+") do |f|
  f.seek(CHIP_OFFSET)
  CHIP_MAX.times do |i|
    bytes = f.read(CHIP_SIZE)

    data = bytes.unpack("l<*")
    # puts "#{i}: #{data.inspect}"

    id        = data[ 0 ]
    chip_id   = data[ 1 ]
    _category = data[ 2 ]
    _level    = data[ 3 ]
    slots     = data[ 4 ]

    puts "#{i}: #{chip_id} (#{CHIP_IDS[chip_id] || "?"}), category: #{_category}, level: #{_level}, slots: #{slots}"

    # if i == 4
    #   payload = [112,3076,9,5,10,-1,-1,-1,-1,-1,-1,0]
    #   f.seek(CHIP_OFFSET + (i * CHIP_SIZE))
    #   f.write(payload.pack("l<*"))
    # end

  end 
end