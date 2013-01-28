// List with context menu project template
#ifndef FringeDecoder_HPP_
#define FringeDecoder_HPP_

#include <QObject>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class FringeDecoder : public QObject
{
    Q_OBJECT
public:
    FringeDecoder(bb::cascades::Application *app);
    virtual ~FringeDecoder() {}
};

#endif /* FringeDecoder_HPP_ */