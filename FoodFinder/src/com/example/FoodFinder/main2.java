package com.example.FoodFinder;

import java.net.URL;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class main2 extends Activity implements OnClickListener {
	int temp = 0;
	boolean c_id, c_nick;
	EditText et_id, et_pw;
	Button check_id, check_nick;

	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main2);
		final EditText input_id = (EditText) findViewById(R.id.main2_id);
		final EditText input_pw = (EditText) findViewById(R.id.main2_pw);
		final EditText input_pw2 = (EditText) findViewById(R.id.main2_pw2);

		final EditText input_nik = (EditText) findViewById(R.id.main2_nik);
		final EditText input_email = (EditText) findViewById(R.id.main2_email);
		check_id = (Button) findViewById(R.id.check_id);
		check_nick = (Button) findViewById(R.id.check_nick);
		c_id = false;
		c_nick = false;
		Button ok = (Button) findViewById(R.id.ok_btn);

		ok.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				String input_pw_1 = input_pw.getText().toString();
				String input_pw2_2 = input_pw2.getText().toString();
				if (c_id == true) {
					if (c_nick == true) {
						if (input_pw_1.equals(input_pw2_2) ) {
							try {

								String serviceUrl = "http://jellybean.dongyangmirae.kr/android_join.jsp";

								String id = input_id.getText().toString();
								String pw = input_pw.getText().toString();
								String nickname = input_nik.getText()
										.toString();
								String nickname2 = java.net.URLEncoder
										.encode(new String(nickname
												.getBytes("UTF-8")));
								String email = input_email.getText().toString();

								String strURL = serviceUrl + "?id=" + id
										+ "&pw=" + pw + "&nickname="
										+ nickname2 + "&email=" + email;

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
										if (tag.equals("join")) {
											bSet = true;
										}
										break;

									case XmlPullParser.END_TAG:
										break;

									case XmlPullParser.TEXT:
										if (bSet) {
											String content = parser.getText();

											if (content.equals("true")) {
												Toast.makeText(v.getContext(),
														"정상적으로 가입되었습니다.", 0)
														.show();
												Intent it = new Intent(
														main2.this,
														select.class);
												it.putExtra("id", id);
												startActivity(it);

											} else if (content.equals("error")) {
												Toast.makeText(v.getContext(),
														"에러발생", 0).show();

											}

										}
										break;

									case XmlPullParser.END_DOCUMENT:

										break;

									}

									eventType = parser.next();

								}
							} catch (Exception e) {
								Toast.makeText(v.getContext(),
										"에러발생" + e.getMessage(), 0).show();
							}
						} else {
							Toast.makeText(v.getContext(), "비밀번호가 일치하지 않습니다", 0)
									.show();
						}
					} else {
						Toast.makeText(v.getContext(), "닉네임 중복확인을 해주세요", 0)
								.show();
					}
				} else {
					Toast.makeText(v.getContext(), "id 중복확인을 해주세요", 0).show();
				}
			}
		});
		check_id.setOnClickListener(new OnClickListener() {

			public void onClick(View v) {
				try {

					String serviceUrl = "http://jellybean.dongyangmirae.kr/android_check_id.jsp";

					String id = input_id.getText().toString();

					String strURL = serviceUrl + "?input_id=" + id;

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
							if (tag.equals("check")) {
								bSet = true;
							}
							break;

						case XmlPullParser.END_TAG:
							break;

						case XmlPullParser.TEXT:
							if (bSet) {
								String content = parser.getText();

								if (content.equals("true")) {
									Toast.makeText(v.getContext(),
											"id를 사용가능합니다.", 0).show();
									c_id = true;

								} else if (content.equals("false")) {
									Toast.makeText(v.getContext(),
											"id가 중복됩니다. 다시시도해주세요", 0).show();

								} else {
									Toast.makeText(v.getContext(), "에러발생", 0)
											.show();
									Toast.makeText(v.getContext(), content, 0)
											.show();
								}

							}
							break;

						case XmlPullParser.END_DOCUMENT:

							break;

						}

						eventType = parser.next();

					}
				} catch (Exception e) {
					Toast.makeText(v.getContext(), "에러발생" + e.getMessage(), 0)
							.show();
					Toast.makeText(v.getContext(), e.getMessage(), 0).show();
				}

			}
		});
		check_nick.setOnClickListener(new OnClickListener() {

			public void onClick(View v) {
				try {

					String serviceUrl = "http://jellybean.dongyangmirae.kr/android_check_nick.jsp";

					String nickname = input_nik.getText().toString();
					String nickname2 = java.net.URLEncoder.encode(new String(
							nickname.getBytes("UTF-8")));

					String strURL = serviceUrl + "?input_nickname=" + nickname2;

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
							if (tag.equals("check")) {
								bSet = true;
							}
							break;

						case XmlPullParser.END_TAG:
							break;

						case XmlPullParser.TEXT:
							if (bSet) {
								String content = parser.getText();

								if (content.equals("true")) {
									Toast.makeText(v.getContext(),
											"닉네임을 사용가능합니다.", 0).show();
									c_nick = true;

								} else if (content.equals("false")) {
									Toast.makeText(v.getContext(),
											"닉네임이 중복됩니다. 다시시도해주세요", 0).show();

								} else {
									Toast.makeText(v.getContext(), "에러발생", 0)
											.show();
									Toast.makeText(v.getContext(), content, 0)
											.show();
								}

							}
							break;

						case XmlPullParser.END_DOCUMENT:

							break;

						}

						eventType = parser.next();

					}
				} catch (Exception e) {
					Toast.makeText(v.getContext(), "에러발생" + e.getMessage(), 0)
							.show();
				}

			}
		});

	}

	public void onClick(View v) {

	}

}
