# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :read, :update, to: :cru
    alias_action :create, :update, to: :cu
    alias_action :create, :read, to: :cr
    alias_action :create, to: :c
    unless user
      can :read, DataKeagamaanKatolik
    else
      if user.peran.nama_peran == "Admin"
        can :manage, :all
      elsif user.peran.nama_peran == "Penyelenggara Pendakat"
        can :crud, DataKeagamaanKatolik, LaporanPenyuluhAgamaKatolik
      elsif user.peran.nama_peran == "Kasie Urakat"
        can :crud, DataKeagamaanKatolik, LaporanPenyuluhAgamaKatolik
      elsif user.peran.nama_peran == "Penyuluh Agama Katolik"
        can :read, DataKeagamaanKatolik, LaporanPenyuluhAgamaKatolik
        can :create, LaporanPenyuluhAgamaKatolik
        can :update, LaporanPenyuluhAgamaKatolik do |laporan_penyuluh_agama_katolik|
          laporan_penyuluh_agama_katolik.try(:user) == user
        end
        can :destroy, LaporanPenyuluhAgamaKatolik do |laporan_penyuluh_agama_katolik|
          laporan_penyuluh_agama_katolik.try(:user) == user
        end
      elsif user.peran.nama_peran == "Pegawai Urakat"
        can :read, DataKeagamaanKatolik, LaporanPenyuluhAgamaKatolik
        can :create, DataKeagamaanKatolik
        can :update, DataKeagamaanKatolik do |data_keagamaan_katolik|
          data_keagamaan_katolik.try(:user) == user
        end
        can :destroy, DataKeagamaanKatolik do |data_keagamaan_katolik|
          data_keagamaan_katolik.try(:user) == user
        end
      elsif user.peran.nama_peran == "Pemirsa"
        can :read, DataKeagamaanKatolik
      end
    end
  end
end