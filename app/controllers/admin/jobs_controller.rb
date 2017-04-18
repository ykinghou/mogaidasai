class Admin::JobsController < ApplicationController
   before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :index]
   before_action :require_is_admin
   before_action :find_job_and_check_permission , only: [:edit, :update, :destroy]

   def index
     @jobs = current_user.participated_jobs.order("created_at DESC")
   end


    def show
      @job = Job.find(params[:id])
    end

    def edit
      @job = Job.find(params[:id])
    end

    def new
      @job = Job.new

    end

    def create
      @job = Job.new(job_params)
      @job.user = current_user
      if @job.save
        current_user.join!(@job)
        redirect_to admin_jobs_path
      else
        render :new
      end
    end

    def update

      if @job.update(job_params)
         redirect_to admin_jobs_path, notice: "Update Success!"
      else
        render :edit
      end
    end

    def destroy

      @job.destroy
      flash[:alert] = "Job deleted!"
      redirect_to admin_jobs_path
    end



   private

   def require_is_admin
     if !current_user.admin?
       flash[:alert] = 'You are not admin!'
       redirect_to root_path
     end
   end

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
