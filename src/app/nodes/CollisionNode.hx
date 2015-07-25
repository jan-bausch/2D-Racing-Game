package app.nodes;

import ash.core.Node;
import app.components.Position;
import app.components.Collision;

class CollisionNode extends Node<CollisionNode> {

    public var position: Position;
    public var collision: Collision;

}