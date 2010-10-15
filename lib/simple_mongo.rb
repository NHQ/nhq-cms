require 'mongo'
module SimpleMongo
 
  private

  def stringify_keys(hash)
    return_hash = {}
    hash.each_key do |key|
      return_hash[key.to_s] = hash[key]
    end
    return_hash
  end

  def nil_or_array(result)
    if result.size == 0
      return nil
    else
      return result
    end
  end

  # --------------- private
end