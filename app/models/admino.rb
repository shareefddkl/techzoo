require 'digest/sha2'
class Admino < ActiveRecord::Base
  attr_accessor :password_confirmation
  attr_reader :password

   class << self
    def authenticate(email, password)
      if admino = find_by_email(email)
        if admino.status == 'active' || 'pending' and admino.hashed_password == encrypt_password(password, admino.salt)
          admino
        end
      end
    end

    def encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
    end
  end
  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  private

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
