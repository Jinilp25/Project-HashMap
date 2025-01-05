require_relative 'linked_list.rb'

class HashMap

  def initialize
    @buckets = Array.new(16)
    @capacity = 16
    @load_factor = 0.75
  end
  
  def hash(key)
    hash_code = 1
    key.each_char { |char| hash_code = hash_code * char.ord + 1}
    hash_code * 87 % @capacity
  end

  def set(key, value)
    index = self.hash(key)
    raise IndexError if index.negative? || index >= @buckets.length
    if self.has?(key)
      @buckets[index].replace(key, value)
    elsif @buckets[index] == nil
      new_bucket = LinkedList.new
      new_bucket.append(key, value)
      @buckets[index] = new_bucket
    else
      @buckets[index].append(key, value) 
    end

    if self.length > (@capacity * @load_factor).floor
      old_buckets = @buckets
      @capacity = @capacity * 2
      @buckets = Array.new(@capacity)
      old_buckets.each do |bucket| 
        unless bucket == nil
          until bucket == nil
            key = bucket.get_first_key
            break if key == nil
            value = bucket.remove_key(key)
            self.set(key, value)
          end
        end
      end
    end

  end

  def get(key)
    hash_code = self.hash(key)
    @buckets[hash_code].find_value(key) if self.has?(key)
  end
    

  def has?(key)
    hash_code = self.hash(key)
    bucket = @buckets[hash_code]
    if bucket == nil || bucket.find_value(key) == nil
      false
    else
      true
    end
  end

  def remove(key)
    hash_code = self.hash(key)
    return unless @buckets[hash_code] != nil || @buckets[hash_code].has?
    @buckets[hash_code].remove_key(key)
  end

  def length(x = false)
    p @capacity if x
    count = 0
    @buckets.each do |bucket|
      count += bucket.size unless bucket == nil
      p bucket.to_s unless bucket == nil if x
    end
    count
  end

  def clear
    @buckets = []
  end

  def keys
    all_keys = []
    @buckets.each do |bucket|
      all_keys += bucket.get_all_keys unless bucket == nil
    end
    all_keys
  end

  def values
    all_values = []
    @buckets.each do |bucket|
      all_values += bucket.get_all_values unless bucket == nil
    end
    all_values
  end

  def entries
    all_entries = []
    keys = self.keys
    values = self.values
    keys.each_with_index { |key, idx| all_entries.append([key, values[idx]])}
    all_entries
  end

end
  