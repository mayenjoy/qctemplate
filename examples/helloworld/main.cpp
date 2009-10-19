#include <ctemplate.h>
#include <QDebug>

int main()
{
    CTemplate tpl;
    
    tpl[ "MESSAGE" ] = "Hello World";

	QString s = "{{MESSAGE}}";
    
    qDebug() << tpl.expandString( s );
}
