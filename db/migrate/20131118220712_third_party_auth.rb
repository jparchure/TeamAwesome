class ThirdPartyAuth < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :uid
      t.string :provider
    end
  end

  def down
  end
end
