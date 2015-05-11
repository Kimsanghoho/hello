package com.example.FoodFinder;

import java.net.URL;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.RatingBar;
import android.widget.RatingBar.OnRatingBarChangeListener;
import android.widget.TextView;
import android.widget.Toast;

public class select extends Activity {

	int max = 20;
	int progress = 0;
	ProgressBar pgb;
	ArrayList<String> data = new ArrayList<String>();
	ArrayList<String> savedata_food = new ArrayList<String>();
	ArrayList<String> savedata_score = new ArrayList<String>();
	boolean nextok = false;
	String id = null;

	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.select);

		Intent intent = getIntent();
		id = intent.getStringExtra("id");

		DisplayMetrics displayMetrics = new DisplayMetrics();

		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		int deviceWidth = displayMetrics.widthPixels;

		getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);

		ImageView img = (ImageView) findViewById(R.id.daum_btn);
		LinearLayout inner = (LinearLayout) findViewById(R.id.Innerscroll);
		pgb = (ProgressBar) findViewById(R.id.progressBar1);
		pgb.setMax(max);
		try {

			String serviceUrl = "http://jellybean.dongyangmirae.kr/android_all_food_name.jsp";

			URL url = new URL(serviceUrl);

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
					if (tag.equals("name")) {
						bSet = true;
					}
					break;

				case XmlPullParser.END_TAG:
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

		for (int i = 0; i <= data.size() - 1; i++) {
			LinearLayout ll = new LinearLayout(this);
			LinearLayout llv = new LinearLayout(this);
			ll.setId(i);
			ll.setOrientation(LinearLayout.HORIZONTAL);
			ll.setWeightSum(0.3f);
			llv.setId(i);
			llv.setOrientation(LinearLayout.VERTICAL);
			WebView wb = new WebView(this);
			wb.getSettings().setDefaultTextEncodingName("utf-8");
			wb.loadUrl("http://jellybean.dongyangmirae.kr/android_food_img.jsp?foodname="
					+ data.get(i));
			wb.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
			wb.setHorizontalScrollBarEnabled(false);
			wb.setVerticalScrollBarEnabled(false);
			// 레이팅바 생성
			final RatingBar rbtemp = new RatingBar(this);
			rbtemp.setTag((String) data.get(i));

			TextView txv = new TextView(this);
			txv.setId(i);
			txv.setText(data.get(i));
			txv.setTextColor(Color.BLACK);
			txv.setTextSize(19);
			llv.addView(txv);
			llv.addView(rbtemp);

			switch (deviceWidth) {
			case 1080:
				ll.addView(wb, 225, 225);
				break;
			default:
				ll.addView(wb, 150, 150);
			}

			ll.addView(llv);
			inner.addView(ll);

			rbtemp.setOnRatingBarChangeListener(new OnRatingBarChangeListener() {
				int indexnum;
				boolean firstcheck = true;

				public void onRatingChanged(RatingBar ratingBar, float rating,
						boolean fromUser) {

					if (rating != 0) {
						if (firstcheck) {
							pgb.setProgress(++progress);
							firstcheck = false;
							savedata_food.add((String) rbtemp.getTag());
							savedata_score.add("" + rating);

						}
					} else {
						if (progress != 0) {
							pgb.setProgress(--progress);
							for (int i = 0; i < savedata_food.size(); i++) {
								if (savedata_food.get(i).equals(
										(String) rbtemp.getTag())) {
									indexnum = i;
									break;
								}
							}

							savedata_food.remove(indexnum);
							savedata_score.remove(indexnum);
							firstcheck = true;
						}
					}

					if (progress >= max) {
						nextok = true;
					} else if (progress <= max) {
						nextok = false;
					}
				}
			});
		}

		img.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {
				if (nextok) {
					Intent it = new Intent(select.this, puttolikedb.class);
					it.putExtra("id", id);
					it.putExtra("savedata_food", savedata_food);
					it.putExtra("savedata_score", savedata_score);
					startActivity(it);
					finish();
				} else {
					Toast.makeText(view.getContext(), "조금더 평가해주세요", 0).show();
				}
			}
		});

	}

}