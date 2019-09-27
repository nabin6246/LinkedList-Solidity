pragma solidity >=0.4.21 <0.6.0;

contract LinkedList {
    event AddEntry(bytes32 head,uint number,bytes32 name,bytes32 next);

    uint public length = 0;
    uint public writtenTotal = 0;

    struct Object {
        bytes32 next;
        uint number;
        bytes32 name;
    }

    bytes32 public head;
    mapping(bytes32 => Object) public objects;


function addEntry(uint _number, bytes32 _name) public returns (bool) {
    Object memory object = Object(head,_number,_name);
    bytes32 id = keccak256(abi.encode(object.number,object.name,length));
    objects[id] = object;
    head = id;
    length = length + 1;
    emit AddEntry(head,object.number,object.name,object.next);
}

function getEntry(bytes32 _id) public view returns (bytes32,uint,bytes32){
    return (objects[_id].next,objects[_id].number,objects[_id].name);
}

function total() public view returns (uint) {
    bytes32 current = head;
    uint totalCount = 0;
    while(current != 0){
        totalCount = totalCount + objects[current].number;
        current = objects[current].next;
    }
    return totalCount;
}

function setTotal() public returns (bool) {
    writtenTotal = total();
    return true;
}

function resetTotal() public returns (bool) {
    writtenTotal = 0;
    return true;
}





}