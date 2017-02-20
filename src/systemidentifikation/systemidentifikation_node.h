#ifndef SYSTEMIDENTIFIKATION_NODE_H
#define SYSTEMIDENTIFIKATION_NODE_H

#include "common/node_base.h"

#include "systemidentifikation.h"

/*!
 * \brief die wirkliche und erwünschte Geschwindigkeit bekommen
 */
class SystemidentifikationNode : public NodeBase {
 public:
  /*!
   * \brief SystemidentifikationNode the constructor.
   * \param node_handle the NodeHandle to be used.
   */
  SystemidentifikationNode(ros::NodeHandle& node_handle);
  /*!
   * \brief returns the name of the node. It is needed in main and onInit (nodelet) method.
   * \return the name of the node
   */
  static const std::string getName();

 private:
  /*!
   * \brief init init implements initialization of the node. It's only used in
   * the constructors, becaus delegation of constructors is not allowed in
   * C++03. The registration of the parameters is done in here.
   */ 
  void init();

  // NodeBase interface
  /*!
   * \brief startModule is called, if the node shall be turned active. In here
   * the subrscribers an publishers are started.
   */
  void startModule();
  /*!
   * \brief stopModule is called, if the node shall be turned inactive. In this
   * function subscribers and publishers are shutdown.
   */
  void stopModule();

  /*!
   * \brief systemidentifikation contains the ROS-indipendent implementation of this node.
   */
  Systemidentifikation systemidentifikation_;
};

#endif  // SYSTEMIDENTIFIKATION_NODE_H
