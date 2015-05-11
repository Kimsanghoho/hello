package com.example.FoodFinder;

import java.net.URL;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class idpw extends Activity implements OnClickListener {


	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.idpw);
		Button btn = (Button) findViewById(R.id.button1);
		final EditText ed_id = (EditText) findViewById(R.id.EditText03);
		final TextView idtext = (TextView) findViewById(R.id.idtext);

		btn.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

				try {

					// http://jellybean.dongyangmirae.kr/android_find_pw.jsp?id=****

					String id = ed_id.getText().toString();
					
					String serviceUrl = "http://jellybean.dongyangmirae.kr/android_find_pw.jsp?id=";

					String strURL = serviceUrl +id;
					URL url = new URL(strURL);

					XmlPullParserFactory factory = XmlPullParserFactory
							.newInstance();
					XmlPullParser parser = factory.newPullParser();

					parser.setInput(url.openStream(), "utf-8");

					int eventType = parser.getEventType();
					boolean bSet = false;

					while (eventType != XmlPullParser.END_DOCUMENT) {

						switch (eventType) {

						case XmlPullParser.START_DOCUMENT:
							break;

						case XmlPullParser.START_TAG:
							String tag = parser.getName();
							if (tag.equals("find")) {
								bSet = true;
							}
							break;

						case XmlPullParser.END_TAG:
							bSet = false;
							break;

						case XmlPullParser.TEXT:
							if (bSet) {
								String content = parser.getText();
								if(content.equals("false")){
									idtext.setText("그런 아이디 없습니다.");
								}
								else
								idtext.setText(content);
								
							}
							break;

						case XmlPullParser.END_DOCUMENT:

							break;

						}

						eventType = parser.next();

					}
				} catch (Exception e) {

				}

			}
		});

	}

	public void onClick(View v) {

	}

}