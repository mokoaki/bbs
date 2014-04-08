namespace :db do
  task populate: :environment do
    p 'テストユーザ作成 3000人'

    User.create!(name: "テストユーザ",     email: "user@gmail.com",   password: "11111111", password_confirmation: "11111111", admin: false, super_admin: false)
    User.create!(name: "adminユーザ",      email: "admin@gmail.com",  password: "11111111", password_confirmation: "11111111", admin: true,  super_admin: false)
    User.create!(name: "superadminユーザ", email: "sadmin@gmail.com", password: "11111111", password_confirmation: "11111111", admin: true,  super_admin: true)

    (4..3000).each do |count|
      User.create!(name: "ユーザ#{count}", email: "user#{count}@gmail.com", password: "11111111#{count}", password_confirmation: "11111111#{count}", admin: false, super_admin: false)
    end

    p 'テスト板作成 20板'

    Plate.create!(name: '会社A')
    Plate.create!(name: '学校B')

    (3..20).each do |count|
      Plate.create!(name: "組織#{count}")
    end

    p 'テストユーザとテスト板を関連付け 3000人 x 20板'

    (1..3000).each do |user_id|
      (1..20).each do |plate_id|
        UserPlate.create!(user_id: user_id, plate_id: plate_id)
      end
    end

    p 'テストスレ作成 20板 x 20スレ'

    (1..20).each do |plate_id|
      (1..20).each do |bbs_thread_id|
        BbsThread.create!(plate_id: plate_id, name: "スレ#{plate_id}-#{bbs_thread_id}")
      end
    end

    p 'テスト書き込み作成 400スレ x 500'

    (1..400).each do |bbs_thread_id|
      (1..500).each do |no|
        Context.create!(bbs_thread_id: bbs_thread_id, user_id: rand(3000) + 1, no: no, description: ">>#{(1..no).to_a.sample} 内容内容内容内容内容")
      end
    end
  end
end
