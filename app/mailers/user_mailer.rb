class UserMailer < ApplicationMailer
  
  default from: 'notification@hamsternest.com'
 
  def return_notification_email
    @return_list = params[:return_list]
    
    @return_list.each do |unit|
      @user_profile = unit.user_profile
      @user = @user_profile.user
      @borrow_requests = unit.requests
      @due_date = @borrow_requests.first.return_date
      
      mail(to: @user.email, subject: 'Return your items')
    end
  end
  
  def borrow_request_confirmation_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_borrow_request_url(:item_id => @item.id, :id => @borrow_request.id)
    
    mail(to: @lender.email, subject: 'Borrow request on your item')
  end
  
  def borrow_request_approved_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_url(:id => @item.id)
    
    mail(to: @borrower.email, subject: 'Approved borrow request')
  end
  
  def borrow_request_rejected_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @item_name = @item.item_name
    @url = item_url(:id => @item.id)
    
    mail(to: @borrower.email, subject: 'Rejected borrow request')
  end
end