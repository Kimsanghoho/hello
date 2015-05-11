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
      // ��ư Ŭ�� ���
      
 

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
                     
                      // �̺�Ʈ Ÿ���� ��ť��Ʈ�� ������ ���
                         case XmlPullParser.START_DOCUMENT:
                            break;
                             
                            // �̺�Ʈ Ÿ���� START_TAG�� ���(��: <name>)
                         case XmlPullParser.START_TAG:
                            // �±� �̸��� ������
                             String tag = parser.getName();
                             // �±� �̸��� <name>, <address>�� ���  
                             if (tag.equals("login")) {
                                bSet = true;
                             }
                             break;
                             
                         // �̺�Ʈ Ÿ���� END_TAG�� ���(��: </name>)    
                         case XmlPullParser.END_TAG:
                             break;
                             
                            // �̺�Ʈ Ÿ���� �±� ������ �������� ���� ������ ���� (��: <name>������</name>)       
                         case XmlPullParser.TEXT:
                            // �±�(<name>, <address>) ������ ������ ����
                             if (bSet) {
                                String content = parser.getText();
                                
                                if(content.equals("true")){
                             Intent it = new Intent(main.this, ffmain.class);
                             it.putExtra("login_id", id);
                             finish();
                             startActivity(it);
                                }else if (content.equals("wrong_pw")){
                                   Toast.makeText(v.getContext(), "��й�ȣ�� �����ʽ��ϴ�. �ٽ�Ȯ�����ּ���", 0).show();
                                   
                                }else{
                                   Toast.makeText(v.getContext(), "���̵� �������� �ʽ��ϴ�. �ٽ�Ȯ�����ּ���", 0).show();
                                }
                                
                             }
                             break;
                             
                       // �̺�Ʈ Ÿ���� ��ť��Ʈ�� ���� ���
                         case XmlPullParser.END_DOCUMENT:
                            
                             break;
                             
                     } 
                     
                     // ���� �̺�Ʈ Ÿ���� �Ҵ� 
                     eventType = parser.next();
                     
                 }
             } catch (Exception e) {
                 Toast.makeText(v.getContext(), "�����߻�"+e.getMessage(), 0).show();
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
       
     alertDlg.setMessage("���� �Ͻðڽ��ϱ�?");
     alertDlg.setPositiveButton("��", new DialogInterface.OnClickListener() { //Ȯ�� ��ư
      @Override
     public void onClick(DialogInterface dialog, int whichButton) {
       
      System.exit(0); //�ý��� ����
      
      }
       }) ;        
       alertDlg.setNegativeButton("�ƴϿ�", new DialogInterface.OnClickListener() { // ��� ��ư
        @Override
     public void onClick(DialogInterface dialog, int whichButton) {         
        
         dialog.cancel();   
        }
       });
       AlertDialog alert = alertDlg.create();
       alert.setTitle("FoodFinder"); //�˸�â ��� Ÿ��Ʋ
       alert.show();
    }
    return false;
   }

}