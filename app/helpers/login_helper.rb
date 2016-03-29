module LoginHelper

  def log_in_student(id)
    session[:user_id] = id
  end

  def log_out_student
    session.delete(:user_id)
  end

  def logged_in_student?
    session.key? :user_id
  end

  def log_in_admin
    session[:is_admin] = true
  end

  def log_out_admin
    session.delete(:is_admin)
  end

  def logged_in_admin?
    session.key? :is_admin
  end

end
