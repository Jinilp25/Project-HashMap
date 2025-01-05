
class Node
  def initialize(key, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end

  def get_key
    @key
  end

  def get_value
    @value
  end

  def get_next
    @next_node
  end

  def set_value(new_value)
    @value = new_value
  end

  def set_next(new_node)
    @next_node = new_node
  end
end

class LinkedList

  @head = nil

  def append(key, value)
    new_node = Node.new(key, value)
    current = @head

    if current == nil
      @head = new_node
    else
      until current.get_next == nil
        current = current.get_next
      end
      current.set_next(new_node)
    end
  end
  
  def get_first_key
    return nil if @head == nil
    @head.get_key 
  end

  def find_value(key)
    current = @head
    until current == nil
      if current.get_key == key
        return current.get_value
      else
        current = current.get_next
      end
    end
    current
  end

  def replace(key, value)
    current = @head
    until current == nil
      if current.get_key == key
        current.set_value(value)
      end
      current = current.get_next
    end
  end

  def remove_key(key)
    current = @head
    value = nil

    if @head.get_key == key
      value = @head.get_value
      @head = @head.get_next
      current.set_next(nil)
    else
      until current == nil
        if current.get_next.get_key == key
          value = current.get_next.get_value
          current.set_next(current.get_next.get_next)
        end
        current = current.get_next
      end
    end
    value
  end

  def get_all_keys
    current = @head
    keys = []

    until current == nil
      keys.append(current.get_key)
      current = current.get_next
    end
    keys
  end

  def get_all_values
    current = @head
    values = []

    until current == nil
      values.append(current.get_value)
      current = current.get_next
    end
    values
  end

  def size
    count = 0
    current = @head
    while current != nil
      current = current.get_next
      count += 1
    end
    count
  end

  def to_s
    current = @head
    str = ""
    until current == nil
      str += "( #{current.get_value} ) -> "
      current = current.get_next
    end
    str += "nil"
    str
  end

end

