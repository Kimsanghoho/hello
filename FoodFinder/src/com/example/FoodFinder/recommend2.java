package com.example.FoodFinder;

import java.net.URL;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.R.color;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.ContextMenu;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

public class recommend2 extends Activity {

	ArrayList<String> data = new ArrayList<String>();
	ArrayList<String> savedata = new ArrayList<String>();

	String foodname = null;
	String restaurantname = null;
	TextView aa = null;
	String addr = null;
	String id = null;
	int i;
	ImageView img;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.recomm_2);

		Intent intent = getIntent();
		String foodname = intent.getStringExtra("foodname");
		String addr = intent.getStringExtra("addr");
		id = intent.getStringExtra("login_id");

		img = (ImageView) findViewById(R.id.btn_click);
		registerForContextMenu(img);

		DisplayMetrics displayMetrics = new DisplayMetrics();

		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		int deviceWidth = displayMetrics.widthPixels;

		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		LinearLayout inner = (LinearLayout) findViewById(R.id.Innerscroll);

		try {

			String foodname1 = java.net.URLEncoder.encode(new String(foodname
					.getBytes("UTF-8")));
			String serviceUrl = "http://jellybean.dongyangmirae.kr/android_restaurant_";

			String strURL = serviceUrl + addr + foodname1;
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
			Toast.makeText(this, "에러발생" + e.getMessage(), 0).show();
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
					Intent it = new Intent(recommend2.this, search2.class);
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
			Intent it = new Intent(recommend2.this, select.class);
			it.putExtra("id", id);
			startActivity(it);
			return true;
		case 2:
			Intent it1 = new Intent(recommend2.this, search.class);
			it1.putExtra("id", id);
			it1.putExtra("str", "");
			startActivity(it1);
			return true;
		case 3:
			Intent it2 = new Intent(recommend2.this, main.class);
			startActivity(it2);
			Toast.makeText(this, "로그아웃되었습니다", 0).show();
			finish();
			return true;
		default:
			return super.onContextItemSelected(item);
		}
	}
}
