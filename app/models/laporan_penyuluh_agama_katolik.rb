class LaporanPenyuluhAgamaKatolik < ApplicationRecord
	validates :judul, length: { minimum: 5 }
	validates :keterangan, length: { minimum: 9 }
	belongs_to :users
end
