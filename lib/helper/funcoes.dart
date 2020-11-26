class funcoes{

  static corrigirCaminhoPasta(pasta){
      int posicao = pasta.toString().indexOf('0');
      return pasta.substring(posicao+2, pasta.toString().length ).toString().replaceAll("'","");
  }

}