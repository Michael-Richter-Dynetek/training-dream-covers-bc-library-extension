function Run1(){
    var controlAddIn = document.getElementById("controlAddIn");

    var buttonDib = document.createElement("a");
    buttonDib.id = "buttonDiver";
    buttonDib.href = "#";
    buttonDib.appendChild(document.createTextNode('Press for fun'));
    buttonDib.style.cssText = 'background-color: Red;';

    var nameDiv = document.createElement("div");
    nameDiv.id = "nameDiv";
    nameDiv.appendChild(document.createTextNode("Enjoy Microsoft Learn!"));
    
    var imageDiv = document.createElement("div");
    imageDiv.id = "imageDiv";

    var image1 = document.createElement("img");
    image1.id = "image1";
    image1.setAttribute("src", Microsoft.Dynamics.
                                         NAV.GetImageResource("image1.png"));

    imageDiv.appendChild(image1);
    
    controlAddIn.appendChild(nameDiv);
    controlAddIn.appendChild(imageDiv);
    controlAddIn.appendChild(buttonDib);
}

Run1();