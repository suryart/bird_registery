node :birds, object_root: false do
  @birds.collect(&:id)
end