if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', 
   function preview(){
    const ImageList = document.getElementById('image-list');

      // 選択した画像を表示する関数
    const createImageHTML = (blob) => {
        // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length

      // 表示する画像を生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);

      // ファイル選択ボタンを生成
      const inputHTML = document.createElement('input')
      inputHTML.setAttribute('id', `house_image_${imageElementNum}`)
      inputHTML.setAttribute('name', 'house[images][]')
      inputHTML.setAttribute('type', 'file')

      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      imageElement.appendChild(inputHTML);
      ImageList.appendChild(imageElement);
      
      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob)
      })
    };
        // 上記の選択した画像を表示する物を簡潔にする前のもの↓
        // const blob = window.URL.createObjectURL(file);
        // // 画像を表示するためのdiv要素を生成↓
        // const imageElement = document.createElement('div');
        // // 表示する画像を生成↓
        // const blobImage = document.createElement('img');
        // blobImage.setAttribute('src', blob);
        // imageElement.appendChild(blobImage);
        // ImageList.appendChild(imageElement);

      document.getElementById('house-image').addEventListener('change', function(e){
        // 画像が表示されている場合のみ、すでに存在している画像を削除する
        // const imageContent = document.querySelector('img');
        // if (imageContent){
        //     imageContent.remove();
        // }
        const file = e.target.files[0];
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
    });
  });
}