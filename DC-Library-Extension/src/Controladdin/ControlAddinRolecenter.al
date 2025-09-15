controladdin MyControlAddIn
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts =
        'test2.js';
    StyleSheets =
        'test1.css';
    StartupScript = 'test1.js';
    RecreateScript = 'test1.js';
    RefreshScript = 'test1.js';
    Images =
        'test1.png';


    procedure Run()
}