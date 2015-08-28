class CreateTables < ActiveRecord::Migration
  def change
    create_table(:bands) do |t|
      t.column(:name, :string)
      t.column(:tagline, :string)
    end
    create_table(:venues) do |t|
      t.column(:name, :string)
    end
    create_table(:conquests) do |t|
      t.column(:band_id, :int)
      t.column(:venue_id, :int)
      t.column(:date, :string)
      t.column(:canceled, :boolean)
      t.timestamps
    end
  end
end
