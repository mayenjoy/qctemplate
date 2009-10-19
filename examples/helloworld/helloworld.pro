TARGET = helloworld

INCLUDEPATH += ../../src/
DEPENDPATH += ../../src

win32 {
    LIBS += ctemplate.lib

    CONFIG(debug, debug|release) {
        QMAKE_LIBDIR += ../../src/debug
    }
    CONFIG(release, debug|release) {
        QMAKE_LIBDIR += ../../src/release    
    }
}

SOURCES = main.cpp
