class User < ApplicationRecord
  # md5 加密存储用户密码(password_digest)
  has_secure_password

  # 每个用户可以拥有多条todos
  has_many :todos
end
