class CreateFormMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :form_messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.string :message_text
      t.string :sender_ip
      t.string :sender_devise
      t.string :sender_lang
      t.boolean :checked
      t.boolean :spam

      t.timestamps
    end
  end
end
