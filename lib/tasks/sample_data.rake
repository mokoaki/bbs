namespace :db do
  task populate: :environment do
    User.create!(name: "テストユーザ１",
                 email: "test1@test.com",
                 password: "testtest",
                 password_confirmation: "testtest",
                 admin: true,
                 super_admin: true)

    User.create!(name: "テストユーザ２",
                 email: "test2@gmail.com",
                 password: "testtest",
                 password_confirmation: "testtest",
                 admin: true,
                 super_admin: true)

    Plate.create!(name: '会社1')
    Plate.create!(name: '会社2')
    Plate.create!(name: '学校1')
    Plate.create!(name: '学校2')

    UserPlate.create!(user_id: 1, plate_id: 1)
    UserPlate.create!(user_id: 1, plate_id: 2)
    UserPlate.create!(user_id: 2, plate_id: 1)
    UserPlate.create!(user_id: 2, plate_id: 2)

    BbsThread.create!(plate_id: 1, name: 'スレ1-1')
    BbsThread.create!(plate_id: 1, name: 'スレ1-2')
    BbsThread.create!(plate_id: 2, name: 'スレ2-1')
    BbsThread.create!(plate_id: 2, name: 'スレ2-2')
    BbsThread.create!(plate_id: 3, name: 'スレ3-1')
    BbsThread.create!(plate_id: 3, name: 'スレ3-2')
    BbsThread.create!(plate_id: 4, name: 'スレ4-1')
    BbsThread.create!(plate_id: 4, name: 'スレ5-2')

    (1..8).each do |bbs_thread_id|
      (1..20).each do |no|
        Context.create!(bbs_thread_id: bbs_thread_id, user_id: [1, 2].sample, no: no, description: ">>#{rand(2000)} >>#{rand(2000)} 内容#{no}")
      end
    end

    (21..3000).each do |no|
      Context.create!(bbs_thread_id: 1, user_id: [1, 2].sample, no: no, description: ">>#{rand(3000)} >>#{rand(3000)} >>#{rand(3000)} 内容#{no}")
    end
  end
end
