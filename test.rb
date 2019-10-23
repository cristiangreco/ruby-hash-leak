# frozen_string_literal: true

def create
  h = {{:a => 1} => 2}
  h.keys.first.object_id
end

def find(object_id)
  ObjectSpace.each_object(Hash).any?{|h| h.object_id == object_id}
end

leaked = create

10.times do
  GC.start(full_mark: true, immediate_sweep: true)
end

exit (find(leaked) ? 1 : 0)
