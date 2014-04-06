namespace :db do
  task populate: :environment do
    User.create!(name: "テストユーザ",
                 email: "test@gmail.com",
                 password: "11111111",
                 password_confirmation: "11111111",
                 admin: false,
                 super_admin: false)

    User.create!(name: "adminユーザ",
                 email: "admin@gmail.com",
                 password: "11111111",
                 password_confirmation: "11111111",
                 admin: true,
                 super_admin: false)

    User.create!(name: "superadminユーザ",
                 email: "sadmin@gmail.com",
                 password: "11111111",
                 password_confirmation: "11111111",
                 admin: true,
                 super_admin: true)

    Plate.create!(name: 'うんたら会社')
    Plate.create!(name: 'うんたら学校')

    UserPlate.create!(user_id: 1, plate_id: 1)
    UserPlate.create!(user_id: 2, plate_id: 1)
    UserPlate.create!(user_id: 3, plate_id: 1)
    UserPlate.create!(user_id: 1, plate_id: 2)
    UserPlate.create!(user_id: 2, plate_id: 2)
    UserPlate.create!(user_id: 3, plate_id: 2)

    BbsThread.create!(plate_id: 1, name: 'スレ1-1')
    BbsThread.create!(plate_id: 1, name: 'スレ1-2')
    BbsThread.create!(plate_id: 2, name: 'スレ2-1')
    BbsThread.create!(plate_id: 2, name: 'スレ2-2')

    (1..4).each do |bbs_thread_id|
      (1..20).each do |no|
        Context.create!(bbs_thread_id: bbs_thread_id, user_id: [1, 2].sample, no: no, description: ">>#{rand(2000)} >>#{rand(2000)} 内容#{no}")
      end
    end

    (21..3000).each do |no|
      Context.create!(bbs_thread_id: 1, user_id: [1, 2].sample, no: no, description: ">>#{rand(3000)} >>#{rand(3000)} >>#{rand(3000)} 内容#{no}")
    end
  end
end
