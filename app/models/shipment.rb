class Shipment < ActiveRecord::Base

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
    length = sorted_sides.last
    girth = (2*sorted_sides.first) + (2*sorted_sides[1])
    measurement = (length + girth) > 165 
    oversize_charge = measurement ? "yes" : "no"
  end

  def conditions(box)
    box_length = box.length >= self.length && box.length <= self.length + 30
    box_width = box.width >= self.height || box.width >= self.width
    box_height = box.height >= self.height || box.height >= self.width
    condition_one = box_length && box_width
    condition_two = box_width && box_height
    condition_three = box.width >= self.width
    condition_four = box.height >= self.height
    condition_five = condition_one && condition_two
    condition_six = condition_three && condition_four
    box if condition_five && condition_six
  end

  def best_box
    possible_sizes = []

    Box.all.each { |box| possible_sizes << box if self.cubic_volume <= box.cubic_volume && conditions(box) }

    possible_sizes.sort_by! { |box| [box.length, box.width, box.height] }.take(3).map { |box| "#{box.length} x #{box.width} x #{box.height} || DIM Weight: #{'%.2f' % box.dim_weight}lbs." }.join("\n")
  end
end
