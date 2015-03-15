If you are familiar with string template engines like [Smarty](http://www.smarty.net/) (PHP) or [Django](http://www.djangoproject.com/) (Python), then you know what template engines are about: to facilitate the separation of application code from presentation.

Template engines are much less common in C++ than in web development, but things are slowly changing. Today, C++ application need to generate more and more web pages. This is particularly true for Qt programmers since they can embed a complete browser engine (QtWebKit) in their applications. [Google CTemplate](http://code.google.com/p/google-ctemplate/) is such a template system for C++. It is a quite powerful library, but it does not mix that well with the Qt framework, and it is not that simple to use.

**QCTemplate** is a very thin layer above _Google CTemplate_ developed with the following goals in mind:
  * be as simple as possible to use (encapsulate nicely _Google CTemplate_)
  * integrate nicely into "Qt philosophy": use a qmake project file, be compatible with Qt Resource System, use QString type, etc.

To give you a taste of it, just look at the classical Hello World example bellow:

```
CTemplate tlp;

tpl[ "MESSAGE" ] = "Hello World";

qDebug() << tlp.expand( "helloworld.tpl" );
```

Now, let see a more advanced example showing us how to handle a `for loop` in our template:

```
CTemplate tlp;

tpl[ "TITLE" ] = tr( "We display 5 lines bellow:" );

for ( int i = 0; i < 5; i++ )
{
    tpl.enterSection( "FORLOOP" );
    tpl[ "LOOP_MESSAGE" ] = tr( "This is loop number %1" ).arg( i  + 1 );
    tpl.exitSection();
}

qDebug() << tlp.expand( ":/forloop_txt.tpl" );
qDebug() << tlp.expand( ":/forloop_htm.tpl" );
```

As you may notice, the given file name starts with ":/" which means the given file names are not located on disk but embedded in the resource of the application. We also automatically translate the text passed to our template by using the `tr()` function.

The content of `forloop_txt.tpl` is:
```
{{TITLE}}
{{#FORLOOP}}
  * {{LOOP_MESSAGE}}
{{/FORLOOP}}
```

and produce the following output:
```
We display 5 lines bellow:
  * This is loop number 1
  * This is loop number 2
  * This is loop number 3
  * This is loop number 4
  * This is loop number 5
```

The content of of `forloop_htm.tpl` is:
```
<html>
<head>
    <title>{{TITLE}}</title>
</head>
<body>
    <h1>{{TITLE}}</h1>
    <ul>
    {{#FORLOOP}}
        <li>{{LOOP_MESSAGE}}</li>
    {{/FORLOOP}}
    </ul>
</body>
</html>
```

and produce the following output:
```
<html>
<head>
    <title>We display 5 lines bellow:</title>
</head>
<body>
    <t1>We display 5 lines bellow:</t1>
    <ul>
        <li>This is loop number 1</li>
        <li>This is loop number 2</li>
        <li>This is loop number 3</li>
        <li>This is loop number 4</li>
        <li>This is loop number 5</li>
    </ul>
</body>
</html>
```