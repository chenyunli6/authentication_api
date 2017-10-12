class CreateSmsMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :sms_messages do |t|
      t.string :sid, index: true
      t.string :mobile
      t.datetime :send_time
      t.text :text
      t.string :code
      t.string :send_status
      t.string :report_status
      t.string :fee
      t.datetime :user_receive_time
      t.text :error_msg
      t.timestamps
    end
  end
end
