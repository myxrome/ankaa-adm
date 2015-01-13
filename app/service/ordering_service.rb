class OrderingService

  def initialize(subject)
    @subject = subject
  end

  def move_up
    upper = subject_neighbors.where("#{@subject.class.table_name}.order < ?", @subject.order).
        order(order: :desc).limit(1).first
    switch_order(@subject, upper) if upper
  end

  def move_down
    lower = subject_neighbors.where("#{@subject.class.table_name}.order > ?", @subject.order).
        order(order: :asc).limit(1).first
    switch_order(@subject, lower) if lower
  end

  private
  def subject_neighbors
    @subject.class.neighbors(@subject)
  end

  def switch_order(first, second)
    buffer = second.order
    second.update_attribute(:order, first.order)
    first.update_attribute(:order, buffer)
  end

end