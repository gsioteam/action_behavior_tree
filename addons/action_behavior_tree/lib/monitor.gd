extends GraphEdit


export(NodePath) var target_path

const _Gap = 20
const _Size = Vector2(100, 50)

class NodeTree:
	var target: BNode
	var children: Array
	var _size
	var _node: GraphNode
	var _state_label: Label
	var _attributes: Dictionary = {}
	
	func _init(var target:BNode):
		self.target = target
		children = []
		for child in target.get_children():
			if child is BNode:
				children.append(NodeTree.new(child))
	
	func setup(var editor: GraphEdit, var position: Vector2, parent_node: GraphNode = null):
		if _node == null:
			_node = GraphNode.new()
			_state_label = Label.new()
			_state_label.add_color_override("font_color", Color.white)
			_node.add_child(_state_label)
			_node.set_slot(0, true, 0, Color.white, true, 0, Color.white);
			_updateAttrbites()
		var parent = _node.get_parent()
		if parent != editor:
			if parent != null:
				parent.remove_child(_node)
			editor.add_child(_node)
		_node.set_size(_Size)
		_node.offset = position
		_node.title = target.name
		if parent_node == null:
			_node.name = target.name
		else:
			_node.name = str(parent_node.name, ">", target.name)
			editor.connect_node(parent_node.name, 0, _node.name, 0)
		
		var size = self.size()
		var offset = position + Vector2(_Size.x + _Gap * 4, -size.y/2)
		for child in children:
			var subsize = child.size()
			offset.y += subsize.y / 2
			child.setup(editor, offset, _node)
			offset.y += _Gap + subsize.y / 2;
	
	func size() -> Vector2:
		if _size == null:
			var subsize = Vector2(0,0)
			for child in children:
				var s = child.size()
				subsize.y += s.y + _Gap
				if s.x > subsize.x:
					subsize.x = s.x
			var dic = target.debug_data()
			var size = dic.keys().size()
			_size = Vector2(subsize.x + _Gap * 4 + _Size.x, max(subsize.y - _Gap, _Size.y + size * 20))
		return _size

	func tick():
		var state = BNode.Status.FAILED
		if target.has_new():
			state = target.last_status
		match state:
			BNode.Status.FAILED:
				_state_label.text = "FAILED"
				_state_label.add_color_override("font_color", Color.white)
				_node.set_slot_color_left(0, Color.white)
			BNode.Status.RUNNING:
				_state_label.text = "RUNNING"
				_state_label.add_color_override("font_color", Color.green)
				_node.set_slot_color_left(0, Color.green)
				_updateAttrbites()
			BNode.Status.SUCCEED:
				_state_label.text = "SUCCEED"
				_state_label.add_color_override("font_color", Color.green)
				_node.set_slot_color_left(0, Color.green)
				_updateAttrbites()
		for child in children:
			child.tick()
	
	func _updateAttrbites():
		var dic = target.debug_data()
		for key in dic.keys():
			var value = dic[key]
			if _attributes.has(key):
				_attributes[key].text = str(value)
			else:
				var slot = HBoxContainer.new()
				var name_label = Label.new()
				name_label.text = str(key)
				slot.add_child(name_label)
				var value_label = Label.new()
				value_label.text = str(value)
				slot.add_child(value_label)
				_node.add_child(slot)
				_attributes[key] = value_label
		pass

var tree

func _ready():
	var target = get_node(target_path)
	if (target != null):
		tree = _setupTree(target)
		tree.setup(self, Vector2(0,0))

func _setupTree(target) -> NodeTree:
	return NodeTree.new(target)

func _physics_process(delta):
	if tree != null:
		tree.tick()
