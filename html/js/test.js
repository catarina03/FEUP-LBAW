const radios = document.getElementsByClassName("form-check-input faq-i");
console.log(radios);

for(let i = 0;i<radios.length;i++){
    radios[i].addEventListener("click",function(event){
        event.preventDefault();
        console.log("f");
        for(let j = 0;j<=i;j++){
            radios[j].style = "background-image:url(\"../images/sad_2.png\");"
        }
        for(let k = i+1;k<radios.length;k++){
            radios[k].style = "background-image:url(\"../images/sad_1.png\");"
        }
    });
}