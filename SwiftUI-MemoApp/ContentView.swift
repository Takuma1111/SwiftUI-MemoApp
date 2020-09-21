//
//  ContentView.swift
//  SwiftUI-MemoApp
//
//  Created by 村上拓麻 on 2020/09/21.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var fruits: [String] = ["Apple","apple","orange","strawberry","pineapple","lemon"]
    @State var selection:String = "Apple"
    @State var btnOut:String = "Search"
    @State var inPut:String = ""
    @State var ttxt:String = ""
    @State var searchText:String = ""
    
    
    //検索機能
    func find(value searchText:String, in array:[String]) -> Array<Int>?
    {
        var arr:Array<Int> = []
        
        //arrayの中に検索した文字列が概要するか検索
        for(index,value) in array.enumerated(){
            
            //入力した文字と配列の中の果物の名前と一致しているかどうか調べる
            //部分一致も対応している
            if value.localizedStandardContains(searchText){
                
                //該当していたら番地を追加
                arr.append(index)
            }
        }
        return arr
    }
    
    
    var body: some View {
        
        //検索にヒットした果物を出力.番地ではなく要素を取得
        VStack(spacing:50){
            Button(action: {
                
                
                self.btnOut = "Searched"
                let index = self.find(value: self.inPut, in: self.fruits)!
                var hitTxt = ""
                
                for val in index{
                    //valはfindメソッドで抽出された一致した番地が格納されている
                    hitTxt += self.fruits[val] + " "
                }
                
                self.ttxt = "\(hitTxt)"
                }
                ){
                    Text("\(btnOut)")
                }
            
            //検索フィールド
            TextField("Input Text",text: $inPut){
                self.btnOut = "Search"
                self.searchText = self.inPut
        }
        Text(ttxt)  //検索結果を表示
        SinglePicker(fruits: fruits, selection: $selection)
        
        }.font(.system(size:30))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Pickerを定義。配列の中の要素を参照
struct SinglePicker: View {
    let fruits:[String]
    @Binding var selection:String
    
    var body: some View{
        GeometryReader{ geometry in
            Picker("Memo",selection: self.$selection){
                ForEach(0..<self.fruits.count) { row in
                    Text(verbatim: self.fruits[row]).tag(self.fruits[row])
                }
            }.font(.system(size:30))
        }
    }
}
