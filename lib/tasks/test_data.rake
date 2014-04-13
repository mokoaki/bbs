namespace :db do
  desc 'insert test data'
  task test_data: :environment do
    user_num       = 5
    plate_num      = 10
    bbs_thread_num = 10
    context_num    = 20

    users       = []
    plates      = []

    p "テストユーザ作成 #{user_num}人"

    users << User.create(name: 'テストユーザ',     email: 'user@gmail.com',   password: '11111111', password_confirmation: '11111111', admin: false, super_admin: false)
    users << User.create(name: 'adminユーザ',      email: 'admin@gmail.com',  password: '11111111', password_confirmation: '11111111', admin: true,  super_admin: false)
    users << User.create(name: 'superadminユーザ', email: 'sadmin@gmail.com', password: '11111111', password_confirmation: '11111111', admin: true,  super_admin: true)

    ActiveRecord::Base.transaction do
      ((User.all.size + 1)..user_num).each do |count|
        users << User.create(name: "ユーザ#{count}", email: "user#{count}@gmail.com", password: "11111111#{count}", password_confirmation: "11111111#{count}", admin: false, super_admin: false)
      end
    end

    p "テスト板作成 #{plate_num}板"

    plates << Plate.create(name: '会社A')
    plates << Plate.create(name: '学校B')

    ((Plate.all.size + 1)..plate_num).each do |count|
      plates << Plate.create(name: "組織#{count}")
    end

    p "テストユーザとテスト板を関連付け #{user_num}人 x #{plate_num}板"

    users.each do |user|
      ActiveRecord::Base.transaction do
        plates.each do |plate|
          user.user_plates.build(plate_id: plate.id).save(:validate => false)
        end
      end
    end

    p "テストスレッド作成 #{plate_num}板 x #{bbs_thread_num}スレ x テスト書き込み#{context_num}"

    plates.each do |plate|
      (1..bbs_thread_num).each do |bbs_threads_count|
        ActiveRecord::Base.transaction do
          bbs_thread = plate.bbs_threads.create(name: "テストスレッド#{plate.id}-#{bbs_threads_count}")

          (1..context_num).each do |no|
            user = users.sample
            bbs_thread.contexts.build(user_id: user.id, user_name: user.name, plate_id: plate.id, no: no, description: ">>#{(1..no).to_a.sample}\n内容内容内容内容内容").save(:validate => false)
          end

          bbs_thread.contexts_count = bbs_thread.contexts.size
          bbs_thread.save(:validate => false)
        end
      end
    end
  end
end
