class ScholarshipsController < ApplicationController

  before_filter :set_page
  before_filter :set_new_submission, only: [:show]

  def index
    @scholarships = []
    active_scholarships = Scholarship.active
    @scholarships << active_scholarships

    @city = request.location.city
    @state = request.location.state
    @scholarships << active_scholarships.where(["name like ? or copy like ? or logged_in_copy like ? or meta_description like ?", "%#{@city}%", "%#{@city}%", "%#{@city}%", "%#{@city}%"]) unless @city.blank?
    @scholarships << active_scholarships.where(["name like ? or copy like ? or logged_in_copy like ? or meta_description like ?", "%#{@state}%", "%#{@state}%", "%#{@state}%", "%#{@state}%"]) unless @city.blank?

    if current_user.present?
      audience_ids = current_user.audiences

      audience_ids.each do |audience|
        @scholarships << active_scholarships.joins(:audiences).where(:audiences => {:id => audience.id})
      end

       unless cookies[:signin_scholarships].nil?
        cookies[:signin_scholarships].split.uniq.each do |blog|
          @scholarships << active_scholarships.find_by_permalink(blog)
        end
      end
    else
      unless cookies[:recent_scholarships].nil?
        cookies[:recent_scholarships].split.uniq.each do |blog|
          @scholarships << active_scholarships.find_by_permalink(blog)
        end
      end
    end

    @scholarships.compact!
    @scholarships.flatten!
    @scholarships.reverse!
    @scholarships.uniq!
    @scholarships

    if @scholarships.any? && @scholarships.size == 1
      redirect_to scholarship_path(@scholarships.first)
    end

  end

  def show
    @scholarship = Scholarship.find_by_permalink!(params[:id])
    if @scholarship.unpublished?
      unless user_signed_in?
        return render_404
      else
        flash.now[:notice] = "This scholarship is only visible to admin users."
      end
    end
    if user_signed_in? && current_user.verified?
      cookies[:signin_scholarships] = ''  if cookies[:signin_scholarships].nil?
      cookies[:signin_scholarships] = cookies[:signin_scholarships] + " " + "#{@scholarship.permalink}"

    else  
      cookies[:recent_scholarships] = ''  if cookies[:recent_scholarships].nil?
      cookies[:recent_scholarships] = cookies[:recent_scholarships] + " " + "#{@scholarship.permalink}"
    end  
  end

  private
    def set_new_submission
      @scholarship_submission = ScholarshipSubmission.new
      @scholarship_submission.populate(current_user) if user_signed_in?
    end

    def set_page
      @page = Page.find_by_absolute_url!("/scholarships")
      @promos = @page.promos.includes(:promo_instance)
      @scholarship_submission = ScholarshipSubmission.new
    end
end
