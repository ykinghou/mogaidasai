class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs
  has_many :job_relationships
  has_many :participated_jobs, :through => :job_relationships, :source => :job

  def admin?
    is_admin
  end

  def join!(job)
     participated_jobs << job
  end

  def beadmin
     is_admin = true
  end

  def noadmin
     is_admin = false
  end

end
