require 'byebug'
class OrganismalLevel
  attr_accessor :level, :parent

  def initialize(level)
    @level = level
    @parent = nil
  end

  def hierarchical_level
    0
  end
end

class CompositeLevel < OrganismalLevel
  attr_reader :level_composites, :parent

  def initialize(name)
    super(name)
    @level_composites = []
  end

  def <<(*levels)
    levels.flatten!
    levels.each do |l| 
      level_composites << l
      l.parent = self     
    end   
  end

  def remove(level)
    @level.delete(level)
    level.parent = nil
  end

  def hierarchical_levels
    h_level = 0
    level_composites.each { |lc| h_level += lc.hierarchical_level }
    h_level
  end

  def hierarchical_level
    h_level = 0
    level_composites.each { |lc| h_level += lc.hierarchical_level }
    h_level
  end
end

class Organ < CompositeLevel
  def initialize(name)
    super(name)
  end
end

class TissueType2 < CompositeLevel 
  def initialize(name)
    super(name)
  end
end

class TissueType1 < CompositeLevel
  def initialize(name)
    super(name)
  end
end

class CellTypeD < OrganismalLevel
  def initialize
    super('CellType D')
  end

  def hierarchical_level
    1
  end
end

class CellTypeE < OrganismalLevel
  def initialize
    super('CellType E')
  end

  def hierarchical_level
    1
  end
end


class CellTypeC < OrganismalLevel
  def initialize
    super('CellType B')
  end

  def hierarchical_level
    1
  end
end

class CellTypeB < OrganismalLevel
  def initialize
    super('CellType B')
  end

  def hierarchical_level
    1
  end
end

class CellTypeA < OrganismalLevel
  def initialize
    super('CellType A')
  end

  def hierarchical_level
    1
  end
end

composite_specimen_a = TissueType1.new('Tissue A')
composite_specimen_a <<([CellTypeA.new, CellTypeB.new, CellTypeC.new])

composite_specimen_b = TissueType2.new('Tissue B')
composite_specimen_b <<([CellTypeD.new, CellTypeE.new])

composite_specimen_c = Organ.new('Organ II3EB')
composite_specimen_c <<([composite_specimen_a, composite_specimen_b])

puts composite_specimen_a.hierarchical_levels
puts composite_specimen_b.hierarchical_levels
puts composite_specimen_c.hierarchical_levels