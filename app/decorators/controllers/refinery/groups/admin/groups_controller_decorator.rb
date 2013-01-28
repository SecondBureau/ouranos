Refinery::Groups::Admin::GroupsController.class_eval do
  
  skip_before_filter :check_if_superuser
  before_filter :check_if_allowed_to_create, :only => :new

  helper ::MenuHelper
  
  def index
    if current_refinery_user.has_role?("GroupAdmin") && !current_refinery_user.has_role?("Superuser") && !current_refinery_user.has_role?("Bureau")
      redirect_to refinery.groups_admin_group_path(current_refinery_user.group) and return
    end 
    if params[:search]
      @groups = Refinery::Groups::Group.where("lower(name) like ?", "%#{params[:search].downcase}%").paginate(:page => params[:page])
    else
      @groups = Refinery::Groups::Group.paginate(:page => params[:page])
    end
    
  end
  
  private
  
  def find_current_group
    if current_refinery_user.has_role?("GroupAdmin") && !current_refinery_user.has_role?("Superuser") && !current_refinery_user.has_role?("Bureau")
      @group = current_refinery_user.group
    else
      @group = Refinery::Groups::Group.find params[:id]
    end
    @is_guest_group = true if @group.name == "guest"
  end
  

    def check_if_allowed_to_create
      unless current_refinery_user.has_role?("Superuser") || current_refinery_user.has_role?("Bureau")
        flash[:error] = t("refinery.groups.not_allowed_to_create_new_group")
        redirect_to refinery.groups_admin_groups_path
      end
    end
    
    def check_current_user_role
      unless current_refinery_user.has_role?("Superuser")  || current_refinery_user.has_role?("Bureau") || (current_refinery_user.has_role?("GroupAdmin") && @group.users.include?(current_refinery_user))
      redirect_to refinery.groups_admin_groups_path, :flash => { :notice => "can not find that group" }
      end
    end

    def check_before_destroy
      if @is_guest_group || !current_refinery_user.has_role?("Superuser") || !current_refinery_user.has_role?("Bureau")
        redirect_to refinery.groups_admin_groups_path, :flash => { :notice => "can not delete this group" }
      end
    end
  
end
