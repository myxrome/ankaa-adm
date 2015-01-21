class DeactivateServiceFactory
  include Singleton

  def build_deactivate_service(subject)
    "Deactivate#{subject.class.name}Service".constantize.new subject
  end

end