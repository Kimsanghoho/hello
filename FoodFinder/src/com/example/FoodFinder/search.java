package com.example.FoodFinder;

import java.net.URL;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.ContextMenu;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class search extends Activity {
	ArrayList<String> data = new ArrayList<String>();
	ArrayList<String> savedata = new ArrayList<String>();
	String id = null;
	String foodname = null;
	String restaurantname = null;
	String addr = null;
	String search_1 = null;
	String search1 = null;
	String serviceUrl = null;
	String search_2 = null;
	String searched_str = "";
	ImageView img;
	EditText search;
	int i;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.search);
		Intent intent = getIntent();
		searched_str = intent.getStringExtra("str");
		id = intent.getStringExtra("id");

		search_1 = intent.getStringExtra("search_1");

		img = (ImageView) findViewById(R.id.btn_click);
		registerForContextMenu(img);

		ImageView btn = (ImageView) findViewById(R.id.temp);
		search = (EditText) findViewById(R.id.editText1);

		search.setText(searched_str);
		DisplayMetrics displayMetrics = new DisplayMetrics();

		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		int deviceWidth = displayMetrics.widthPixels;

		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		LinearLayout inner = (LinearLayout) findViewById(R.id.Innerscroll);

		btn.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {
				String search1 = search.getText().toString();
				Intent it = new Intent(search.this, search.class);
				it.putExtra("id", id);
				it.putExtra("str", search1);
				it.putExtra("search_1", search1);

				startActivity(it);
				finish();
			}
		});

		try {

			if (search_1.equals("all")) {
				serviceUrl = "http://jellybean.dongyangmirae.kr/android_restaurant_name.jsp?food=all";

			} else {
				String serviceUrl1 = "http://jellybean.dongyangmirae.kr/android_restaurant_name.jsp?food=";
				search_2 = java.net.URLEncoder.encode(new String(search_1
						.getBytes("UTF-8")));
				serviceUrl = serviceUrl1 + search_2;
			}

			String aa = serviceUrl;

			URL url = new URL(aa);

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
					if (tag.equals("restaurant")) {
						bSet = true;
					}
					break;

				case XmlPullParser.END_TAG:
					bSet = false;
					break;

				case XmlPullParser.TEXT:
					if (bSet) {
						String content = parser.getText();
						data.add(content);
					}
					break;

				case XmlPullParser.END_DOCUMENT:

					break;

				}

				eventType = parser.next();

			}
		} catch (Exception e) {
		}

		for (i = 0; i < data.size(); i++) {
			LinearLayout ll = new LinearLayout(this);
			LinearLayout llv = new LinearLayout(this);
			LinearLayout llh = new LinearLayout(this);
			ll.setId(i);
			ll.setOrientation(LinearLayout.HORIZONTAL);
			ll.setWeightSum(0.3f);

			llh.setOrientation(LinearLayout.HORIZONTAL);
			llv.setId(i);
			llv.setOrientation(LinearLayout.VERTICAL);

			ImageView iv = new ImageView(this);
			iv.setImageResource(R.drawable.logo);

			final TextView txv = new TextView(this);
			txv.setId(i);
			txv.setText(data.get(i));

			txv.setTextColor(Color.BLACK);
			txv.setTextSize(25);

			txv.setOnClickListener(new OnClickListener() {
				public void onClick(View view) {

					restaurantname = txv.getText().toString();

					Toast.makeText(txv.getContext(), restaurantname, 0).show();
					Intent it = new Intent(search.this, search2.class);
					it.putExtra("resname", restaurantname);
					it.putExtra("login_id", id);
					startActivity(it);
				}
			});

			ImageView imgBar = new ImageView(this);
			imgBar.setImageResource(R.drawable.line);

			ImageView imgicon = new ImageView(this);
			imgicon.setImageResource(R.drawable.resulticon);

			llh.addView(imgicon);
			llh.addView(txv);
			llv.addView(llh);
			llv.addView(imgBar);

			ll.addView(llv);

			inner.addView(ll);

		}
	}

	public void onCreateContextMenu(ContextMenu menu, View v,
			ContextMenuInfo menuInfo) {

		super.onCreateContextMenu(menu, v, menuInfo);

		menu.setHeaderIcon(android.R.drawable.btn_star);

		menu.setHeaderTitle("설정");
		menu.add(0, 1, 0, "취향 재설정");
		menu.add(0, 2, 0, "검색");
		menu.add(0, 3, 0, "로그아웃");
	}

	@Override
	public boolean onContextItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case 1:
			Intent it = new Intent(search.this, select.class);
			it.putExtra("id", id);
			startActivity(it);
			return true;
		case 2:

			Intent it1 = new Intent(search.this, search.class);
			it1.putExtra("id", id);
			startActivity(it1);
			return true;
		case 3:
			Intent it2 = new Intent(search.this, main.class);
			startActivity(it2);
			Toast.makeText(this, "로그아웃되었습니다", 0).show();
			finish();
			return true;
		default:
			return super.onContextItemSelected(item);
		}
	}
}
