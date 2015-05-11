package com.example.FoodFinder;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.TextView;

public class puttolikedb extends Activity {

   String id = null;
   ArrayList<String> input_foods = null;
   ArrayList<String> input_scores = null;
   String foods = null;
   int i = 0;

   public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.puttolikedb);
      ImageView a11 = (ImageView) findViewById(R.id.asdf);
      Intent intent = getIntent();
      id = intent.getStringExtra("id");
      
      input_foods = intent.getStringArrayListExtra("savedata_food");
      input_scores = intent.getStringArrayListExtra("savedata_score");
      
      for (i = 0; i < input_foods.size(); i++) {
         if (i == 0) {
            foods = input_foods.get(i)+ "-"+input_scores.get(i);
         } else {
            foods = foods + "," + input_foods.get(i)+ "-"+input_scores.get(i);
         }
      }

      // 웹뷰 만들어서 jsp파일로 연결시키기.
      WebView wb = (WebView) findViewById(R.id.wb_puttolikedb);
      wb.loadUrl("http://jellybean.dongyangmirae.kr/android_set_likedb.jsp?id=" + id + "&foods="+foods);
      

      
      a11.setOnClickListener(new OnClickListener() {
            public void onClick(View view) {

               Intent it = new Intent( puttolikedb.this, ffmain.class);
               it.putExtra("login_id", id);
               startActivity(it);
               finish();
            }
         });
   }
}