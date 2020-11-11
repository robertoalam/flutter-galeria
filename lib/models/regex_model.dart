
class RegexModel {
  String nome;
  String alvo;

  RegexModel({this.nome,this.alvo});

  List<RegexModel> get buscarLista {
    return [
      new RegexModel(nome:'imagem' , alvo: "\.(gif|jpe?g|tiff?|png|webp|bmp)") ,
      new RegexModel(nome:'pdf' , alvo: "\.(pdf)") ,
      new RegexModel(nome:'txt' , alvo: "\.(txt)") ,
      new RegexModel(nome:'doc' , alvo: "\.(doc)") ,
      new RegexModel(nome:'video' , alvo: "\.(avi|mpg|mp4|mov)") ,
      new RegexModel(nome:'unknow' , alvo: "\.(key)") ,
      new RegexModel(nome:'pasta' , alvo: "^[\.(gif|jpe?g|tiff?|png|webp|bmp|pdf|txt|doc|avi|mp4|mpg|mov|key)]") ,
    ];
  }

}