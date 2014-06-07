User.delete_all

name = "Admin"
pass = ENV["ADMIN_PASS"]

User.create!(name: name, password: pass, password_confirmation: pass, admin: true)

99.times do |i|
  name = "user#{i}"
  pass = "password"
  User.create!(name: name, password: pass, password_confirmation: pass)
end
