#include "systemidentifikation_node.h"

#include "common/node_creation_makros.h"

SystemidentifikationNode::SystemidentifikationNode(ros::NodeHandle &node_handle)
    : NodeBase(node_handle), systemidentifikation_(&parameter_handler_) {
  init();
  activateIfDesired();
}

void SystemidentifikationNode::init() {
  // Abb initializations of class member here. This function is meant to be
  // called at construction time an shall be called ONLY in the constructors.
}

void SystemidentifikationNode::startModule() {
  // sets your node in running mode. Activate publishers, subscribers, service
  // servers, etc here.
}

void SystemidentifikationNode::stopModule() {
  // sets your node in idle mode. Deactivate publishers, subscribers, service
  // servers, etc here.
}

const std::string SystemidentifikationNode::getName() {
  return std::string("systemidentifikation");
}

CREATE_NODE(SystemidentifikationNode)
