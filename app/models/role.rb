      #PERM_CREATE = 1
      #PERM_READ   = 2
      #PERM_UPDATE = 4
      #PERM_DESTROY = 8
      #PERM_MANAGE  = 16
class Role < ActiveRecord::Base
  include Rorshack::Permission::RoleModelMethods
end