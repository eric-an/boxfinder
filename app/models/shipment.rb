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
    
    if self.height_check
      requirement = box.height >= self.height && box.width >= self.width
      requirement_two = box_length
      box if requirement && requirement_two
    else
      box_one_width = box.width >= self.height
      box_one_height = box.height >= self.width
      box_two_width = box.width >= self.width
      box_two_height = box.height >= self.height
      condition = box_one_width && box_one_height
      condition_two = box_two_width && box_two_height

      necessary_condition = box_length 
      necessary_condition_two = condition || condition_two

      box if necessary_condition && necessary_condition_two
    end
  end

  def best_box
    possible_sizes = []

    Box.all.each { |box| possible_sizes << box if self.cubic_volume <= box.cubic_volume && conditions(box) }

    possible_sizes.sort_by! { |box| [box.dim_weight, box.length, box.width, box.height] }.take(3).map { |box| "#{box.length} x #{box.width} x #{box.height} || DIM Weight: #{'%.2f' % box.dim_weight}lbs." }.join("\n")
  end
end
