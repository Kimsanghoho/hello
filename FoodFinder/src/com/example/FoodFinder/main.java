package com.example.FoodFinder;

import java.net.URL;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

public class main extends Activity {
   
   Button btn1, btn2, btn3;
   ArrayList<String> savedata = new ArrayList<String>();
   EditText et_id,et_pw;
   String id =null;
   
   protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main);
      ImageView temp = (ImageView) findViewById(R.id.temp);
      ImageView img = (ImageView) findViewById(R.id.login_btn);
      ImageView img2 = (ImageView) findViewById(R.id.idpw_btn);
      ImageView img3 = (ImageView) findViewById(R.id.ga_btn);
      final EditText input_id = (EditText) findViewById(R.id.input_id);
      final EditText input_pw = (EditText) findViewById(R.id.input_pw);      
      // 버튼 클릭 대기
      
 

      img.setOnClickListener(new OnClickListener() {
         public void onClick(View v) {

            try {
                
                String serviceUrl = "http://jellybean.dongyangmirae.kr/android_login.jsp";
                          
               id = input_id.getText().toString();
               String pw = input_pw.getText().toString();
               
                
               
                  String strURL = serviceUrl+"?input_id="+id+"&input_pw="+pw;
                
                    URL url = new URL(strURL);
               
                 XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
                 XmlPullParser parser = factory.newPullParser();
                 
                 parser.setInput(url.openStream(),"utf-8");
                 
                 int eventType = parser.getEventType();
                 boolean bSet = false;
                 

                 while (eventType != XmlPullParser.END_DOCUMENT) {
                    
                     switch (eventType) {
                     
                      // 이벤트 타입이 도큐먼트의 시작인 경우
                         case XmlPullParser.START_DOCUMENT:
                            break;
                             
                            // 이벤트 타입이 START_TAG인 경우(예: <name>)
                         case XmlPullParser.START_TAG:
                            // 태그 이름을 추출함
                             String tag = parser.getName();
                             // 태그 이름이 <name>, <address>인 경우  
                             if (tag.equals("login")) {
                                bSet = true;
                             }
                             break;
                             
                         // 이벤트 타입이 END_TAG인 경우(예: </name>)    
                         case XmlPullParser.END_TAG:
                             break;
                             
                            // 이벤트 타입이 태그 사이의 데이터인 경우는 데이터 추출 (예: <name>데이터</name>)       
                         case XmlPullParser.TEXT:
                            // 태그(<name>, <address>) 사이의 데이터 추출
                             if (bSet) {
                                String content = parser.getText();
                                
                                if(content.equals("true")){
                             Intent it = new Intent(main.this, ffmain.class);
                             it.putExtra("login_id", id);
                             finish();
                             startActivity(it);
                                }else if (content.equals("wrong_pw")){
                                   Toast.makeText(v.getContext(), "비밀번호가 맞지않습니다. 다시확인해주세요", 0).show();
                                   
                                }else{
                                   Toast.makeText(v.getContext(), "아이디가 존재하지 않습니다. 다시확인해주세요", 0).show();
                                }
                                
                             }
                             break;
                             
                       // 이벤트 타입이 도큐먼트의 끝인 경우
                         case XmlPullParser.END_DOCUMENT:
                            
                             break;
                             
                     } 
                     
                     // 다음 이벤트 타입을 할당 
                     eventType = parser.next();
                     
                 }
             } catch (Exception e) {
                 Toast.makeText(v.getContext(), "에러발생"+e.getMessage(), 0).show();
             } 
            
         }
      });

      img2.setOnClickListener(new OnClickListener() {
         public void onClick(View view) {

            Intent it = new Intent(main.this, idpw.class);

            startActivity(it);
            
         }
      });
      img3.setOnClickListener(new OnClickListener() {
         public void onClick(View view) {

            Intent it = new Intent(main.this, main2.class);

            startActivity(it);
            
         }
      });
       
   }
   public boolean  onKeyDown(int keyCode, KeyEvent event)
   {
    
    if(keyCode == KeyEvent.KEYCODE_BACK)
    {
     AlertDialog.Builder alertDlg = new AlertDialog.Builder(this);
       
     alertDlg.setMessage("종료 하시겠습니까?");
     alertDlg.setPositiveButton("예", new DialogInterface.OnClickListener() { //확인 버튼
      @Override
     public void onClick(DialogInterface dialog, int whichButton) {
       
      System.exit(0); //시스템 종료
      
      }
       }) ;        
       alertDlg.setNegativeButton("아니오", new DialogInterface.OnClickListener() { // 취소 버튼
        @Override
     public void onClick(DialogInterface dialog, int whichButton) {         
        
         dialog.cancel();   
        }
       });
       AlertDialog alert = alertDlg.create();
       alert.setTitle("FoodFinder"); //알림창 상단 타이틀
       alert.show();
    }
    return false;
   }

}