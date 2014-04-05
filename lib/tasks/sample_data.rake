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
    BbsThread.create!(plate_id: 1, name: 'スレ1-3')
    BbsThread.create!(plate_id: 1, name: 'スレ1-4')

    BbsThread.create!(plate_id: 2, name: 'スレ2-1')
    BbsThread.create!(plate_id: 2, name: 'スレ2-2')
    BbsThread.create!(plate_id: 2, name: 'スレ2-3')
    BbsThread.create!(plate_id: 2, name: 'スレ2-4')

    (1..8).each do |bbs_thread_id|
      (1..200).each do |no|
        Context.create!(bbs_thread_id: bbs_thread_id, user_id: [1, 2].sample, no: no, description: "内容#{no}")
      end
    end
  end
end
