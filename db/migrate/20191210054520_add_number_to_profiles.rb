class AddNumberToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :number, :string
  end
end
