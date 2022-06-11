# Action Behavior Tree

A behavior tree plugin for action games.

In many cases we want the behavior tree have continuous state capabilities.
For example, during a character is casting an action, we need this behavior tree 
focus on this action and no need to check or toggle states in partial branches.

A `RUNNING` status is added for indicating that this node is running continuously.

## Try the living demo

[https://gsioteam.github.io/ActionGame/](https://gsioteam.github.io/ActionGame/)

## Special Nodes

### Action Node

Action nodes is used to execute specific actions. 

Override `action` method to implement the behavior.
You can use `yield` in `action` method, the state will
be `RUNNING` until `action` method is complete.

```python
func action(tick):
    bodis = []
    # The returned state will be Status.RUNNING until animation completed.
    yield(tick.target.play_anim(animation), "completed")
    return Status.SUCCEED
```

In a `tick` if the `action` is still in running, `running` method will be invoked.

If `can_cancel` returns `true`. The children nodes 
will be ran, and if any child returns not 
Status.FAILED, move focus to that child.

### If Node

A condition node, returns `FAILED` while the result 
of `test` method is `false`. Otherwise the child node
will be ran. The `test` method will not be invoked while
the child node is in `RUNNING` state.

### Link Node

Select a target node, and the behavior of this link node is same as the target node.

### Goto Node

Move focus to target node.

### During Select Node

Totaly same as Selector node. But if a child node 
returns `RUNNING`, that child node will get focus.
And the select behavior will continue after that 
child node is complete (No longer in `RUNNING` state).

### Queue Node

Run children nodes sequentially. Next child node 
will be ran after prev child node is complete
(No longer in `RUNNING` state).

### Switch Node

Run the selected child node.

