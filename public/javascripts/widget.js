var pintmeWidget = document.createElement('DIV');
pintmeWidget.setAttribute('id', 'pintmeWidget');
pintmeWidget.setAttrubute('style', 'background: url(\'http://pint.me/images/widgets/widget1.png\');');

if (typeof pintmeUser != 'undefined) {
  var pintmeLink = document.createElement('A');
  pintmeLink.setAttribute('href', 'http://pint.me/buy/' + pintmeUser);
  pintmeLink.appendChild(pintmeWidget);
  document.body.appendChild(pintmeLink);
} else {
  alert("Missing PintMe User");
}
