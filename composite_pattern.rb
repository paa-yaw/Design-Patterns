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
end

class TissueType < CompositeLevel
  def initialize(name)
    super(name)
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

composite_specimen_a = TissueType.new('Tissue A')
composite_specimen_a <<([CellTypeA.new, CellTypeB.new, CellTypeC.new])
puts composite_specimen_a.hierarchical_levels

