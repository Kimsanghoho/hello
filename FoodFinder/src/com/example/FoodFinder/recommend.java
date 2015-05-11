package com.example.FoodFinder;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

public class recommend extends Activity {
	ArrayList<String> data = new ArrayList<String>();
	ArrayList<String> savedata_food = new ArrayList<String>();
	ArrayList<String> savedata_score = new ArrayList<String>();
	boolean nextok = false;
	String id = null;
	String fd = null;
	String addr = null;
	int i;

	Bitmap bit_aaa1;
	Bitmap bit_aaa2;
	Bitmap bit_aaa3;
	Bitmap bit_aaa4;
	Bitmap bit_aaa5;

	// --------------------------------------------------------------------//
	HttpPost httppost;
	StringBuffer buffer;
	HttpResponse response;
	HttpClient httpclient;
	List<NameValuePair> nameValuePairs;

	// --------------------------------------------------------------------//

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.recomm);
		final TextView foodname1 = (TextView) findViewById(R.id.foodname1);
		final TextView foodname2 = (TextView) findViewById(R.id.foodname2);
		final TextView foodname3 = (TextView) findViewById(R.id.foodname3);
		final TextView foodname4 = (TextView) findViewById(R.id.foodname4);
		final TextView foodname5 = (TextView) findViewById(R.id.foodname5);

		Intent now_it = getIntent();
		id = now_it.getStringExtra("login_id");

		final TextView foodname_1 = (TextView) findViewById(R.id.foodname_1);

		final LinearLayout Layout_1 = (LinearLayout) findViewById(R.id.Layout_re1);
		final LinearLayout Layout_2 = (LinearLayout) findViewById(R.id.Layout_re2);
		final LinearLayout Layout_3 = (LinearLayout) findViewById(R.id.Layout_re3);
		final LinearLayout Layout_4 = (LinearLayout) findViewById(R.id.Layout_re4);
		final LinearLayout Layout_5 = (LinearLayout) findViewById(R.id.Layout_re5);
		final FrameLayout aa = (FrameLayout) findViewById(R.id.aa);

		ImageView back_btn = (ImageView) findViewById(R.id.back_btn);
		ImageView aaa1 = (ImageView) findViewById(R.id.foodView1);
		ImageView aaa2 = (ImageView) findViewById(R.id.foodView2);
		ImageView aaa3 = (ImageView) findViewById(R.id.foodView3);
		ImageView aaa4 = (ImageView) findViewById(R.id.foodView4);
		ImageView aaa5 = (ImageView) findViewById(R.id.foodView5);
		final ImageView aaa6 = (ImageView) findViewById(R.id.foodView_1);

		try {

			String serviceUrl = "http://jellybean.dongyangmirae.kr/android_recommend.jsp?id=";

			String strURL = serviceUrl + id;

			URL url = new URL(strURL);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
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
					if (tag.equals("f1") || tag.equals("f2")
							|| tag.equals("f3") || tag.equals("f4")
							|| tag.equals("f5")) {
						bSet = true;
					}
					break;

				case XmlPullParser.END_TAG:
					break;

				case XmlPullParser.TEXT:

					if (bSet) {
						if (i == 0) {

							String content = parser.getText();
							foodname1.setText(content);
							i++;
							bSet = false;
						} else if (i == 1) {

							String content = parser.getText();
							foodname2.setText(content);
							i++;
							bSet = false;
						} else if (i == 2) {

							String content = parser.getText();
							foodname3.setText(content);
							i++;
							bSet = false;
						} else if (i == 3) {

							String content = parser.getText();
							foodname4.setText(content);
							i++;
							bSet = false;
						} else {

							String content = parser.getText();
							foodname5.setText(content);

							bSet = false;
						}

					}

					break;

				case XmlPullParser.END_DOCUMENT:

					break;

				}

				eventType = parser.next();

			}
		} catch (Exception e) {

		}

		String aa1 = foodname1.getText().toString();
		String aa2 = foodname2.getText().toString();
		String aa3 = foodname3.getText().toString();
		String aa4 = foodname4.getText().toString();
		String aa5 = foodname5.getText().toString();

		bit_aaa1 = getRemoteImage(findImagesrc(aa1));
		bit_aaa2 = getRemoteImage(findImagesrc(aa2));
		bit_aaa3 = getRemoteImage(findImagesrc(aa3));
		bit_aaa4 = getRemoteImage(findImagesrc(aa4));
		bit_aaa5 = getRemoteImage(findImagesrc(aa5));

		LinearLayout inner = (LinearLayout) findViewById(R.id.Innerscroll);

		DisplayMetrics displayMetrics = new DisplayMetrics();

		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		int deviceWidth = displayMetrics.widthPixels;

		aaa1.setImageBitmap(bit_aaa1);
		aaa2.setImageBitmap(bit_aaa2);
		aaa3.setImageBitmap(bit_aaa3);
		aaa4.setImageBitmap(bit_aaa4);
		aaa5.setImageBitmap(bit_aaa5);

		Layout_1.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

				String foodname = foodname1.getText().toString();
				String addr = "name.jsp?food=";
				foodname_1.setText(foodname);
				foodname_1.setTextColor(Color.BLACK);
				foodname_1.setTextSize(30);
				aaa6.setImageBitmap(bit_aaa1);

				Intent it = new Intent(recommend.this, recommend2.class);
				it.putExtra("foodname", foodname);
				it.putExtra("addr", addr);
				it.putExtra("login_id", id);
				startActivity(it);

			}

		});

		Layout_2.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

				String foodname = foodname2.getText().toString();
				String addr = "name.jsp?food=";
				foodname_1.setText(foodname);
				foodname_1.setTextColor(Color.BLACK);
				foodname_1.setTextSize(30);
				aaa6.setImageBitmap(bit_aaa2);

				Intent it = new Intent(recommend.this, recommend2.class);
				it.putExtra("foodname", foodname);
				it.putExtra("addr", addr);
				it.putExtra("login_id", id);
				startActivity(it);
			}
		});

		Layout_3.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

				String foodname = foodname3.getText().toString();
				String addr = "name.jsp?food=";
				foodname_1.setText(foodname);
				foodname_1.setTextColor(Color.BLACK);
				foodname_1.setTextSize(30);

				aaa6.setImageBitmap(bit_aaa3);

				Intent it = new Intent(recommend.this, recommend2.class);
				it.putExtra("foodname", foodname);
				it.putExtra("addr", addr);
				it.putExtra("login_id", id);
				startActivity(it);
			}
		});

		Layout_4.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

				String foodname = foodname4.getText().toString();
				String addr = "name.jsp?food=";
				foodname_1.setText(foodname);
				foodname_1.setTextColor(Color.BLACK);
				foodname_1.setTextSize(30);

				aaa6.setImageBitmap(bit_aaa4);

				Intent it = new Intent(recommend.this, recommend2.class);
				it.putExtra("foodname", foodname);
				it.putExtra("addr", addr);
				it.putExtra("login_id", id);
				startActivity(it);
			}
		});

		Layout_5.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

				String foodname = foodname5.getText().toString();
				String addr = "name.jsp?food=";
				foodname_1.setText(foodname);
				foodname_1.setTextColor(Color.BLACK);
				foodname_1.setTextSize(30);

				aaa6.setImageBitmap(bit_aaa5);

				Intent it = new Intent(recommend.this, recommend2.class);
				it.putExtra("foodname", foodname);
				it.putExtra("addr", addr);
				it.putExtra("login_id", id);
				startActivity(it);
			}
		});
		back_btn.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

				aa.setVisibility(View.GONE);
				Layout_1.setVisibility(View.VISIBLE);
				Layout_2.setVisibility(View.VISIBLE);
				Layout_3.setVisibility(View.VISIBLE);
				Layout_4.setVisibility(View.VISIBLE);
				Layout_5.setVisibility(View.VISIBLE);

			}
		});

	}

	public Bitmap getRemoteImage(String url) {

		Bitmap bm = null;

		try {
			URL imageURL = new URL(url);
			imageURL = new URL(url);
			HttpURLConnection conn = null;
			conn = (HttpURLConnection) imageURL.openConnection();
			BufferedInputStream bis = null;
			bis = new BufferedInputStream(conn.getInputStream(), 10240);
			bm = BitmapFactory.decodeStream(bis);
			bis.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return bm;
	}

	String findImagesrc(String foodname12) {
		String src = null;
		try {
			httpclient = new DefaultHttpClient();
			httppost = new HttpPost(
					"http://jellybean.dongyangmirae.kr/android_food_img_src.jsp");
			nameValuePairs = new ArrayList<NameValuePair>(2);

			nameValuePairs.add(new BasicNameValuePair("foodname", foodname12));

			UrlEncodedFormEntity ent = new UrlEncodedFormEntity(nameValuePairs,
					HTTP.UTF_8);

			httppost.setEntity(ent);

			response = httpclient.execute(httppost);

			ResponseHandler<String> responseHandler = new BasicResponseHandler();
			final String response = httpclient.execute(httppost,
					responseHandler);
			System.out.println("Response : " + response);

			src = response;

		} catch (Exception e) {
			Log.d("Error", e.getMessage());
		}

		return src;
	}

	public boolean onKeyDown(int keyCode, KeyEvent event) {

		if (keyCode == KeyEvent.KEYCODE_BACK) {
			AlertDialog.Builder alertDlg = new AlertDialog.Builder(this);

			alertDlg.setMessage("종료 하시겠습니까?");
			alertDlg.setPositiveButton("예",
					new DialogInterface.OnClickListener() { // 확인 버튼
						@Override
						public void onClick(DialogInterface dialog,
								int whichButton) {

							System.exit(0); // 시스템 종료

						}
					});
			alertDlg.setNegativeButton("아니오",
					new DialogInterface.OnClickListener() { // 취소 버튼
						@Override
						public void onClick(DialogInterface dialog,
								int whichButton) {

							dialog.cancel();
						}
					});
			AlertDialog alert = alertDlg.create();
			alert.setTitle("FoodFinder"); // 알림창 상단 타이틀
			alert.show();
		}
		return false;
	}
}
