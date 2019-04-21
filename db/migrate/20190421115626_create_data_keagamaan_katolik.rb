class CreateDataKeagamaanKatolik < ActiveRecord::Migration[5.2]
  def change
    create_table :data_keagamaan_katolik do |t|
      t.string :judul
      t.string :keterangan
      t.string :tautan
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
