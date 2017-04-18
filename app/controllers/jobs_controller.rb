class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:show, :new, :create, :update, :edit, :destroy]
  before_action :find_job_and_check_permission , only: [:edit, :update, :destroy]

   def index
     @jobs = Job.where(:is_hidden => false).order("created_at DESC")
     flash[:notice] = "创建admin@job-listing.com超级admin,进入“Admin Controller”对账户权限进行管理！"
   end

   def show
     @job = Job.find(params[:id])
   end

   def edit

   end

   def new
     @job = Job.new

   end

   def create
     @job = Job.new(job_params)
     @job.user = current_user
     if @job.save
       current_user.join!(@job)
       redirect_to jobs_path
     else
       render :new
     end
   end

   def update

     if @job.update(job_params)
        redirect_to jobs_path, notice: "Update Success!"
     else
       render :edit
     end
   end

   def destroy

     @job.destroy
     flash[:alert] = "Job deleted!"
     redirect_to jobs_path
   end


private

def find_job_and_check_permission
   @job = Job.find(params[:id])
   if current_user != @job.user
     redirect_to root_path, alert: "You have no permission!"
   end
end

def job_params
  params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
end

end
