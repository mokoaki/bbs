namespace :db do
  task populate: :environment do
    user_num       = 5000
    plate_num      = 30
    bbs_thread_num = 20
    context_num    = 500

    p "テストユーザ作成 #{user_num}人"

    @users       = []
    @plates      = []
    @bbs_threads = []

    @users << User.create!(name: "テストユーザ",     email: "user@gmail.com",   password: "11111111", password_confirmation: "11111111", admin: false, super_admin: false)
    @users << User.create!(name: "adminユーザ",      email: "admin@gmail.com",  password: "11111111", password_confirmation: "11111111", admin: true,  super_admin: false)
    @users << User.create!(name: "superadminユーザ", email: "sadmin@gmail.com", password: "11111111", password_confirmation: "11111111", admin: true,  super_admin: true)

    (4..user_num).each do |count|
      @users << User.create!(name: "ユーザ#{count}", email: "user#{count}@gmail.com", password: "11111111#{count}", password_confirmation: "11111111#{count}", admin: false, super_admin: false)
    end

    p "テスト板作成 #{plate_num}板"

    @plates << Plate.create!(name: '会社A')
    @plates << Plate.create!(name: '学校B')

    (3..plate_num).each do |count|
      @plates << Plate.create!(name: "組織#{count}")
    end

    p "テストユーザとテスト板を関連付け #{user_num}人 x #{plate_num}板"

    @users.each do |user|
      @plates.each do |plate|
        user.user_plates.create(plate_id: plate.id)
      end
    end

    p "テストスレ作成 #{plate_num}板 x #{bbs_thread_num}スレ"

    @plates.each do |plate|
      (1..bbs_thread_num).each do |bbs_thread_id|
        @bbs_threads << plate.bbs_threads.create(name: "テストスレ#{plate.id}-#{bbs_thread_id}")
      end
    end

    p "テスト書き込み作成 #{plate_num}板 x #{bbs_thread_num}スレ x #{context_num}"

    @bbs_threads.each do |bbs_thread|
      (1..context_num).each do |no|
        user = User.select(:id, :name).find_by(id: rand(user_num) + 1)
        bbs_thread.contexts.create(user_id: user.id, user_name: user.name, no: no, description: ">>#{(1..no).to_a.sample}\n内容内容内容内容内容")
      end

      bbs_thread.context_count = bbs_thread.contexts.size
      bbs_thread.save
    end
  end
end
