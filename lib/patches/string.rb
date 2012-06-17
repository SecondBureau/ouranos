class String
  def clean
    acc = "ÀÁÂÃÄÅÇÑñÇçÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöøùúûüýÿ"
    self.force_encoding("UTF-8").tr(acc,'_').downcase
  end
end