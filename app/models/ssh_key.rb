# Store the public key in the database

class SshKey
  def self.store(name, public_key)
    # Store the public key in the database
    $redis.set("ssh_key:#{name}", public_key)
  end

  def self.find(name)
    # Find the public key in the database
  end
end