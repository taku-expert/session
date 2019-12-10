class AddFamilyToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :family, :string
  end
end
