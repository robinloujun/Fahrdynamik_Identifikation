#ifndef SYSTEMIDENTIFIKATION_H
#define SYSTEMIDENTIFIKATION_H

#include "common/parameter_interface.h"

/*!
 * \brief die wirkliche und erwünschte Geschwindigkeit bekommen
 */
class Systemidentifikation {
 public:
   /*!
   * \brief Systemidentifikation is the consstructor. A ros indipendent functionality containing
   * class needs a pointer to a ParameterInterface (in fact a ParameterHandler)
   * to get access to parameters.
   * \param parameters the ParameterInterface
   */ 
  Systemidentifikation(ParameterInterface *parameters);

 private:
   /*!
   * \brief parameters_ptr_ is needed for parameter access
   */
  ParameterInterface *parameters_ptr_;
};

#endif  // SYSTEMIDENTIFIKATION_H
