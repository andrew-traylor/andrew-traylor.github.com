#highway

class Character
  default_attributes = {:st => 10, :dx => 10, :iq => 10, :ht => 10}
  
  def initialize(name, attrib = default_attributes)
    @name = name
    @attributes = attrib
  end
  
  def getAtt(type)
    @attributes[type]
  end
  def setAtt(attribute, value)
    @attributes[attribute] = value
  end
  
  def getName
    @name
  end
  
  #rolls @dice number of dice, returns the total
  def roll(dice = 1)
    total = 0
    dice.times do
      total += (rand(6) + 1)
    end
    return total
  end
  
  #returns difference between success roll and character's attribute
  # >= 0 is success, < 0 is failure
  def success_roll(att_type, modifier = 0)
    att = self.getAtt(att_type)
    check = roll(3) + modifier
    att - check
  end
  
  #returns the winning character
  #2 players make one success roll
  #if one player fails and the other succeeds, the succeeding player wins
  #if they both fail/succeed, the highest margin wins
  def quick_contest (att_type, char1, char1mod, char2, char2mod)
    roll_1 = char1.success_roll(att_type, char1mod)
    roll_2 = char2.success_roll(att_type, char2mod)
  
    if roll_1 >= 0 && roll_2 < 0 
      char1
    end
  
    if roll_2 >= 0 && roll_1 < 0 
      char2
    end
  
    else 
      (roll_1 > roll_2) ? char1 : char2
    end
  end
