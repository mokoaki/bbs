namespace :db do
  task populate: :environment do
    User.create!(name: "mokoaki",
                 email: "mokoriso@gmail.com",
                 password: "mokoaki",
                 password_confirmation: "mokoaki",
                 admin: true,
                 super_admin: true)

    Plate.create!(name: '会社1')
    Plate.create!(name: '会社2')
    Plate.create!(name: '学校1')
    Plate.create!(name: '学校2')

    UserPlate.create!(user_id: 1, plate_id: 1)
    UserPlate.create!(user_id: 1, plate_id: 2)

    BbsThread.create!(plate_id: 1, name: 'スレ1')
    BbsThread.create!(plate_id: 1, name: 'スレ2')
    BbsThread.create!(plate_id: 1, name: 'スレ3')
    BbsThread.create!(plate_id: 1, name: 'スレ4')

    (1..4).each do |bbs_thread_id|
      (1..1000).each do |count|
        Context.create!(bbs_thread_id: bbs_thread_id, user_id: 1, no: count, description: "内容#{count}")
      end
    end
  end
end
