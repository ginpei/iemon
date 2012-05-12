# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20.times do |i|
  begin
    th = Theme.new
    th.body = "hoge: #{i}"
    th.target_date = Date.today - i
    th.save
  rescue => e
    p e
  end


  begin
    post = User.new
    post.save
  rescue => e
    p e
  end


end

# 対応するThemeに合わせてPostを生成
Theme.all.each do |th|
  begin
    post = Post.new
    post.body = "hogehoge #{th.id}"
    post.user_id = 1
    post.theme_id = th.id
    post.save
  rescue => e
    p e
  end
end

User.all.each do |u|
  begin
    post = Post.new
    post.body = "user post #{u.id}"
    post.user_id = u.id
    post.theme_id = 3
    post.save
  rescue => e 
    p e
  end
end
