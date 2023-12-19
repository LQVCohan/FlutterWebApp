import 'dart:html';

void main() {
  //Lấy phần tử có id = idxinchao
  var xinchao = querySelector('#App_shopItemButton_23FO1');

  //Khi load trang thiết lập dòng chữ

  //Bấm vào dòn chữ thì viết ra log
  xinchao?.addEventListener('click', (e) => print('Bấm vào dòng chữ'));
}
