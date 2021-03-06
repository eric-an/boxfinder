class Box < ActiveRecord::Base

  def cubic_volume
    self.length * self.height * self.width
  end

  def dim_weight
    cubic_volume/166.0
  end
  
  def sorted_sides
    [self.length, self.height, self.width].sort
  end

  def girth
    length = sorted_sides.last+1
    girth = (2*(sorted_sides.first+1)) + (2*(sorted_sides[1]+1))
    measurement = (length + girth) > 130
    oversize_charge = measurement ? "yes" : "no"
  end

    def exceeds_girth(box)
    "exceeds girth" if box.girth == "yes"
  end

  def self.box_location(letter)
    box_sizes = []
    Box.all.each { |box| box_sizes << box if box.location == letter}
    box_sizes.sort_by! { |box| [box.length, box.width, box.height] }
    box_sizes
  end

end
